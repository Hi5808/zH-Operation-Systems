# Hardware / HAL Map — Blackview BL6000 Pro (mt6873)

Inventory extracted from `images/logical/vendor.img` (Android 11,
build `BL6000Pro_EEA_S1000A_V1.0_20220108V09`).

HAL blobs live in `vendor/lib64/hw/` (64-bit) and `vendor/lib/hw/` (32-bit).
Firmware lives in `vendor/firmware/`.

---

## HAL blobs by subsystem

### Display / Graphics
| Blob | Notes |
|---|---|
| `hwcomposer.mt6873.so` | Hardware Composer (947 KB) |
| `android.hardware.graphics.composer@2.1-impl.so` | HWC2 binderised |
| `android.hardware.graphics.allocator@4.0-impl-mediatek.so` | Gralloc allocator |
| `android.hardware.graphics.mapper@4.0-impl-mediatek.so` | Gralloc mapper |
| `gralloc.default.so` | Fallback gralloc |
| `vulkan.mt6873.so` | Vulkan driver (2.0 MB) |

**Porting note:** the display path is via MediaTek's DRM driver
(`CONFIG_DRM_MEDIATEK=y`) + `CONFIG_DRM_PANEL_TRULY_NT36675_VDO=y`. A custom
Wayland/DRM setup may be able to avoid the HWC blob entirely.

### Camera (heaviest subsystem)
| Blob | Notes |
|---|---|
| `android.hardware.camera.provider@2.6-impl-mediatek.so` | Camera provider |
| `vendor.mediatek.hardware.camera.isphal@1.0-impl.so` | ISP HAL (243 KB) |
| `vendor.mediatek.hardware.camera.atms@1.0-impl.so` | ATMS (auto-focus/tracking) |
| `vendor.mediatek.hardware.camera.bgservice@1.1-impl.so` | Background service |
| `vendor.mediatek.hardware.camera.ccap@1.0-impl.so` | Camera control |
| `vendor.mediatek.hardware.camera.lomoeffect@1.0-impl.so` | Effects |

**Porting note:** most complex to replace; likely requires Ghidra RE.

### Audio
| Blob | Notes |
|---|---|
| `audio.primary.mt6873.so` | Primary audio HAL (2.1 MB) |
| `audio.r_submix.mt6873.so` | Remote submix |
| `audio.usb.mt6873.so` | USB audio |
| `audio.bluetooth.default.so` | BT audio |
| `android.hardware.audio@6.0-impl-mediatek.so` | AUDIO HAL 6.0 |
| `android.hardware.audio.effect@6.0-impl.so` | Effects |
| `sound_trigger.primary.mt6873.so` | Sound trigger |

**Porting note:** `fs1603s.fsm` amp firmware + ALSA/PipeWire.

### Connectivity
| Blob | Notes |
|---|---|
| `android.hardware.bluetooth@1.0-impl-mediatek.so` | BT HAL |
| `android.hardware.bluetooth.audio@2.0-impl.so` | BT A2DP |
| `vendor.mediatek.hardware.bluetooth.audio@2.1-impl.so` | BT audio vendor ext |
| `android.hardware.gnss@2.1-impl-mediatek.so` | GNSS |
| `gps.default.so` | GPS |
| `vendor.mediatek.hardware.mms@1.5-impl.so` | MMS (modem) |
| `vendor.mediatek.hardware.videotelephony@1.0-impl.so` | VT (modem) |

Combo chip: `CONSYS_6873`. Kernel modules: `wlan_drv_gen4m.ko`,
`wmt_drv.ko`, `bt_drv.ko`, `gps_drv.ko`, `fmradio_drv.ko`.

### Sensors / Misc
| Blob | Notes |
|---|---|
| `sensors.mt6873.so` | Sensors HAL (171 KB) |
| `lights.mt6873.so` | Lights |
| `power.mt6873.so` | Power |
| `thermal.mt6873.so` | Thermal |
| `memtrack.mt6873.so` | Memtrack |
| `vibrator.default.so` | Vibrator |
| `sunwave.fingerprint.default.so` | Fingerprint (Sunwave, 1.0 MB) |
| `fsfingerprint.default.so` | Fingerprint (FPS, 5.3 MB) |
| `face.default.so` | Face unlock |

### Security (TEE)
| Blob | Notes |
|---|---|
| `gatekeeper.trustkernel.so`, `gatekeeper.default.so` | Gatekeeper |
| `vendor.mediatek.hardware.keymaster_attestation@1.1-impl.so` | Keymaster |
| `kmsetkey.trustkernel.so` | Key provisioning |
| `vendor.mediatek.hardware.nvram@1.1-impl.so` | NVRAM |

Backed by TrustKernel TEE (`tee1`/`tee2` partitions contain the TEE OS).

---

## Firmware blobs (`vendor/firmware/`)
| File | Purpose |
|---|---|
| `WIFI_RAM_CODE_soc2_0_3b_1.bin` | WiFi firmware (768 KB) |
| `BT_FW.cfg` | Bluetooth firmware config |
| `WMT_SOC.cfg` | Connectivity (WiFi/BT/GPS) config |
| `fm_cust.cfg` | FM radio config |
| `fs1603s.fsm` | FocalTech FS1603S audio amp firmware |
| `gt9886_cfg_6873v01.bin` | Goodix GT9886 touch config (mt6873) |
| `gt9886_firmware_*.bin` | Goodix GT9886 touch firmware |
| `gt9886_*` | Additional GT9886 variants (6785/6853/6885/6893) |

---

## Other relevant vendor contents
- `vendor/bin/hw/` — binderised HAL service executables
- `vendor/etc/init/` — init `.rc` scripts defining service startup order
- `vendor/etc/vintf/manifest.xml` — declared HAL interfaces
- `vendor/lib64/` — shared libraries (DRM, codecs, MTK proprietary)

---

## Useful inspection commands

```bash
debugfs -R 'ls -l /lib64/hw/' images/logical/vendor.img
debugfs -R 'ls -l /firmware/'  images/logical/vendor.img
debugfs -R 'rdump /lib64/hw /tmp/vendor-hw' images/logical/vendor.img
```

Use **Ghidra** on the `*.so` blobs to understand vendor IPCs when writing
open replacements or `libhybris` wrappers.
