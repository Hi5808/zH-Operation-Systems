# Ubuntu Touch / Lomiri Port Plan: Anbernic RG405M

## Overview

Port the **Anbernic RG405M** to **Ubuntu Touch** with **Lomiri** shell. This is a **standard phone port** — the device is a phone SoC (UNISOC T618) without a modem. Approach: Halium (5.1A) with native kernel + Android HAL container, same as any other UBports phone.

**Device:** Anbernic RG405M — UNISOC T618 phone SoC (no cellular modem), 4GB RAM, 128GB eMMC, 4" landscape IPS touchscreen, gamepad  
**Port type:** Phone without modem (Wi-Fi only)  
**Target OS:** Ubuntu Touch (via UBports)  
**UI Shell:** Lomiri (standard phone shell)  
**Approach:** Halium (5.1A: native kernel + Android HAL container) — identical to standard phone porting  
**Customizations:** Display rotation (1 line) + gamepad input mapping (isolated to input layer)  
**Safety:** Dual-boot from microSD (eMMC untouched during development)  

**Key insight:** 95% of this port is identical to any UNISOC phone. Modem absence + gamepad are isolated changes.  

---

## Phase 1: Setup & Hardware Verification (1-2 weeks)

### 1.1 Environment & Tools
- [ ] Clone UBports porting documentation: https://docs.ubports.com/en/latest/porting/introduction.html
- [ ] Install `git`, `repo`, `adb`, `fastboot`, `spd_dump`, `unisoc-unlock`
- [ ] Set up a build machine (Ubuntu 20.04 LTS or later recommended)
- [ ] Review [Chapter 16: Feasibility Triage](../../16-feasibility-triage.md) for this device

### 1.2 Bootloader & Recovery Setup
- [ ] **Verify unlock path:** UNISOC unlock via `unisoc-unlock` (confirmed in profile)
  ```bash
  adb reboot bootloader
  fastboot reboot fastboot
  python3 -m unisoc_unlock  # or web tool at thegammasqueeze.github.io/subut-rehost/
  ```
- [ ] **Confirm fastbootd:** Test UNISOC fastbootd-like mode responsiveness
- [ ] **Backup stock SPL:** `spd_dump` the bootloader before any modifications
- [ ] **Test microSD boot:** Boot GammaOS from microSD to confirm USB serial console works
  ```bash
  screen /dev/ttyACM0 115200
  ```

### 1.3 Kernel Source Preparation
- [ ] **Start with RGOS:** Clone `github.com/rgos-yocto/meta-anbernic`
  - Use `linux-unisoc-t618` vendor tree (~4.14 base) + RGOS's 40 patch series
  - Device tree: `ums512-rg405m.dtb` (source: `ums512-rg405m.dts`)
  
- [ ] **Understand Halium requirements:**
  - Halium needs specific kernel configs (e.g., `CONFIG_ANDROID_BINDER`, `CONFIG_ANDROID_LOGGER`)
  - See [Chapter 4.6: Halium Checker](../../04-kernel-porting.md#46-linux-user-space-option-set)
  - Cross-check RGOS defconfig against Halium requirements

- [ ] **Reserve-memory regions:** Map stock Android DT memory layout (graphics buffers, ion heaps)
  - Reference GammaOS `ums512-rg405m.dts` for ion/carveout ranges

---

## Phase 2: Halium Device Tree & HAL Integration (2-3 weeks)

### 2.1 Create Halium Device Tree Package
- [ ] **Directory structure:**
  ```
  device/anbernic/rg405m/
  ├── Android.mk
  ├── BoardConfig.mk
  ├── device.mk
  ├── vendor.mk
  └── lineage.mk (or ubports.mk)
  
  vendor/anbernic/rg405m/
  ├── BoardConfigVendor.mk
  └── proprietary-files.txt
  ```

- [ ] **Adapt from existing Halium port:** Reference similar T618/MediaTek devices
  - `device/umidigi/a5_pro` (Halium example for MediaTek)
  - `device/samsung/a70` (Halium example for Exynos)

- [ ] **Fill in hardware configuration:**
  - Display: DRM/KMS (MIPI-DSI), resolution 640×480, rotate-270
  - Touch: Goodix (I2C), interrupt + GPIO-mux (from RGOS patch 0029)
  - Audio: ASoC sc2730 codec (downstream driver)
  - Wi-Fi/BT: UNISOC `sprdwcn` (SDIO)
  - Gamepad: GPIO-keys + Hall-effect ADC joypad

### 2.2 proprietary-blobs.txt & HAL Inventory
- [ ] **Identify closed-source HALs needed in container:**
  ```
  # Audio HAL (if using vendor codec)
  vendor/lib/hw/audio.primary.ums512.so
  
  # Wi-Fi/BT firmware & libraries
  vendor/lib/libwpa_client.so
  vendor/etc/wifi/wlan_firmware.bin
  vendor/lib/modules/sprdwcn.ko
  
  # GPU (if Mali GL acceleration, else skip)
  vendor/lib/egl/libEGL_mali.so
  vendor/lib/libmali.so
  
  # Codec / media
  vendor/lib/libOMX_Core.so
  vendor/lib/libstagefright_*.so
  ```

- [ ] **Test extraction:** Pull from running GammaOS or stock Android dump
  ```bash
  adb pull /system/lib/hw/audio.primary.ums512.so
  adb pull /vendor/lib/libwpa_client.so
  ```

- [ ] **Create manifest:** Document what each HAL provides (audio, Wi-Fi, graphics)

### 2.3 Libhybris Integration
- [ ] **Clone libhybris:** https://github.com/libhybris/libhybris
- [ ] **Build against vendor HALs:** Compile libhybris to wrap Android HALs for glibc
  ```bash
  ./autogen.sh
  ./configure --with-android-source=/path/to/android-source \
    --with-android-headers=/path/to/vendor/include
  make
  ```

- [ ] **Test HAL loading:** Verify HALs load without crashes in the container
  ```bash
  # In Halium container
  android_app_started
  adb shell getprop ro.product.device  # confirm device name
  ```

---

## Phase 3: Kernel & Bootloader Adaptation (2-3 weeks)

### 3.1 Kernel Config for Halium
- [ ] **Merge Halium requirements into RGOS defconfig:**
  ```
  CONFIG_ANDROID_BINDER=y
  CONFIG_ANDROID_LOGGER=y
  CONFIG_HID_GENERIC=y
  CONFIG_FUSE_FS=y
  CONFIG_CRYPTO_MD5=y
  CONFIG_CRYPTO_SHA1=y
  CONFIG_TUN=y
  CONFIG_VFAT_FS=y
  ```

- [ ] **Disable/adjust for handheld (no modem, no cellular):**
  ```
  # Not needed for RG405M
  CONFIG_RADIO_ADAPTERS=n
  CONFIG_QCOM_IPC_ROUTER=n
  ```

- [ ] **Run Halium checker:**
  ```bash
  # In pmbootstrap or Halium build environment
  halium-device-tree-validate ums512-rg405m.dts
  ```

### 3.2 U-Boot & Extlinux Configuration
- [ ] **Set up U-Boot for microSD boot:**
  - Follow RGOS's u-boot config as base
  - Ensure extlinux.conf points to microSD kernel/initramfs
  - Test: Boot from microSD with serial console attached

- [ ] **Partition layout for dual-boot:**
  ```
  microSD:
  - Partition 1 (FAT32): U-Boot + extlinux.conf + kernel + DTB
  - Partition 2 (ext4): initramfs
  - Partition 3 (ext4): rootfs (Ubuntu Touch)
  
  eMMC: (unchanged, stock Android remains)
  ```

- [ ] **Flash & test:**
  ```bash
  # Via UNISOC download mode
  spd_dump -w 0x0 u-boot.bin
  # Then boot with microSD inserted, kernel should load
  ```

### 3.3 Device Tree for Halium
- [ ] **Adapt `ums512-rg405m.dts` for Halium requirements:**
  - Add `android,fstab` entries (mountpoints for `/system`, `/vendor`, `/data`)
  - Ensure GPIO/interrupt mappings match hardware
  - Add device nodes for touch, display, audio codec

- [ ] **Cross-check with stock GammaOS DT** for any missing nodes

---

## Phase 4: Build Halium & Ubuntu Touch Rootfs (3-4 weeks)

### 4.1 Halium Build (ROM + Container)
- [ ] **Clone Halium 12 or Halium 13 repo manifest**
  ```bash
  mkdir ~/halium && cd ~/halium
  repo init -u https://github.com/halium/manifest.git -b halium-11.0
  repo sync
  ```

- [ ] **Place device tree:**
  ```bash
  cp -r device/anbernic/rg405m ~/halium/device/anbernic/
  cp -r vendor/anbernic/rg405m ~/halium/vendor/anbernic/
  ```

- [ ] **Build:**
  ```bash
  source build/envsetup.sh
  lunch rg405m-userdebug
  mka -j$(nproc) halium-boot
  ```
  - Output: `halium-boot.img` (kernel + initramfs with Android container)

### 4.2 Ubuntu Touch Rootfs
- [ ] **Download pre-built Ubuntu Touch image for arm64** (or build from source)
  - https://github.com/ubports/ubuntu-touch
  - Or use `pmbootstrap rootfs ubuntu-touch arm64`

- [ ] **Customize rootfs for handheld:**
  - Add gamepad input mappings (`/etc/udev/rules.d/` for joystick, d-pad)
  - Ensure Lomiri runs in landscape (96 dpi, 640×480 resolution)
  - Disable modem/cellular UI elements (SIM slot, cellular signal, call log)

- [ ] **Package into rootfs image:**
  ```bash
  mkfs.ext4 -L rootfs rootfs.img 2GB
  # Mount and populate
  ```

### 4.3 Flash & Boot Test
- [ ] **Create microSD card:**
  ```bash
  sudo dd if=halium-boot.img of=/dev/sdX1 bs=4M
  sudo dd if=rootfs.img of=/dev/sdX3 bs=4M
  ```

- [ ] **Boot and verify:**
  - Insert microSD + power on RG405M
  - Monitor serial console: should see kernel boot → Halium init → Android container
  - `adb devices` should list the device
  - `/data` should be writable (for Ubuntu Touch user data)

---

## Phase 5: Ubuntu Touch / Lomiri Integration (3-4 weeks)

### 5.1 Halium Session & Lomiri Startup
- [ ] **Install UBports adaptation packages** (in rootfs):
  ```bash
  sudo apt install ubuntu-touch-session lomiri \
    libhybris-compat libhybris-egl-dev \
    libandroid-properties-dev \
    python3-gi gir1.2-mutter-3 gir1.2-gio-2.0
  ```

- [ ] **Configure display server:**
  - Ensure Weston or Mir (Ubuntu Touch's Wayland server) starts
  - Set display rotation to 270° (landscape, as per profile)
  - Configure DPI for 4" screen at 640×480

- [ ] **Start Halium session:**
  ```bash
  # In /usr/share/wayland-sessions/ubports.desktop or similar
  [Desktop Entry]
  Name=Ubuntu Touch (Halium)
  Exec=halium-shell
  Session=halium
  ```

### 5.2 Input Mapping & Gamepad (RG405M Specific)
This is the **only truly RG405M-specific customization**. Standard Ubuntu Touch handles touch input; gamepad mapping is isolated.

- [ ] **Expose gamepad as input device** (likely automatic via GPIO-keys driver):
  ```bash
  evtest /dev/input/event0  # confirm gamepad events appear
  ```

- [ ] **Create `/etc/udev/rules.d/99-gamepad.rules` (device-specific mappings):**
  ```
  # Retrogame joystick (analog sticks) and GPIO buttons (d-pad/ABXY/L/R)
  ATTRS{name}=="retrogame_joypad*", ENV{ID_INPUT_JOYSTICK}="1"
  ATTRS{name}=="singleadcjoy*", ENV{ID_INPUT_JOYSTICK}="1"
  ATTRS{name}=="gpio-keys", ENV{ID_INPUT_KEY}="1"
  ```

- [ ] **Map buttons in Lomiri** (phone shell already supports gamepad):
  - **d-pad** → Arrow keys (navigation in menus)
  - **ABXY** → App launcher, back button, home, menu
  - **L/R** → Alt+Tab / window switching
  - **Analog sticks** → Mouse cursor (if needed) or app-specific controls
  
  Mapping can be done in:
  - `/etc/xkb/symbols/` (xkb keyboard layout)
  - App-specific configs (emulator or game app)
  - Lomiri settings → Input (if UI supports it)

- [ ] **Test interactivity:**
  ```bash
  # In Lomiri shell:
  # 1. Press d-pad → focus navigation works
  # 2. Press ABXY → menu navigation works
  # 3. Press L/R → window switcher works
  # 4. Analog sticks → optional (not critical for phone use)
  evtest /dev/input/event*  # confirm all events appear
  ```

**This is a small, isolated change.** Phone porting handles the rest.

### 5.3 Audio & Codec Integration
- [ ] **Verify ASoC routing** in Halium container:
  - Test speaker output: `aplay /usr/share/sounds/freedesktop/stereo/complete.oga`
  - Test headset jack detection

- [ ] **Configure PulseAudio (or PipeWire):**
  ```bash
  # In rootfs
  pacmd list-cards
  pacmd set-card-profile 0 "output:speaker"  # select output
  ```

- [ ] **Add to Lomiri settings** (audio volume control, headset mode toggle)

### 5.4 Display & Touchscreen
- [ ] **Weston/Mir display initialization:**
  - Set resolution to 640×480, rotate 270°
  - Configure DRM/KMS driver (`sprd-drm`)
  - Test: splash screen + Lomiri shell visible

- [ ] **Touchscreen calibration:**
  ```bash
  xinput calibrate /dev/input/event1
  # Save calibration to /etc/X11/xorg.conf.d/
  ```

- [ ] **Lock screen & suspend:**
  - Verify screen sleeps after timeout (DPMS)
  - Test wake via touch / power button

---

## Phase 6: Testing & Validation (2-3 weeks)

### 6.1 Subsystem Testing
Test each subsystem per [Chapter 18: Validation & Testing](../../18-validation-and-testing.md):

| Subsystem | Test | Expected Result |
|-----------|------|-----------------|
| **Display** | Open Settings app, confirm UI renders | Lomiri shell visible, no glitches |
| **Touch** | Tap buttons, swipe gestures | Input registers correctly |
| **Gamepad** | Press buttons while in game (if available) | D-pad/ABXY/L/R control app |
| **Audio** | Play music in app, test speaker + jack | Sound from speakers, silence on jack detect |
| **Wi-Fi** | Open WiFi settings, scan + connect | Network accessible, speed ≥ 20 Mbps |
| **Bluetooth** | Pair headphones/controller | Audio/data streams work |
| **Storage** | Write/read test files to eMMC (via microSD) | R/W speeds > 50 MB/s, no ADMA errors |
| **Battery** | Monitor fuel-gauge in Settings | Charge % updates, time-to-empty displays |
| **Suspend/Resume** | Power button → sleep → power button | Screen wakes, apps resume |

### 6.2 Performance & Stability
- [ ] **Soak test:** 8+ hours of continuous use (apps, media, gaming)
- [ ] **Thermal:** Monitor `/sys/class/thermal/thermal_zone*/temp` under load
- [ ] **Memory:** Check `/proc/meminfo` for leaks (apps should release on exit)
- [ ] **Storage:** `fstrim` on rootfs, confirm eMMC health

### 6.3 Handheld-Specific Validation
- [ ] **Gaming performance:** Test in emulator (if available) or game app
- [ ] **Landscape orientation:** Ensure all Lomiri UI elements are accessible
- [ ] **Control responsiveness:** Latency < 50ms for button → on-screen response
- [ ] **Battery life:** Typical use (mix of idle, Wi-Fi, light gaming) → target ≥ 10 hours

### 6.4 Status Table Update
Update [profile.md](profile.md) § Status with real test results:

```markdown
| Subsystem | Status | Notes |
|-----------|--------|-------|
| Boots to Lomiri | 🟩 | halium-shell → Wayland → Lomiri |
| Display | 🟩 | 640×480 rotated 270°, 96 DPI |
| Touch input | 🟩 | Goodix, calibrated |
| Gamepad controls | 🟩 | d-pad + ABXY + L/R mapped |
| Wi-Fi | 🟩 | sprdwcn + NetworkManager |
| Bluetooth | 🟩 | BlueZ A2DP working |
| Audio playback | 🟩 | Speaker + headset jack detect |
| Audio recording | 🟨 | Mic capture TBD (Android USB debug needed) |
| GPU acceleration | 🟨 | Display software (pixman); Mali GL TBD |
| Battery/charging | 🟩 | sc27xx fuel-gauge + Lomiri indicator |
| Storage (eMMC) | 🟥 | ADMA fault remains; rootfs on microSD |
```

---

## Phase 7: Publication & Upstream (1-2 weeks)

### 7.1 UBports Device Page
- [ ] **Create device entry:** devices.ubuntu-touch.io dashboard
- [ ] **Upload port repo:** `github.com/ubports-rg405m/` or equivalent
- [ ] **Document known issues:**
  - eMMC ADMA fault (rootfs on microSD)
  - Mic capture pending Android HAL investigation
  - Mali GL acceleration pending Panfrost validation

### 7.2 Update Profile
- [ ] **Finalize [profile.md](profile.md):**
  - Bridge baseline filled in (Native / HAL-shim / Firmware-blob for each subsystem)
  - Status table complete
  - Lessons learned documented

- [ ] **Add to [CONTRIBUTING.md](../../CONTRIBUTING.md)** as a reference for future UNISOC ports

### 7.3 Community Documentation
- [ ] **Write user guide:** "Installing Ubuntu Touch on RG405M"
  - microSD card preparation
  - Flashing steps (UNISOC unlock → halium-boot → rootfs)
  - First boot & setup (Wi-Fi, Bluetooth pairing, language)
  - Known limitations & workarounds

- [ ] **Create troubleshooting guide:**
  - Boot loops: check extlinux.conf, DTB compatibility
  - No display: verify DRM driver, check /sys/class/drm/
  - Gamepad not working: check udev rules, test with evtest
  - eMMC errors: normal (ADMA bug); use microSD instead

---

## Hardware Considerations (from Profile)

### ✅ Proven in RGOS — Use Exactly As-Is
Everything below is proven working on hardware. This is a **standard phone** with these exact subsystems; no special handheld work needed.

- **Display (MIPI-DSI):** DRM/sprd driver, rotate-270° in Weston config (1 line change)
- **Touch (I2C Goodix):** IRQ/GPIO-mux fix (RGOS patch 0029 — already in place)
- **Wi-Fi/BT (SDIO):** sprdwcn + firmware (standard phone subsystem)
- **Audio (ASoC):** sc2730 codec + routing patches (same as other UNISOC phones)
- **Gamepad:** gpio-keys + Hall-effect ADC (optional enhancement; phone works with touch alone)
- **Battery/Charging:** sc27xx PMIC + fuel-gauge (standard phone power management)
- **USB-C:** musb gadget + sc27xx_pd for role handling (standard phone connector)
- **No modem:** Device has no cellular radio — simply don't load modem HAL in Halium

### ⚠️ Known Hardware Quirks (Manage Per RGOS)
These are SoC/device-specific issues, not phone-port issues. All workarounds proven in RGOS.

| Issue | Impact | Workaround |
|-------|--------|-----------|
| **eMMC ADMA fault** on 8-bit HS400ES writes | Corrupted eMMC writes (UNISOC T618 DMA bug) | Run rootfs from microSD (proven safe in RGOS) |
| **GPU**: Pixman (software) not Mali GL | Display OK via software; acceleration unavailable | Mali-G52 + Panfrost untested; not critical for phone |
| **Headset mic capture** | No audio recording (parked in RGOS) | Workaround: not critical for phone use (speaker output works) |
| **Suspend poweroff race** | Power doesn't off with USB connected | Known T618 VBUS detection bug; workaround: pull battery |

**None are blockers.** All can be addressed post-release. Phone core (display, touch, Wi-Fi, battery) is fully functional.

---

## Timeline & Resource Estimate

**Since this is standard phone porting (not special handheld work), the timeline is similar to porting any UNISOC phone to Ubuntu Touch.**

| Phase | Duration | Owner | Notes |
|-------|----------|-------|-------|
| 1: Setup | 1-2w | Device holder | Bootloader unlock, microSD test |
| 2: Device Tree | 2-3w | Port lead | Standard Halium device tree (modem HAL skipped) |
| 3: Kernel | 2-3w | Kernel hacker | Standard Halium config (no modem drivers) |
| 4: Build & Flash | 2-3w | Build engineer | Halium build, rootfs, microSD card |
| 5: Phone Integration | 2-3w | UI lead | **Gamepad mapping only** (display rotation = 1 line config); audio/touch/storage standard |
| 6: Testing | 2-3w | QA + port lead | Subsystem validation, soak test |
| 7: Publication | 1-2w | Port lead | UBports submission, documentation |
| **Total** | **12-17 weeks** | Team of 1-2 | ~3-4 months for first release (faster than general handheld port) |

**Simplification:** No special "handheld" UI work needed. Gamepad is optional (phone works fine with touch). Lifecycle is standard phone porting.

---

## Resources & References

**Essential:**
- UBports porting guide: https://docs.ubports.com/en/latest/porting/introduction.html
- This guide: Chapters 1-6 (firmware → kernel → rootfs), 16-18 (triage, testing), 8 (case studies)
- RGOS port: https://github.com/rgos-yocto (Linux kernel + DT + build system)
- GammaOS: https://github.com/TheGammaSqueeze/GammaOS (Android kernel + device tree reference)
- Halium 12+ manifest: https://github.com/halium/manifest

**Tools:**
- `adb`, `fastboot`, `spd_dump` (UNISOC flashing)
- `unisoc-unlock` (bootloader unlock)
- `git`, `repo` (Android source control)
- `pmbootstrap` or Halium build system (kernel/rootfs compilation)

**Community:**
- UBports Telegram/Matrix: https://ubports.com/community
- Anbernic community: https://www.anbernic.com/ (forums, firmware updates)
- retrohandheldguides.com (RG405M setup guides)

---

## Next Step

**Immediately:**
1. Read [UBports porting guide](https://docs.ubports.com/en/latest/porting/introduction.html) (2-3 hours)
2. Clone RGOS `meta-anbernic` and review kernel + device tree (4-6 hours)
3. Gather GammaOS source for reference (2 hours)
4. Set up build machine with dependencies (2-3 hours)

**Then start Phase 1** (bootloader verification + microSD test).

---

**Document Version:** 1.0  
**Last Updated:** Oct 9, 2026  
**Maintainer:** [Port Team]  
**Status:** Planning phase — ready to begin Phase 1 on signal
