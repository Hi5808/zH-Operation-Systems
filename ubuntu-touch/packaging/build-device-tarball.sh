#!/usr/bin/env bash
#
# build-device-tarball.sh - Package the BL6000 Pro port into a UBports
# device/OTA tarball (Phase 8).
#
# A UBports install/OTA needs three things bundled per device:
#   1. halium-boot.img        - the boot image (kernel + hybris ramdisk)
#   2. the Ubuntu Touch rootfs (system image, or the super rewrite)
#   3. device config          - device.yaml + the rootfs-overlay customizations
#
# This script assembles those into a tarball suitable for publishing to a
# UBports system-image channel, or for a manual `fastboot flash` install.
#
# It does NOT build the rootfs (that comes from the Halium/UBports build); it
# packages what the build produced plus this port-tree's device overlay.
#
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UT="$(cd "${HERE}/.." && pwd)"
PROJECT_ROOT="$(cd "${UT}/.." && pwd)"

HALIUM_SRC="${HALIUM_SRC:-$HOME/halium-11.0}"
OUT_PRODUCT="${HALIUM_SRC}/out/target/product/BL6000Pro"
STAGING="${HERE}/staging"
TARBALL="${HERE}/bl6000pro-ubports-$(date +%Y%m%d).tar.xz"

echo "=== Packaging BL6000 Pro for UBports ==="
rm -rf "${STAGING}"; mkdir -p "${STAGING}"

# 1. Boot image.
if [[ -f "${OUT_PRODUCT}/halium-boot.img" ]]; then
    cp "${OUT_PRODUCT}/halium-boot.img" "${STAGING}/"
    echo "  + halium-boot.img (from build)"
elif [[ -f "${UT}/halium-boot/halium-boot.img" ]]; then
    cp "${UT}/halium-boot/halium-boot.img" "${STAGING}/"
    echo "  + halium-boot.img (from assemble-boot.sh - pipeline test image)"
else
    echo "  ! no halium-boot.img found (run the Halium build or assemble-boot.sh)"
fi

# 2. Rootfs / system image (from the build, if present).
for img in system.img halium-system.img super.img; do
    [[ -f "${OUT_PRODUCT}/${img}" ]] && cp "${OUT_PRODUCT}/${img}" "${STAGING}/" && echo "  + ${img}"
done

# 3. Device config + overlay.
cp "${HERE}/device.yaml" "${STAGING}/"
echo "  + device.yaml"
if [[ -d "${UT}/rootfs-overlay" ]]; then
    mkdir -p "${STAGING}/rootfs-overlay"
    cp -a "${UT}/rootfs-overlay/." "${STAGING}/rootfs-overlay/"
    echo "  + rootfs-overlay/ (udev rules, wifi/bt loader)"
fi
# Include the disabled-verification vbmeta + stock dtbo from the port artifacts.
for f in "${PROJECT_ROOT}/images/vbmeta.img" "${PROJECT_ROOT}/images/dtbo.img"; do
    [[ -f "${f}" ]] && cp "${f}" "${STAGING}/" && echo "  + $(basename "${f}")"
done

# 4. A manifest of what's inside + checksums.
( cd "${STAGING}" && sha256sum * > SHA256SUMS 2>/dev/null || true )
cat > "${STAGING}/INSTALL.txt" <<'EOF'
BL6000 Pro (mt6873) - Ubuntu Touch / Halium install
===================================================
Prereq: bootloader UNLOCKED, and a BROM backup taken (scripts/backup-all.sh).

Fastboot install:
  fastboot flash boot   halium-boot.img
  fastboot flash vbmeta vbmeta.img          # disabled-verification variant
  fastboot flash dtbo   dtbo.img
  # rootfs: either flash the system/super image, or sideload per the UBports
  #         device instructions for this channel.
  fastboot reboot

See ubuntu-touch/flash.sh and docs/UNBRICK-BROM.md (recovery).
EOF
echo "  + INSTALL.txt + SHA256SUMS"

# 5. Tar it up.
echo "--- creating tarball ---"
tar -C "${STAGING}" -cJf "${TARBALL}" .
echo
echo "=== Done ==="
ls -la "${TARBALL}"
echo "  staging dir : ${STAGING}"
echo
echo "To publish: upload ${TARBALL} to the UBports system-image channel for"
echo "this device (set ota.channel in device.yaml), or extract + fastboot flash."
