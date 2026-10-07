#!/bin/sh
# BL6000 Pro: bind the device's real identity (Blackview / BL6000Pro) into the
# Android container prop files before init. TrustKernel teed passes
# ro.product.brand/model to the TEE, which checks them against the factory
# device config; with Halium's "halium / Generic Device" the keybox/device-config
# verification fails and the fingerprint TA never gets its vendor key. With the
# real identity the chain completes (keybox.deployed=true, TA 5b9e0e41 loads).
# Safe to run every boot since kernel #56 fixed the tee_clkmgr CFI panic.
# Kill switch: create /userdata/bl6000pro-halium/identity.off to skip.
D=/userdata/bl6000pro-halium
[ -f "$D/identity.off" ] && exit 0
for m in "build.prop:system/build.prop" "product.build.prop:system/product/build.prop" "system_ext.build.prop:system/system_ext/build.prop"; do
  s=$D/${m%%:*}; d=${LXC_ROOTFS_MOUNT}/${m#*:}
  [ -f "$s" ] && [ -f "$d" ] && mount --bind "$s" "$d"
done
exit 0
