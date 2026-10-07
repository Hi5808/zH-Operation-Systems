#!/usr/bin/env bash
#
# run-ghidra.sh - Run Ghidra headless analysis on a BL6000 Pro vendor blob and
# export the decompilation + IPC analysis (Phase 7).
#
# Usage:
#   ./run-ghidra.sh <path/to/blob.so>
#   GHIDRA_HOME=$HOME/ghidra_12.1.2_PUBLIC_20260605 ./run-ghidra.sh vendor/lib64/libccci_util.so
#
# Outputs land in $GHIDRA_OUT (default /tmp/ghidra-out):
#   <blob>.functions.txt  - function inventory
#   <blob>.decomp.c       - decompiled C for every function
#   <blob>.strings.txt    - IPC/HAL/device-path strings
#   <blob>.ipc-xrefs.txt  - callers of IPC-ish functions
#
set -euo pipefail

GHIDRA_HOME="${GHIDRA_HOME:-$HOME/ghidra_12.1.2_PUBLIC_20260605}"
# Ghidra 12.x runs Python (.py) headless scripts through PyGhidra, NOT the plain
# analyzeHeadless (which only runs Jython/Java). pyghidraRun --headless is the
# correct entry point. On first use it installs PyGhidra into a venv and asks
# two y/n questions - we auto-answer with `yes`.
PYGHIDRA_RUN="$(find "${GHIDRA_HOME}" -name pyghidraRun -type f 2>/dev/null | head -1)"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GHIDRA_OUT="${GHIDRA_OUT:-/tmp/ghidra-out}"
PROJ_DIR="${PROJ_DIR:-/tmp/ghidra-proj}"

BLOB="${1:-}"
if [[ -z "${BLOB}" || ! -f "${BLOB}" ]]; then
    echo "Usage: $0 <path/to/blob.so>"
    echo "  e.g. $0 /tmp/redemo/libccci_util.so"
    exit 1
fi
if [[ -z "${PYGHIDRA_RUN}" ]]; then
    echo "ERROR: pyghidraRun not found under ${GHIDRA_HOME}"
    echo "  Set GHIDRA_HOME to your Ghidra install (>= 11.3 for PyGhidra)."
    exit 1
fi

mkdir -p "${GHIDRA_OUT}" "${PROJ_DIR}"
NAME="$(basename "${BLOB}")"

echo "=== Ghidra (PyGhidra) headless analysis ==="
echo "  blob     : ${BLOB} ($(stat -c%s "${BLOB}") bytes)"
echo "  pyghidra : ${PYGHIDRA_RUN}"
echo "  output   : ${GHIDRA_OUT}"
echo "  NOTE: first run installs PyGhidra into a venv (~1 min); auto-analysis of a"
echo "        small blob takes ~1-3 min, large HALs much longer. Run in background"
echo "        for big binaries:  nohup $0 <blob> > ghidra.log 2>&1 &"
echo

# `yes` auto-confirms the first-time PyGhidra venv install prompts.
GHIDRA_OUT="${GHIDRA_OUT}" yes | "${PYGHIDRA_RUN}" --headless \
    "${PROJ_DIR}" "BL6000Pro_$(date +%s)" \
    -import "${BLOB}" \
    -scriptPath "${HERE}" \
    -postScript analyze_hal.py \
    -deleteProject \
    2>&1 | grep -iE 'analyze_hal|ERROR|Exception|DONE|succeed' | head -40 || true

echo
echo "=== Outputs ==="
ls -la "${GHIDRA_OUT}"/"${NAME}".* 2>/dev/null || echo "(no outputs - check Ghidra log)"
echo
echo "Quick look at the IPC strings found:"
grep -iE '/dev/|ioctl|binder|ccci|AT\+|ril' "${GHIDRA_OUT}/${NAME}.strings.txt" 2>/dev/null | head -20 || true
