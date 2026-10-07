# Ubuntu Touch for Blackview BL6000 Pro 5G (MediaTek MT6873)

A community Halium 11 port of Ubuntu Touch to the Blackview BL6000 Pro 5G.
(Searchable title — people find the port by this.)

## Status: working daily driver (community / "as-is")
Working: calls + **VoLTE**, LTE data, SMS, Wi-Fi, Bluetooth (incl. BLE kbd), GPS,
speaker/headphone audio, video recording with sound, **all 3 cameras** (main /
front / ultra-wide, 12 MP), **fingerprint** (enrol + unlock + single-touch),
vibration, sensors, charging, NFC HAL.
Not working / known gaps: 48 MP capture (Camera1 can't drive MTK remosaic),
manual white balance, orange "unlocked" boot warning (cosmetic).

## Build
See **build.sh** — full pipeline: kernel (`Image.gz-dtb`) -> boot image ->
cross-built userspace plugins (biometryd single-touch, qtubuntu-camera) -> overlay.
Reverse-engineering notes and the deployment rules are in `re-notes.md`.

## Install
Flash the built `boot.img` to the boot partition and deploy the rootfs per the
guide. **Back up your partitions first** (boot, seccfg, vbmeta, lk, tee). Never
program the RPMB key. (Detailed steps: `docs/INSTALL.md` — TODO before release.)

## Credits / license
Kernel: GPLv2 (MediaTek/Xiaomi 4.14 base + reverse-engineered device drivers).
Derived RE notes only; no vendor binaries are redistributed here.
