# Ubuntu Touch / Lomiri Port Plan: Anbernic RG405M

## Target & strategy

**Deliverable: Ubuntu Touch (Lomiri) on the RG405M**, via **Halium 5.1A**
(native kernel + a minimal Android HAL container). We are *not* shipping the
native Ubuntu or Yocto builds — those are **reference sources**. Three references
feed the port:

| Reference | What it provides |
|---|---|
| **OEM Android — stock Anbernic V1.15** (`Firmware.pac`) | The Halium side: Mali GPU HAL + blob, `hwcomposer`, vendor firmware (wcn/gnss/dsp), RF/audio config, stock DT, dynamic-super/AVB layout. See [ubuntu-build/proprietary-files.txt](ubuntu-build/proprietary-files.txt) and [ubuntu-build/stock-boot-analysis.md](ubuntu-build/stock-boot-analysis.md). |
| **Ubuntu / mainline build** (`beebono/rg-rotate-linux`) | Kernel + DT + bootchain + rootfs packaging, and the proven **SD-boot** path. See [ubuntu-build/BUILD.md](ubuntu-build/BUILD.md) / [FLASH.md](ubuntu-build/FLASH.md). |
| **Yocto / RGOS** (`rgos-yocto` `meta-anbernic`) | Proven **native open drivers** (display, touch, audio, Wi-Fi/BT, power, gamepad) + the ~40 kernel patches. See [profile.md](profile.md). |

**Device:** UNISOC T618 (ums512), 4 GB RAM, 128 GB eMMC, 4" 640×480 IPS
(rotate-270), touch + gamepad, **no cellular modem**, Wi-Fi only.

### The key insight: this is a *low-shim* Halium port

RGOS already proves every subsystem except the GPU runs on open native drivers.
So instead of shimming the whole HAL stack through libhybris (the usual Halium
phone port), we run **native drivers for everything except the GPU**, and use the
Android container only for graphics:

| Subsystem | Path | Source |
|---|---|---|
| Display / KMS | **Native** `sprd-drm` | RGOS |
| Touch + gamepad | **Native** `goodix` + `rocknix-singleadc-joypad` | RGOS (DT already wired) |
| Audio | **Native** `sc2730`/VBC ASoC | RGOS |
| Wi-Fi / BT | **Native** `sprdwcn` + stock firmware | RGOS + OEM firmware |
| Power / charging | **Native** `sc27xx` | RGOS |
| **GPU (Mali-G52)** | **OEM Mali Android GL HAL via libhybris + hwcomposer** | OEM Android |
| Modem / camera | N/A (not fitted / not needed) | — |

### GPU decision: Mali Android HAL (primary), Panfrost (migration)

**Primary = the OEM Mali-G52 GL HAL through libhybris + hwcomposer.** This is
Lomiri/Mir's canonical phone graphics path, gives full hardware **GLES 3.2 +
Vulkan** from the vendor DDK, and all the pieces are already in hand (the OEM
Mali blob is hashed; `mali_kbase` ships in the OEM Android kernel). The DT's
`gpu@60000000` node switches to the `mali_kbase` binding for this path.

**Alternative / long-term = mainline + Mesa Panfrost + Mir `gbm-kms`** (the
PinePhone-style, **zero Android container** path). Cleaner end-state, no blob —
but Panfrost on Bifrost/G52 trails the DDK and is **unproven on this device**
(RGOS only reached software/pixman rendering). Keep as the open-stack migration
once Panfrost is validated on the G52; do not block first boot on it.

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
- [ ] **Halium container configs — already present in the stock kernel**, carry
      them: `ANDROID_BINDER_IPC`, `ANDROID_BINDERFS`, `ASHMEM`, `ION`,
      `DMABUF_HEAPS`, `MEMFD_CREATE`, `STAGING` (all `=y` in stock —
      [stock-boot-analysis.md](ubuntu-build/stock-boot-analysis.md)). Add
      `SW_SYNC` if a HAL needs legacy sync.
- [ ] **systemd / glibc userspace configs — MISSING in stock, must add:**
      `CONFIG_SYSVIPC`, `DEVTMPFS` (+`_MOUNT`), `FHANDLE`, `TMPFS_POSIX_ACL`,
      `TMPFS_XATTR`, `AUTOFS_FS`.
- [ ] **GPU DT/driver:** switch `gpu@60000000` to the `mali_kbase` binding and
      build the matching Arm `mali_kbase` (Bifrost) GPL module from the OEM
      Android kernel source (keep `DRM_SPRD` for the display controller). (For the
      Panfrost alternative instead: `CONFIG_DRM_PANFROST=y`, leave the DT on the
      panfrost binding.)
- [ ] Validate with the pmbootstrap/Halium kconfig checker (§4.6).

## Phase 2 — Halium HAL: GPU only (1–2 wks)

Because only graphics is shimmed, the HAL surface is tiny.

- [ ] **Extract the OEM GPU HAL set** from the stock `vendor` partition (carve
      recipe in [proprietary-files.txt](ubuntu-build/proprietary-files.txt)):
      `libGLES_mali.so` (+ egl/vulkan sonames), `hwcomposer`/`gralloc` for
      ums512, `libsync`, and their `vndk`/`vendor` lib deps.
- [ ] **libhybris** built against the bionic linker to load those blobs on glibc.
- [ ] **A minimal `android-rootfs`/system image** (or a slimmed Halium overlay)
      holding just the GPU HAL + its property/init needs — no full Android ROM.
- [ ] Bring up `test_hwcomposer` / `test_glesv2` under libhybris before Lomiri.

## Phase 3 — Device repo & rootfs (1–2 wks)

- [ ] Halium/UBports device tree `device/anbernic/rg405m` — but minimal: it only
      wires the GPU HAL + the Ubuntu Touch rootfs; everything else is the native
      kernel. Reuse the stock DT's reserved-memory/ion carveouts
      ([stock-boot-analysis.md](ubuntu-build/stock-boot-analysis.md)).
- [ ] `proprietary-files.txt` (Halium format) = the GPU HAL subset only (paths
      in [ubuntu-build/proprietary-files.txt](ubuntu-build/proprietary-files.txt)).
- [ ] Assemble the UT rootfs (UBports `rootfs` + the device overlay) onto an SD
      image laid out like RGOS's (GPT `uboot` + boot + root), so the existing SPL
      boots it. Wi-Fi/BT firmware + RF config + audio params from the OEM vendor
      (hashes in the manifest) onto `/lib/firmware` + the right vendor paths.

## Phase 4 — Lomiri bring-up (2–3 wks)

- [ ] Mir on the **hwcomposer** platform (libhybris) → Lomiri greeter.
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
  Stock kernel confirmed Halium-config-ready. OEM vendor extracted + hashed.
  Gamepad DT already wired. See [profile.md](profile.md), [re-notes.md](re-notes.md),
  and the [ubuntu-build/](ubuntu-build/) analysis docs.

## Realistic effort

The generic "15–21 week full Halium phone port" estimate does **not** apply here:
the kernel drivers are done (RGOS), the container configs are already in the
stock kernel, and only the GPU is shimmed. The gating work is Phase 1 (one kernel
with merged configs) + Phase 2 (GPU HAL under libhybris) + Phase 4 (Lomiri on
hwcomposer). Modem, camera, and most HAL bring-up — the usual time sinks — are
not in scope.
