# 10. Device Profile Template

Copy this file to `docs/android-linux-porting/devices/<codename>/profile.md`
for each new device you port, and fill it in as you work through §1-§9.
It is the single source of truth for "what do we know about this device,"
and makes the rest of the port mechanical instead of ad hoc — this is what
makes the guide work for *any* device rather than just the one it was
written against.

```markdown
# Device Profile: <Manufacturer> <Model> (codename: <codename>)

## Identity
- Manufacturer / model / codename:
- Release year:
- Android version(s) shipped:
- `getprop ro.board.platform` / `ro.hardware`:
- Bootloader unlock method: [fastboot oem unlock / vendor unlock tool / none found]
- SoC vendor: [Qualcomm / MediaTek / Samsung Exynos / UNISOC / HiSilicon / Allwinner / Rockchip / Tegra / other] — see 09-soc-vendor-specifics.md
- Exact SoC model:
- RAM / storage type: [LPDDR4/5] / [eMMC / UFS 2.x/3.x]

## §1 Firmware acquired
- [ ] OTA/full-firmware ZIP — source: ______
- [ ] Factory/engineering image — source: ______
- [ ] Direct device dump (adb/root) — partitions pulled: ______
- [ ] Full BootROM-mode dump (EDL/BROM/Odin/maskrom/etc) — partitions pulled: ______
- [ ] `kernel.config` recovered — method: [adb /proc/config.gz / extract-ikconfig]
- [ ] `.dts`/DTB extracted — source: [decompiled from boot.img / real BSP source]
- [ ] `vendor`/`system` partitions mounted, HAL `.so` + `.ko` + firmware blobs located

## §2 Reverse engineering notes
Link to a `re-notes.md` in this device's folder containing, per
component RE'd:
- Component name / file
- Why it needed RE (no public source found at: ______)
- Ghidra project location (local only — don't commit the binary)
- Recovered init sequence / register table / protocol notes (this part
  *is* committed — it's your own derived notes, not the vendor's binary)

## §3 Hardware inventory
Fill in the full peripheral table from 03-hardware-identification.md §3.2
for this device specifically: component, compatible string, bus, mainline
driver exists? (Y/N/partial), decision (native / blob-shim).

| Subsystem | Compatible string | Bus | Mainline driver? | Decision |
|---|---|---|---|---|
| Display panel | | | | |
| Touchscreen | | | | |
| GPU | | | | |
| Audio | | | | |
| Modem | | | | |
| Wi-Fi/BT | | | | |
| Sensors | | | | |
| Fingerprint | | | | |
| PMIC/charging | | | | |
| USB | | | | |

## §4 Kernel
- Kernel base chosen: [vendor source / community BSP fork / mainline] — link: ______
- Defconfig location in this repo: ______
- Device tree location in this repo: ______
- Reserved-memory regions (must match vendor DT exactly):
- Known-working kernel command line:

## §5 Userspace strategy
- Overall approach: [fully native / Halium+libhybris shim / mixed]
- `proprietary-blobs.txt` location (list of vendor files needed, not the files themselves): ______
- Rootfs base: [postmarketOS / Ubuntu Touch / Debian / Arch / other]

## §6 Boot chain
- Boot chain stages (fill in from 09-soc-vendor-specifics.md for this SoC vendor): ______
- `boot.img` header version / base / offsets (from `unpack_bootimg` on the stock image):
- AVB/vbmeta handling needed: [none / --disable-verity / re-signed with test keys]
- Confirmed unbrick path tested *before* first flash: [EDL / BROM / Odin / maskrom / APX] — Y/N

## Status (update as you go — mirrors postmarketOS wiki style)

| Subsystem | Status | Notes |
|---|---|---|
| Boots to shell | ⬜ Not started / 🟨 Boots, no display / 🟩 Full boot | |
| Display | | |
| Touch input | | |
| Wi-Fi | | |
| Bluetooth | | |
| Mobile data (modem) | | |
| Audio playback | | |
| Audio recording | | |
| Camera | | |
| Sensors | | |
| GPU acceleration | | |
| Suspend/resume | | |
| Battery/charging | | |

## Backups taken before first flash
- [ ] Every partition in §6 backed up to: ______
- [ ] Unbrick path confirmed accessible (tested entering recovery mode, not actually used): ______
```

## Why this template matters for "supporting any device"

The rest of this guide (§1-§9) is deliberately written as *methodology*,
not as a fixed walkthrough for one phone. This template is what turns that
methodology into a repeatable, trackable process per device: every device
you port gets its own `devices/<codename>/` folder with this profile, a
`re-notes.md`, and a `status.md`, following exactly the structure
[08-case-studies.md](08-case-studies.md) recommends postmarketOS/Halium's
own wikis use. Over multiple devices, these profiles are also how you spot
shared work (same SoC family → mostly-shared kernel/DT, per
[09-soc-vendor-specifics.md](09-soc-vendor-specifics.md)) instead of
starting from zero every time.

## Next

→ [11-troubleshooting-and-debugging.md](11-troubleshooting-and-debugging.md)
for what to do when a step in this template doesn't go as expected.
