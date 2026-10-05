# 7. Tool Reference

Run [scripts/check-tools.sh](scripts/check-tools.sh) to see which of the
tools below are already installed on this machine, with install hints
for anything missing.

## Dumping & unpacking (§1)
| Tool | Purpose | Source |
|---|---|---|
| `payload_dumper` / `update-payload-extractor` | Extract partitions from Android OTA `payload.bin` | github.com/vm03/payload_dumper |
| `unpack_bootimg` / Android-Image-Kitchen | Split `boot.img` into kernel/ramdisk/dtb | AOSP `system/tools/mkbootimg`; github.com/osm0sis/Android-Image-Kitchen |
| `extract-dtb` | Pull DTBs out of a kernel image/appended blob | github.com/PabloCastellano/extract-dtb |
| `dtc` (device-tree-compiler) | `.dtb` ⇄ `.dts` conversion | distro package `device-tree-compiler` |
| `scripts/extract-ikconfig` | Recover `.config` from a raw kernel binary | in any `torvalds/linux` checkout |
| `simg2img` | Android sparse image → raw image | distro package `android-tools`/`simg2img` |
| `fsck.erofs --extract` | Extract EROFS-formatted `system`/`vendor` images | github.com/erofs/erofs-utils |
| `qdl` / `edl.py` | Qualcomm EDL-mode full partition dump on unbootable devices | github.com/linux-msm/qdl, github.com/bkerler/edl |
| `mtkclient` | MediaTek BROM/Preloader mode dump/unbrick | github.com/bkerler/mtkclient |
| `unisoc-unlock` (`pip install unisoc-unlock`) | UNISOC bootloader unlock on Anbernic's T618/T820 handheld line (confirmed working via the GammaOS project, §9.4) | pypi.org/project/unisoc-unlock, github.com/TheGammaSqueeze/GammaOSNext |
| `Heimdall` | Samsung Exynos Odin-protocol dump/flash | github.com/Benjamin-Dobell/Heimdall |
| `sunxi-tools` (`sunxi-fel`) | Allwinner FEL-mode dump/flash | github.com/linux-sunxi/sunxi-tools |
| `rkdeveloptool` | Rockchip maskrom-mode dump/flash | github.com/rockchip-linux/rkdeveloptool |
| `nvflash` / `tegrarcm` | NVIDIA Tegra APX/RCM-mode dump/flash | developer.nvidia.com, github.com/NVIDIA/tegrarcm |
| `sgdisk` / `parted` | Inspect/edit GPT partition tables on a raw storage dump | distro package `gdisk`/`parted` |

## Reverse engineering (§2)
| Tool | Purpose |
|---|---|
| Ghidra | Primary disassembler/decompiler for ARM/AArch64 ELFs, raw bootloader binaries |
| `ghidra_bridge` | Script Ghidra from external Python for batch analysis across many `.ko`/`.so` |
| BinDiff (or Ghidra's built-in version tracking) | Diff vendor binaries against known/mainline equivalents |
| `jadx` | Decompile the Java/Kotlin side of HALs when logic lives in a `.jar`/APK rather than native `.so` |
| `radare2`/`r2ghidra` | Scriptable alternative/companion to Ghidra for quick triage |

## Kernel & device tree (§3-4)
| Tool | Purpose |
|---|---|
| `aarch64-linux-gnu-gcc` / Android NDK's `clang` toolchain | Cross-compiling the kernel |
| `dtc` | Building/validating device trees |
| `scripts/diffconfig` (in-tree) | Compare `.config` against the vendor's recovered `kernel.config` |
| LineageOS/CodeLinaro (ex-CodeAurora)/MediaTek kernel source mirrors | Starting point for a real (non-RE'd) kernel base |

## Userspace / Halium (§5)
| Tool | Purpose |
|---|---|
| `libhybris` | Bionic↔glibc ABI bridge for reusing Android HALs on a glibc rootfs |
| `halium-boot` / `hybris-boot` | Build scripts/device-repo layout for the Android HAL container |
| `droidmedia` | Camera/media HAL bridge used by Halium ports |
| `pmbootstrap` | postmarketOS build/porting tool, has built-in Halium device-porting mode |
| `clickable` | UBports/Ubuntu Touch *app* build tool (not device-porting tooling) |
| `debootstrap` | From-scratch Debian/Ubuntu rootfs build |

## Boot chain & flashing (§6)
| Tool | Purpose |
|---|---|
| `mkbootimg` / `mkbootfs` | Repack kernel+ramdisk+dtb into a flashable `boot.img` |
| `avbtool` | Re-sign/patch `vbmeta` for Android Verified Boot on unlocked devices |
| `fastboot` | Flash/boot images over USB in bootloader mode |
| `adb` | Shell access, file pull/push, log capture on a bootable device |
| Vendor unlock tool (varies) | OEM bootloader-unlock step required before any of this is possible |

## General
| Tool | Purpose |
|---|---|
| `binwalk` | Quick firmware-blob format/entropy triage before deciding how to unpack something |
| `strings` / `file` / `readelf` / `objdump` | Fast first-pass triage before reaching for Ghidra |
| Serial/USB-UART adapter | Hardware debug console — buy one before you need it |
