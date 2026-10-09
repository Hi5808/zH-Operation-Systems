# 7. Tool Reference

Run [scripts/check-tools.sh](scripts/check-tools.sh) to see which of the
tools below are already installed on this machine, with install hints
for anything missing.

## 7.0 One-command environment setup (Debian / Ubuntu)

The fastest way to make sure none of §1–§6 ever hits a "command not found".
Package names below are **verified on Ubuntu 26.04 LTS** (adjust for older
releases — e.g. `7zip` was `p7zip-full`, `qemu-user-binfmt` was
`qemu-user-static`). Three tiers: distro packages (`apt`), Python libraries
(`pip`), and a short list that isn't packaged and must be fetched manually.

### apt — distro packages (one line, paste as-is)

```sh
sudo apt update && sudo apt install -y erofs-utils android-sdk-libsparse-utils f2fs-tools e2fsprogs dosfstools mtools squashfs-tools cramfsswap cpio cabextract libguestfs-tools adb fastboot android-sdk-platform-tools android-sdk-platform-tools-common mkbootimg abootimg lz4 zstd brotli unzip 7zip device-tree-compiler u-boot-tools build-essential bison flex libssl-dev bc kmod libncurses-dev gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu gcc-arm-linux-gnueabi gcc-arm-none-eabi binutils-multiarch binwalk foremost sleuthkit radare2 gdb gdb-multiarch strace ltrace file xxd hexedit bsdextrautils ripgrep git openssl default-jdk qemu-user qemu-user-binfmt qemu-system-arm python3-pip python3-dev pipx libusb-1.0-0-dev python3-serial minicom screen
```

> Keep it **one physical line**. Backslash-continued multi-line `apt` commands
> frequently break on copy-paste (the tail package names get run as standalone
> shell commands and silently skipped) — if you must split it, end every line
> with a real ` \` and a newline, or just use the single line above.

Which package provides the binary each step calls:

| Binary | Package |
|---|---|
| `simg2img`, `img2simg` | `android-sdk-libsparse-utils` |
| `fsck.erofs --extract`, `dump.erofs` | `erofs-utils` |
| `debugfs`, `mke2fs`, `dumpe2fs` | `e2fsprogs` |
| `unpack_bootimg`, `mkbootimg` | `mkbootimg` |
| `guestfish`, `virt-*` (read any FS without root/loop mount) | `libguestfs-tools` |
| `unsquashfs` / `mksquashfs` | `squashfs-tools` |
| `dtc` | `device-tree-compiler` |
| `mkimage`, `dumpimage` | `u-boot-tools` |
| `aarch64-linux-gnu-gcc` / `arm-linux-gnueabi-gcc` | `gcc-aarch64-linux-gnu` / `gcc-arm-linux-gnueabi` |
| `qemu-aarch64` (run arm64 binaries via `binfmt_misc`) | `qemu-user` + `qemu-user-binfmt` |
| `objdump`, `readelf` for non-native targets | `binutils-multiarch`, `binutils-aarch64-linux-gnu` |

### pip — Python RE libraries (userspace, no sudo)

```sh
pip3 install --user --break-system-packages capstone keystone-engine unicorn lief pwntools zstandard python-lzo ubi_reader jefferson uefi_firmware
pipx install ropper
```

`ubi_reader` + `jefferson` give `binwalk` its UBIFS/JFFS2 extractors;
`capstone`/`keystone`/`unicorn`/`lief` are the scripting backbone for
disasm/asm/emulation and ELF surgery.

### Not in apt — fetch manually (verify checksums before running)

| Tool | Purpose | Source |
|---|---|---|
| **Ghidra** | Primary decompiler (§2); uses the `default-jdk` installed above | github.com/NationalSecurityAgency/ghidra (releases) |
| **`lpunpack` / `lpdump`** | Split a dynamic `super.img` into `vendor`/`system`/`product`/`odm` | AOSP `system/extras/partition_tools` (prebuilt in Android "otatools") |
| **`avbtool`** | AVB/`vbmeta` inspect + re-sign (§6, §12) | AOSP `external/avb/avbtool.py` (single file) |
| **`payload-dumper-go`** | Fast `payload.bin` (OTA) extraction | github.com/ssut/payload-dumper-go (releases) |
| **`sasquatch`** | Vendor-mangled SquashFS that stock `unsquashfs` rejects | github.com/devttys0/sasquatch (build) |

> **No `lpunpack`? You don't strictly need it.** A dynamic `super.img` is a
> documented liblp container: 4096-byte reserved region, then the geometry
> (magic `0x616c4467`) at offset 4096, the metadata header (magic
> `0x414C5030`) at 12288, then packed partition + extent tables. It's ~40 lines
> of Python to parse: sector size is 512, each partition's extents give a
> `target_data`×512 byte offset and `num_sectors`×512 length, so you can `dd`
> out `vendor.img` directly and then `fsck.erofs --extract` it. This also
> recovers partitions from a **partial/retrofit** super dump that `lpunpack`
> refuses to open. See [10-device-profile-template.md](10-device-profile-template.md)
> and the Anbernic RG405M device notes for a worked example.

After installing, re-run [scripts/check-tools.sh](scripts/check-tools.sh) to
confirm the kit is complete.

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
| `analyzeHeadless` (ships with Ghidra, `support/analyzeHeadless`) | Ghidra's headless CLI — import + auto-analyze + run a script over a binary with no GUI; the basis for batch-processing a device's vendor modules in CI/scripts |
| **PyGhidra** (bundled since Ghidra 11.3; formerly the `pyhidra` project) | Drive Ghidra's full API from CPython — scripts and an interactive interpreter against a real Python 3, instead of Jython |
| Ghidra scripting (Jython / Java `GhidraScript`) | In-GUI or headless scripts using the built-in interpreter, no external deps |
| `ghidra_bridge` | Script a *running* Ghidra instance from an external CPython process (predates PyGhidra; still handy for driving an open GUI session) |
| BinDiff (+ BinExport) or Ghidra's built-in Version Tracking | Diff vendor binaries against known/mainline equivalents |
| `jadx` | Decompile the Java/Kotlin side of HALs when logic lives in a `.jar`/APK rather than native `.so` |
| `radare2`/`r2ghidra`, `Cutter` | Scriptable alternative/companion to Ghidra (r2ghidra embeds Ghidra's decompiler; Cutter is radare2's GUI) for quick triage |

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
