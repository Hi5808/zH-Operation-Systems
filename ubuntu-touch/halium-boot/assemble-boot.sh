#!/usr/bin/env bash
#
# assemble-boot.sh - Build a halium-boot.img for the BL6000 Pro (Phase 3).
#
# Two modes:
#
#   A) FROM THE HALIUM BUILD (normal path):
#      The Halium build produces out/target/product/BL6000Pro/halium-boot.img
#      with the hybris init + libhybris ramdisk. This script then injects the
#      DEVICE-SPECIFIC bits (fstab.mt6873, init hooks) into that ramdisk.
#
#   B) FROM STOCK boot.img (dry-run / pipeline test, no Halium tree needed):
#      Repacks the STOCK boot.img with the device overlay so you can verify the
#      repack pipeline and the boot header offsets BEFORE the full build. This
#      image boots the stock kernel + Android init (it will NOT boot Ubuntu
#      Touch - that needs the hybris ramdisk from mode A) but proves the
#      toolchain and offsets are correct.
#
# Usage:
#   ./assemble-boot.sh                # mode B: from stock boot.img (default)
#   ./assemble-boot.sh <halium-boot.img>   # mode A: inject into Halium output
#
# Requires: abootimg, cpio, gzip/lz4.
#
set -euo pipefail

# SUPERSEDED (2026-10-04): the stock boot.img is header v2 with a DTB section;
# abootimg (used below) only understands v0/v1 and silently DROPS the DTB.
# Use tools/repack-boot.sh (AOSP mkbootimg, verified byte-identical to stock).
echo "assemble-boot.sh is superseded: use tools/repack-boot.sh (header v2 + DTB)" >&2
exit 1

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${HERE}/../.." && pwd)"
DEVICE_DIR="${PROJECT_ROOT}/ubuntu-touch/device/blackview/BL6000Pro"
OVERLAY="${HERE}/ramdisk-overlay"
WORK="${HERE}/work"
OUT="${OUT:-${HERE}/$([[ $# -ge 1 ]] && echo halium-boot.img || echo stock-repack-test.img)}"

STOCK_BOOT="${STOCK_BOOT:-${PROJECT_ROOT}/images/boot.img}"
INPUT_BOOT="${1:-${STOCK_BOOT}}"

for tool in abootimg cpio; do
    command -v "${tool}" >/dev/null 2>&1 || { echo "ERROR: need ${tool}"; exit 1; }
done
[[ -f "${INPUT_BOOT}" ]] || { echo "ERROR: boot image not found: ${INPUT_BOOT}"; exit 1; }

echo "=== Assembling halium-boot.img ==="
echo "  input boot : ${INPUT_BOOT}"
echo "  overlay    : ${OVERLAY}"

rm -rf "${WORK}"; mkdir -p "${WORK}/ramdisk"
cd "${WORK}"

# 1. Split the boot image (kernel + ramdisk + header config).
echo "--- [1/5] unpacking boot image (abootimg) ---"
abootimg -x "${INPUT_BOOT}"
[[ -f bootimg.cfg ]] || { echo "ERROR: abootimg did not produce bootimg.cfg"; exit 1; }
echo "  kernel  : $(ls -la zImage 2>/dev/null | awk '{print $5}') bytes"
echo "  ramdisk : $(ls -la initrd.img 2>/dev/null | awk '{print $5}') bytes"

# 2. Unpack the ramdisk (cpio; may be gzip or lz4 compressed).
echo "--- [2/5] unpacking ramdisk ---"
cd ramdisk
if gzip -t ../initrd.img 2>/dev/null; then
    zcat ../initrd.img | cpio -idm 2>/dev/null
elif lz4 -t ../initrd.img 2>/dev/null; then
    lz4 -dc ../initrd.img | cpio -idm 2>/dev/null
else
    cpio -idm < ../initrd.img 2>/dev/null
fi
echo "  ramdisk entries: $(find . | wc -l)"
cd ..

# 3. Inject the device-specific overlay.
echo "--- [3/5] injecting device overlay ---"
if [[ -d "${OVERLAY}" ]]; then
    cp -a "${OVERLAY}/." ramdisk/
    echo "  copied overlay: $(cd "${OVERLAY}" && find . -type f | wc -l) files"
else
    echo "  (no overlay dir yet)"
fi
# Always refresh the fstab from the device tree (ground-truth corrected).
if [[ -f "${DEVICE_DIR}/rootdir/etc/fstab.mt6873" ]]; then
    cp "${DEVICE_DIR}/rootdir/etc/fstab.mt6873" ramdisk/fstab.mt6873
    echo "  installed corrected fstab.mt6873"
fi

# 4. Repack the ramdisk (gzip cpio, the format abootimg/MTK expect).
echo "--- [4/5] repacking ramdisk ---"
cd ramdisk
find . | cpio -o -H newc 2>/dev/null | gzip -9 > ../initrd-new.img
cd ..
echo "  new ramdisk: $(ls -la initrd-new.img | awk '{print $5}') bytes"

# 5. Repack the boot image with the original header/offsets.
echo "--- [5/5] repacking boot image (abootimg) ---"
abootimg --create "${OUT}" -f bootimg.cfg -k zImage -r initrd-new.img
echo
echo "=== Done ==="
ls -la "${OUT}"
echo
echo "Header used (must match stock so LK loads it at the right address):"
grep -E 'bootsize|kerneladdr|ramdiskaddr|secondaddr|tagsaddr|pagesize|cmdline' bootimg.cfg || true
echo
echo "NOTE:"
echo "  - Mode B output boots stock kernel+init (pipeline/offset test only)."
echo "  - For a real Ubuntu Touch boot, run mode A on the Halium build's"
echo "    halium-boot.img so the hybris init/libhybris ramdisk is present."
