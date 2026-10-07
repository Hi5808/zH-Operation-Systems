#!/usr/bin/env bash
#
# extract-files.sh — pull the proprietary blobs listed in proprietary-files.txt
# out of the stock vendor partition and into the vendor tree.
#
# Unlike the stock LineageOS script (which pulls from a live device over adb),
# this version extracts from the dumped images/logical/vendor.img via debugfs,
# so it works entirely offline from the firmware dump.
#
# Usage:
#   ./extract-files.sh                 # extract from images/logical/vendor.img
#   SRC=/path/to/vendor.img ./extract-files.sh
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# ROOT contains device/ and vendor/ (the ubuntu-touch dir here, or the Halium
# source root in a real tree); it is three levels up from the device tree.
ROOT="$(cd "${SCRIPT_DIR}/../../.." && pwd)"
# The firmware dump lives one level above ROOT in this project layout. In a real
# Halium tree there is no dump — set SRC=/path/to/vendor.img explicitly.
PROJ_ROOT="$(cd "${ROOT}/.." && pwd)"

SRC="${SRC:-${PROJ_ROOT}/images/logical/vendor.img}"
BLOB_LIST="${SCRIPT_DIR}/proprietary-files.txt"
OUT_ROOT="${ROOT}/vendor/blackview/BL6000Pro"

if [[ ! -f "${SRC}" ]]; then
    echo "ERROR: vendor image not found at ${SRC}" >&2
    echo "       Run: python3 ${REPO_ROOT}/scripts/extract-super.py" >&2
    exit 1
fi
command -v debugfs >/dev/null 2>&1 || { echo "ERROR: debugfs (e2fsprogs) required" >&2; exit 1; }

echo "==> Source : ${SRC}"
echo "==> Output : ${OUT_ROOT}/proprietary"
mkdir -p "${OUT_ROOT}/proprietary"

extracted=0
missing=0
# Strip comments/blanks; each line is 'vendor/<path>' relative to the fw root.
while IFS= read -r line; do
    line="${line%%#*}"                      # drop trailing comments
    line="${line#"${line%%[![:space:]]*}"}" # ltrim
    line="${line%"${line##*[![:space:]]}"}" # rtrim
    [[ -z "${line}" ]] && continue

    # Path inside the ext4 image is relative to the vendor mount (strip 'vendor/')
    img_path="/${line#vendor/}"
    dest="${OUT_ROOT}/proprietary/${line#vendor/}"
    mkdir -p "$(dirname "${dest}")"

    if debugfs -R "dump ${img_path} ${dest}" "${SRC}" 2>/dev/null && [[ -s "${dest}" ]]; then
        extracted=$((extracted+1))
    else
        echo "   [missing] ${line}" >&2
        rm -f "${dest}"
        missing=$((missing+1))
    fi
done < "${BLOB_LIST}"

echo "==> Extracted ${extracted} blobs, ${missing} missing."
echo "==> Next: run ./setup-makefiles.sh to generate the vendor makefiles."
