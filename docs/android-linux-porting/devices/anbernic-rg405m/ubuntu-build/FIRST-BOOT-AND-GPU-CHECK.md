# RG405M — first-boot + GPU-gate command sheet

Paste-ready steps for when the device is in hand. Goal: prove the **boot chain**
(the eMMC SPL loads U-Boot from the SD) and resolve the **GPU gate** (native
Panfrost vs. our own Mali driver) — **before** building the Ubuntu Touch rootfs.

> The UT/Lomiri image is **not built yet**. For this validation, flash the
> already-built **plain Ubuntu reference image** (`rg405m-ubuntu-sdcard.img`) — a
> full Ubuntu userspace is ideal for probing DRM/Mesa/Panfrost. Use a **spare**
> microSD; the RGOS card and eMMC/Android stay untouched. No SPL reflash (the
> open SPL is already on eMMC and boots U-Boot from the SD `uboot` partition).

## 0. Pre-flight (on the flashing host)

```sh
# identify the SD reader FIRST — do not guess sdX
lsblk -o NAME,SIZE,TYPE,TRAN,MODEL
# image is on vivo: /mnt/data/shared/Projects/RG405M/rg405m-ubuntu-port/rg405m-ubuntu-sdcard.img
# copy it over if needed, then verify it's the expected build before writing
```

## 1. Flash the SD (⚠️ triple-check the device node)

```sh
sudo dd if=rg405m-ubuntu-sdcard.img of=/dev/sdX bs=4M conv=fsync status=progress
sync
```

## 2. First boot + serial console

1. Power the RG405M **fully off**; insert the freshly-written card.
2. On the host: `screen /dev/ttyACM0 115200`  (USB-C enumerates a CDC-ACM console;
   this board has no broken-out UART). `sudo` or add yourself to `dialout` if
   `/dev/ttyACM0` is permission-denied.
3. Power on. Watch for: SPL → U-Boot banner → `extlinux` → kernel log → login.
   The image autologins root on the console.

**If U-Boot hangs (no kernel, stuck after the U-Boot banner):** that's the
`preboot=role` USB-gadget-wait gotcha. Patch the SD U-Boot in place (see
[FLASH.md](FLASH.md)) — `preboot=role` → `preboot=echo` in the DHTB image on the
SD `uboot` partition — and rebuild the DHTB SHA. Then re-boot.

**If "No OS found" / U-Boot can't read the card:** the image's U-Boot can't read
its own layout. Quickest fix: copy RGOS's known-good `uboot` partition contents
onto this card's `uboot` partition (same open SPL loads either).

## 3. Smoke-test the base (should all work from the reference image)

```sh
dmesg | grep -iE "panic|fail|error" | head         # triage boot errors
cat /proc/cmdline                                   # confirm root=, console
# display
ls -l /dev/dri/                                     # expect card0 (sprd-drm) + renderD128
dmesg | grep -iE "sprd.?drm|dpu|dsi|panel"          # panel/KMS brought up
# input — gamepad should be a native js0
ls /dev/input/js*  /dev/input/event*
cat /proc/bus/input/devices | grep -iA3 "retrogame\|joypad\|goodix"
# wifi
nmcli dev ; nmcli dev wifi list | head             # sprdwcn up?
# audio
aplay -l                                            # sc2730 card present?
```

## 4. GPU gate — the decision point

```sh
# Is a native GPU render node + Panfrost present in THIS kernel?
ls -l /dev/dri/renderD128
lsmod | grep -i panfrost
dmesg | grep -iE "panfrost|mali|gpu"
# Mesa's view of the GPU:
sudo apt update && sudo apt install -y mesa-utils kmscube glmark2-es2 2>/dev/null || true
eglinfo 2>/dev/null | grep -iE "renderer|vendor|panfrost|mali" | head
# render tests (run from the console/VT, no X needed):
kmscube                        # draws a spinning cube via GBM/KMS
glmark2-es2 --off-screen       # GLES2 score; note fps
```

**Read the result:**

- **`renderD128` + `panfrost` loaded + `kmscube`/`glmark2-es2` render** → Panfrost
  works on this G52. **Decision: native Panfrost; done — no custom driver needed.**
  Record the `glmark2-es2` score + `eglinfo` renderer string.
- **No `renderD128` / no `panfrost` module** → this reference kernel wasn't built
  with Panfrost (expected — stock/RGOS didn't enable it). **Not a failure of the
  GPU** — it means we proceed to Phase 1: rebuild the kernel with
  `CONFIG_DRM_PANFROST=y` + the panfrost DT binding, reflash the SD, re-run §4.
- **`panfrost` loads but GL is broken/too slow/incomplete** (glmark2 errors,
  missing GLES3.x) → that's the trigger for **our own RE'd/custom Mali-G52
  driver** (OEM `mali_kbase`/DDK as the register/ioctl RE reference; see
  [../re-notes.md](../re-notes.md) GPU section).

## 5. Report back (paste these)

- `/dev/ttyACM0` boot log from SPL to login (or where it stopped).
- `ls -l /dev/dri/`, `lsmod | grep panfrost`, `dmesg | grep -i panfrost`.
- `eglinfo` renderer/vendor line + `glmark2-es2 --off-screen` score (if it ran).
- `js0` present? gamepad buttons/sticks seen in `evtest`?
- Wi-Fi associate + `aplay -l` output.

## Recovery (always available)

Pull the card → stock Android boots from eMMC. RGOS card → RGOS. eMMC/`splloader`
untouched by any of the above.
