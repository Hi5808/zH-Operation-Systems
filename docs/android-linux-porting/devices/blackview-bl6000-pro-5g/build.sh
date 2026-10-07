#!/usr/bin/env bash
# =============================================================================
# Blackview BL6000 Pro 5G (MediaTek MT6873) — Ubuntu Touch / Halium build script
# =============================================================================
# Reproducible build of the OPEN components of the port. Vendor blobs are NOT
# included or redistributed — this builds the kernel, boot image, and the two
# userspace plugins we patched, and lays out the overlay. Fill the <PLACEHOLDER>
# paths for your environment. See re-notes.md / profile.md for the RE behind each
# step. Hard-won deployment rules are in the comments — follow them.
set -euo pipefail

# ---- 0. config (edit these) -------------------------------------------------
WORK="${WORK:-$HOME/bl6000pro}"            # scratch root
KSRC="$WORK/kernel-mt6873"                 # MTK 4.14 kernel tree (cezanne-r-oss base + RE'd drivers)
OUT="$WORK/out"                            # kernel out dir
TOOLCHAIN="$WORK/toolchain/clang-r383902"  # AOSP clang
STOCK_BOOT="$WORK/stock/boot.img"          # for ramdisk+dtb extraction (your dump; never redistributed)
CMDLINE="bootopt=64S3,32N2,64N2 console=tty0 loop.max_part=7 printk.devkmsg=on"
UBPORTS_SUITE="24.04-1.x"                  # ubports apt suite for the build container

# ---- 1. kernel + connectivity modules --------------------------------------
# Image config enables CONFIG_CUSTOM_KERNEL_IMGSENSOR (imx582/s5k3p9sp/s5k3l6xx/gc032a),
# the tkcore TEE driver (with the CFI fix in peridev.c), and the SunWave fingerprint glue.
build_kernel() {
  export PATH="$TOOLCHAIN/bin:$PATH" ARCH=arm64
  make -C "$KSRC" O="$OUT" CC=clang LLVM=1 bl6000pro_defconfig
  make -C "$KSRC" O="$OUT" CC=clang LLVM=1 -j"$(nproc)" Image.gz-dtb
  # connectivity (WMT/WiFi/BT/GPS) out-of-tree modules
  "$KSRC/build-conn.sh" all      # produces wlan/bt/gps .ko + fs load script
}

# ---- 2. boot image (ramdisk from UT boot, our kernel, AVB hash footer) ------
# NOTE: the boot image MUST carry a valid AVB hash footer or LK panics in an
# hdr_loaded loop. repack-boot.sh (header v2 + dtb + footer) handles this.
build_boot() {
  "$WORK/tools/unpack_bootimg.py" --boot_img "$STOCK_BOOT" --out "$WORK/ramdisk"
  "$WORK/tools/repack-boot.sh" \
     "$OUT/arch/arm64/boot/Image.gz" "$WORK/ramdisk/ramdisk" \
     "$OUT/arch/arm64/boot/dts/.../bl6000pro.dtb" "$WORK/ut-boot.img" "$CMDLINE"
}

# ---- 3. userspace plugins (cross-build arm64, MATCH the installed version) --
# RULE: build each plugin against the EXACT git commit the device package ships
# (the commit is embedded in the dpkg version string). A newer HEAD may bump the
# SONAME / change the IPC interface and will not load. Verify with
# `readelf -d <lib> | grep NEEDED` and `ldd <lib>` ON the device before use.
container() { podman exec utbuild sh -c "$1"; }
setup_container() {
  podman run -d --name utbuild --platform linux/arm64 docker.io/library/ubuntu:24.04 sleep infinity
  container "echo 'deb [trusted=yes] http://repo.ubports.com/ $UBPORTS_SUITE main' > /etc/apt/sources.list.d/ubports.list"
  container "apt-get update"
}

# 3a. biometryd QML plugin — single-touch fingerprint availability fix.
#     Watches the com.ubports.biometryd.Service bus name (QDBusServiceWatcher) so
#     Biometryd.available flips true when biometryd starts late; builds default
#     Device lazily. Build from the device's biometryd commit; link Qt5::DBus.
build_biometryd_qml() {
  container "apt-get install -y --no-install-recommends cmake cmake-extras pkgconf \
      libdbus-1-dev libdbus-cpp-dev libprocess-cpp-dev qtbase5-dev qtdeclarative5-dev \
      libapparmor-dev libboost-filesystem-dev libboost-program-options-dev libsqlite3-dev \
      nlohmann-json3-dev libglib2.0-dev libgtest-dev google-mock"
  # (apply the service.{h,cpp} bus-watcher patch + add find_package(Qt5DBus)+Qt5::DBus, then:)
  container "cd /bio && mkdir -p build && cd build && cmake .. -DENABLE_QT6=OFF -DENABLE_WERROR=OFF \
      -DUSE_SYSTEMD=OFF && make -j\$(nproc) biometryd-qml"
}

# 3b. qtubuntu-camera (libaalcamera.so) — white-balance control (AalImageProcessingControl).
#     NOTE: deploying this WB plugin requires its matching QML (ViewFinderOverlay WB additions)
#     as a CONSISTENT SET — the WB QML binds camera.imageProcessing.whiteBalanceMode which only
#     exists in this build. (On this device the WB control also destabilised preview init; treat
#     WB as experimental. The 3-camera cycle below is independent and reliable.)
build_qtubuntu_camera() {
  container "apt-get install -y --no-install-recommends build-essential pkg-config qtbase5-dev \
      qtmultimedia5-dev libqt5opengl5-dev libqt5sensors5-dev libpulse-dev libgles2-mesa-dev \
      libhybris-dev libmedia-dev libqtubuntu-media-signals-dev android-headers \
      libandroid-properties-dev libdeviceinfo-dev libexiv2-dev"
  container "cd /qtcam/src && qmake && make -j\$(nproc)"   # -> libaalcamera.so
}

# ---- 4. overlay layout + DEPLOYMENT RULES -----------------------------------
# The device /system is read-only. Deploy every fix as a boot-time systemd unit
# that BIND-MOUNTS the file over its stock path, with a payload on the writable
# data partition and a kill-switch sentinel.
#
#   *** CARDINAL RULE (learned the hard way): apply overlays at BOOT, before the
#       target app/HAL starts — NEVER `mount --bind` live over a running app and
#       never force-kill+rebind. Live binding corrupts app state (black screen). ***
#
# Camera 3-lens cycle: bind ONLY ViewFinderView.qml (stock + a ~6-line change that
# cycles QtMultimedia.availableCameras instead of toggling front/back). It has NO
# dependency on the WB plugin — keep it separate so the camera is reliable.
#
# Diff your overlay QML against the CURRENT stock app QML; if the only delta is your
# intended change, it is version-safe. Extra/removed lines = version drift = it will break.
deploy_notes() { :; }  # see ../../17-reversible-development.md and re-notes.md

# ---- 5. flash + install -----------------------------------------------------
# Back up the working boot partition first: dd if=by-partlabel/boot of=boot-backup.img
# Flash boot: fastboot flash boot ut-boot.img   (or dd to /dev/disk/by-partlabel/boot)
# Overlay: copy payloads to /userdata/<component>/, enable the bind-mount units.
# NEVER program the RPMB key. Keep the full partition backup (seccfg/vbmeta/lk/tee).

main() {
  mkdir -p "$WORK"
  build_kernel
  build_boot
  setup_container
  build_biometryd_qml
  build_qtubuntu_camera
  echo "Build complete. See re-notes.md for per-component RE and deployment units."
}
main "$@"
