#!/usr/bin/env bash
#
# flash.sh — flash the Halium boot image (and optionally the Ubuntu Touch
# rootfs) to the Blackview BL6000 Pro (mt6873).
#
# The bootloader must already be UNLOCKED (it is — see README). The device is
# put into fastboot mode automatically if it is currently booted with adb.
#
# Usage:
#   ./flash.sh                 # flash halium-boot.img only
#   ./flash.sh --with-rootfs   # also flash the Ubuntu Touch system image
#   HALIUM_SRC=/path ./flash.sh
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HALIUM_SRC="${HALIUM_SRC:-${HOME}/halium-11.0}"
PRODUCT_OUT="${HALIUM_SRC}/out/target/product/BL6000Pro"
BOOT_IMG="${PRODUCT_OUT}/halium-boot.img"
WITH_ROOTFS=0
[[ "${1:-}" == "--with-rootfs" ]] && WITH_ROOTFS=1

command -v fastboot >/dev/null 2>&1 || { echo "ERROR: fastboot not found" >&2; exit 1; }

if [[ ! -f "${BOOT_IMG}" ]]; then
    echo "ERROR: ${BOOT_IMG} not found. Run ./build.sh first." >&2
    exit 1
fi

# Ensure the device is in fastboot mode.
if ! fastboot devices | grep -q .; then
    if adb devices | grep -qw device; then
        echo "==> Rebooting into fastboot mode..."
        adb reboot bootloader
        echo "==> Waiting for fastboot..."
        until fastboot devices | grep -q .; do sleep 2; done
    else
        echo "ERROR: no device in fastboot or adb mode." >&2
        echo "       Power off, hold Volume-Up, plug in USB (BROM), or" >&2
        echo "       'adb reboot bootloader' from a booted system." >&2
        exit 1
    fi
fi

echo "==> Device: $(fastboot getvar product 2>&1 | grep -i product || echo unknown)"

# Verified boot is disabled in BoardConfig.mk; flash a disabled vbmeta so the
# stock AVB chain does not reject the custom boot image.
if [[ -f "${PRODUCT_OUT}/vbmeta.img" ]]; then
    echo "==> Flashing disabled vbmeta"
    fastboot --disable-verity --disable-verification flash vbmeta "${PRODUCT_OUT}/vbmeta.img"
fi

echo "==> Flashing halium-boot.img -> boot"
fastboot flash boot "${BOOT_IMG}"

if [[ ${WITH_ROOTFS} -eq 1 ]]; then
    # The Ubuntu Touch rootfs is delivered as the system image (Halium-11 GSI
    # + UBports overlay). Flash it to the dynamic 'system' partition.
    SYSTEM_IMG="${PRODUCT_OUT}/system.img"
    if [[ -f "${SYSTEM_IMG}" ]]; then
        echo "==> Flashing Ubuntu Touch rootfs -> system (via fastbootd)"
        fastboot reboot fastboot          # userspace fastboot for logical parts
        until fastboot devices | grep -q .; do sleep 2; done
        fastboot flash system "${SYSTEM_IMG}"
        fastboot reboot bootloader
    else
        echo "WARNING: ${SYSTEM_IMG} not found; skipping rootfs flash." >&2
    fi
fi

if [[ "${WIPE:-0}" == "1" ]]; then
    echo "==> Wiping userdata (WIPE=1)"
    fastboot -w
else
    echo "==> Not wiping userdata (set WIPE=1 for a clean first install)"
fi

echo "==> Rebooting"
fastboot reboot

echo
echo "==> Done. The device should now boot Ubuntu Touch."
echo "    If it hangs, check 'fastboot flash' output and the halium-boot ramdisk."
echo "    To revert to stock: see ../docs/BACKUP-RESTORE.md (BROM restore)."
