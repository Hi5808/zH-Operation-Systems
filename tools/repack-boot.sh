#!/usr/bin/env bash
#
# repack-boot.sh - build a BL6000 Pro boot.img (Android boot header v2).
#
# The stock image is header v2 with a separate DTB section (a dt_table), so
# abootimg (v0/v1 only) must NOT be used: it silently drops the DTB.
# All addresses below reproduce the stock header byte-for-byte (verified).
#
# AVB: this LK loads boot via AVB. The partition MUST end with a valid AVB
# footer whose vbmeta lies right after the image; otherwise LK logs
# "Magic is incorrect" and panics on g_boot_info.hdr_loaded (lk_crash loop).
# A stale stock footer only works for images <= 13938688 bytes, so we always
# add our own hash footer (unsigned; accepted while unlocked/orange).
# PART_SIZE=41943040 for the recovery partition.
#
# Usage: repack-boot.sh <kernel Image.gz> <ramdisk> <dtb/dt_table> <out.img> [cmdline]
#
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
[[ $# -ge 4 ]] || { echo "usage: $0 <kernel> <ramdisk> <dtb> <out.img> [cmdline]" >&2; exit 1; }
python3 "${HERE}/mkbootimg.py" \
    --header_version 2 \
    --kernel "$1" --ramdisk "$2" --dtb "$3" \
    --base 0x40078000 --kernel_offset 0x00008000 \
    --ramdisk_offset 0x07c08000 --tags_offset 0x0bc08000 \
    --dtb_offset 0x0bc08000 --second_offset 0xbff88000 \
    --pagesize 2048 --os_version 11.0.0 --os_patch_level 2021-12 \
    --cmdline "${5:-bootopt=64S3,32N2,64N2 buildvariant=user}" \
    -o "$4"
python3 "${HERE}/avbtool.py" add_hash_footer --image "$4" \
    --partition_name "${PART_NAME:-boot}" --partition_size "${PART_SIZE:-33554432}"
