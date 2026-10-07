# Blackview BL6000 Pro → Ubuntu Desktop Port

## Device Information
- **Device:** Blackview BL6000 Pro 5G
- **SoC:** MediaTek Dimensity 800 (mt6873 / k6873v1_64)
- **GPU:** ARM Mali-G57 MC3 (Valhall architecture, r25p0)
- **Kernel:** Linux 4.14.186+ (ARM64, built Jan 8 2022)
- **Android:** 11 (API 30), security patch 2021-12-05
- **Build:** BL6000Pro_EEA_S1000A_V1.0_20220108V09
- **Display:** Truly NT36675 (DSI, VDO mode)
- **Touch:** Goodix GT9886
- **Audio:** FocalTech FS1603S amplifier
- **Fingerprint:** Sunwave (fingerprint sensor)
- **WiFi/BT:** MediaTek combo chip (WIFI_RAM_CODE_soc2_0_3b_1)

## Dumped Partitions (in /tmp/rooting/dump/)
| Partition | Size | Purpose |
|-----------|------|---------|
| boot.img | 32 MB | Linux kernel + ramdisk |
| recovery.img | 40 MB | Recovery partition |
| dtbo.img | 8 MB | Device tree overlay |
| super.img | 5 GB | Dynamic partitions (system + vendor + product) |
| vbmeta.img | 8 MB | Verified boot metadata |
| lk.img | 2 MB | Bootloader (Little Kernel) |
| logo.img | 8 MB | Boot logo |
| tee1.img | 5 MB | Trusted Execution Environment |
| tee2.img | 9 MB | TEE backup |
| md1img.img | 200 MB | Modem firmware |
| cam_vpu1.img | 15 MB | Camera VPU firmware 1 |
| cam_vpu2.img | 15 MB | Camera VPU firmware 2 |
| cam_vpu3.img | 15 MB | Camera VPU firmware 3 |

## Extracted Analysis (in /tmp/rooting/analysis/)
- `kernel_raw` - Decompressed ARM64 kernel (Linux 4.14.186+)
- `device.dts` - Decompiled device tree (2,860 lines)
- `zImage` - Compressed kernel from boot.img
- `initrd.img` - Ramdisk with init scripts + fstab.mt6873

## HAL Blobs Found (vendor/lib64/hw/)

### Audio
- audio.primary.mt6873.so (2.1 MB)
- audio.r_submix.mt6873.so
- audio.usb.mt6873.so
- android.hardware.audio@6.0-impl-mediatek.so
- android.hardware.audio.effect@6.0-impl.so
- sound_trigger.primary.mt6873.so

### Display / Graphics
- hwcomposer.mt6873.so (947 KB) - Hardware composer
- gralloc.default.so
- android.hardware.graphics.allocator@4.0-impl-mediatek.so
- android.hardware.graphics.composer@2.1-impl.so
- android.hardware.graphics.mapper@4.0-impl-mediatek.so
- vulkan.mt6873.so (Vulkan driver)

### Camera
- android.hardware.camera.provider@2.6-impl-mediatek.so
- vendor.mediatek.hardware.camera.atms@1.0-impl.so
- vendor.mediatek.hardware.camera.bgservice@1.1-impl.so
- vendor.mediatek.hardware.camera.isphal@1.0-impl.so
- vendor.mediatek.hardware.camera.ccap@1.0-impl.so
- vendor.mediatek.hardware.camera.lomoeffect@1.0-impl.so

### Connectivity
- android.hardware.bluetooth@1.0-impl-mediatek.so
- android.hardware.bluetooth.audio@2.0-impl.so
- vendor.mediatek.hardware.bluetooth.audio@2.1-impl.so
- android.hardware.gnss@2.1-impl-mediatek.so
- gps.default.so

### Sensors / Input
- sensors.mt6873.so (171 KB)
- lights.mt6873.so
- vibrator.default.so
- power.mt6873.so
- thermal.mt6873.so
- sunwave.fingerprint.default.so (1 MB)
- fsfingerprint.default.so (5.3 MB)

### Firmware Files
- WIFI_RAM_CODE_soc2_0_3b_1.bin (768 KB)
- BT_FW.cfg
- gt9886_cfg_6873v01.bin (touch config for mt6873)
- gt9886_firmware_*.bin (touch firmware)
- fs1603s.fsm (audio amp firmware)

## Porting Roadmap

### Phase 1: Foundation ✅ DONE
- [x] Dump all partitions
- [x] Extract and analyze kernel
- [x] Decompile device tree
- [x] Identify all HAL blobs and firmware

### Phase 2: Kernel Work
- [ ] Extract kernel config (from /proc/config.gz or IKCONFIG)
- [ ] Identify required kernel modules (.ko files from vendor)
- [ ] Evaluate: keep stock 4.14 kernel vs upgrade to mainline
- [ ] Patch kernel for mainline DRM/KMS display support
- [ ] Enable Panfrost GPU driver (Valhall support exists in mainline)

### Phase 3: Userspace (Yocto/Buildroot)
- [ ] Set up Yocto build environment for aarch64
- [ ] Create machine config for mt6873/BL6000Pro
- [ ] Build minimal rootfs with systemd
- [ ] Integrate libhybris for Android HAL bridging
- [ ] Set up Mesa with Panfrost for GPU acceleration

### Phase 4: Display Stack
- [ ] Port DRM/KMS driver for MediaTek display controller
- [ ] Adapt hwcomposer HAL via libhybris or custom DRM driver
- [ ] Set up Wayland compositor (Weston or Sway)
- [ ] Configure touch input (Goodix GT9886 - mainline driver exists!)

### Phase 5: Peripherals
- [ ] WiFi/BT firmware loading (mt76 driver)
- [ ] Audio via ALSA + PulseAudio/PipeWire
- [ ] Camera (hardest - needs extensive reverse engineering in Ghidra)
- [ ] Fingerprint sensor (nice to have)
- [ ] Modem (if cellular data desired)

### Phase 6: Ubuntu Desktop Integration
- [ ] Ubuntu rootfs overlay (apt, GNOME/KDE/XFCE)
- [ ] Create custom boot image with Ubuntu kernel + initramfs
- [ ] Fastboot flash procedure
- [ ] Recovery/rollback mechanism

## Tools Available
- **Ghidra** - Reverse engineering HAL blobs
- **mtkclient** - Read/write partitions via BROM
- **abootimg** - Boot image manipulation
- **dtc** - Device tree compiler
- **debugfs** - ext4 filesystem inspection

## Key Advantages for This Port
1. **Mali-G57 (Valhall)** has open-source Panfrost driver in mainline Linux
2. **Goodix GT9886** touchscreen has mainline Linux driver
3. **MediaTek WiFi** chips often work with mainline mt76 driver
4. **Bootloader is unlocked** - can flash custom images
5. All HAL blobs and firmware have been dumped and are available for analysis

## Key Challenges
1. MediaTek Dimensity 800 has NO mainline kernel support
2. Stock kernel is 4.14 (old) - many modern Linux features need 5.x+
3. Camera HAL is the most complex to reverse engineer
4. Modem/telephony requires significant effort
5. No existing community port to reference