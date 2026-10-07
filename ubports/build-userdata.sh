#!/bin/bash
# build-userdata.sh - ext4 userdata image holding rootfs.img + android-rootfs.img
# side by side (Halium "halium" file layout). Features limited so the phone's
# e2fsck 1.43 / kernel 4.14 can replay the journal after an unclean reboot.
set -euo pipefail
# Overlay and debs come from this repo; the big inputs (UT tarball, halium/)
# and the output images live in the work dir (UT_WORK).
export R="$(cd "$(dirname "$0")" && pwd)"
cd "${UT_WORK:-$HOME/bl6000pro-work/ut}"
rm -rf ud userdata.img; mkdir ud
cp --sparse=always rootfs.img ud/rootfs.img
cp halium/system/var/lib/lxc/android/android-rootfs.img ud/android-rootfs.img
SZ=$(( $(du -m --apparent-size rootfs.img | cut -f1) + 1536 ))
mke2fs -q -t ext4 -O ^orphan_file,^metadata_csum_seed -L userdata -d ud userdata.img ${SZ}M
e2fsck -fn userdata.img >/dev/null && echo "userdata.img OK"
