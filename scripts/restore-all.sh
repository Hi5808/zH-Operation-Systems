#!/usr/bin/env bash
#
# restore-all.sh - Restore a Blackview BL6000 Pro from a backup made by
#                  backup-all.sh, using BROM mode.
#
# This reflashes every partition image found in the backup directory back to
# the device. Use it to recover from a bricked/corrupted custom OS.
#
# The device must be in BROM mode:
#   power off -> hold Volume-Up while plugging in USB
#
# Usage:
#   MTKCLIENT_DIR=$HOME/mtkclient BACKUP_DIR=~/bl6000pro-backup \
#       ./restore-all.sh
#
# WARNING: This overwrites the flash. Only restore your OWN backup.
#
set -uo pipefail   # NOT -e: attempt the preloader step even if `wl` warns

MTKCLIENT_DIR="${MTKCLIENT_DIR:-$HOME/mtkclient}"
BACKUP_DIR="${BACKUP_DIR:-$HOME/bl6000pro-backup}"

if [[ ! -f "${MTKCLIENT_DIR}/mtk.py" ]]; then
    echo "ERROR: mtkclient not found at ${MTKCLIENT_DIR}"
    exit 1
fi
if [[ ! -d "${BACKUP_DIR}" ]]; then
    echo "ERROR: backup directory not found: ${BACKUP_DIR}"
    exit 1
fi

echo "About to restore the device from: ${BACKUP_DIR}"
echo "Partition images present (.bin):"
ls "${BACKUP_DIR}"/*.bin 2>/dev/null | xargs -n1 basename | tr '\n' ' '; echo
echo "  count: $(ls "${BACKUP_DIR}"/*.bin 2>/dev/null | wc -l)"
if [[ ! -s "${BACKUP_DIR}/preloader.bin" ]]; then
    echo "  WARNING: preloader.bin is MISSING. 'wl' cannot restore the preloader"
    echo "           (it is not a GPT partition). Capture it first with"
    echo "           capture-preloader.sh, or the device may not boot after restore."
fi
echo
read -r -p "Type YES to continue: " ans
if [[ "${ans}" != "YES" ]]; then
    echo "Aborted."
    exit 1
fi

cd "${MTKCLIENT_DIR}" || exit 1

echo
echo "=== [1/3] Restoring all GPT partitions (wl) ==="
# wl = write every file in the dir whose name matches a GPT partition. It skips
# preloader.bin / gpt.bin / *.txt / *.json (not GPT partitions). If the on-device
# GPT itself is corrupted, add:  --gpt_file "${BACKUP_DIR}/gpt.bin"
timeout "${WL_TIMEOUT:-7200}" python3 mtk.py wl "${BACKUP_DIR}"
wl_rc=$?
[[ ${wl_rc} -ne 0 ]] && echo "  wl exited ${wl_rc} (continuing to preloader step)."

echo
echo "=== [2/3] Restoring the PRELOADER (UFS boot1) ==="
if [[ -s "${BACKUP_DIR}/preloader.bin" ]]; then
    # mtkclient allows ONE command per BROM entry (see backup-all.sh), so the
    # preloader write needs a fresh clean-BROM session.
    echo "  Unplug USB, power off (hold power ~10s), then hold Volume-Up and replug."
    read -r -p "  Press Enter when the device is back in clean BROM... " _
    # The preloader lives before the GPT, so `wl` never writes it - do it here.
    timeout 600 python3 mtk.py w preloader "${BACKUP_DIR}/preloader.bin" --parttype=boot1 \
        && echo "  preloader written." \
        || echo "  preloader write FAILED - re-run from clean BROM."
else
    echo "  skipped - no ${BACKUP_DIR}/preloader.bin (see capture-preloader.sh)."
fi

echo
echo "=== [3/3] Rebooting device ==="
echo "Unplug USB and hold power to boot (no further mtk.py call: the DA session is spent)."
echo "If the device does not boot, power-cycle into clean BROM (hold Volume-Up"
echo "while plugging in) and re-run this script."
