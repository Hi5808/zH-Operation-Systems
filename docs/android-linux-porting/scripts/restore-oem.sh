#!/usr/bin/env bash
# Restore a device to the partition images recorded in a manifest built
# by backup-partitions.sh or catalog-dump.sh. Defaults to a dry run --
# nothing is written until --yes is passed. Read 12-oem-restore.md before
# using this on real hardware.
#
# Usage:
#   restore-oem.sh <manifest.tsv> --method fastboot|adb-dd|plan-only [--yes] [--only part1,part2]
#
# IMPORTANT -- read before using:
#   - This script only implements the two write paths this guide can
#     assert with confidence: `fastboot flash` (stable, documented AOSP
#     syntax) and adb+root `dd` (stable, documented Android syntax). For
#     BootROM-mode tools (mtkclient, Heimdall, qdl, rkdeveloptool,
#     sunxi-fel, nvflash), use --method plan-only to get a
#     checksum-verified restore plan, then run that vendor tool's own
#     write command YOURSELF -- verify its exact flag syntax against its
#     own --help/docs for the version you actually have. This script
#     deliberately does not guess at flag syntax it hasn't verified; see
#     12-oem-restore.md for why that matters.
#   - fastboot cannot read partitions back (an AOSP limitation, not a
#     choice made here), so only the *source file's* checksum is
#     verified before flashing -- there is no post-write verification on
#     that path. The adb-dd path reads back and compares after writing.
#   - Restoring older firmware can collide with anti-rollback counters
#     (AVB and some SoC secure-boot schemes can refuse an older signed
#     image once a newer one has booted) -- see
#     02-reverse-engineering-ghidra.md §2.6 and
#     06-bootloader-and-flashing.md §6.3. This script cannot detect or
#     work around that; it will report whatever the flashing tool reports.
#   - Never restore unit-specific partitions (IMEI/calibration data such
#     as modemst1/modemst2/persist/efs-equivalents) from a DIFFERENT
#     physical unit's backup -- only from THIS device's own earlier
#     backup. See 12-oem-restore.md.

set -euo pipefail

MANIFEST=""
METHOD=""
CONFIRM=0
ONLY=""

usage() {
  cat <<'EOF'
Usage: restore-oem.sh <manifest.tsv> --method fastboot|adb-dd|plan-only [--yes] [--only part1,part2,...]

  <manifest.tsv>   Manifest produced by backup-partitions.sh or catalog-dump.sh
  --method         fastboot | adb-dd | plan-only
  --yes            Actually write. Without this flag, only prints the plan.
  --only           Comma-separated partition allow-list (default: every
                   partition in the manifest). Review this -- never
                   restore a partition you don't have a specific reason to.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --method) METHOD="$2"; shift 2 ;;
    --yes) CONFIRM=1; shift ;;
    --only) ONLY="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *)
      if [[ -z "$MANIFEST" ]]; then MANIFEST="$1"; shift
      else echo "error: unexpected argument '$1'" >&2; usage; exit 1
      fi
      ;;
  esac
done

if [[ -z "$MANIFEST" || ! -f "$MANIFEST" ]]; then usage; exit 1; fi
if [[ -z "$METHOD" ]]; then echo "error: --method is required" >&2; exit 1; fi

MANIFEST_DIR="$(cd "$(dirname "$MANIFEST")" && pwd)"

declare -a ONLY_LIST=()
[[ -n "$ONLY" ]] && IFS=',' read -ra ONLY_LIST <<< "$ONLY"

in_only_list() {
  [[ ${#ONLY_LIST[@]} -eq 0 ]] && return 0
  local p="$1" x
  for x in "${ONLY_LIST[@]}"; do [[ "$x" == "$p" ]] && return 0; done
  return 1
}

check_single_device() {
  local tool="$1" count
  if [[ "$tool" == "fastboot" ]]; then
    count="$(fastboot devices 2>/dev/null | grep -c . || true)"
  else
    count="$(adb devices 2>/dev/null | tail -n +2 | grep -c . || true)"
  fi
  if [[ "$count" -eq 0 ]]; then
    echo "error: no device visible to $tool (check '$tool devices')" >&2
    exit 1
  elif [[ "$count" -gt 1 ]]; then
    echo "error: multiple devices visible to $tool -- set \$ANDROID_SERIAL or" >&2
    echo "       disconnect all but the target device before restoring" >&2
    exit 1
  fi
}

# Load manifest body (skip header) so it can be iterated more than once
# (plan pass, then execute pass).
declare -a ROWS=()
{
  IFS= read -r _header
  while IFS= read -r line; do ROWS+=("$line"); done
} < "$MANIFEST"

echo "== Restore plan (method: $METHOD) =="
ANY=0
for line in "${ROWS[@]}"; do
  IFS=$'\t' read -r partition file sha256 size source_method timestamp <<< "$line"
  [[ -z "$partition" ]] && continue
  in_only_list "$partition" || continue
  ANY=1
  FULL_PATH="$MANIFEST_DIR/$file"
  if [[ ! -f "$FULL_PATH" ]]; then
    echo "error: $FULL_PATH (partition $partition) listed in manifest but missing on disk" >&2
    exit 1
  fi
  ACTUAL_SHA="$(sha256sum "$FULL_PATH" | awk '{print $1}')"
  if [[ "$ACTUAL_SHA" != "$sha256" ]]; then
    echo "error: checksum mismatch for $partition ($file)" >&2
    echo "       manifest:  $sha256" >&2
    echo "       on disk:   $ACTUAL_SHA" >&2
    echo "       refusing to flash a file that doesn't match the recorded backup." >&2
    exit 1
  fi
  echo "  $partition  <-  $file  (sha256 OK, from $source_method @ $timestamp)"
done

if [[ "$ANY" -eq 0 ]]; then
  echo "error: no partitions matched (check --only, or the manifest is empty)" >&2
  exit 1
fi

echo
if [[ "$METHOD" == "plan-only" ]]; then
  echo "plan-only: use the checksum-verified files above with your vendor"
  echo "tool's own write command. Verify its exact flag syntax yourself --"
  echo "see the warning at the top of this script and 12-oem-restore.md."
  exit 0
fi

if [[ "$CONFIRM" -ne 1 ]]; then
  echo "Dry run only -- no writes performed. Re-run with --yes to execute this plan."
  exit 0
fi

case "$METHOD" in
  fastboot)
    command -v fastboot >/dev/null 2>&1 || { echo "error: fastboot not found" >&2; exit 1; }
    check_single_device fastboot
    for line in "${ROWS[@]}"; do
      IFS=$'\t' read -r partition file sha256 size source_method timestamp <<< "$line"
      [[ -z "$partition" ]] && continue
      in_only_list "$partition" || continue
      echo "==> fastboot flash $partition $MANIFEST_DIR/$file"
      fastboot flash "$partition" "$MANIFEST_DIR/$file"
    done
    echo
    echo "Done. fastboot cannot read back for verification -- the pre-flash"
    echo "checksum check above is the only integrity guarantee on this path."
    ;;
  adb-dd)
    command -v adb >/dev/null 2>&1 || { echo "error: adb not found" >&2; exit 1; }
    check_single_device adb
    for line in "${ROWS[@]}"; do
      IFS=$'\t' read -r partition file sha256 size source_method timestamp <<< "$line"
      [[ -z "$partition" ]] && continue
      in_only_list "$partition" || continue
      REMOTE_PATH="/sdcard/restore_${partition}.img"
      echo "==> adb push + dd for $partition"
      adb push "$MANIFEST_DIR/$file" "$REMOTE_PATH"
      adb shell "su -c 'dd if=$REMOTE_PATH of=/dev/block/by-name/$partition bs=4M'"
      REMOTE_SHA="$(adb shell "su -c 'sha256sum /dev/block/by-name/$partition'" 2>/dev/null | awk '{print $1}' | tr -d '\r')"
      adb shell "su -c 'rm -f $REMOTE_PATH'"
      if [[ "$REMOTE_SHA" == "$sha256" ]]; then
        echo "    verified: on-device sha256 matches manifest"
      else
        echo "    WARNING: on-device sha256 ($REMOTE_SHA) does not match manifest ($sha256)" >&2
        echo "             the write may have failed, or the partition is sized" >&2
        echo "             differently than the backed-up image -- investigate" >&2
        echo "             before trusting this restore" >&2
      fi
    done
    ;;
  *)
    echo "error: unknown --method '$METHOD' (expected fastboot | adb-dd | plan-only)" >&2
    exit 1
    ;;
esac
