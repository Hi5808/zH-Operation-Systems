#!/usr/bin/env bash
#
# extract-kernel.sh — unpack the prebuilt kernel from the stock boot image.
#
# BoardConfig.mk builds halium-boot.img against TARGET_PREBUILT_KERNEL, which
# points at prebuilt/kernel/Image.gz-dtb. This script produces that file from
# the dumped stock boot image (images/boot.img or images/partitions/boot.img).
#
# MediaTek mt6873 uses a standard Android boot image header, so any of the
# common unpackers works. We try them in order of preference.
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# ROOT contains device/ and vendor/; the firmware dump is one level above it.
ROOT="$(cd "${SCRIPT_DIR}/../../.." && pwd)"
PROJ_ROOT="$(cd "${ROOT}/.." && pwd)"

# Locate the stock boot image. It may live at images/boot.img or
# images/partitions/boot.img depending on how the dump was organised.
find_boot_img() {
    local c
    for c in \
        "${BOOT_IMG:-}" \
        "${PROJ_ROOT}/images/boot.img" \
        "${PROJ_ROOT}/images/partitions/boot.img"; do
        [[ -n "${c}" && -f "${c}" ]] && { echo "${c}"; return 0; }
    done
    return 1
}

if ! BOOT_IMG="$(find_boot_img)"; then
    echo "ERROR: stock boot image not found." >&2
    echo "       Looked in: images/boot.img, images/partitions/boot.img" >&2
    echo "       Re-dump it: cd /tmp/mtkclient && python3 mtk.py r boot <path>/boot.img" >&2
    exit 1
fi
OUT_DIR="${SCRIPT_DIR}/prebuilt/kernel"

mkdir -p "${OUT_DIR}"
WORK="$(mktemp -d)"
trap 'rm -rf "${WORK}"' EXIT

echo "==> Unpacking ${BOOT_IMG}"

# --- Method 1: AOSP unpack_bootimg (preferred, exact) ------------------------
if command -v unpack_bootimg >/dev/null 2>&1; then
    unpack_bootimg --boot_img "${BOOT_IMG}" --out "${WORK}" >/dev/null
    KERNEL="${WORK}/kernel"
# --- Method 2: magiskboot (works without an AOSP tree) -----------------------
elif command -v magiskboot >/dev/null 2>&1; then
    (cd "${WORK}" && magiskboot unpack -n "${BOOT_IMG}" >/dev/null)
    KERNEL="${WORK}/kernel"
# --- Method 3: abootimg (last resort, older images) --------------------------
elif command -v abootimg >/dev/null 2>&1; then
    (cd "${WORK}" && abootimg -x "${BOOT_IMG}" >/dev/null)
    KERNEL="${WORK}/zImage"
else
    echo "ERROR: no unpacker found. Install one of:" >&2
    echo "       - unpack_bootimg (from an AOSP/LineageOS build tree)" >&2
    echo "       - magiskboot  (from the Magisk release)" >&2
    echo "       - abootimg    (apt install abootimg)" >&2
    exit 1
fi

if [[ ! -f "${KERNEL}" ]]; then
    echo "ERROR: unpacker produced no kernel image" >&2
    exit 1
fi

cp -f "${KERNEL}" "${OUT_DIR}/Image.gz-dtb"
echo "==> Wrote ${OUT_DIR}/Image.gz-dtb"

# Sanity-check the header so the offsets in BoardConfig.mk stay correct.
echo "==> Stock boot header (keep BoardConfig.mk in sync with these):"
if command -v unpack_bootimg >/dev/null 2>&1; then
    unpack_bootimg --boot_img "${BOOT_IMG}" --format 2>/dev/null | \
        grep -iE 'kernel|ramdisk|tags|second|page|cmdline|os_version' || true
elif command -v abootimg >/dev/null 2>&1; then
    abootimg -i "${BOOT_IMG}" | grep -iE 'kernel|ramdisk|second|tags|page|cmdline' || true
fi

echo "==> Done. Kernel size: $(stat -c %s "${OUT_DIR}/Image.gz-dtb") bytes"
