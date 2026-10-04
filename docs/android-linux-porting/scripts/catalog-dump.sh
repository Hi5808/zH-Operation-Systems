#!/usr/bin/env bash
# Build a restore-oem.sh-compatible manifest from partition image files
# you already have on disk -- e.g. from an mtkclient/Heimdall/qdl/
# rkdeveloptool BootROM-mode dump you ran yourself, or SP Flash Tool's
# own readback. This script does NOT dump anything itself; it only
# catalogs and checksums files you point it at. See 12-oem-restore.md.
#
# Usage:
#   catalog-dump.sh <out-dir> <source-method> <partition>=<file> [partition=file ...]
#
# Example:
#   catalog-dump.sh devices/my-device/backups mtkclient \
#     boot=/home/me/dumps/boot.img vendor=/home/me/dumps/vendor.img
#
# <source-method> is a free-text label for your own records (e.g.
# mtkclient, heimdall, qdl, sp-flash-tool, manual) -- it has no effect
# on behavior, it just travels with the manifest so you know later how
# each file was obtained.

set -euo pipefail

OUT_DIR="${1:-}"
SOURCE_METHOD="${2:-}"
shift 2 2>/dev/null || true

if [[ -z "$OUT_DIR" || -z "$SOURCE_METHOD" || $# -eq 0 ]]; then
  echo "Usage: catalog-dump.sh <out-dir> <source-method> <partition>=<file> [partition=file ...]" >&2
  exit 1
fi

mkdir -p "$OUT_DIR"
MANIFEST="$OUT_DIR/manifest.tsv"
if [[ ! -f "$MANIFEST" ]]; then
  printf 'partition\tfile\tsha256\tsize_bytes\tsource_method\ttimestamp_utc\n' > "$MANIFEST"
fi

TIMESTAMP="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
sha256_of() { sha256sum "$1" | awk '{print $1}'; }
size_of() { stat -c%s "$1" 2>/dev/null || stat -f%z "$1"; }

for pair in "$@"; do
  if [[ "$pair" != *=* ]]; then
    echo "error: expected partition=file, got '$pair'" >&2
    exit 1
  fi
  PART="${pair%%=*}"
  SRC="${pair#*=}"
  if [[ -z "$PART" || -z "$SRC" ]]; then
    echo "error: expected partition=file, got '$pair'" >&2
    exit 1
  fi
  if [[ ! -f "$SRC" ]]; then
    echo "error: $SRC not found" >&2
    exit 1
  fi

  DEST="$OUT_DIR/${PART}.img"
  cp "$SRC" "$DEST"
  SHA256="$(sha256_of "$DEST")"
  SIZE="$(size_of "$DEST")"
  printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$PART" "${PART}.img" "$SHA256" "$SIZE" "$SOURCE_METHOD" "$TIMESTAMP" >> "$MANIFEST"
  echo "cataloged: $PART <- $SRC ($SIZE bytes, sha256 $SHA256)"
done

echo
echo "Done. Manifest: $MANIFEST"
