# Ubuntu Touch / Lomiri Port Plan: Anbernic RG405M

## Target & strategy

**Deliverable: Ubuntu Touch (Lomiri) on the RG405M**, as a **pure native port —
no Halium, no libhybris, no Android container.** Every subsystem runs an open
Linux driver: RGOS proves native display, touch, audio, Wi-Fi/BT, power and
gamepad, and the **GPU is native too** — Mesa Panfrost, or our own
reverse-engineered / custom Mali-G52 kernel driver if Panfrost proves
insufficient. There is no modem and no camera HAL, so nothing requires an Android
HAL; Halium is explicitly **not used**. The OEM Mali blob is kept only as an
**RE reference** (DDK register/behaviour), never as a runtime component. We are
*not* shipping the native Ubuntu or Yocto builds — those are **reference
sources**. Three references feed the port:

| Reference | What it provides |
|---|---|
| **OEM Android — stock Anbernic V1.15** (`Firmware.pac`) | RE reference for the GPU (Mali DDK behaviour, kbase ABI) + runtime vendor firmware (wcn/gnss/dsp), RF/audio config, stock DT, dynamic-super/AVB layout. See [ubuntu-build/proprietary-files.txt](ubuntu-build/proprietary-files.txt) and [ubuntu-build/stock-boot-analysis.md](ubuntu-build/stock-boot-analysis.md). |
| **Ubuntu / mainline build** (`beebono/rg-rotate-linux`) | Kernel + DT + bootchain + rootfs packaging, and the proven **SD-boot** path. See [ubuntu-build/BUILD.md](ubuntu-build/BUILD.md) / [FLASH.md](ubuntu-build/FLASH.md). |
| **Yocto / RGOS** (`rgos-yocto` `meta-anbernic`) | Proven **native open drivers** (display, touch, audio, Wi-Fi/BT, power, gamepad) + the ~40 kernel patches. See [profile.md](profile.md). |

**Device:** UNISOC T618 (ums512), 4 GB RAM, 128 GB eMMC, 4" 640×480 IPS
(rotate-270), touch + gamepad, **no cellular modem**, Wi-Fi only.

### The key insight: fully native, zero Android container

RGOS already proves every subsystem except the GPU runs on open native drivers,
and the GPU is being solved natively too (own RE'd / custom driver + Mesa). So
this is a **pure native Ubuntu Touch port** — no Halium, no libhybris, no
hwcomposer anywhere:

| Subsystem | Path | Source |
|---|---|---|
| Display / KMS | **Native** `sprd-drm` | RGOS |
| Touch + gamepad | **Native** `goodix` + `rocknix-singleadc-joypad` | RGOS (DT already wired) |
| Audio | **Native** `sc2730`/VBC ASoC | RGOS |
| Wi-Fi / BT | **Native** `sprdwcn` + stock firmware | RGOS + OEM firmware |
| Power / charging | **Native** `sc27xx` | RGOS |
| **GPU (Mali-G52)** | **Native** — Mesa Panfrost, or our RE'd/custom Mali kernel driver + Mesa | own RE (OEM DDK as reference) |
| Modem / camera | N/A (not fitted / not needed) | — |

### GPU: native, no Halium

GPU stays open — the one subsystem that could have justified an Android container
is being handled with our own drivers instead:

- **Mesa Panfrost + Mir `gbm-kms`** (`CONFIG_DRM_PANFROST=y`, panfrost DT binding)
  — the default native stack. Validate GL coverage/perf on this Bifrost G52
  (unproven here — RGOS only reached software/pixman).
- **If Panfrost is insufficient → our own RE'd / custom Mali-G52 kernel driver**
  paired with Mesa, using the OEM DDK/`mali_kbase` purely as the RE reference for
  register/ioctl behaviour. Still native, still `gbm-kms`, still no libhybris.

No path uses Halium, hwcomposer, or the Android GL HAL at runtime.

### Boot: no SPL reflash needed

The eMMC already carries the open **`signed-open` SPL** (flashed during RGOS
dual-boot). It loads U-Boot from whatever SD GPT partition is named `uboot`,
else falls through to stock Android. So the UT image boots the same way RGOS
does — **flash the SD card only**, on a *separate* card, leaving eMMC/Android/RGOS
untouched. (See [ubuntu-build/FLASH.md](ubuntu-build/FLASH.md); skip its "flash
the SPL" step.) Watch for the `preboot=role` USB-gadget-wait gotcha (patch to
`echo` if U-Boot hangs).

---

## Phase 1 — Kernel (the real work): one kernel, three config sets (1–2 wks)

Start from the **RGOS `linux-unisoc-t618`** tree + its ~40 patches (not a fresh
RE — the drivers are done). Build **one** kernel that satisfies all three config
groups:

- [ ] **Base:** RGOS `meta-anbernic/recipes-kernel/linux` tree + patch series
      (touch IRQ/mux `0020`/`0029`, ASoC routing, charger, `singleadcjoy` `0002`,
      eMMC ADMA workarounds, `sprd-drm` vblank `0034`, etc.).
- [ ] **No Android-container configs needed** — since there's no Halium, the
      stock `ANDROID_BINDER_IPC`/`BINDERFS`/`ASHMEM`/`STAGING` can be dropped.
      Keep `DMABUF_HEAPS`/`ION` and `MEMFD_CREATE` for GPU/display buffer sharing.
- [ ] **systemd / glibc userspace configs — MISSING in stock, must add:**
      `CONFIG_SYSVIPC`, `DEVTMPFS` (+`_MOUNT`), `FHANDLE`, `TMPFS_POSIX_ACL`,
      `TMPFS_XATTR`, `AUTOFS_FS` ([stock-boot-analysis.md](ubuntu-build/stock-boot-analysis.md)).
- [ ] **GPU driver (native):** `CONFIG_DRM_PANFROST=y` + panfrost DT binding; or,
      if Panfrost is insufficient, build our RE'd/custom Mali-G52 DRM driver
      against this tree. Keep `DRM_SPRD` for the display controller. No `mali_kbase`
      / Android HAL.
- [ ] Validate with `pmbootstrap`'s `kconfig_check` (mainline/systemd profile — not
      the Halium profile; §4.6).

## Phase 2 — GPU bring-up (native) (1–3 wks)

- [ ] **Try Mesa Panfrost first** — boot the native rootfs, confirm
      `/dev/dri/renderD128`, run `glmark2-es2`/`kmscube` and a Mir `gbm-kms` smoke
      test on the G52. Good enough → done.
- [ ] **If Panfrost GL coverage/perf is insufficient — our own driver:** finish
      the RE'd/custom Mali-G52 DRM driver (OEM DDK/`mali_kbase` as the register/
      ioctl reference only), pair it with the Mesa Panfrost gallium driver (or a
      custom Mesa backend). Still `gbm-kms`, still no Android container.
- [ ] Confirm EGL/GLES under Mir before Lomiri.

## Phase 3 — Rootfs & image (1–2 wks)

- [ ] Assemble the Ubuntu Touch rootfs (UBports `rootfs` + a thin device
      overlay) — no Halium/`android-rootfs`, no `proprietary-files.txt` HAL
      manifest. Reuse the stock DT's reserved-memory/ion carveouts
      ([stock-boot-analysis.md](ubuntu-build/stock-boot-analysis.md)).
- [ ] Place the only runtime blobs — Wi-Fi/BT/GNSS **firmware** + RF config +
      audio params from the OEM vendor (hashes in
      [ubuntu-build/proprietary-files.txt](ubuntu-build/proprietary-files.txt)) —
      onto `/lib/firmware` and the matching paths.
- [ ] Lay the SD image out like RGOS's (GPT `uboot` + boot + root) so the SPL
      already on eMMC boots it.

## Phase 4 — Lomiri bring-up (2–3 wks)

- [ ] Mir on the **`gbm-kms`** platform (native Mesa) → Lomiri greeter.
- [ ] **Display:** confirm 640×480 **rotate-270** (Mir/Lomiri display config) —
      the one unavoidable device-specific tweak.
- [ ] **Input:** touch via native `goodix`; **gamepad** already a native `js0`
      (`retrogame_joypad`, DT-wired — buttons + Hall sticks). Map gamepad →
      Lomiri navigation (d-pad/A/B as cursor/select) and leave `js0` for games.
- [ ] Audio routing (PulseAudio/PipeWire on the native `sc2730` ASoC), Wi-Fi
      (NetworkManager + `sprdwcn`), BT (BlueZ), power/battery (`sc27xx`).

## Phase 5 — Validation & soak (2–3 wks)

- [ ] Walk the [checklist.md](checklist.md) + [profile.md](profile.md) §Status
      per subsystem, **tested not just probed** (§18). Stick calibration pass
      (DT `amux-channel-mapping` / per-axis fuzz — flagged in BUILD.md).
- [ ] Suspend/resume, charging while on, thermal under GPU load, reboot loops.
- [ ] Confirm the pull-the-card recovery still lands on stock Android.

## Phase 6 — Publish

- [ ] UBports device wiki + the device repo; feed any kernel fixes back to RGOS.

---

## What's already done (don't redo)

- Feasibility/unlock/write/restore proven; stock firmware in hand; SPL on eMMC;
  SD-boot working (RGOS). Native drivers for all non-GPU subsystems proven (RGOS).
  Stock kernel `.config` recovered + systemd config gaps identified. OEM vendor
  extracted + hashed.
  Gamepad DT already wired. See [profile.md](profile.md), [re-notes.md](re-notes.md),
  and the [ubuntu-build/](ubuntu-build/) analysis docs.

## Realistic effort

The generic "15–21 week full Halium phone port" estimate does **not** apply here:
there is no Halium, no HAL bring-up, and the non-GPU drivers are done (RGOS). The
gating work is Phase 1 (one native kernel with the systemd configs merged) +
Phase 2 (native GPU — Panfrost or our own driver) + Phase 4 (Lomiri on Mir
`gbm-kms`). Modem, camera, and all HAL/libhybris work — the usual time sinks —
are not in scope at all.
