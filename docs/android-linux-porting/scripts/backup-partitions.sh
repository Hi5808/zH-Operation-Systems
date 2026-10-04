#!/usr/bin/env bash
# Back up a set of Android partitions via adb+root (dd) and build a
# checksummed manifest that restore-oem.sh can replay later. Automates
# docs/android-linux-porting/06-bootloader-and-flashing.md §6.5 and
# 12-oem-restore.md.
#
# Usage:
#   backup-partitions.sh <out-dir> <partition> [partition ...]
#
# Example:
#   backup-partitions.sh devices/my-device/backups boot dtbo vendor_boot vbmeta vbmeta_system
#
# For a FULL stock-restore safety net (not just the boot-chain
# partitions above), enumerate every partition first:
#   adb shell "su -c 'ls /dev/block/by-name/'"
# and pass all of them. See 12-oem-restore.md for which partitions are
# safe to treat as "backup/restore freely" vs. unit-specific data
# (IMEI/calibration) that must never be restored from a DIFFERENT unit's
# dump, only your own.
#
# Requires: adb shell access with root (su) on the device. This script
# does not perform a BootROM-mode (mtkclient/Heimdall/qdl/etc.) dump --
# if you already have partition images from one of those tools, use
# catalog-dump.sh instead to build a manifest from files you have on disk.

set -euo pipefail

OUT_DIR="${1:-}"
shift || true
PARTITIONS=("$@")

if [[ -z "$OUT_DIR" || ${#PARTITIONS[@]} -eq 0 ]]; then
  echo "Usage: backup-partitions.sh <out-dir> <partition> [partition ...]" >&2
  exit 1
fi

command -v adb >/dev/null 2>&1 || { echo "error: adb not found" >&2; exit 1; }

DEVICE_COUNT="$(adb devices 2>/dev/null | tail -n +2 | grep -c . || true)"
if [[ "$DEVICE_COUNT" -eq 0 ]]; then
  echo "error: no device visible to adb (check 'adb devices')" >&2
  exit 1
elif [[ "$DEVICE_COUNT" -gt 1 ]]; then
  echo "error: multiple devices visible to adb -- set \$ANDROID_SERIAL or" >&2
  echo "       disconnect all but the target device" >&2
  exit 1
fi

if ! adb shell "su -c id" 2>/dev/null | grep -q "uid=0"; then
  echo "error: 'adb shell su -c id' did not report root (uid=0)." >&2
  echo "       See 11-troubleshooting-and-debugging.md if you expected root." >&2
  exit 1
fi

mkdir -p "$OUT_DIR"
MANIFEST="$OUT_DIR/manifest.tsv"
printf 'partition\tfile\tsha256\tsize_bytes\tsource_method\ttimestamp_utc\n' > "$MANIFEST"

TIMESTAMP="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
sha256_of() { sha256sum "$1" | awk '{print $1}'; }
size_of() { stat -c%s "$1" 2>/dev/null || stat -f%z "$1"; }

for p in "${PARTITIONS[@]}"; do
  echo "==> Backing up partition: $p"
  if ! adb shell "su -c 'test -e /dev/block/by-name/$p'" >/dev/null 2>&1; then
    echo "    warning: /dev/block/by-name/$p not found on device, skipping" >&2
    continue
  fi

  REMOTE_PATH="/sdcard/backup_${p}.img"
  adb shell "su -c 'dd if=/dev/block/by-name/$p of=$REMOTE_PATH bs=4M'"
  adb pull "$REMOTE_PATH" "$OUT_DIR/${p}.img"
  adb shell "su -c 'rm -f $REMOTE_PATH'"

  SHA256="$(sha256_of "$OUT_DIR/${p}.img")"
  SIZE="$(size_of "$OUT_DIR/${p}.img")"
  printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$p" "${p}.img" "$SHA256" "$SIZE" "adb-dd" "$TIMESTAMP" >> "$MANIFEST"
  echo "    OK: $OUT_DIR/${p}.img ($SIZE bytes, sha256 $SHA256)"
done

echo
echo "Done. Manifest: $MANIFEST"
echo "Keep this entire directory together -- restore-oem.sh needs both the"
echo "images and the manifest to verify integrity before writing anything back."
