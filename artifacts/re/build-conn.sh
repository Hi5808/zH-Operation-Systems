#!/bin/bash
# build-conn.sh - build MTK connectivity modules (Motorola android-12-release-STA32
# sources) against our BL6000 Pro kernel. Usage: ./build-conn.sh [wmt|wlan|bt|gps|fm|all]
W=$HOME/bl6000pro-work; C=$W/connectivity
KM=${KM:-$W/kmake.sh}; OUTD=${OUTD:-$W/out}
COMMON="TOP=$W/top CONFIG_MTK_PLATFORM=mt6873 MTK_PLATFORM_WMT=mt6873 TARGET_BOARD_PLATFORM_WMT=mt6873 KERNEL_OUT=$OUTD TARGET_BUILD_VARIANT=user"
b() { echo "== $1"; $KM M=$C/$1 modules $COMMON "${@:2}" > $W/conn-$(basename $1).log 2>&1; echo "rc=$?"; grep -E ' error:|WARNING: .*undefined' $W/conn-$(basename $1).log | sort -u | head -10; }
case "${1:-all}" in
  wmt|all) b common ;;&
  adaptor|wlan|all) b wlan-adaptor MODULE_NAME=wmt_chrdev_wifi KBUILD_EXTRA_SYMBOLS=$C/common/Module.symvers ;;&
  wlan|all) b wlan-core-gen4m/gen4m MTK_COMBO_CHIP=SOC2_2X2 WLAN_CHIP_ID=6873 CONFIG_MTK_COMBO_WIFI_HIF=axi \
      MODULE_NAME=wlan_drv_gen4m WIFI_IP_SET=3 MTK_ANDROID_WMT=y MTK_ANDROID_EMI=y MTK_WLAN_SERVICE=yes \
      CONFIG_MTK_MDDP_SUPPORT= KBUILD_EXTRA_SYMBOLS="$C/common/Module.symvers $C/wlan-adaptor/Module.symvers" ;;&
  bt|all) b bt-mt66xx/wmt BT_PLATFORM=connac1x MODULE_NAME=bt_drv KBUILD_EXTRA_SYMBOLS=$C/common/Module.symvers ;;&
  gps|all) b gps/gps_stp AUTOCONF_H=$OUTD/include/generated/autoconf.h KBUILD_EXTRA_SYMBOLS=$C/common/Module.symvers ;;&
esac
find $C -name '*.ko' -newer $W/kmake.sh
