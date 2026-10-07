#!/usr/bin/env bash
#
# backup-all.sh - COMPLETE backup of the Blackview BL6000 Pro so the device can
#                 be fully restored to stock Android via BROM.
#
# *** IMPORTANT - READ THIS ***
# mtkclient works in ONE session per BROM entry: the FIRST `mtk.py` command
# handshakes with BROM and loads the DA (download agent); the device then stays
# in DA mode and any SEPARATE later `mtk.py` invocation cannot re-handshake (it
# hangs retrying, or says "please disconnect and reconnect"). So this script does
# the critical read-ALL (`rl`) as the very FIRST invocation - the whole backup
# happens in a single BROM->DA session. Every mtk.py call is wrapped in `timeout`
# so nothing can hang forever.
#
# The device must be in CLEAN BROM mode:
#   power off -> hold Volume-Up while plugging in USB
# If mtkclient says "please disconnect and reconnect": unplug USB, power off
# (hold power ~10s), then hold Volume-Up while replugging, and re-run.
#
# Usage:
#   MTKCLIENT_DIR=$HOME/mtkclient BACKUP_DIR=~/bl6000pro-backup \
#       ./backup-all.sh
#
set -uo pipefail   # deliberately NOT -e: best-effort steps must not abort the run

MTKCLIENT_DIR="${MTKCLIENT_DIR:-$HOME/mtkclient}"
BACKUP_DIR="${BACKUP_DIR:-$HOME/bl6000pro-backup}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKIP="${SKIP:-userdata}"               # huge + wiped on restore anyway
RL_TIMEOUT="${RL_TIMEOUT:-7200}"       # 2h for the full read-all
CHECKSUM="${CHECKSUM:-0}"              # set to 1 to sha256 all .bin (~6 GB, slow)

if [[ ! -f "${MTKCLIENT_DIR}/mtk.py" ]]; then
    echo "ERROR: mtkclient not found at ${MTKCLIENT_DIR}"
    exit 1
fi

mkdir -p "${BACKUP_DIR}"
cd "${MTKCLIENT_DIR}"

# run_mtk <timeout> <outfile-or--> <mtk args...>
# Runs mtk.py under a timeout. With an outfile, only keeps the result if it looks
# like real output (never clobbers a previously captured good file on failure).
run_mtk() {
    local tmo="$1"; shift
    local out="$1"; shift
    if [[ "${out}" == "-" ]]; then
        timeout "${tmo}" python3 mtk.py "$@" 2>&1
        return $?
    fi
    local tmp; tmp="$(mktemp)"
    if timeout "${tmo}" python3 mtk.py "$@" >"${tmp}" 2>&1 \
       && grep -qiE 'Device detected|GPT Table|Offset 0x|:' "${tmp}" \
       && ! grep -qiE 'Handshake failed|please disconnect|Waiting for' "${tmp}"; then
        mv "${tmp}" "${out}"; return 0
    fi
    rm -f "${tmp}"; return 1
}


echo "=== [1/3] Reading ALL partitions in ONE BROM->DA session (skip: ${SKIP}) ==="
echo "    (critical step; must be the first mtk.py invocation)"
run_mtk "${RL_TIMEOUT}" - rl "${BACKUP_DIR}" --skip "${SKIP}"
rl_rc=$?
if [[ ${rl_rc} -ne 0 ]]; then
    echo "  read-all exited ${rl_rc}. If it said 'please disconnect and reconnect',"
    echo "  the device left clean BROM: unplug, power off (hold power ~10s), hold"
    echo "  Volume-Up while replugging, then re-run this script."
fi

echo
echo "=== [2/3] Verifying backup against the GPT (name + exact byte size) ==="
# verify-backup.sh parses partition-table.txt and checks that every GPT partition
# (except userdata) has a matching .bin of EXACTLY the declared byte length.
# It also flags the preloader, which is NOT part of the GPT/rl dump.
if [[ -x "${SCRIPT_DIR}/verify-backup.sh" ]]; then
    BACKUP_DIR="${BACKUP_DIR}" "${SCRIPT_DIR}/verify-backup.sh"
else
    echo "  verify-backup.sh not found next to this script - skipping verification."
fi

echo
echo "=== [3/3] Checksums (CHECKSUM=1 to enable; hashes ~6 GB, slow) ==="
if [[ "${CHECKSUM}" == "1" ]]; then
    ( cd "${BACKUP_DIR}" && sha256sum ./*.bin > SHA256SUMS ) \
        && echo "  wrote ${BACKUP_DIR}/SHA256SUMS" \
        || echo "  ERROR: checksum generation failed"
else
    echo "  skipped. To checksum later:"
    echo "    BACKUP_DIR=${BACKUP_DIR} ${SCRIPT_DIR}/verify-backup.sh --checksum"
fi

echo
echo "=== Backup complete: ${BACKUP_DIR} ==="
du -sh "${BACKUP_DIR}"
echo
echo "IMPORTANT - the PRELOADER is NOT captured by 'rl' (it lives before the GPT)."
echo "It is the single most critical recovery image. Capture it in a SEPARATE"
echo "clean-BROM session with:"
echo "    ${SCRIPT_DIR}/capture-preloader.sh"
echo
echo "Why only ONE mtk.py command per BROM session: the first command handshakes"
echo "with BROM and loads the DA; the device then leaves clean BROM, so any SEPARATE"
echo "later invocation cannot re-handshake (it hangs, or says 'please disconnect and"
echo "reconnect'). That is why 'rl' is the first and only command here, and why the"
echo "preloader (and printgpt/gettargetconfig) each need their own BROM entry."
