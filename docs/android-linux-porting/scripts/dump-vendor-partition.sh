#!/usr/bin/env bash
# Convert (if needed) and mount/extract an Android vendor/system partition
# image. Automates docs/android-linux-porting/01-firmware-dumping.md §1.5.
#
# Usage: dump-vendor-partition.sh <image> <out-dir>
#
# Handles: Android sparse images (auto-converted via simg2img), ext4
# (mounted read-only via a loop device — needs sudo), and EROFS (extracted
# via fsck.erofs — no sudo needed).

set -euo pipefail

IMG="${1:-}"
OUT_DIR="${2:-}"

if [[ -z "$IMG" || -z "$OUT_DIR" || ! -f "$IMG" ]]; then
  echo "Usage: dump-vendor-partition.sh <image> <out-dir>" >&2
  exit 1
fi

WORK_IMG="$IMG"

# Android sparse image magic is 0xED26FF3A, stored little-endian.
magic="$(head -c4 "$IMG" | od -An -tx1 | tr -d ' \n')"
if [[ "$magic" == "3aff26ed" ]]; then
  echo "==> Detected Android sparse image; converting with simg2img"
  command -v simg2img >/dev/null 2>&1 || { echo "error: simg2img not found" >&2; exit 1; }
  WORK_IMG="${IMG%.img}.raw.img"
  simg2img "$IMG" "$WORK_IMG"
fi

mkdir -p "$OUT_DIR"

# EROFS magic 0xE0F5E1E2 at offset 1024; ext4 superblock magic 0xEF53 at
# offset 1024+56=1080, both little-endian.
erofs_magic="$(dd if="$WORK_IMG" bs=1 skip=1024 count=4 2>/dev/null | od -An -tx1 | tr -d ' \n')"
ext4_magic="$(dd if="$WORK_IMG" bs=1 skip=1080 count=2 2>/dev/null | od -An -tx1 | tr -d ' \n')"

if [[ "$erofs_magic" == "e2e1f5e0" ]]; then
  echo "==> Detected EROFS; extracting with fsck.erofs"
  command -v fsck.erofs >/dev/null 2>&1 || { echo "error: fsck.erofs not found (build erofs-utils)" >&2; exit 1; }
  fsck.erofs --extract="$OUT_DIR" "$WORK_IMG"
elif [[ "$ext4_magic" == "53ef" ]]; then
  echo "==> Detected ext4; mounting read-only via loop device (needs sudo)"
  sudo mount -o loop,ro "$WORK_IMG" "$OUT_DIR"
  echo "    mounted at $OUT_DIR — unmount with: sudo umount $OUT_DIR"
else
  echo "warning: could not identify filesystem type from magic bytes" >&2
  echo "         (erofs magic: $erofs_magic, ext4 magic: $ext4_magic)" >&2
  echo "         try: file \"$WORK_IMG\"  and consult 01-firmware-dumping.md §1.5" >&2
  exit 1
fi

echo
echo "Done. Look under:"
echo "  $OUT_DIR/lib*/hw/        -> HAL .so files"
echo "  $OUT_DIR/lib*/modules/   -> vendor .ko kernel modules"
echo "  $OUT_DIR/firmware/       -> firmware blobs (Wi-Fi/BT, DSP, etc)"
