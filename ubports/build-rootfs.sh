#!/bin/bash
# build-rootfs.sh - assemble the BL6000 Pro Ubuntu Touch rootfs.img (no root
# needed): UT 24.04 rootfs + Halium 11 android-rootfs.img + device overlay.
set -euo pipefail
# Overlay and debs come from this repo; the big inputs (UT tarball, halium/)
# and the output images live in the work dir (UT_WORK).
export R="$(cd "$(dirname "$0")" && pwd)"
cd "${UT_WORK:-$HOME/bl6000pro-work/ut}"
rm -rf rootfs rootfs.img
export DEV=${DEV:-1}
fakeroot -s fakeroot.state bash -c '
  mkdir rootfs
  tar -xpzf ut-rootfs-24.04-arm64.tar.gz -C rootfs --numeric-owner
  cp -a halium/system/. rootfs/
  cp -a "$R/overlay/." rootfs/
  # locally rebuilt packages (e.g. ofono-binder-plugin-ext-mtk with mtkradioex@2.0)
  for d in "$R"/debs/*.deb; do [ -e "$d" ] && dpkg-deb -x "$d" rootfs/; done
  # everything we add is root-owned (laptop uid must never leak into the image)
  ( cd "$R/overlay" && find . -mindepth 1 ) | while read -r p; do chown -h 0:0 "rootfs/$p"; done
  # dev access: key-only SSH (root + phablet), persistent journal
  chmod 700 rootfs/root/.ssh; chmod 600 rootfs/root/.ssh/authorized_keys
  JG=$(awk -F: '\''$1=="systemd-journal"{print $3}'\'' rootfs/etc/group)
  chown 0:${JG:-0} rootfs/var/log/journal; chmod 2755 rootfs/var/log/journal
  # DEV=1 (default) marks a development image: skips the setup wizard.
  # Official builds: DEV=0 ./build-rootfs.sh
  [ "${DEV:-1}" = 1 ] && touch rootfs/usr/share/bl6000pro/dev-image
  echo bl6000pro > rootfs/etc/hostname
  SZ=$(( ($(du -sm rootfs | cut -f1) * 13 / 10 + 512) ))
  mke2fs -q -t ext4 -O ^orphan_file,^metadata_csum_seed -L rootfs -d rootfs rootfs.img ${SZ}M
'
e2fsck -fn rootfs.img >/dev/null && echo "rootfs.img OK: $(du -h --apparent-size rootfs.img | cut -f1)"
