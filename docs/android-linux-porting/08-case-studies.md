# 8. Case Studies & Reference Projects

Real-world projects that followed this exact dump → RE → port pipeline.
Reading their device-porting trees is more valuable than any amount of
abstract guidance — they are the ground truth for "what does a finished
version of each step in this guide actually look like."

## Halium / UBports (Ubuntu Touch)

- **Project**: github.com/Halium, UBports (ubuntu-touch.io)
- **Approach**: exactly the mixed native-kernel + Android-HAL-container
  strategy described in §5.1A. Device ports live in `device/<vendor>/<codename>`
  + `vendor/<vendor>/<codename>` repos, each containing a `proprietary-blobs.txt`
  manifest rather than committed binaries.
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
  in §3.4/§5.1.
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
