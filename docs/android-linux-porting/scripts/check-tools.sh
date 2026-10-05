#!/usr/bin/env bash
# Report which command-line tools from 07-tools-reference.md are
# installed on this machine, with install hints for anything missing.
# Read-only — never installs anything itself.
#
# Usage: check-tools.sh

set -uo pipefail

check() {
  local name="$1" hint="$2"
  if command -v "$name" >/dev/null 2>&1; then
    printf "  [x] %-24s %s\n" "$name" "$(command -v "$name")"
  else
    printf "  [ ] %-24s missing -- %s\n" "$name" "$hint"
  fi
}

echo "== Dumping & unpacking (01-firmware-dumping.md) =="
check unpack_bootimg "AOSP system/tools/mkbootimg (android.googlesource.com), or distro mkbootimg package"
check extract-dtb    "pip install extract-dtb"
check dtc            "distro package: device-tree-compiler"
check simg2img       "Debian/Ubuntu: android-sdk-libsparse-utils"
check fsck.erofs     "distro package: erofs-utils (>= 1.5)"
check mtk            "mtkclient's CLI -- install per github.com/bkerler/mtkclient README (MediaTek)"
check heimdall       "distro package heimdall-flash, or github.com/Benjamin-Dobell/Heimdall (Samsung)"
check rkdeveloptool  "build from github.com/rockchip-linux/rkdeveloptool (Rockchip)"
check sunxi-fel      "distro package: sunxi-tools (Allwinner)"
check binwalk        "pip install binwalk"

echo
echo "== Reverse engineering (02-reverse-engineering-ghidra.md) =="
check jadx    "distro package, or releases at github.com/skylot/jadx"
check radare2 "distro package, or github.com/radareorg/radare2"
echo "  [ ] ghidra                   GUI install, not CLI-checkable -- see ghidra-sre.org"

echo
echo "== Kernel & device tree (04-kernel-porting.md) =="
check aarch64-linux-gnu-gcc "distro package gcc-aarch64-linux-gnu, or use the Android NDK clang toolchain"
check git                   "distro package: git (needed by extract-kernel-config.sh)"

echo
echo "== Userspace / rootfs (05-rootfs-and-userspace.md) =="
check pmbootstrap "pip install --user pmbootstrap -- see wiki.postmarketos.org"
check debootstrap "distro package: debootstrap"
check clickable   "UBports app build tool, optional -- see docs.ubports.com"

echo
echo "== Boot chain & flashing (06-bootloader-and-flashing.md) =="
check mkbootimg "AOSP system/tools/mkbootimg, or distro android-tools"
check avbtool   "AOSP external/avb"
check fastboot  "distro package: android-tools / fastboot"
check adb       "distro package: android-tools / adb"
check sgdisk    "distro package: gdisk"

echo
echo "Note: Ghidra, SP Flash Tool, QFIL/QPST, Odin, and other GUI-only"
echo "vendor tools aren't meaningfully checkable via 'command -v' -- verify"
echo "those manually per 07-tools-reference.md and 09-soc-vendor-specifics.md."
