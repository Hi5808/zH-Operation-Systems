#!/usr/bin/env bash
# Recover a .config from a raw/compressed Android kernel image. Automates
# docs/android-linux-porting/01-firmware-dumping.md §1.4 using the Linux
# kernel's own scripts/extract-ikconfig, which is fetched once and cached
# rather than vendored into this repo.
#
# Usage: extract-kernel-config.sh <kernel-image> [output.config]

set -euo pipefail

KERNEL_IMG="${1:-}"
OUT_FILE="${2:-kernel.config}"
CACHE_DIR="${EXTRACT_IKCONFIG_CACHE:-$HOME/.cache/android-linux-porting}"
LINUX_SCRIPTS_DIR="$CACHE_DIR/linux-scripts-src"

if [[ -z "$KERNEL_IMG" || ! -f "$KERNEL_IMG" ]]; then
  echo "Usage: extract-kernel-config.sh <kernel-image> [output.config]" >&2
  echo "Tip: for a bootable device, 'adb shell zcat /proc/config.gz' is faster" >&2
  echo "     than this if available at all." >&2
  exit 1
fi

if command -v extract-ikconfig >/dev/null 2>&1; then
  EXTRACT_SCRIPT="$(command -v extract-ikconfig)"
else
  mkdir -p "$CACHE_DIR"
  if [[ ! -f "$LINUX_SCRIPTS_DIR/scripts/extract-ikconfig" ]]; then
    echo "==> extract-ikconfig not found locally; shallow-cloning torvalds/linux"
    echo "    (one-time, cached at $LINUX_SCRIPTS_DIR)"
    git clone --depth 1 --filter=blob:none \
      https://github.com/torvalds/linux "$LINUX_SCRIPTS_DIR"
  fi
  EXTRACT_SCRIPT="$LINUX_SCRIPTS_DIR/scripts/extract-ikconfig"
fi

echo "==> Extracting config from $KERNEL_IMG"
"$EXTRACT_SCRIPT" "$KERNEL_IMG" > "$OUT_FILE"

if [[ -s "$OUT_FILE" ]]; then
  echo "==> Wrote $(wc -l < "$OUT_FILE" | tr -d ' ') lines to $OUT_FILE"
else
  echo "error: extraction produced an empty file — the kernel image may not" >&2
  echo "       contain an embedded IKCONFIG, or may need decompressing first" >&2
  rm -f "$OUT_FILE"
  exit 1
fi
