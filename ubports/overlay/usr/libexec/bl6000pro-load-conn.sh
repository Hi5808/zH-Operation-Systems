#!/bin/sh
# BL6000 Pro MTK CONSYS bring-up (WMT + WiFi + BT + GPS), sources built for the Halium
# kernel. Stage "wmt" runs BEFORE the Android container (so its vendor
# wmt_loader finds /dev/wmtdetect); stage "wifi" runs after it.
D=/usr/lib/bl6000pro/modules
[ -d /userdata/bl6000pro-modules ] && D=/userdata/bl6000pro-modules
log() { echo "bl6000pro-conn: $*" > /dev/kmsg; }
ld() { grep -q "^$1 " /proc/modules || insmod "$D/$1.ko" || log "insmod $1 failed"; }
case "$1" in
wmt)
    ld wmt_drv ;;
wifi)
    ld wmt_drv
    i=0
    until [ "$(getprop vendor.connsys.driver.ready)" = yes ] || [ $i -ge 60 ]; do
        # vendor wmt_loader is a oneshot; re-trigger it if it ran too early
        [ $i = 15 ] && { log "re-triggering wmt_loader"; setprop ctl.start wmt_loader; }
        sleep 1; i=$((i+1))
    done
    log "connsys ready=$(getprop vendor.connsys.driver.ready) after ${i}s"
    ld wmt_chrdev_wifi
    ld wlan_drv_gen4m
    on=0
    for n in 1 2 3 4 5; do
        echo 1 > /dev/wmtWifi 2>/dev/null && { log "wifi powered on"; on=1; break; }
        sleep 2
    done
    [ $on = 1 ] || log "wifi power-on failed"
    # Bluetooth (/dev/stpbt, used by the vendor BT HAL + bluebinder) and GPS (/dev/stpgps)
    ld bt_drv
    ld gps_drv_stp
    # Android ueventd makes /dev/uhid system:system; bluetoothd (root, no
    # CAP_DAC_OVERRIDE) must own it to create BLE (HoG) keyboards/mice.
    chown root:root /dev/uhid 2>/dev/null
    # Camera: the face-detect engine (FDVT) never completes (driver ABI
    # mismatch, WORKLOG §32) and its cmdq timeouts stall the HAL pipeline.
    setprop vendor.debug.camera.fd.disable 1
    # 3DNR uses the RSC engine, whose requests are never dequeued (driver
    # mismatch, WORKLOG §33); its rsc_mv pool starves and video stalls.
    setprop vendor.debug.camera.3dnr.enable 0
    setprop vendor.debug.fpipe.force.3dnr 0 ;;
esac
