#!/usr/bin/env bash
# Scaffold a new device port folder under docs/android-linux-porting/devices/
# from the canonical templates in ../templates/. See ../10-device-profile-template.md
# for what each field means.
#
# Usage:
#   new-device.sh <codename> "<Display Name>" [SoC vendor] [SoC model]
#
# Example:
#   new-device.sh pixel-7-pro "Google Pixel 7 Pro" Qualcomm "Snapdragon 8 Gen 1 (SM8450)"

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GUIDE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_DIR="$GUIDE_DIR/templates"
DEVICES_DIR="$GUIDE_DIR/devices"
OVERVIEW_FILE="$GUIDE_DIR/00-overview.md"

usage() {
  cat <<'EOF'
Usage: new-device.sh <codename> "<Display Name>" [SoC vendor] [SoC model]

  <codename>       Short, lowercase, hyphenated folder name, e.g. pixel-7-pro
  <Display Name>   Human-readable name, e.g. "Google Pixel 7 Pro"
  [SoC vendor]     Optional: Qualcomm / MediaTek / Samsung Exynos / UNISOC /
                   HiSilicon / Allwinner / Rockchip / Tegra / other
  [SoC model]      Optional: exact chip, e.g. "Snapdragon 8 Gen 1 (SM8450)"

Creates docs/android-linux-porting/devices/<codename>/{profile.md,re-notes.md}
from the templates in docs/android-linux-porting/templates/, and prints the
markdown table row to add to 00-overview.md's device index.
EOF
}

if [[ $# -lt 2 || "$1" == "-h" || "$1" == "--help" ]]; then
  usage
  exit 1
fi

CODENAME="$1"
DISPLAY_NAME="$2"
SOC_VENDOR="${3:-TBD}"
SOC_MODEL="${4:-TBD}"

if [[ ! "$CODENAME" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
  echo "error: <codename> must be lowercase, alphanumeric, hyphen-separated (e.g. pixel-7-pro)" >&2
  exit 1
fi

DEVICE_DIR="$DEVICES_DIR/$CODENAME"
if [[ -e "$DEVICE_DIR" ]]; then
  echo "error: $DEVICE_DIR already exists" >&2
  exit 1
fi

render_template() {
  local tmpl_file="$1" out_file="$2"
  local content
  content="$(cat "$tmpl_file")"
  content="${content//@@CODENAME@@/$CODENAME}"
  content="${content//@@DISPLAY_NAME@@/$DISPLAY_NAME}"
  content="${content//@@SOC_VENDOR@@/$SOC_VENDOR}"
  content="${content//@@SOC_MODEL@@/$SOC_MODEL}"
  printf '%s\n' "$content" > "$out_file"
}

mkdir -p "$DEVICE_DIR"
render_template "$TEMPLATE_DIR/profile.md.tmpl" "$DEVICE_DIR/profile.md"
render_template "$TEMPLATE_DIR/re-notes.md.tmpl" "$DEVICE_DIR/re-notes.md"

echo "Created:"
echo "  $DEVICE_DIR/profile.md"
echo "  $DEVICE_DIR/re-notes.md"
echo
echo "Next: add a row for this device to the 'Devices tracked in this repo'"
echo "table in ${OVERVIEW_FILE#"$GUIDE_DIR"/}, e.g.:"
echo
echo "  | [$DISPLAY_NAME](devices/$CODENAME/profile.md) | $SOC_VENDOR / $SOC_MODEL | Profile created, firmware not yet dumped |"
