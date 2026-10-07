#!/usr/bin/env bash
#
# mt6873-wifi-bt-load.sh - Load the CONSYS WiFi/BT firmware on mt6873 and bring
# up the wireless interfaces (Phase 6).
#
# On this device WiFi/BT/GPS/FM are one MediaTek CONSYS combo chip
# (CONFIG_MTK_CONNSYS_COMB_CHR / MTK_WMT / WIFI_MT6873). The chip needs its RAM
# code downloaded through the WMT (Wireless Management Tool) interface before
# the wlan0 / bluetooth interfaces appear.
#
# Firmware files (confirmed present in the stock vendor partition, and listed in
# proprietary-files.txt so they ship in the port):
#   WIFI_RAM_CODE_mt6873_1{,a,b}.bin     - WiFi RAM code (3 board variants)
#   BT_RAM_CODE_MT6873_1_1_hdr{,_t}.bin  - Bluetooth RAM code
#   WMT_SOC.cfg                          - WMT SoC config
#   (GPS/GNSS runs off the same CONSYS download)
#
# This script is a bring-up/diagnostic helper. In a finished port the Android
# wifi/bluetooth HAL services (android.hardware.wifi@1.0-service,
# android.hardware.bluetooth@1.0-service-mediatek) perform this load; this tool
# reproduces it manually for debugging when those services are not yet running.
#
set -uo pipefail

FW_DIR="${FW_DIR:-/vendor/firmware}"
WMT_DEV="${WMT_DEV:-/dev/stpwmt}"
WMT_DETECT="${WMT_DETECT:-/dev/wmtdetect}"

log() { echo "[wifi-bt] $*"; }

log "=== CONSYS firmware load (mt6873) ==="

# 1. Sanity-check the WMT interface and firmware.
if [[ ! -e "${WMT_DEV}" ]]; then
    log "ERROR: ${WMT_DEV} not present. The CONSYS/WMT kernel driver is not"
    log "       loaded, or the node was not bind-mounted into the container."
    log "       Check: lsmod | grep -iE 'wmt|consys'; dmesg | grep -i wmt"
    exit 1
fi
log "WMT device: ${WMT_DEV} present"

for fw in WIFI_RAM_CODE_mt6873_1.bin BT_RAM_CODE_MT6873_1_1_hdr.bin WMT_SOC.cfg; do
    if [[ -f "${FW_DIR}/${fw}" ]]; then
        log "  firmware OK: ${FW_DIR}/${fw}"
    else
        log "  firmware MISSING: ${FW_DIR}/${fw}"
    fi
done

# 2. Trigger the WMT chip detect + firmware download.
# The CONSYS driver exposes the WMT through /dev/wmtdetect and /dev/stpwmt.
# Writing the function-enable commands downloads the RAM code.
if [[ -e "${WMT_DETECT}" ]]; then
    log "detecting CONSYS chip via ${WMT_DETECT} ..."
    # MTK WMT function numbers: 1=WIFI 2=BT 3=GPS 4=FM. Enable WiFi+BT+GPS.
    for func in 1 2 3; do
        echo "${func}" > "${WMT_DETECT}" 2>/dev/null \
            && log "  enabled WMT function ${func}" \
            || log "  (could not write function ${func} to ${WMT_DETECT})"
    done
fi

# 3. Wait for the interfaces to appear.
log "waiting for wlan0 / bluetooth interfaces ..."
for i in $(seq 1 10); do
    [[ -d /sys/class/net/wlan0 ]] && { log "  wlan0 appeared"; break; }
    sleep 1
done

# 4. Report state.
log "=== interface state ==="
ip link show wlan0 2>/dev/null | head -2 || log "  wlan0: NOT present"
if command -v rfkill >/dev/null 2>&1; then
    rfkill list 2>/dev/null | grep -iE 'bluetooth|wlan|gps' || log "  rfkill: no wireless entries"
fi
log "  dmesg tail (CONSYS):"
dmesg 2>/dev/null | grep -iE 'wmt|consys|wifi|bt_|stp' | tail -15 | sed 's/^/    /'

log "=== done ==="
log "If wlan0 did not appear, the RAM code download failed - check that the"
log "firmware path matches what the driver expects (dmesg | grep -i 'ram code')."
