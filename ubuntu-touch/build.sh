#!/usr/bin/env bash
#
# build.sh — build halium-boot.img (and the Ubuntu Touch image) for the
# Blackview BL6000 Pro (mt6873), Halium-11.0.
#
# This drives a standard Halium/LineageOS build tree. Prerequisites:
#   - A Halium-11.0 source tree synced with repo (see manifests/).
#   - The device tree + vendor tree from this directory placed in the source
#     tree at device/blackview/BL6000Pro and vendor/blackview/BL6000Pro.
#   - ~250 GB free disk, 16 GB+ RAM.
#
# Usage:
#   ./build.sh                 # full build (halium-boot + GSI pairing)
#   ./build.sh bootimage       # only halium-boot.img
#   HALIUM_SRC=/path/to/src ./build.sh
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HALIUM_SRC="${HALIUM_SRC:-${HOME}/halium-11.0}"
LUNCH_TARGET="${LUNCH_TARGET:-lineage_BL6000Pro-userdebug}"
TARGET="${1:-all}"

if [[ ! -d "${HALIUM_SRC}" ]]; then
    echo "ERROR: Halium source tree not found at ${HALIUM_SRC}" >&2
    echo "       Sync it first (see manifests/blackview_BL6000Pro.xml)." >&2
    exit 1
fi

# 1. Make sure the prebuilt kernel exists (BoardConfig.mk needs it).
if [[ ! -f "${SCRIPT_DIR}/device/blackview/BL6000Pro/prebuilt/kernel/Image.gz-dtb" ]]; then
    echo "==> Prebuilt kernel missing; extracting from the stock boot image..."
    "${SCRIPT_DIR}/device/blackview/BL6000Pro/extract-kernel.sh"
fi

# 2. Make sure the vendor blobs + makefiles exist.
VENDOR_MK="${SCRIPT_DIR}/vendor/blackview/BL6000Pro/BL6000Pro-vendor.mk"
if [[ ! -f "${VENDOR_MK}" ]]; then
    echo "==> Vendor makefiles missing; generating from proprietary-files.txt..."
    "${SCRIPT_DIR}/device/blackview/BL6000Pro/extract-files.sh"
    "${SCRIPT_DIR}/device/blackview/BL6000Pro/setup-makefiles.sh"
fi

# 3. Link the device + vendor trees into the Halium source if not present.
for pair in \
    "device/blackview/BL6000Pro:${SCRIPT_DIR}/device/blackview/BL6000Pro" \
    "vendor/blackview/BL6000Pro:${SCRIPT_DIR}/vendor/blackview/BL6000Pro"; do
    dst="${HALIUM_SRC}/${pair%%:*}"
    src="${pair##*:}"
    mkdir -p "$(dirname "${dst}")"
    [[ -e "${dst}" ]] || ln -s "${src}" "${dst}"
done

# 4. Build.
cd "${HALIUM_SRC}"
# shellcheck disable=SC1091
source build/envsetup.sh
lunch "${LUNCH_TARGET}"

case "${TARGET}" in
    bootimage)
        echo "==> Building halium-boot.img only"
        mka halium-bootimage -j"$(nproc)"
        ;;
    all)
        echo "==> Building halium-boot.img + system (GSI pairing)"
        mka halium-bootimage -j"$(nproc)"
        # The Ubuntu Touch rootfs + GSI are assembled by the UBports build
        # system (halium-build / ubuntu-touch-rootfs), not by mka. See README.
        ;;
    *)
        echo "Usage: $0 [all|bootimage]" >&2
        exit 1
        ;;
esac

echo
echo "==> Build complete."
echo "    halium-boot.img : ${HALIUM_SRC}/out/target/product/BL6000Pro/halium-boot.img"
echo "    Next: ./flash.sh to flash to the device."
