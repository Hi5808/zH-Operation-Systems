# Rebuilding libaalcamera.so (white balance) for the BL6000 Pro (UT 24.04 arm64)

The device is Ubuntu Touch 24.04 (noble) arm64; its ubports apt suite is `24.04-1.x`.
There is no local UT SDK, so build in a rootless arm64 container (podman + qemu).

```
podman run -d --name utbuild --platform linux/arm64 docker.io/library/ubuntu:24.04 sleep infinity
podman exec utbuild sh -c 'echo "deb [trusted=yes] http://repo.ubports.com/ 24.04-1.x main" > /etc/apt/sources.list.d/ubports.list'
podman exec utbuild apt-get update
podman exec utbuild env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  build-essential pkg-config qtbase5-dev qtmultimedia5-dev libqt5opengl5-dev libqt5sensors5-dev \
  libpulse-dev libgles2-mesa-dev libhybris-dev libmedia-dev libqtubuntu-media-signals-dev \
  android-headers libandroid-properties-dev libdeviceinfo-dev libexiv2-dev
# source = ubports qtubuntu-camera + this patch + the two new files
podman cp qtubuntu-camera utbuild:/src
podman exec utbuild sh -c 'cd /src/src && qmake && make -j4'
podman cp utbuild:/src/src/libaalcamera.so .
```
Deploy: bind-mount over /usr/lib/aarch64-linux-gnu/qt5/plugins/mediaservice/libaalcamera.so
(see ubports/overlay + bl6000pro-camera-wb.service). Device ldd shows all deps resolve.

Changes: adds AalImageProcessingControl (QCameraImageProcessing WhiteBalancePreset ->
android_camera_set_white_balance_mode, already in the compat layer). 0001-*.patch = the
3 modified files; aalimageprocessingcontrol.{h,cpp} = the new control.
