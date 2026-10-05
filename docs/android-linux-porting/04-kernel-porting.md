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
| Mainline `torvalds/linux` + out-of-tree patches | Best long-term maintainability; realistic only for SoCs with strong mainline support (e.g. recent Qualcomm Snapdragon with `qcom-mainline` efforts, Samsung Exynos via `linux-exynos`) |

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
make O=out <device>_defconfig     # seed from vendor defconfig, then merge
                                   # kernel.config fragments recovered in §1.4
make O=out -j$(nproc) Image.gz dtbs modules
```

Keep the defconfig under version control in this repo (text, not binary),
diffed against the vendor's original — this diff *is* the documentation of
what you changed and why, and is exactly what you'd submit upstream to
mainline a driver later.

## Next

→ [05-rootfs-and-userspace.md](05-rootfs-and-userspace.md) for the
userspace side: Halium/libhybris shim vs. a fully native rootfs.
