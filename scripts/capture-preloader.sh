#!/usr/bin/env bash
#
# capture-preloader.sh - Capture the PRELOADER of the Blackview BL6000 Pro
#                        (MT6873, UFS storage) - the one image `rl` cannot get.
#
# WHY THIS IS SEPARATE
#   The preloader lives in the UFS boot1 LUN, BEFORE the GPT, so `mtk.py rl`
#   (which dumps GPT partitions) never captures it. It is the single most
#   critical recovery image: without a matching preloader the device cannot
#   boot after a restore. It MUST be read in its own session.
#
# WHY ITS OWN BROM SESSION
#   mtkclient does ONE handshake per BROM entry: the first mtk.py command loads
#   the DA and the device then leaves clean BROM, so a separate later command
#   cannot re-handshake. If you just ran backup-all.sh, power-cycle the phone
#   first (see below) so this starts from clean BROM.
#
# GET INTO CLEAN BROM (the "0e8d:0003 doesn't stay on the list" case)
#   The BROM download ID (0e8d:0003 "MT6227 phone") is TRANSIENT by design - it
#   appears for a second or two, then the preloader/DA takes over and the device
#   re-enumerates (often as 0e8d:2000). That is normal. To enter clean BROM:
#     1. Unplug USB.
#     2. Power OFF (hold Power ~10s until it shuts down).
#     3. Hold VOLUME-UP and plug in USB (keep holding until mtkclient grabs it).
#   This script starts mtk.py FIRST (it waits for the device), so plug in after.
#
# Usage:
#   MTKCLIENT_DIR=$HOME/mtkclient BACKUP_DIR=~/bl6000pro-backup \
#       ./capture-preloader.sh
#
set -uo pipefail

MTKCLIENT_DIR="${MTKCLIENT_DIR:-$HOME/mtkclient}"
BACKUP_DIR="${BACKUP_DIR:-$HOME/bl6000pro-backup}"
PL_TIMEOUT="${PL_TIMEOUT:-180}"        # preloader read is small; 3 min is ample
OUT="${BACKUP_DIR}/preloader.bin"

if [[ ! -f "${MTKCLIENT_DIR}/mtk.py" ]]; then
    echo "ERROR: mtkclient not found at ${MTKCLIENT_DIR}"
    exit 1
fi
mkdir -p "${BACKUP_DIR}"
cd "${MTKCLIENT_DIR}" || exit 1

echo "=== capture-preloader: BL6000 Pro (MT6873, UFS boot1) ==="
echo "  mtkclient will WAIT for the device. Enter clean BROM now:"
echo "    unplug -> power off (hold Power ~10s) -> hold VOLUME-UP -> plug in USB."
echo "  (Do NOT hold any key if your firmware needs preloader mode instead; see"
echo "   mtkclient README - MT6873 normally uses BROM via Volume-Up.)"
echo

# Never clobber an existing good preloader: back it up first.
if [[ -s "${OUT}" ]]; then
    cp -f "${OUT}" "${OUT}.prev" 2>/dev/null
    echo "  existing ${OUT} saved to ${OUT}.prev (kept until new one verifies)"
fi

echo "=== [1/2] Reading preloader from UFS boot1 (r preloader --parttype=boot1) ==="
timeout "${PL_TIMEOUT}" python3 mtk.py r preloader "${OUT}" --parttype=boot1 2>&1 | tee /tmp/pl.log
rc=${PIPESTATUS[0]}

# Validate: file must exist, be non-trivial, and the log must not show a failed
# handshake. If it failed, fall back to the DA-based `dumppreloader`.
ok=0
if [[ ${rc} -eq 0 && -s "${OUT}" ]] \
   && ! grep -qiE 'Handshake failed|please disconnect|Waiting for' /tmp/pl.log; then
    ok=1
else
    echo
    echo "  boot1 read did not produce a clean preloader (rc=${rc})."
    echo "=== [1b] Fallback: dumppreloader (DA-based) ==="
    timeout "${PL_TIMEOUT}" python3 mtk.py dumppreloader 2>&1 | tee /tmp/pl2.log
    # dumppreloader writes into the mtkclient dir; move the newest preloader*.bin.
    newest="$(ls -t "${MTKCLIENT_DIR}"/preloader*.bin 2>/dev/null | head -1)"
    if [[ -n "${newest}" && -s "${newest}" ]]; then
        cp -f "${newest}" "${OUT}"
        grep -qiE 'Handshake failed|please disconnect' /tmp/pl2.log || ok=1
    fi
fi

echo
echo "=== [2/2] Result ==="
if [[ ${ok} -eq 1 && -s "${OUT}" ]]; then
    sz=$(stat -c %s "${OUT}")
    echo "  OK - captured ${OUT} (${sz} bytes)"
    sha256sum "${OUT}" | tee "${OUT}.sha256"
    rm -f "${OUT}.prev" 2>/dev/null
    echo
    echo "  Preloader backup COMPLETE. Full backup dir now:"
    du -sh "${BACKUP_DIR}"
    echo "  Re-verify everything: BACKUP_DIR=${BACKUP_DIR} $(dirname "$0")/verify-backup.sh"
    exit 0
else
    echo "  FAILED to capture a clean preloader."
    [[ -s "${OUT}.prev" ]] && mv -f "${OUT}.prev" "${OUT}" && echo "  restored previous ${OUT}"
    echo
    echo "  Troubleshooting:"
    echo "   - The device must be in CLEAN BROM: unplug, power off (hold Power ~10s),"
    echo "     then hold VOLUME-UP while plugging in. Re-run and plug in AFTER it waits."
    echo "   - If it says 'please disconnect and reconnect': unplug, power-cycle, retry."
    echo "   - Confirm the ID while waiting:  watch -n1 'lsusb | grep 0e8d'"
    echo "     (0e8d:0003 = BROM, transient; 0e8d:2000 = preloader VCOM.)"
    exit 1
fi
