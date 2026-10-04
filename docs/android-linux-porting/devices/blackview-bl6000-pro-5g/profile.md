# Device Profile: Blackview BL6000 Pro 5G (codename: TBD — see §Identity)

Filled in from [10-device-profile-template.md](../../10-device-profile-template.md).
Public-spec fields below are sourced from GSMArena/vendor listings; every
field marked **TBD** needs to be confirmed from the device/firmware
itself once dumping (§1) starts, since it can't be determined from
marketing specs alone.

## Identity
- Manufacturer / model / codename: Blackview / BL6000 Pro 5G / codename TBD
  (Blackview's own build strings refer to it as `S1000A`/`dk022` — see
  firmware string below; confirm the DT root `compatible`/`model` string
  once a dump is in hand, per §1.3)
- Release year: 2020 (launched), 2021/2022 firmware updates seen
- Android version(s) shipped: Android 10, with at least one update to
  Android 11 reported in later firmware builds
- `getprop ro.board.platform` / `ro.hardware`: TBD — expect `mt6873`
  family, confirm via `adb shell getprop` or from the dumped `boot.img`/DT
- Bootloader unlock method: TBD — MediaTek devices vary by vendor
  policy; check `Settings > About phone > build number` tap-7x for
  Developer Options, then `Settings > Developer options` for an
  "OEM unlocking" toggle. If absent, BROM mode (below) *may* still be
  usable for dumping independent of that toggle — but whether BROM gives
  read-only, full read/write, or nothing on this exact unit depends on
  whether Blackview enforces MediaTek's SLA/DAA authentication on this
  firmware build, which is **unconfirmed** — test with `mtkclient`
  directly rather than assuming either way (§9.2)
- SoC vendor: **MediaTek** — see
  [09-soc-vendor-specifics.md](../../09-soc-vendor-specifics.md) §9.2
- Exact SoC model: **MediaTek Dimensity 800 (MT6873V/C)**, octa-core
  (4× Cortex-A76 @ 2.0 GHz + 4× Cortex-A55 @ 2.0 GHz), Mali-G57 MP4 GPU,
  integrated 5G modem
- RAM / storage type: 8 GB LPDDR4X (per vendor listing) / 256 GB **UFS 2.1**

## Known firmware build string (for locating the right dump/source)
- `S1000a-dk-dk022-a2-66-l-256G8G-fhdp-bom2-q0-cts-dk_BL6000Pro_NEU_S1000A_V1.0_20210115V04_user_20210115`
  (Android 10 base)
- `MT6873_Blackview_BL6000Pro_Android_11_S1000A_V1.0_20220108V09_RP1A.200720.011_EEA`
  (later Android 11 update)
- Stock firmware is flashed via **SP Flash Tool** (MediaTek's own tool),
  confirming this device uses the standard MediaTek BROM/Preloader chain
  rather than anything unusual.

## §1 Firmware acquired
- [ ] Stock firmware package — vendor/community mirrors exist (search
      "Blackview BL6000 Pro" + "stock ROM"/"firmware" on the usual MTK
      firmware-mirror sites); verify checksum/source before trusting one
- [ ] Direct device dump (adb/root) — partitions pulled: TBD
- [ ] Full BROM-mode dump via `mtkclient` — partitions pulled: TBD
      (this is the recommended primary path per §9.2 — works regardless
      of bootloader unlock state)
- [ ] `kernel.config` recovered — method: TBD
- [ ] `.dts`/DTB extracted — source: TBD
- [ ] `vendor`/`system` partitions mounted, HAL `.so` + `.ko` + firmware
      blobs located — TBD

## §2 Reverse engineering notes
See [re-notes.md](re-notes.md) in this folder (currently a stub — fill in
as components are RE'd per [02-reverse-engineering-ghidra.md](../../02-reverse-engineering-ghidra.md)).

## §3 Hardware inventory

| Subsystem | Compatible string | Bus | Mainline driver? | Decision |
|---|---|---|---|---|
| Display panel | TBD | MIPI-DSI (6.36"/6.67" FHD+, ~1080x2300 or 1920x1080 depending on source — confirm from EDID/panel driver) | TBD | TBD |
| Touchscreen | TBD | I2C | Likely Y (Synaptics/FocalTech/Goodix common on this class of device — confirm chip) | Likely native |
| GPU | `mediatek,mt6873-mfgsys` (expected) | — | **Mali-G57 MP4** → Panfrost/Panthor (Valhall-gen Mali has decent, improving Mesa support) | Likely native, verify Mesa coverage for this exact Mali revision first |
| Audio codec/DSP | `mediatek,mt6873-afe` (expected) | — | TBD, MTK audio DSP is historically the hardest subsystem on this vendor (§9.2) | Likely blob-shim initially |
| Modem | Integrated in Dimensity 800 (not a separate discrete modem chip) | — | MediaTek's own protocol, not QMI — historically the hardest-to-port subsystem on MTK devices (§9.2) | Blob-shim, low priority for full native support |
| Wi-Fi/BT | TBD chipset | SDIO/PCIe/USB (TBD) | TBD | TBD |
| Sensors | TBD (accel/gyro/light/prox chip models) | I2C | Likely Y (industry-standard parts) | Likely native |
| Fingerprint | Rear or side-mounted capacitive, vendor TBD | SPI (likely) | Likely N | Skip / low priority |
| PMIC/charging | TBD (MT6873 typically pairs with an MTK-family PMIC) | — | TBD | TBD |
| USB/USB-C PD | TBD | — | TBD | TBD |
| NFC | Present per spec sheet, chip TBD | I2C (typical) | Depends on chip (NXP PN5xx family usually has mainline support) | Likely native if NXP |

## §4 Kernel
- Kernel base chosen: TBD — check for a published Blackview/MediaTek
  GPL compliance source drop for `MT6873`/Dimensity 800 first (§4.1);
  also check whether any existing postmarketOS/Halium MT6873 port (even
  for a different phone model) exists to fork from, since SoC-level work
  is shared (§3.1/§9.2)
- Defconfig location in this repo: not yet created
- Device tree location in this repo: not yet created
- Reserved-memory regions: TBD — recover from stock `.dts` once dumped
- Known-working kernel command line: TBD

## §5 Userspace strategy
- Overall approach: **mixed, leaning Halium/libhybris** for GPU/audio-DSP/
  modem per the §3 table above, native for touch/sensors/Wi-Fi/BT once
  confirmed
- `proprietary-blobs.txt` location: not yet created
- Rootfs base: TBD (postmarketOS recommended as the starting point per
  [05-rootfs-and-userspace.md](../../05-rootfs-and-userspace.md) §5.3)

## §6 Boot chain
- Boot chain stages: `BROM → Preloader → LK → boot.img` (standard
  MediaTek chain, §9.2)
- `boot.img` header version / base / offsets: TBD, recover via
  `unpack_bootimg` on the stock `boot.img` once dumped
- AVB/vbmeta handling needed: TBD
- Confirmed unbrick path tested before first flash: **BROM mode via
  `mtkclient`** — TBD. Confirm *both* the exact button/USB combo for this
  model *and* that `mtkclient` actually gets write access (not just
  read) on this unit's specific SLA/DAA state before any flashing
  attempt — do not assume write access just because read/dump worked
  (§6.5, §9.2)

## Status

| Subsystem | Status | Notes |
|---|---|---|
| Boots to shell | ⬜ Not started | Firmware not yet dumped |
| Display | ⬜ Not started | |
| Touch input | ⬜ Not started | |
| Wi-Fi | ⬜ Not started | |
| Bluetooth | ⬜ Not started | |
| Mobile data (modem) | ⬜ Not started | Expect blob-shim; MTK integrated 5G modem, no QMI equivalent |
| Audio playback | ⬜ Not started | |
| Audio recording | ⬜ Not started | |
| Camera | ⬜ Not started | |
| Sensors | ⬜ Not started | |
| GPU acceleration | ⬜ Not started | Mali-G57 MP4 — check Panfrost/Panthor support matrix for this exact revision |
| Suspend/resume | ⬜ Not started | |
| Battery/charging | ⬜ Not started | |

## Backups taken before first flash
- [ ] Not yet started — no dump obtained yet.
- [ ] Restore round-trip verified (not just backed up) — see
  [12-oem-restore.md](../../12-oem-restore.md) §12.5. Given the
  unconfirmed SLA/DAA state noted above, this is also where you'll
  learn whether `mtkclient` actually has write access on this unit.

## Next steps (in order)
1. Obtain a firmware dump — either the stock SP-Flash-Tool package (fast
   path, confirm checksum/provenance) or a direct `mtkclient` BROM dump
   from the physical device. The BROM dump is more authoritative (ground
   truth from the actual unit rather than a possibly-different firmware
   build someone else uploaded), but whether it actually gives read
   and/or write access on this specific unit depends on Blackview's
   SLA/DAA configuration for this chip/firmware — that is **not known**
   until `mtkclient` is actually run against the device; don't assume it
   works regardless of lock state. See
   [01-firmware-dumping.md](../../01-firmware-dumping.md) and
   [09-soc-vendor-specifics.md](../../09-soc-vendor-specifics.md) §9.2
   and §9.7.
2. Unpack `boot.img`, recover `kernel.config` and the DTB/`.dts`
   (§1.3-§1.4).
3. Fill in the §3 hardware table above with real `compatible` strings
   once the `.dts` is in hand.
4. Search for an existing MT6873/Dimensity 800 kernel source drop or
   community port to fork from before any Ghidra RE work (§4.1).
