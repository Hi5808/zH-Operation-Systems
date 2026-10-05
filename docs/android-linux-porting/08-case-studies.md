# 8. Case Studies & Reference Projects

Real-world projects that followed this exact dump → RE → port pipeline.
Reading their device-porting trees is more valuable than any amount of
abstract guidance — they are the ground truth for "what does a finished
version of each step in this guide actually look like."

## Ubuntu Touch / UBports

- **Project**: UBports (ubports.com, devices.ubuntu-touch.io,
  github.com/ubports), with the **Lomiri** shell (formerly Unity 8).
- **Why it deserves first mention**: Ubuntu Touch is the longest-running
  community mobile-Linux OS still shipping. Canonical built the original
  Ubuntu Touch and the `libhybris` approach, then discontinued the phone
  effort in 2017; the **UBports community adopted it and has maintained
  and advanced it ever since**, entirely volunteer-driven. Much of the
  practical knowledge this guide distills — how to run vendor Android
  HALs under a glibc Linux userspace on a real phone, day to day —
  exists because that community kept it alive and documented. Treat their
  work, and the credit for it, as foundational (§"ownership and credit"
  in [00-overview.md](00-overview.md)).
- **Approach**: the mixed native-kernel + Android-HAL-container strategy
  of §5.1A, via Halium (below). The Lomiri UI sits on top. Ports are
  tracked openly with a per-device feature matrix on the UBports device
  wiki — a good model for the status table every device profile here
  keeps (§10).
- **For a porter**: the UBports porting documentation (docs.ubports.com)
  is one of the most complete community walkthroughs of the Halium path
  in existence; read it alongside this guide's §5. Note `clickable` is
  their *app* SDK, not a device-porting tool (§7).

## Halium

- **Project**: github.com/Halium, docs.halium.org — the shared base that
  UBports, Droidian, and others build on.
- **Approach**: exactly the native-kernel + Android-HAL-container
  strategy described in §5.1A. Device ports live in
  `device/<vendor>/<codename>` + `vendor/<vendor>/<codename>` repos, each
  containing a `proprietary-blobs.txt` manifest rather than committed
  binaries — the pattern this guide recommends (§5.2, §CONTRIBUTING).
- **Why it's the best first reference**: dozens of community device ports
  covering a huge range of Qualcomm/MediaTek SoCs, all using the same
  repo layout — find one for a SoC close to your target device and diff
  against it instead of starting from an empty repo.

## postmarketOS

- **Project**: postmarketos.org, `pmbootstrap`, wiki.postmarketpos.org
  "Porting to a new device" guide.
- **Approach**: supports both fully-native ("mainline") device ports and
  Halium-based ("downstream"/`hybris`) device ports from the same
  tooling, which maps directly onto the "decide per subsystem" strategy
  in §3.5/§5.1.
- Their wiki's per-device pages are a good template for how to document
  your own port's status (which subsystems work, which are blob-shimmed,
  which are unsupported).

## LineageOS kernel trees

- Not a Linux-desktop port, but the single best source of **already
  cleaned-up vendor kernel source** for a huge number of SoCs
  (`github.com/LineageOS/android_kernel_<vendor>_<chip>`). Always check
  here before reconstructing a kernel driver from Ghidra RE (§4.1) — if
  LineageOS already supports your device or its close sibling, most of
  the kernel-source-recovery work in §1/§4 is already done for you.

## PinePhone / Mobian / Sailfish OS

- **PinePhone/Mobian**: the fully-native end of the spectrum (§5.1B) —
  useful as a reference for what a from-scratch mainline driver looks like
  for touch/sensors/PMIC once you've decided a subsystem doesn't need the
  Halium shim.
- **Sailfish OS (`hybris` ports)**: another long-running `libhybris`-based
  project with its own large set of device ports and porting documentation,
  useful as a second reference implementation alongside Halium's.

## RGOS — a worked native port (Anbernic RG405M, UNISOC T618)

`rgos-yocto` (in this same GitHub account) is a hardware-proven native
Linux port of the RG405M handheld — not a Halium shim, a real
OpenEmbedded/Yocto (Scarthgap) userspace on a downstream UNISOC kernel.
It's the closest thing in this guide to a complete, end-to-end instance
of the methodology, so it's worth reading alongside the abstract
chapters. What it demonstrates:

- **The §5.1 mixed reality in practice**: downstream vendor kernel
  (`linux-unisoc-t618`, a 4.14-era tree) carried forward with a stack of
  ~40 focused patches, under a fully native Yocto userspace (Weston 13 on
  DRM, NetworkManager, BlueZ + A2DP, PipeWire/ALSA). No Android container.
- **Driver work is mostly small patches, not rewrites** (§4.4): the patch
  series is dominated by one- and two-purpose fixes — a touchscreen IRQ/
  GPIO-mux fix, ASoC routing fixes for the `sprdphone-sc2730` codec, a
  joystick ADC driver, charger/fuel-gauge tweaks — exactly the "adapt,
  don't reimplement" pattern the guide predicts for a downstream-kernel
  base.
- **A textbook RE-grade bug writeup**: `docs/EMMC-ADMA-ERROR.md` traces an
  `mmc3: ADMA error` to mainline `sdhci-sprd.c` emitting a trailing
  NOP|END descriptor the controller faults on, where the vendor 4.14
  driver always set END on the last transfer descriptor — found by
  decoding the SDHCI register dump and diffing against the vendor tree.
  That is §2's "diff against the vendor source, decode what the silicon
  actually does" method applied to a live kernel panic.
- **The boot chain and flashing are real, and device-specific in exactly
  the way §6/§9 warn about**: UNISOC BootROM download mode (`spd_dump` +
  FDL), the slot-A kernel partition is named `w_force` rather than
  `boot_a`, and the hard-won operational rule "write one large partition
  per FDL session." None of that is guessable from the generic chapters —
  it's why §10's device profile exists.
- **Unlock is the confirmed UNISOC path, not AOSP fastboot**: it uses
  `patrislav1/unisoc-unlock` (the tool §9.4 now cites), consistent with
  what the Anbernic profile records.
- **Dual-boot as the safe default**: stock Android stays on eMMC, RGOS
  boots from microSD (card in → RGOS, card out → Android), so the
  irreversible-flash risk (§12) is sidestepped entirely during
  development — pulling the card is the recovery path.

The repo also illustrates the §12 lesson the hard way: its handoff log
records multiple filesystem-corruption incidents on eMMC writes (the same
ADMA bug above), which is exactly why "verify the restore path and prefer
a reversible boot medium" is in the guide at all.

## Per-SoC-vendor mainlining efforts

Beyond the full-device projects above, several SoC-vendor-focused
upstream efforts are worth tracking directly, since they determine how
much of §4's "pick a kernel base" decision tilts toward mainline for your
specific chip:

- **Qualcomm mainline** (`linux-arm-msm` list; Linaro, Qualcomm and postmarketOS's per-SoC `*-mainline` groups) — mainline Snapdragon
  support; the most mature effort of any vendor (§9.1).
- **MediaTek mainline** (`linux-mediatek` list) (Collabora/BayLibre), rapidly
  improving for recent Dimensity chips (§9.2).
- **Exynos mainline** (`linux-samsung-soc` list), strongest for
  standalone Exynos (Chromebooks, Exynos Auto) and growing for phone SoCs
  (§9.3).
- **`linux-sunxi`**, **`linux-rockchip`**, **`linux-tegra`** — the three
  most mature *tablet*-class mainlining communities; if your device uses
  one of these chips (§9.6), check here before anything else.

## How to use these in this repo

When porting a specific device, create a new directory here, e.g.
`docs/android-linux-porting/devices/<codename>/`, and track:

- `inventory.md` — your completed §3 hardware table for that device.
- `kernel-diff.md` — what you changed vs. the vendor/BSP kernel, and why
  (link each change back to the RE notes that justified it, per §2.3).
- `status.md` — subsystem-by-subsystem working/broken/blob-shimmed status,
  in the same spirit as postmarketOS's wiki pages.

Never commit extracted vendor binaries themselves (kernel modules, HAL
`.so` files, firmware blobs) — only the notes, patches, and
`proprietary-blobs.txt`-style manifests describing how to re-extract them
from a firmware dump the device owner already has.
