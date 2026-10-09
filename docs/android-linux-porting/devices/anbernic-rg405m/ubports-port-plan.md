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

## Phase 1 — Kernel: pick the mainline tree (Panfrost build already done) (0–2 wks)

**Two candidate kernels — pick the mainline one for the native-GPU goal:**

| Tree | Pros | Cons |
|---|---|---|
| **mainline 7.1 `rg-rotate` (the "Ubuntu build" base)** | **already built** with `DRM_PANFROST=y`, `DRM_SPRD`, the `arm,mali-bifrost` GPU DT node, and all systemd configs — Panfrost works here | sprd Wi-Fi (`sprdwcn`) + sc2730 audio are vendor-only and may not be mainlined — verify/port |
| RGOS vendor `linux-unisoc-t618` | audio/Wi-Fi/power proven (vendor drivers + ~40 patches) | too old for Panfrost (uses `mali_kbase`) |

**Chosen base = the mainline 7.1 tree** (native GPU needs a modern kernel). Status
and remaining work:

- [x] **GPU + userspace config — DONE:** `CONFIG_DRM_PANFROST=y` (built-in),
      `DRM_SPRD`, GEM_SHMEM/SCHED/IOMMU, and all systemd configs (`SYSVIPC`,
      `DEVTMPFS`, `FHANDLE`, `TMPFS_XATTR`, `AUTOFS_FS`) are set; `Image` (Sep 11)
      + `ums512-rg405m.dtb` built; GPU DT node `arm,mali-bifrost` so Panfrost binds.
- [ ] **Driver-coverage gate (on-device, §Phase 2/first-boot):** confirm Wi-Fi
      (`sprdwcn`) and audio (`sc2730` ASoC) actually work on mainline 7.1. If a
      subsystem is missing, **port the vendor driver from the RGOS tree into the
      7.1 tree** — this is the real remaining kernel work, not Panfrost.
- [ ] Deploy the Sep-11 Panfrost `Image`+`dtb` onto the test card
      ([ubuntu-build/FIRST-BOOT-AND-GPU-CHECK.md](ubuntu-build/FIRST-BOOT-AND-GPU-CHECK.md) §1b).

Config notes (reference — mostly already satisfied on the 7.1 tree):
- No Android-container configs (no Halium): `ANDROID_BINDER*`/`ASHMEM`/`STAGING`
  not needed; keep `DMABUF_HEAPS`/`ION`/`MEMFD_CREATE` for buffer sharing.
- systemd/glibc configs (`SYSVIPC`, `DEVTMPFS`(+`_MOUNT`), `FHANDLE`,
  `TMPFS_POSIX_ACL/XATTR`, `AUTOFS_FS`): the **stock Android** kernel lacked these
  (see [stock-boot-analysis.md](ubuntu-build/stock-boot-analysis.md)); the
  **mainline 7.1 tree already has them set** — nothing to do.
- GPU: `CONFIG_DRM_PANFROST=y` + the `arm,mali-bifrost` DT node — done. Our
  RE'd/custom Mali driver is the fallback only if Panfrost GL is insufficient.
- If vendor drivers are backported from RGOS, re-check with `pmbootstrap`'s
  `kconfig_check` (mainline profile).

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
  **Mainline 7.1 port kernel already built with `DRM_PANFROST=y` + the
  `arm,mali-bifrost` GPU DT node + all systemd configs** (`Image` Sep 11). OEM
  vendor extracted + hashed.
  Gamepad DT already wired. See [profile.md](profile.md), [re-notes.md](re-notes.md),
  and the [ubuntu-build/](ubuntu-build/) analysis docs.

## Realistic effort

The generic "15–21 week full Halium phone port" estimate does **not** apply here:
there is no Halium, no HAL bring-up, and the non-GPU drivers are done (RGOS). The
gating work is Phase 1 (one native kernel with the systemd configs merged) +
Phase 2 (native GPU — Panfrost or our own driver) + Phase 4 (Lomiri on Mir
`gbm-kms`). Modem, camera, and all HAL/libhybris work — the usual time sinks —
are not in scope at all.
