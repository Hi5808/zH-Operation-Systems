# Device Profile: Anbernic RG405M (codename: rg405m)

Filled in from [10-device-profile-template.md](../../10-device-profile-template.md).
Not a phone — a handheld gaming device — so the hardware table below
swaps modem/camera for gamepad-specific I/O, but the SoC-level porting
methodology (§1-§9 of the guide) is identical.

**This device has a hardware-proven native Linux port: RGOS
(`rgos-yocto`, same GitHub account), a Yocto Scarthgap OS covered as a
case study in §8.** Most fields below are therefore confirmed from a
running device rather than public specs. Where a field is still unproven
it's marked **TBD**.

## Identity
- Manufacturer / model / codename: Anbernic / RG405M / **`rg405m`**
  (confirmed: the RGOS BSP uses `MACHINE=rg405m` and `ums512-rg405m.dtb`)
- Form factor: handheld gaming console (clamshell-free, horizontal grip,
  4" IPS touchscreen, physical d-pad/buttons/analog sticks)
- Release year: March 2023
- Android version(s) shipped: Android 12
- SoC platform name: **`ums512`** (UNISOC's internal name for the T618),
  confirmed by the RGOS port's DT and machine config (`MACHINE=rg405m`,
  `ums512-rg405m.dtb`)
- Bootloader unlock method: **confirmed, documented, and working** —
  but it is a UNISOC-specific procedure, not standard AOSP
  `fastboot oem unlock`/`fastboot flashing unlock` (and the GammaOS
  Next install docs explicitly note the standard command is absent from
  this flow — no "OEM unlocking" Developer-Options toggle is involved
  either). The confirmed procedure, per GammaOS Next's own install wiki:
  1. Enable USB debugging (Developer Options).
  2. `adb reboot bootloader`, then `fastboot reboot fastboot` to enter
     UNISOC's fastbootd-like mode.
  3. Unlock via either a hosted browser tool
     (`thegammasqueeze.github.io/subut-rehost/` — Connect, select the
     device, click Unlock) or the `unisoc-unlock` Python package
     (`pip3 install unisoc-unlock && python3 -m unisoc_unlock`).
  4. Confirm on-device via the **Home/Back button** — explicitly *not*
     Volume Down (the guide calls this out directly, implying it's a
     common mistake).
  The device reports its own native lock state at boot as a message
  "LOCK FLAG IS : UNLOCK!!!" once unlocked — this is UNISOC's own
  concept, distinct from the Android-level toggle most of this guide's
  other vendor chapters assume. This confirms §9.4's general claim that
  UNISOC doesn't use the standard Android unlock flow, while also
  confirming a *working*, documented alternative exists for this exact
  chip/device family — see §9.4 (updated) for the general pattern.
  Whether this unlock is sufficient for full partition read/write (vs.
  GammaOS's own flasher doing something more specific) is still worth
  confirming directly, but a full custom-ROM install via this exact path
  is a strong existence proof that write access is achievable here.
- SoC vendor: **UNISOC (Spreadtrum)** — see
  [09-soc-vendor-specifics.md](../../09-soc-vendor-specifics.md) §9.4.
  UNISOC is the guide's "minimal community tooling" vendor case *in
  general*, but this specific device is a strong exception: between
  GammaOS (Android) and RGOS (native Yocto), the driver set is already
  worked out on a downstream kernel — the open work is mainlining, not
  bring-up from zero.
- Exact SoC model: **UNISOC Tiger T618**, octa-core
  (2× Cortex-A75 @ 2.0 GHz + 6× Cortex-A55 @ 2.0 GHz), **Mali-G52 GPU**
  @ 850 MHz
- RAM / storage type: 4 GB LPDDR4X / 128 GB **eMMC** + microSD slot

## Existing prior art (check before any RE work)

Unlike the guide's general UNISOC warning, this specific chip family
already has real community traction worth forking from instead of
starting from Ghidra RE:

- **RGOS (`rgos-yocto`, this GitHub account)** — a working native
  Yocto Linux port of *this exact device*. Its `meta-anbernic` BSP layer
  (downstream `linux-unisoc-t618` kernel + ~40 patches), `kas/rg405m.yml`
  build config, flashing scripts, and `docs/` bring-up logs are the
  single best reference for this port — most of §3-§6 above is derived
  from it. Start here.
- **GammaOS** (`github.com/TheGammaSqueeze/GammaOS`) — a LineageOS 19.1
  (Android 12) based ROM for Anbernic's UNISOC T618 handheld line. The
  Android-side reference (and source of the confirmed unlock flow);
  useful for the stock driver set to diff against.
- `github.com/dag7dev/awesome-anbernic` — community link index for
  Anbernic devices generally; useful for finding further prior art
  (firmware dumps, partition layouts, unlock notes) as the community
  around this device evolves.

Since GammaOS is Android-based (not a mainline Linux/postmarketOS-style
port), it doesn't eliminate the work this guide describes — but it is a
massive head start for §4 (kernel source) and §1 (knowing the exact
partition layout/DT), so the realistic plan for this device is "start
from GammaOS's kernel+DT, then do the mainline-Linux/Halium work this
guide describes on top of it" rather than reconstructing the kernel from
a stock-firmware binary dump.

## §1 Firmware acquired

The important point for this device: a working native port (**RGOS**,
`rgos-yocto`) already exists, so the kernel source, device tree and
driver set don't need to be recovered from a stock dump at all — they're
in the RGOS `meta-anbernic` BSP. The rows below distinguish "needed for a
fresh RE effort" from "already solved in the BSP."

- [x] **Stock firmware package — in hand**: the official **Anbernic V1.15
      Unbricker** (`Firmware/Firmware.pac`, 6.33 GB) plus a V1.19 per-slot
      partition dump. The `vendor` EROFS has been carved out and the exact
      vendor file hashes recorded — see
      [ubuntu-build/proprietary-files.txt](ubuntu-build/proprietary-files.txt).
- [x] **Kernel source + device tree — already in the RGOS BSP**:
      `meta-anbernic/recipes-kernel/linux/` builds `linux-unisoc-t618`
      (a vendor 7.1 `sprd` tree) plus ~40 patches; the DT source is
      `ums512-rg405m`. Start here, not from a decompiled `.dtb` (§4.1).
- [ ] GammaOS source/kernel tree — the Android-side reference to diff
      against; release targeting this chip family:
      `github.com/TheGammaSqueeze/GammaOSNext` (confirm the RG405M build
      vs. a sibling before relying on it).
- [ ] Direct device dump (adb/root) — only if you need the stock
      `vendor`/firmware blobs for a subsystem the BSP leaves out.
- [ ] Full download-mode dump (UNISOC `spd_dump`/FDL) — the flash path,
      not a prerequisite for the source (§6, §9.4).
- [x] **Driver inventory — derivable from the BSP patch series**
      (touch, `singleadcjoy`, `sc2730` ASoC, `sprdwcn`, `sc27xx` power,
      the eMMC ADMA fix) rather than from RE; see §3 and §8.

## §2 Reverse engineering notes
See [re-notes.md](re-notes.md) in this folder. Given the GammaOS prior
art above, expect RE work here to be mostly *diffing* GammaOS's drivers
against stock firmware rather than reconstructing from zero — see
[02-reverse-engineering-ghidra.md](../../02-reverse-engineering-ghidra.md)
§2.4's BinDiff workflow.

## §3 Hardware inventory

**Most rows below are now hardware-proven by the RGOS native Yocto port
(`rgos-yocto`, see §8).** Where RGOS has a subsystem working on a
downstream `linux-unisoc-t618` kernel, that's marked "Proven (RGOS)".
These are facts from a running device, not guesses — but note RGOS runs
a *downstream* vendor kernel, so "works in RGOS" means the driver exists
and runs, not that it's mainlined.

| Subsystem | Chip / driver | Bus | Status | Decision |
|---|---|---|---|---|
| Display panel | 4" IPS 640×480, DRM via `sprd` DRM driver; Weston on `card1`, rotate-270 | MIPI-DSI | Proven (RGOS) | Native (downstream `drm/sprd`) |
| Touchscreen | **Goodix**; touch matrix `0 -1 1 1 0 0` (90° CW) | I2C | Proven (RGOS); needed an IRQ/GPIO-mux fix (RGOS patch 0029) | Native (`goodix`) |
| GPU | **Mali-G52** (Bifrost) | — | RGOS ships Weston on **pixman (software)**, not Mali GL — so open-GL-on-Mali is *not* yet proven here | Panfrost is the target; verify for this G52 revision. Software rendering is a working fallback |
| Audio | **`sprdphone-sc2730`** codec (ASoC); speakers + headset-jack playback | — | Proven (RGOS); needed several ASoC routing patches. Headset **boom-mic capture** still parked | Native (downstream `sprd` ASoC) |
| Cellular modem | **None** — no SIM/cellular radio | — | N/A | N/A |
| Wi-Fi/BT | UNISOC WCN (`sprdwcn`), SDIO; dual-band 802.11ac + BT 5.0 incl. A2DP | SDIO | Proven (RGOS, NetworkManager + BlueZ/bluealsa) | Native (downstream `sprdwcn`) |
| Gamepad: d-pad/ABXY/L/R | `gpio-keys` + `retrogame_joypad` (`js0`) | GPIO | Proven (RGOS) | Native |
| Gamepad: analog sticks | **Hall-effect**; `singleadcjoy` ADC driver (RGOS patch 0002) | ADC | Proven (RGOS) | Native (downstream `singleadcjoy`) |
| Sensors | None exposed in RGOS bring-up (handheld omits accel/gyro) | — | — | — |
| Battery/charging | `sc27xx` PMIC/fuel-gauge + AW32257/bq2415x charger; TCPM via `sc27xx_pd` | — | Proven (RGOS); several charger patches (autotimer, Rp default 500 mA) | Native (downstream `sc27xx`) |
| Vibrator | present (`event0`) | — | Proven (RGOS) | Native |
| USB-C | `musb` gadget (ACM + RNDIS); Type-C `sc27xx_pd` | — | Proven (RGOS); host/gadget role handling noted as fiddly | Native |
| eMMC/storage | Samsung eMMC (manfid 0x15), HS400ES | — | **Known bug**: `sdhci-sprd` ADMA faults on 8-bit HS400ES writes — see §8 and RGOS `docs/EMMC-ADMA-ERROR.md`. RGOS works around it by running rootfs from microSD | Native, with the ADMA caveat |

## §4 Kernel
- Kernel base: **`linux-unisoc-t618` downstream vendor tree (~4.14)**, as
  used by the proven RGOS port (§8). This is a different, more complete
  starting point than GammaOS's Android tree for a *native Linux* goal —
  RGOS carries it forward with ~40 focused patches (touch IRQ, ASoC
  routing, charger, joystick ADC, the eMMC ADMA fix, etc.), the pattern
  §4.4 describes as "adapt, don't reimplement."
- Known kernel gaps to inherit awareness of (from RGOS bring-up):
  `CONFIG_LOGO` off (no boot penguin); no `ip_tables` module (Tailscale/
  iptables health check fails, nftables present); Wi-Fi multicast filter
  warning at associate (log noise).
- The eMMC ADMA bug (§3 table, §8) is the single most important kernel
  issue on this SoC — read RGOS `docs/EMMC-ADMA-ERROR.md` before trusting
  eMMC writes.
- **One kernel, shared.** Both the Ubuntu build and the RGOS Yocto build run the
  **same `linux-7-1-sprd` tree = mainline Linux 7.1.0-rc1 + sprd/ums512 patches**
  (`Linux version 7.1.0-rc1-sprd-ums512`; upstream `github.com/beebono/linux-mainline-sprd`).
  It has `DRM_PANFROST=y` + the `arm,mali-bifrost` GPU node + `DRM_SPRD` + all
  systemd configs, and RGOS proves display/touch/audio(`sc2730`)/Wi-Fi(`sprdwcn`)/
  power(`sc27xx`)/gamepad all work on it — so there is no vendor-driver backport
  to do. (The earlier "~4.14 vendor tree" note was wrong.)
- **DONE:** rebuilt on the **latest mainline 7.2.9** (`Linux 7.2.9-sprd-ums512`, Image+DTB) — forward-ported
  the rg405m/sprd delta from 7.1-rc1 — per the user's "latest mainline" direction.
- **Config gap-check (from the recovered stock V1.15 `.config`,
  [ubuntu-build/stock-boot-analysis.md](ubuntu-build/stock-boot-analysis.md)):**
  the stock kernel is already Halium-ready (`ANDROID_BINDER_IPC`/`BINDERFS`,
  `ASHMEM`, `ION`, `DMABUF_HEAPS`, `MEMFD` all `=y`), but for a glibc+systemd
  userspace (Ubuntu Touch/pmOS/Debian) it is **missing** `CONFIG_SYSVIPC`,
  `DEVTMPFS`(+`_MOUNT`), `FHANDLE`, `TMPFS_POSIX_ACL`, `TMPFS_XATTR`,
  `AUTOFS_FS` — enable these. GPU: stock is `DRM_SPRD=m` with **no Panfrost**
  (Android uses `mali_kbase`); the open port must add `CONFIG_DRM_PANFROST`.

## §5 Userspace strategy
- Overall approach: **fully native (no Halium container)** — proven by
  RGOS: OpenEmbedded/Yocto Scarthgap userspace, Weston 13 on DRM,
  NetworkManager, BlueZ + bluealsa, PipeWire/ALSA on the `sc2730` codec.
  GPU is the one open question: RGOS renders with pixman (software), not
  Mali GL, so a Panfrost-accelerated stack is still unproven here.
- Rootfs base: RGOS chose **Yocto**; **postmarketOS** remains a reasonable
  alternative, but there is still no upstream pmaports T618 port, so
  either path is new-device work. RGOS is the existence proof that a
  native userspace runs on this hardware.

## Bridge baseline

Verified from the RGOS port (§5.1 four-way bridge). **This device is the
guide's all-native reference: no Halium container, no HAL-shim anywhere**
— every subsystem is a real Linux driver, with only ordinary firmware
blobs. That is the closed-gap ideal §5.1 describes.

| Subsystem | Bridge | Notes |
|---|---|---|
| Display | Native | downstream `drm/sprd`, Weston on DRM |
| Touch / input | Native | `goodix`; `retrogame_joypad` + `singleadcjoy` for Hall sticks |
| GPU | Native (software) + Firmware-blob (future) | Weston on pixman today; Mali-G52 via Panfrost is the open path, not yet proven |
| Audio | Native | `sprdphone-sc2730` ASoC; mic capture still parked |
| Wi-Fi / BT | Native + Firmware-blob | `sprdwcn` driver + vendor Wi-Fi/BT firmware |
| Modem | N/A | no cellular radio on this device |
| Sensors | N/A | none fitted/exposed |
| Power / charging | Native | `sc27xx` fuel-gauge + charger |

No `proprietary-blobs.txt`/HAL container exists for this port because
nothing needs one — the contrast case to a phone that must shim
GPU/modem/camera.

## §6 Boot chain
- Boot chain stages: `BootROM → eMMC SPL (ums512_spl) → U-Boot → extlinux
  → kernel` (proven by RGOS; standard UNISOC chain, §9.4).
- **Flashing: UNISOC BootROM download mode via `spd_dump` + FDL.** Enter
  with the device OFF: hold **POWER + VOL-DOWN + BACK**, plug USB, at the
  "Waiting for dl_diag" prompt. **Write one large partition per FDL
  session** (chaining multiple writes in one session is unreliable — a
  hard-won RGOS rule).
- **Partition naming gotcha**: the slot-A kernel/boot partition is named
  **`w_force`**, not `boot_a`. `uboot_a`/`uboot_b` hold U-Boot;
  `userdata` holds the rootfs. Don't assume AOSP names.
- **Unlock**: `patrislav1/unisoc-unlock` (the confirmed UNISOC path, §9.4),
  not AOSP `fastboot`.
- **Safest development pattern (proven by RGOS): dual-boot from microSD.**
  Keep stock Android on eMMC untouched; put U-Boot + extlinux + rootfs on
  a microSD card. Card in → your Linux; card out → stock Android. This
  makes recovery "pull the card" and sidesteps the irreversible-eMMC-flash
  risk (§12) entirely during bring-up.
- USB serial console: appears as `/dev/ttyACM*` (`screen /dev/ttyACM0 115200`).

## Status

Status reflects the RGOS native Yocto port (§8), which runs a downstream
`linux-unisoc-t618` kernel. 🟩 = working on that port.

| Subsystem | Status | Notes |
|---|---|---|
| Boots to shell | 🟩 | RGOS boots to systemd, serial + panel getty + SSH |
| Display | 🟩 | Weston 13 on DRM, rotate-270 |
| Touch input | 🟩 | Goodix; needed an IRQ/GPIO-mux fix |
| Gamepad controls | 🟩 | `retrogame_joypad` (`js0`) + `singleadcjoy` for Hall sticks |
| Wi-Fi | 🟩 | `sprdwcn` + NetworkManager (multicast-filter warning is log noise) |
| Bluetooth | 🟩 | BlueZ + A2DP (bluealsa) |
| Audio playback | 🟩 | Speakers + headset jack, `sprdphone-sc2730` |
| Audio recording | 🟨 | Headset boom-mic capture parked (needs Android USB debug dump) |
| Sensors | ⬜ | None exposed / likely none fitted |
| GPU acceleration | 🟨 | Display works via pixman (software); Mali-G52 GL via Panfrost not yet proven |
| Suspend/resume | 🟨 | Power-tap → DPMS and hold → poweroff work; `systemctl poweroff` doesn't stay off with VBUS present |
| Battery/charging | 🟩 | `sc27xx` fuel-gauge + charger |
| eMMC writes | 🟥 | ADMA fault on 8-bit HS400ES (§3, §8); RGOS runs rootfs from microSD instead |

## Backups taken before first flash
- RGOS sidesteps this by **not writing eMMC at all** during development —
  stock Android stays on eMMC, RGOS boots from microSD (§6). The recovery
  path is "pull the card." A stock SPL backup
  (`spl-boot0-stock.img`) is also kept.
- [ ] If you *do* intend to write eMMC, verify the restore round-trip
  first — see [12-oem-restore.md](../../12-oem-restore.md) §12.5 — and be
  aware of the eMMC ADMA write bug (§3, §8) before relying on any
  eMMC-resident recovery image.

## Next steps (in order)

**If a dump already exists locally** (e.g. on a laptop with physical
device access), skip straight to
the unified checklist in [../../HANDOFF.md](../../HANDOFF.md) instead of
re-deriving these steps — it's the concrete, ready-to-run version of the
list below.

1. Clone and read `github.com/TheGammaSqueeze/GammaOS`'s kernel/device
   tree — this is almost certainly the fastest path to a complete,
   working DT + defconfig for this exact board, skipping most of §1/§4's
   from-scratch recovery work.
2. Confirm the UNISOC download-mode flashing/unbrick procedure from
   GammaOS's own install docs before attempting anything on real
   hardware.
3. Fill in the §3 hardware table above with real `compatible` strings
   once GammaOS's DT (or a stock dump) is in hand.
4. Decide, subsystem by subsystem, native vs. Halium shim per
   [03-hardware-identification.md](../../03-hardware-identification.md)
   §3.5, informed by what GammaOS already proves works.

## Research sources

Gathered via web research (not hands-on testing): GammaOS Next's own
install wiki (fetched directly — this is the most authoritative source
in this profile, since it's the project's own documentation of a
procedure its users actually run); retrohandheldguides.com and
joeysretrohandhelds.com third-party setup guides; gbatemp.net and
retrododo.com hardware reviews (Hall-effect stick confirmation);
vendor/press spec listings (Anbernic's own site, slickdeals listings).
Treat anything not marked "confirmed" above as still needing direct
verification against the physical device.
