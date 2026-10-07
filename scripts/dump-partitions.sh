#!/usr/bin/env bash
#
# dump-partitions.sh - Dump all partitions from a Blackview BL6000 Pro
#                      (MediaTek Dimensity 800 / mt6873) using mtkclient.
#
# The phone must be in BROM mode:
#   1. Power the phone off completely
#   2. Hold Volume Up while plugging in the USB cable
#   3. Run this script
#
# Requires: mtkclient (https://github.com/bkerler/mtkclient)
#           pip3 install pyusb pycryptodome pycryptodomex colorama pyserial \
#                        keystone-engine capstone unicorn
#
set -euo pipefail

MTKCLIENT_DIR="${MTKCLIENT_DIR:-$HOME/mtkclient}"
OUT_DIR="${OUT_DIR:-/tmp/rooting/dump}"

if [[ ! -f "${MTKCLIENT_DIR}/mtk.py" ]]; then
    echo "ERROR: mtkclient not found at ${MTKCLIENT_DIR}"
    echo "Clone it with: git clone https://github.com/bkerler/mtkclient.git ${MTKCLIENT_DIR}"
    exit 1
fi

mkdir -p "${OUT_DIR}"
cd "${MTKCLIENT_DIR}"

# Small / medium partitions (fast) - dumped individually because
# mtkclient's --partitionlist flag differs across versions.
SMALL_PARTS=(
    boot recovery dtbo vbmeta vbmeta_system vbmeta_vendor
    lk lk2 logo tee1 tee2
    cam_vpu1 cam_vpu2 cam_vpu3
    scp1 scp2 gz1 gz2 spmfw preloader
)
# Larger partitions
LARGE_PARTS=( md1img super )

echo "=== Dumping ${#SMALL_PARTS[@]} small/medium partitions ==="
for part in "${SMALL_PARTS[@]}"; do
    echo "--- ${part} ---"
    python3 mtk.py r "${part}" "${OUT_DIR}/${part}.img" 2>&1 | grep -E 'Dumped|error' || true
done

echo "=== Dumping large partitions ==="
for part in "${LARGE_PARTS[@]}"; do
    echo "--- ${part} ---"
    python3 mtk.py r "${part}" "${OUT_DIR}/${part}.img" 2>&1 | grep -E 'Dumped|error' || true
done

echo "=== Done. Partitions in ${OUT_DIR} ==="
ls -lhS "${OUT_DIR}"
