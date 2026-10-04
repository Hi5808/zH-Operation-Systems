# Device Profile: Anbernic RG405M (codename: TBD — see §Identity)

Filled in from [10-device-profile-template.md](../../10-device-profile-template.md).
Not a phone — a handheld gaming device — so the hardware table below
swaps modem/camera for gamepad-specific I/O, but the SoC-level porting
methodology (§1-§9 of the guide) is identical. Public-spec fields are
sourced from vendor/press listings; fields marked **TBD** need
confirmation from the device/firmware itself.

## Identity
- Manufacturer / model / codename: Anbernic / RG405M / codename TBD
- Form factor: handheld gaming console (clamshell-free, horizontal grip,
  4" IPS touchscreen, physical d-pad/buttons/analog sticks)
- Release year: March 2023
- Android version(s) shipped: Android 12
- `getprop ro.board.platform` / `ro.hardware`: TBD — expect a `ums9230`/
  `t618`-family string (UNISOC's internal codename for Tiger T618),
  confirm via `adb shell getprop` or the dumped DT
- Bootloader unlock method: TBD — no confirmed public documentation
  found; UNISOC devices generally lack a standardized
  `fastboot oem unlock` toggle (§9.4), so the SPRD/UNISOC download-mode
  path is the realistic dump route by default. That said, UNISOC chips
  have their own secure-boot/authentication options too, and whether
  this exact chip/firmware has them enabled — and therefore whether
  download mode gives full read/write, read-only, or nothing without a
  bypass — is **unconfirmed**. GammaOS's existence (it ships installable
  firmware for this exact chip family) is reasonably strong circumstantial
  evidence that *some* level of community access works, but confirm
  actual read/write behavior directly before relying on it, same caveat
  as §9.7 generally
- SoC vendor: **UNISOC (Spreadtrum)** — see
  [09-soc-vendor-specifics.md](../../09-soc-vendor-specifics.md) §9.4.
  This is the guide's "minimal community tooling, expect heavy
  from-scratch RE" vendor case — budget accordingly.
- Exact SoC model: **UNISOC Tiger T618**, octa-core
  (2× Cortex-A75 @ 2.0 GHz + 6× Cortex-A55 @ 2.0 GHz), **Mali-G52 GPU**
  @ 850 MHz
- RAM / storage type: 4 GB LPDDR4X / 128 GB **eMMC** + microSD slot

## Existing prior art (check before any RE work)

Unlike the guide's general UNISOC warning, this specific chip family
already has real community traction worth forking from instead of
starting from Ghidra RE:

- **GammaOS** (`github.com/TheGammaSqueeze/GammaOS`) — a LineageOS 19.1
  (Android 12) based ROM specifically for Anbernic's UNISOC T618 handheld
  line (RG405M/RG405V/RG505/etc). This is almost certainly the fastest
  path to a working kernel source tree and known-good driver set for
  this exact SoC+board combination (§4.1) — check its kernel tree and
  device repo *before* any firmware dump/Ghidra work on this device.
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
- [ ] Stock firmware package — TBD, check Anbernic's own support site
- [ ] GammaOS source/kernel tree cloned for reference — TBD
- [ ] Direct device dump (adb/root) — TBD
- [ ] Full download-mode dump (UNISOC SPRD protocol) — TBD; tooling is
      less standardized than Qualcomm/MediaTek's (§9.4), check
      `awesome-anbernic` and GammaOS's own build docs for whatever the
      community has already worked out for this exact device before
      reverse-engineering the protocol yourself
- [ ] `kernel.config` recovered — TBD
- [ ] `.dts`/DTB extracted — TBD (or taken directly from GammaOS's kernel
      tree, which is likely more complete than a decompiled DTB)
- [ ] `vendor`/`system` partitions mounted — TBD

## §2 Reverse engineering notes
See [re-notes.md](re-notes.md) in this folder. Given the GammaOS prior
art above, expect RE work here to be mostly *diffing* GammaOS's drivers
against stock firmware rather than reconstructing from zero — see
[02-reverse-engineering-ghidra.md](../../02-reverse-engineering-ghidra.md)
§2.4's BinDiff workflow.

## §3 Hardware inventory

| Subsystem | Compatible string | Bus | Mainline driver? | Decision |
|---|---|---|---|---|
| Display panel | TBD (4" IPS, 640×480) | MIPI-DSI (typical) | TBD | TBD |
| Touchscreen | TBD | I2C (typical) | TBD | TBD |
| GPU | TBD (`sprd,...` or `unisoc,...` expected) | — | **Mali-G52** → Panfrost (Bifrost/Valhall-class Mali has reasonable Mesa support, same driver family as §9.3 Exynos/§9.2 MediaTek Mali parts) | Likely native, verify against Panfrost's support matrix for this exact Mali revision |
| Audio | TBD | — | TBD | TBD |
| Cellular modem | **None** — no SIM/cellular radio on this device | — | N/A | N/A |
| Wi-Fi/BT | 802.11ac + BT 5.0, chipset TBD | SDIO/USB (typical) | TBD | TBD |
| Gamepad controls (d-pad, ABXY, L/R, analog sticks) | TBD — likely a GPIO matrix + ADC for analog sticks, or an I2C/HID microcontroller | GPIO/ADC/I2C (TBD) | Not a standard phone peripheral — check GammaOS's kernel source first, this is very likely already solved there | Native, fork from GammaOS |
| Sensors | TBD (if any — many handhelds omit accel/gyro entirely) | — | TBD | TBD |
| Battery/charging | TBD | — | TBD | TBD |
| USB-C | Present (charging + likely USB-OTG/display-out) | — | TBD | TBD |

## §4 Kernel
- Kernel base chosen: **GammaOS's T618 kernel tree** (strong
  recommendation per the prior-art note above) rather than reconstructing
  from a stock dump
- Defconfig location in this repo: not yet created
- Device tree location in this repo: not yet created
- Reserved-memory regions: TBD
- Known-working kernel command line: TBD

## §5 Userspace strategy
- Overall approach: TBD — likely mixed (native touchscreen/gamepad/Wi-Fi,
  Halium/libhybris shim for GPU if Panfrost doesn't fully cover this Mali
  revision)
- `proprietary-blobs.txt` location: not yet created
- Rootfs base: TBD (postmarketOS recommended as a starting point; note
  there is no existing postmarketOS UNISOC T618 device port to fork from
  as of this writing, per §9.4's general UNISOC community-maturity note —
  this would likely be a genuinely new postmarketOS device port)

## §6 Boot chain
- Boot chain stages: `BootROM → FDL1/FDL2 → bootloader → kernel`
  (standard UNISOC chain, §9.4)
- `boot.img` header version / base / offsets: TBD
- AVB/vbmeta handling needed: TBD
- Confirmed unbrick path tested before first flash: TBD — identify the
  UNISOC download-mode entry combo for this exact model before any
  flashing attempt; check GammaOS's install instructions first since they
  necessarily document a working flash/unbrick procedure for this device

## Status

| Subsystem | Status | Notes |
|---|---|---|
| Boots to shell | ⬜ Not started | No dump obtained yet; GammaOS confirms the device is at least Android-flashable by the community |
| Display | ⬜ Not started | |
| Touch input | ⬜ Not started | |
| Gamepad controls | ⬜ Not started | Expect to inherit from GammaOS's kernel largely as-is |
| Wi-Fi | ⬜ Not started | |
| Bluetooth | ⬜ Not started | |
| Audio playback | ⬜ Not started | |
| Audio recording | ⬜ Not started | |
| Sensors | ⬜ Not started | |
| GPU acceleration | ⬜ Not started | Mali-G52 — check Panfrost support matrix |
| Suspend/resume | ⬜ Not started | |
| Battery/charging | ⬜ Not started | |

## Backups taken before first flash
- [ ] Not yet started — no dump obtained yet.
- [ ] Restore round-trip verified (not just backed up) — see
  [12-oem-restore.md](../../12-oem-restore.md) §12.5. GammaOS's install
  docs are a likely source for a known-working flash procedure to adapt
  for this.

## Next steps (in order)

**If a dump already exists locally** (e.g. on a laptop with physical
device access), skip straight to
[../../HANDOFF.md](../../HANDOFF.md)'s Anbernic checklist instead of
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
   §3.4, informed by what GammaOS already proves works.
