#!/usr/bin/env bash
#
# verify-backup.sh - Verify the BL6000 Pro (mt6873) partition backup against the
#                    GPT captured by mtkclient, then (optionally) checksum it.
#
# mtkclient's `rl` writes each partition as <name>.bin. This checks that every
# GPT partition (except userdata, which is intentionally skipped) has a .bin of
# EXACTLY the byte length the GPT declares. That is the real proof the backup is
# complete and restorable.
#
# Usage:
#   BACKUP_DIR=~/bl6000pro-backup ./verify-backup.sh [--checksum]
#
set -uo pipefail

BACKUP_DIR="${BACKUP_DIR:-$HOME/bl6000pro-backup}"
GPT="${BACKUP_DIR}/partition-table.txt"
DO_CHECKSUM=0
[[ "${1:-}" == "--checksum" ]] && DO_CHECKSUM=1

if [[ ! -f "${GPT}" ]]; then
    echo "ERROR: ${GPT} not found - cannot verify against the GPT."
    exit 1
fi

echo "=== Verifying ${BACKUP_DIR} against captured GPT ==="
ok=0; mismatch=0; missing=0; skipped=0

# Parse lines like:  recovery:  Offset 0x.., Length 0x0000000002800000, ...
# Emit "<name> <length-hex>" for each partition entry.
while read -r name lenhex; do
    [[ -z "${name}" || -z "${lenhex}" ]] && continue
    if [[ "${name}" == "userdata" ]]; then
        echo "  [SKIP]     userdata (intentionally not backed up; wiped on restore)"
        skipped=$((skipped+1)); continue
    fi
    len=$(( lenhex ))                 # bash converts 0x.. hex to decimal
    f="${BACKUP_DIR}/${name}.bin"
    if [[ ! -f "${f}" ]]; then
        echo "  [MISSING]  ${name}.bin (expected ${len} bytes)"
        missing=$((missing+1)); continue
    fi
    sz=$(stat -c %s "${f}")
    if [[ "${sz}" -eq "${len}" ]]; then
        ok=$((ok+1))
    else
        echo "  [MISMATCH] ${name}.bin: have ${sz} bytes, GPT says ${len}"
        mismatch=$((mismatch+1))
    fi
done < <(awk '
    /Length 0x/ {
        if (match($0, /[A-Za-z_0-9]+:/)) name = substr($0, RSTART, RLENGTH-1);
        else next;
        if (match($0, /Length 0x[0-9a-fA-F]+/)) lh = substr($0, RSTART+7, RLENGTH-7);
        else next;
        print name, lh;
    }' "${GPT}")

# GPT headers themselves (captured by `rl` as gpt.bin / gpt_backup.bin).
for g in gpt gpt_backup; do
    if [[ -s "${BACKUP_DIR}/${g}.bin" ]]; then
        echo "  [OK]       ${g}.bin (GPT header)"; ok=$((ok+1))
    else
        echo "  [MISSING]  ${g}.bin (GPT header)"; missing=$((missing+1))
    fi
done

echo
echo "=== Summary ==="
echo "  OK: ${ok}   size-mismatch: ${mismatch}   missing: ${missing}   skipped: ${skipped}"
if [[ ${mismatch} -eq 0 && ${missing} -eq 0 ]]; then
    echo "  RESULT: PASS - backup matches the GPT exactly."
else
    echo "  RESULT: FAIL - re-capture the missing/mismatched partitions from clean BROM."
fi

# NOTE: preloader is NOT a GPT partition on MediaTek; it lives before the GPT and
# must be read separately (see backup-all.sh preloader step). Flag it here.
if [[ ! -s "${BACKUP_DIR}/preloader.bin" ]]; then
    echo
    echo "  NOTE: preloader.bin not present. The preloader is the most critical"
    echo "        recovery image and is NOT part of the GPT/rl dump. Capture it in a"
    echo "        separate clean-BROM session (mtk.py r preloader preloader.bin)."
fi

if [[ ${DO_CHECKSUM} -eq 1 ]]; then
    echo
    echo "=== Generating SHA256SUMS (this hashes ~6 GB, please wait) ==="
    ( cd "${BACKUP_DIR}" && sha256sum ./*.bin > SHA256SUMS ) \
        && echo "  wrote ${BACKUP_DIR}/SHA256SUMS ($(wc -l < "${BACKUP_DIR}/SHA256SUMS") entries)" \
        || echo "  ERROR: checksum generation failed"
fi

exit $(( mismatch + missing ))
