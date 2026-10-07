#!/bin/sh
# BL6000 Pro: the MTK BT address lives in NVRAM (first 6 bytes of BT_Addr).
# bluebinder reads it from /var/lib/bluetooth/board-address.
F=/mnt/vendor/nvdata/APCFG/APRDEB/BT_Addr
[ -f /var/lib/bluetooth/board-address ] && exit 0
[ -r "$F" ] || exit 0
A=$(od -An -tx1 -N6 "$F" | tr -s ' ' | sed 's/^ //; s/ /:/g' | tr a-f A-F)
[ "$A" = "00:00:00:00:00:00" ] && exit 0
mkdir -p /var/lib/bluetooth && echo "$A" > /var/lib/bluetooth/board-address
