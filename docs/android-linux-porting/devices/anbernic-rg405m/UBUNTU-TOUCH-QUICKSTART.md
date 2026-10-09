# Ubuntu Touch on RG405M: Quick Start

**TL;DR:** Build **Ubuntu Touch / Lomiri** on the RG405M as a **pure native port —
no Halium, no libhybris, no Android container.** Every subsystem runs an open
Linux driver: RGOS proves display/touch/audio/Wi-Fi/power/gamepad native, and the
**GPU is native too** (Mesa Panfrost, or our own reverse-engineered / custom
Mali-G52 driver). No modem, no camera HAL. Three builds are *references* — OEM
Android (stock V1.15), the Ubuntu/mainline build, and the Yocto/RGOS build — not
the product.

> This quick start was first written as a **generic from-scratch Halium phone
> port** (a sound ~15–21-week baseline). Device-specific findings since — a proven
> native driver set, our own GPU drivers (so no Android GL HAL is needed), the SPL
> already in place, and the OEM vendor already extracted — let us drop Halium
> entirely and refine the estimate down. The **refined method is below**; the
> **original baseline is preserved further down** for honest comparison. The
> baseline isn't wrong — it's what you'd assume before the legwork.

---

## 🎯 What You're Building

A **Linux handheld** running **Ubuntu Touch** with the **Lomiri** shell.

- **Hardware:** Anbernic RG405M (UNISOC T618, Wi-Fi only, no cellular)
- **Display:** 4" IPS 640×480, landscape (rotate-270°)
- **Input:** touch + gamepad (d-pad/ABXY/L/R + Hall sticks)
- **Approach:** **fully native** — native kernel + native drivers for everything,
  GPU included. No Halium/libhybris/hwcomposer anywhere.
- **Boot:** microSD (eMMC/Android/RGOS untouched; the SPL on eMMC already boots
  U-Boot from the SD `uboot` partition — **no SPL reflash**)

---

## 🧭 The three references (not the deliverable)

| Reference | Feeds |
|---|---|
| **OEM Android (stock V1.15 `Firmware.pac`)** | **RE reference** for the GPU (Mali DDK/`mali_kbase` behaviour) + runtime **firmware** (wcn/gnss/dsp), RF/audio config, stock DT, AVB/super layout |
| **Ubuntu / mainline (`rg-rotate-linux`)** | kernel + DT + bootchain + rootfs packaging + SD-boot |
| **Yocto / RGOS (`meta-anbernic`)** | proven native open drivers + ~40 patches (display/touch/audio/Wi-Fi/power/gamepad) |

Full detail: **[ubports-port-plan.md](ubports-port-plan.md)**.

---

## ✅ What's already done (why readiness is well past the baseline)

- ✅ Kernel + ~40 patches, device tree, **gamepad DT already wired** (RGOS)
- ✅ All non-GPU subsystems **proven on hardware** (RGOS)
- ✅ **Own GPU drivers RE'd** (+ a custom driver if Panfrost is insufficient) — no Android GL HAL needed
- ✅ Bootloader unlock + write + restore proven; **SPL already on eMMC** (flash SD only)
- ✅ **OEM vendor extracted + hashed** (firmware, RF/audio, Mali as RE reference) — [ubuntu-build/proprietary-files.txt](ubuntu-build/proprietary-files.txt)
- ✅ Stock boot/DT/kernel-config analysis done — [ubuntu-build/stock-boot-analysis.md](ubuntu-build/stock-boot-analysis.md)

**Remaining is essentially: one native kernel → native GPU (Panfrost or our
driver) → Lomiri on Mir `gbm-kms`.** Modem/camera/HAL/libhybris work is out of
scope entirely.

---

## 🚀 Refined method — what actually remains

1. **Kernel (1–2 wks):** RGOS tree + patches; **add** the missing systemd configs
   (`SYSVIPC`, `DEVTMPFS`(+`_MOUNT`), `FHANDLE`, `TMPFS_POSIX_ACL/XATTR`,
   `AUTOFS_FS`); **drop** the Android-container configs (binder/ashmem — not
   needed), keep `DMABUF_HEAPS`/`ION` for buffer sharing; GPU = `DRM_PANFROST`
   or our RE'd/custom Mali driver.
2. **GPU (1–3 wks):** try Mesa Panfrost on the G52 (`/dev/dri/renderD128`,
   `glmark2-es2`, `kmscube`); if GL coverage/perf is insufficient, finish our
   RE'd/custom Mali-G52 DRM driver + Mesa. Native either way — no libhybris.
3. **Rootfs (1–2 wks):** UT rootfs on an SD image laid out like RGOS (GPT
   `uboot`+boot+root) so the existing SPL boots it; firmware + RF/audio config
   onto `/lib/firmware`. No Halium overlay, no `proprietary-files.txt` HAL manifest.
4. **Lomiri (2–3 wks):** Mir on **`gbm-kms`** → greeter; rotate-270; touch +
   gamepad input; audio/Wi-Fi/BT/power on the native drivers.
5. **Validate & publish:** per-subsystem test (§18), soak, UBports wiki.

### GPU (decided): native, no Halium
Open stack only: **Mesa Panfrost + Mir `gbm-kms`**, or — if Panfrost's GL on this
Bifrost G52 is insufficient — **our own RE'd/custom Mali-G52 DRM driver** paired
with Mesa, using the OEM DDK purely as the register/ioctl RE reference. No Android
GL HAL, no `hwcomposer`, no `mali_kbase` at runtime.

### First-boot (when at the device)
`dd` the UT SD image to a **spare** microSD → power on (SPL already boots it).
Watch `/dev/ttyACM0`. If U-Boot hangs on USB, apply the `preboot=role`→`echo`
patch ([ubuntu-build/FLASH.md](ubuntu-build/FLASH.md)).

### Tooling
See the one-command setup in **[../../07-tools-reference.md](../../07-tools-reference.md) §7.0**.

---

## 📜 Original generic estimate (baseline — superseded by the refined plan above)

Preserved as first written, for comparison. This is the **generic** from-scratch
**Halium** phone-port assumption — correct as a starting estimate before the
device-specific legwork and the decision to RE our own GPU drivers.

**Readiness score (baseline): 16%** — "hardware done, full Halium adaptation
needed."

Generic 7-phase plan:
1. **Phase 1 (Setup):** Verify bootloader unlock + microSD boot (1–2 weeks)
2. **Phase 2 (Device Tree):** Adapt kernel to Halium format + HAL manifest (2–3 weeks)
3. **Phase 3 (Kernel):** Merge Halium configs, validate with checker (2–3 weeks)
4. **Phase 4 (Build):** Compile Halium ROM + Ubuntu rootfs (3–4 weeks)
5. **Phase 5 (UI):** Map gamepad to Lomiri, configure display (3–4 weeks)
6. **Phase 6 (Testing):** Validate each subsystem, soak test (2–3 weeks)
7. **Phase 7 (Publish):** Submit to UBports device wiki (1–2 weeks)

**Baseline total: ~15–21 weeks**, team of 2–3, assuming a **full Halium ROM**
build, bootloader bring-up from scratch, and HAL shims across all subsystems.

### Baseline vs refined — what changed and why

| Assumption (baseline) | Refined reality | Why |
|---|---|---|
| Full Halium ROM + HAL shims for all subsystems | **No Halium at all — fully native** | RGOS proves non-GPU subsystems native; GPU solved with our own drivers |
| GPU via Android Mali GL HAL + libhybris | **Native Mesa Panfrost / our RE'd driver + `gbm-kms`** | own GPU RE; no Android container needed |
| Bootloader/SPL bring-up from scratch | **SPL already on eMMC; flash SD only** | RGOS dual-boot already flashed the open SPL |
| Merge + discover Halium kernel configs | **Drop Android configs; add systemd configs** | no container → binder/ashmem unneeded; systemd gaps known from stock `.config` |
| Recover vendor blobs / DT via RE | **OEM vendor extracted + hashed; no Ghidra for drivers** | carved from the V1.15 `.pac`; BSP + config recovery sufficed |
| ~15–21 weeks, team of 2–3 | **Gated by kernel + native GPU + Lomiri only** | modem/camera/HAL/libhybris entirely out of scope |

The baseline wasn't wrong — it's the honest estimate for a device you know
nothing about yet. The refined plan is what doing the homework (and owning the
GPU drivers) buys you.

---

## 🎮 Core customizations: handheld without modem

| Aspect | Standard phone | RG405M | Work needed |
|---|---|---|---|
| Kernel/graphics | UT + kernel + Android HAL | **native kernel, native GPU** | no HAL at all |
| Display | portrait 1080×2400 | landscape 640×480, rotate-270° | rotate-270° config |
| Cellular modem | SIM/voice/SMS | absent | nothing (no modem HAL) |
| Input | touch | touch + gamepad (`js0`, DT-wired) | map gamepad → Lomiri navigation |
| Audio | mic (calls) | speaker + headset jack | mic capture can wait |

---

## ⚠️ Known limitations

| Issue | Impact | Status |
|---|---|---|
| **eMMC ADMA fault** | unrecoverable 8-bit HS400ES writes | Workaround: rootfs on microSD (proven) |
| **GPU GL maturity** | Panfrost on G52 unproven | Fallback: our RE'd/custom Mali driver |
| **Headset mic** | recording path | Parked; needs a capture trace |
| **Suspend poweroff** | stays on with USB VBUS present | Known race; minor |

None are first-release blockers.

---

## 🏁 Success criteria

**First working release:** boots to Lomiri from microSD; display 640×480
rotate-270; touch + gamepad respond; Wi-Fi connects; audio via speaker; battery %
correct; click packages install.
**Production:** all subsystems tested (§18); 8h+ soak; thermal under GPU load OK;
UBports wiki + install guide.

---

## 🔗 Key links & docs

- Refined plan: **[ubports-port-plan.md](ubports-port-plan.md)**
- Device data: [profile.md](profile.md) · [checklist.md](checklist.md) · [re-notes.md](re-notes.md)
- OEM/stock analysis: [ubuntu-build/](ubuntu-build/) (`proprietary-files.txt`, `stock-boot-analysis.md`, `BUILD.md`, `FLASH.md`)
- UBports porting guide: https://docs.ubports.com/en/latest/porting/introduction.html

---

**Document Version:** 3.0 (pure-native, no-Halium method; v1.0 generic Halium baseline preserved above)  
**Last Updated:** Oct 9, 2026
