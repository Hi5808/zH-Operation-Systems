# 4. Kernel Porting

Goal: a buildable kernel source tree that boots the real device, combining
(a) the vendor's Android kernel source/config as a base, (b) drivers
recovered/adapted per §2-3, and (c) as much mainline Linux as will fit.

## 4.1 Finding the real kernel source (don't start from disassembly)

Android kernels are GPLv2 and vendors are obligated to publish source.
Before reconstructing anything from the binary:

1. Check the vendor's open-source compliance site (required by GPL) —
   search `"<device codename>" kernel source opensource.<vendor>.com`.
2. Check SoC-vendor BSP trees (Qualcomm's `git.codelinaro.org` (CodeAurora's successor)/
   `github.com/LineageOS/android_kernel_<vendor>_<chip>` mirrors, MediaTek's
   kernel releases) — community LineageOS/kernel trees for the same SoC are
   an enormous head start even if not for your exact model.
3. Only fall back to Ghidra-driven reconstruction (§2) for the delta: the
   handful of files/drivers that differ between the published BSP and your
   device's actual binary (verify with the `kernel.config` and module list
   from §1.4/§1.5 — diff `vermagic`/`modules.builtin` against the BSP tree).

If you truly have zero source (rare, but happens on obscure
vendors/chipsets), the realistic goal is not "recompile their exact
kernel" — it's "write a new, mainline-based kernel that re-implements the
small set of device-specific drivers" using the RE'd init sequences from
§2.3, which is far more maintainable long-term anyway.

## 4.2 Picking a kernel base

| Base | When to use |
|---|---|
| Vendor's own kernel source (as found in §4.1) | Fastest path to "boots at all"; keeps every vendor driver/quirk; usually an old LTS (4.9/4.14/4.19/5.4) |
| A community BSP fork for the same SoC (LineageOS, postmarketOS `linux-*` kernels) | Best balance — often already has out-of-tree drivers cleaned up and cross-device DT support |
| Mainline `torvalds/linux` + out-of-tree patches | Best long-term maintainability; realistic only for SoCs with strong mainline support (e.g. recent Qualcomm Snapdragon via the `linux-arm-msm` effort, Samsung Exynos via `linux-samsung-soc`) — see §8 |

Most real-world ports (Halium, postmarketOS "downstream kernel" devices)
start from the vendor/BSP kernel and mainline individual drivers over
time — don't block the whole project on 100% mainline from day one.

## 4.3 Device tree work

- Start from the vendor's `.dts`/`.dtsi` (decompiled in §1.3, or found in
  the BSP source from §4.1 — prefer the real source over the decompiled
  version whenever you have it, decompiled DTS loses labels/includes).
- Split into the mainline convention: SoC-common `.dtsi` + board-specific
  `.dts`, so peripheral nodes you port can be upstreamed/shared.
- Add `chosen { bootargs = ... }` with a Linux-appropriate cmdline (the
  Android one will reference `androidboot.*` params your new init doesn't
  use; replace with standard `root=`, `console=`, etc., keeping any
  `androidboot.*` args that the *bootloader itself* or TrustZone still
  expects to see).
- Re-declare every `reserved-memory` region found in §3.3 exactly — getting
  this wrong is the #1 cause of secure-world/modem crashes on first boot.

## 4.4 Driver work, by category

- **Direct reuse**: vendor `.ko` builds cleanly against the chosen kernel
  base as an out-of-tree module (common for sensors/touch on an
  old-vendor-kernel-base strategy). Just needs `Makefile`/`Kconfig`
  wiring.
- **Adapted reuse**: vendor driver source (from §4.1) needs small changes
  to compile against a newer kernel (API renames, `regmap`/`gpiod` API
  churn between kernel versions) — mechanical, usually a few hours of
  `grep`-driven fixups per driver.
- **Reconstructed from RE**: no source exists; use the register
  sequence/init order recovered in §2.3 to write a minimal driver against
  the modern kernel framework (`iio`, `input`, `drm_panel`, `regulator`,
  etc.) rather than porting 1:1 — a clean 200-line `iio` driver beats a
  disassembled 3000-line blob every time.
- **Left as a blob, bridged**: GPU/DSP/modem — kernel-side driver stays the
  vendor one (built against the chosen base), userspace talks to it
  through the Halium/libhybris shim (§5) instead of a native Linux
  userspace stack.

## 4.5 Build & defconfig

```bash
export ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
make O=out CODENAME_defconfig     # your device defconfig; seed from vendor, then merge
                                   # kernel.config fragments recovered in §1.4
make O=out -j$(nproc) Image.gz dtbs modules
```

Keep the defconfig under version control in this repo (text, not binary),
diffed against the vendor's original — this diff *is* the documentation of
what you changed and why, and is exactly what you'd submit upstream to
mainline a driver later.

### Merging config fragments

Don't hand-edit the vendor defconfig. Keep your Linux-specific changes
in a separate fragment and merge them, so the diff stays readable:

```bash
# vendor.config = recovered kernel.config (§1.4); linux.fragment = your additions
./scripts/kconfig/merge_config.sh -m vendor.config linux.fragment
make O=out olddefconfig                       # resolve new/changed dependencies
./scripts/diffconfig vendor.config out/.config  # review exactly what changed
```

`merge_config.sh` warns when a requested option didn't make it into the
final config (usually because a dependency is off). Read those warnings
rather than assuming the fragment applied.

## 4.6 Options a Linux userspace needs that Android kernels often lack

Android kernels are configured for Android's init and userspace, not a
general Linux distro. Common gaps:

| Option(s) | Why it matters |
|---|---|
| `CONFIG_DEVTMPFS`, `CONFIG_DEVTMPFS_MOUNT` | systemd and most initramfs tools expect the kernel to populate `/dev`. |
| `CONFIG_CGROUPS` (+ controllers), `CONFIG_NAMESPACES` | Required by systemd; also by LXC, which Halium-based systems use to run the Android container. |
| `CONFIG_FHANDLE`, `CONFIG_INOTIFY_USER`, `CONFIG_SIGNALFD`, `CONFIG_TIMERFD`, `CONFIG_EPOLL` | systemd hard requirements. |
| `CONFIG_SYSVIPC` | Android disables System V IPC; some Linux software still needs it. |
| `CONFIG_ANDROID_PARANOID_NETWORK` (downstream kernels only) | When **enabled**, restricts socket creation to Android's network group IDs, so ordinary Linux processes can't open network sockets. Disable it for a Linux userspace. |
| `CONFIG_VT`, `CONFIG_FRAMEBUFFER_CONSOLE` (or `CONFIG_DRM_FBDEV_EMULATION`) | Get a text console on the screen during bring-up, before a compositor works. |
| USB gadget configfs (`CONFIG_USB_CONFIGFS*`, RNDIS/NCM functions) | USB networking to the device — the most useful early debug channel after serial (§5.5). |

Don't rely on this table alone. Use the checker your target project
maintains: `pmbootstrap kconfig check` for postmarketOS, or the Halium
kernel config check script described in Halium's porting docs. Both
encode the current requirements for their userspace.

## 4.7 GKI and vendor modules (Android 12+ devices)

Devices launched with Android 12 or later on kernel 5.10+ typically use
Google's **Generic Kernel Image (GKI)**: a common kernel in `boot`, with
vendor drivers shipped as loadable modules in `vendor_boot` and/or a
`vendor_dlkm` partition.

- Those vendor `.ko` files are built against GKI's stable **Kernel Module
  Interface (KMI)** for that exact kernel branch. They will generally
  **not** load into a different kernel (yours or mainline), so a GKI
  device doesn't let you "reuse the vendor modules" by swapping kernels.
- Practical consequence: on GKI devices, either stay on the same GKI
  branch (Android common kernel source is public at
  android.googlesource.com/kernel/common) and keep using vendor modules
  as-is, or replace each vendor module with a mainline driver. There's
  no reliable middle ground.
- Dump `vendor_boot` and `vendor_dlkm` along with `boot` (§1). On GKI
  devices that's where the device-specific driver list lives, not in
  `boot`.

## 4.8 Toolchain pitfalls

- **Match the vendor's compiler.** Downstream kernels frequently fail to
  build with a modern GCC or clang (new warnings promoted to errors,
  removed flags). Android kernels from roughly 4.14 onward are built with
  clang. Use the clang version from the matching AOSP prebuilts or the
  kernel's build config rather than your distro's latest.
- Prefer `make LLVM=1` for clang builds on kernels that support it, and
  set `CROSS_COMPILE` only when using GCC.
- Avoid globally disabling `-Werror` as a first move. Fix or locally
  silence the specific warning so real bugs still surface.

## 4.9 The iteration loop

1. Change one thing (config, DT node, driver).
2. Build `Image.gz` + DTB only (skip `modules` when you can).
3. Repack with the stock header values (§6.2) and `fastboot boot`, which
   RAM-boots without flashing (§6.4).
4. Read the serial console or `dmesg` (§15, §5.4).
5. Record what changed and what happened in the device's `re-notes.md`.

Keeping each iteration to one change is what makes a black-screen boot
debuggable (§11.6).

## Next

→ [05-rootfs-and-userspace.md](05-rootfs-and-userspace.md) for the
userspace side: Halium/libhybris shim vs. a fully native rootfs.
