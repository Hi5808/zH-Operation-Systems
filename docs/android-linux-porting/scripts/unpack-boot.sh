#!/usr/bin/env bash
# Unpack an Android boot.img into kernel/ramdisk/dtb, and decompile the
# DTB to human-readable .dts. Automates
# docs/android-linux-porting/01-firmware-dumping.md §1.3.
#
# Usage: unpack-boot.sh <boot.img> [out-dir]

set -euo pipefail

BOOT_IMG="${1:-}"
OUT_DIR="${2:-boot_out}"

if [[ -z "$BOOT_IMG" || ! -f "$BOOT_IMG" ]]; then
  echo "Usage: unpack-boot.sh <boot.img> [out-dir]" >&2
  exit 1
fi

if ! command -v unpack_bootimg >/dev/null 2>&1; then
  echo "error: unpack_bootimg not found. Install with: pip install unpack_bootimg" >&2
  echo "       (or use Android-Image-Kitchen — see 07-tools-reference.md)" >&2
  exit 1
fi

mkdir -p "$OUT_DIR"
echo "==> Unpacking $BOOT_IMG into $OUT_DIR"
unpack_bootimg --boot_img "$BOOT_IMG" --out "$OUT_DIR"

echo
echo "==> Contents:"
ls -la "$OUT_DIR"

# Locate a DTB: either a dedicated dtb file, or one appended to the kernel.
DTB_FILE=""
for candidate in "$OUT_DIR"/dtb "$OUT_DIR"/*.dtb; do
  [[ -f "$candidate" ]] && DTB_FILE="$candidate" && break
done

if [[ -z "$DTB_FILE" && -f "$OUT_DIR/kernel" ]]; then
  if command -v extract-dtb >/dev/null 2>&1; then
    echo
    echo "==> No standalone dtb found; trying extract-dtb on the kernel image"
    mkdir -p "$OUT_DIR/dtb"
    extract-dtb "$OUT_DIR/kernel" -o "$OUT_DIR/dtb" || true
    DTB_FILE="$(find "$OUT_DIR/dtb" -name '*.dtb' 2>/dev/null | head -n1 || true)"
  else
    echo
    echo "note: no standalone dtb found and 'extract-dtb' is not installed;" >&2
    echo "      install with: pip install extract-dtb" >&2
  fi
fi

if [[ -n "$DTB_FILE" ]]; then
  if command -v dtc >/dev/null 2>&1; then
    echo
    echo "==> Decompiling $DTB_FILE to device.dts"
    dtc -I dtb -O dts -o "$OUT_DIR/device.dts" "$DTB_FILE" || \
      echo "warning: dtc failed on $DTB_FILE (device may concatenate multiple DTBs — split first)" >&2
  else
    echo "note: 'dtc' not installed; install the device-tree-compiler package" >&2
  fi
else
  echo "note: no DTB located; this device may use a separate dtbo.img — unpack that too" >&2
fi

echo
echo "Done. See 01-firmware-dumping.md §1.4 (or run extract-kernel-config.sh)"
echo "next to recover kernel.config."
