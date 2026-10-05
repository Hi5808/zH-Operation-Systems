# Porting Mainline Linux to Any Unsupported Android Device

## What this guide covers

A vendor-agnostic, end-to-end methodology for taking **any** Android
device — regardless of SoC vendor (Qualcomm, MediaTek, Samsung Exynos,
UNISOC, HiSilicon, or a tablet-class Allwinner/Rockchip/Tegra chip; see
[09-soc-vendor-specifics.md](09-soc-vendor-specifics.md)) — whose vendor
never shipped (or stopped shipping) a mainline Linux / Ubuntu Touch /
postmarketOS build, and bringing a real Linux userspace up on it by:

1. Dumping the stock firmware (bootloader, kernel, vendor partitions).
2. Reverse engineering the closed-source pieces with Ghidra to recover the
   information needed to write or adapt open drivers (register maps, init
   sequences, power-on sequences, pinmux/GPIO tables, calling conventions
   between userspace HALs and kernel drivers).
3. Extracting or rebuilding a buildable kernel source tree (device tree,
   defconfig, out-of-tree vendor drivers) from the dumped kernel + modules.
4. Reusing the vendor's Android HALs/firmware blobs for the hardest-to-RE
   subsystems (GPU, modem, DSP/audio, Wi-Fi/BT firmware) via a compatibility
   shim (the "Halium" approach), instead of reimplementing them from
   scratch.
5. Assembling a standard Linux rootfs (postmarketOS, Ubuntu Touch, Debian,
   Arch) on top of that kernel + HAL layer, and producing a flashable image.

This is the same approach used by the postmarketOS, Halium/UBports, and
LineageOS communities to bring mainline-ish Linux to devices with zero
vendor support. It is **device-enablement / interoperability reverse
engineering**: you already own the hardware and the firmware image that
ships on it; the goal is to understand it well enough to run a different,
otherwise-compatible OS on your own device — not to break DRM, pull
somebody else's copyrighted content, or redistribute the vendor's binaries.

## Why do this

Before the methodology, the motivation — because "why would anyone
reverse engineer their own phone" is a fair question, and the answer
shapes which parts of this guide matter for a given project.

- **The hardware outlives the vendor's software support.** Android
  OEMs, especially budget/regional vendors, routinely stop shipping
  security patches 1-3 years after release while the hardware itself
  keeps working fine. A device with a dead Android build is still a
  capable ARM computer with a screen, battery, radios, and storage — the
  software is the only thing that's actually obsolete. Porting a
  maintained Linux distribution is how the hardware keeps receiving
  security updates after the vendor has moved on, instead of becoming
  e-waste or a permanently-vulnerable "it still works, don't connect it
  to anything important" device.
- **Repurposing hardware for a job it wasn't sold for.** A phone or
  handheld with a real Linux userspace can run as a dedicated
  single-purpose device — a small server, a diagnostic/field tool, a
  retro-emulation frontend without Android's background-service
  overhead, a kiosk, a SDR/radio front-end, a portable dev environment —
  none of which need or benefit from stock Android's app model, Play
  Services, or ad/telemetry stack. This is the exact motivation behind
  the Anbernic case in this repo: GammaOS already proves the hardware is
  capable of more than its stock firmware exposes.
- **Software freedom and reduced attack surface.** Stock Android on
  most devices ships a substantial closed-source stack (OEM apps,
  telemetry, Google/GMS services, vendor-specific "optimizations") that
  the device owner cannot audit, remove, or fully control, even on their
  own hardware. A Linux userspace with only the drivers/blobs actually
  required for hardware function (and nothing else) is a meaningfully
  smaller, more inspectable, more owner-controlled system.
- **It's how the broader ecosystem actually advances.** Every device
  this methodology successfully supports is also a contribution back:
  mainline kernel patches, a new postmarketOS/Halium device port, a
  driver that the next person porting a similar chip doesn't have to
  write from scratch (§4.1, §8, §9). The guide's "check for existing
  prior art first" principle throughout exists because this is a
  cumulative community effort, not a series of isolated one-off hacks.
- **Direct, hands-on understanding of how the device actually works.**
  Independent of any practical outcome, reverse engineering your own
  hardware's boot chain, drivers, and HAL boundary is a genuinely
  effective way to learn embedded Linux, ARM SoC architecture, and
  Android internals that no amount of reading about them substitutes
  for — this is explicitly legitimate, protected activity (§Legal
  below), not a byproduct that needs separate justification.

None of this requires bypassing DRM, defeating a security boundary you
don't have the right to cross, or touching hardware you don't own — see
the legal scope below for exactly where this guide's methodology stops.

## A note on ownership and credit

By the end of a successful port, the running system on your device is
yours — you did the dumping, the reverse engineering, the kernel work,
the testing, the flashing. Nobody disputes that the finished result
belongs to the person who did the work to get there.

But "the final product is mine" and "I built this from nothing" are two
different claims, and this guide is only honest if it keeps them
separate. Almost nothing here is done from a blank slate:

- The kernel you port from is someone else's source tree, published
  under GPL specifically so you could do this.
- The shim layer that lets Android HALs run under Linux (`libhybris`)
  is Halium/UBports' engineering, not yours.
- The device-porting conventions and tooling (`proprietary-blobs.txt`,
  the per-device repo layout, `pmbootstrap`) came from postmarketOS and
  Halium's accumulated work across hundreds of devices.
- A specific chip family's bring-up — like GammaOS's work on the
  UNISOC T618 handhelds (§9.4, `devices/anbernic-rg405m/profile.md`) —
  is often the single thing that makes an otherwise "from scratch"
  device tractable at all.

Relying on that work isn't a shortcut you should feel is diminishing the
result, and it isn't something to paper over either. It's how this
entire ecosystem functions — every finished port is itself prior art for
the next person, the same way GammaOS or Halium's device trees were
prior art for you. The obligation that comes with using it is small and
specific: name the project, link the source, don't present someone
else's engineering as if it were a from-scratch result. That's not a
legal formality — it's the actual mechanism by which this community
keeps working for the next device and the next person after you.

So the end-state view this guide wants you to walk away with is: the
device is yours, the result is yours, and it was only possible because
of named, credited work that came before it — all three of those are
true at once, not in tension with each other.

## Why this is shared openly

This project is written and maintained in the spirit of open-source
community etiquette: document what you learned, credit where it came
from, and publish it so the next person can build on it. That's a
deliberate choice, not a default.

Hardware knowledge has a way of disappearing. Vendors stop supporting
devices, firmware mirrors go offline, forum threads vanish, and the
understanding of how a given phone or handheld actually works ends up
either lost or locked inside proprietary tools and private repositories.
Projects like postmarketOS, Halium, LineageOS, and GammaOS exist because
people chose to write down and share that knowledge while it was still
recoverable — before it became closed off for good.

This guide aims to do the same:

- **Methodology over secrets.** Everything here is meant to be
  repeatable by anyone with the same hardware, not a private recipe.
- **Notes, not binaries.** Vendor firmware stays with the device owner;
  what gets shared is the understanding derived from it — register
  tables, init sequences, device trees, porting notes — which is what
  actually helps the next port.
- **Contribute back.** A finished device port is most valuable as a
  public reference: upstream kernel patches, a postmarketOS/Halium device
  port, or at minimum a published device profile in this repo's format.
- **Keep the engineering visible.** The reason to do this openly is the
  same reason most people got into this field: seeing how real systems
  are built, taking them apart, and learning from it. Shared, credited
  work keeps that path open for whoever comes next.

While this repo is being drafted it may be kept private; the intent is
for the finished guide to be published under these same principles.

## Legal / scope notes (read first)

- Work only on hardware you own or are explicitly authorized to modify.
- Decompiling firmware to understand interfaces for interoperability is
  broadly recognized as fair use / protected reverse engineering in many
  jurisdictions (e.g. the DMCA §1201(f) interoperability exception in the
  US, and similar provisions elsewhere) — but verify your local law and the
  device's terms before distributing any derived artifact.
- Never redistribute the vendor's proprietary binaries (bootloader, GPU
  blobs, modem firmware) in a public repo. Document the *process* to extract
  and use them locally; point others at `source.android.com`/vendor sites or
  have your tooling pull them from the user's own device/firmware package at
  build time (this is exactly how Halium's `hybris-boot` / `android_vendor`
  trees and postmarketOS's `pmbootstrap` do it).
- Flashing custom firmware can brick a device and may void warranty. Always
  keep a full, verified backup of the original partitions before touching
  anything.

## Pipeline at a glance

```
Stock Android firmware (OTA zip / dump from device)
        │
        ▼
  Partition/image extraction  (payload.bin, boot.img, vendor.img, ...)
        │
        ▼
  Kernel + DTB + modules recovery   (unmkbootimg, dtc, extract-ikconfig)
        │
        ▼
  Ghidra RE of closed userspace/kernel blobs
   (HALs, vendor .ko modules, bootloader, TrustZone/TEE images)
        │
        ▼
  Device tree / defconfig reconstruction  →  buildable kernel tree
        │
        ▼
  Hardware adaptation layer (libhybris / Halium HAL shim, or native drivers)
        │
        ▼
  Linux rootfs (postmarketOS / Ubuntu Touch / Debian arm64) + bootloader glue
        │
        ▼
  Flashable image → test on device → iterate
```

## Guide index

| File | Contents |
|---|---|
| [01-firmware-dumping.md](01-firmware-dumping.md) | Getting the firmware off the device/OTA and unpacking partitions |
| [02-reverse-engineering-ghidra.md](02-reverse-engineering-ghidra.md) | Ghidra workflow for kernel modules, HALs, bootloader, TEE/TrustZone |
| [03-hardware-identification.md](03-hardware-identification.md) | Identifying SoC, peripherals, pinmux/clock trees, sensors, modem |
| [04-kernel-porting.md](04-kernel-porting.md) | Rebuilding a buildable kernel source tree and device tree |
| [05-rootfs-and-userspace.md](05-rootfs-and-userspace.md) | Halium/libhybris shim vs. native drivers; building the rootfs |
| [06-bootloader-and-flashing.md](06-bootloader-and-flashing.md) | Boot chain, repacking images, flashing, recovery |
| [07-tools-reference.md](07-tools-reference.md) | Full tool list with install notes |
| [08-case-studies.md](08-case-studies.md) | Real-world references: Halium, postmarketOS, PinePhone, Sailfish |
| [09-soc-vendor-specifics.md](09-soc-vendor-specifics.md) | Per-SoC-vendor boot chain, unbrick mode, GPU/modem specifics (Qualcomm, MediaTek, Exynos, UNISOC, HiSilicon, Allwinner, Rockchip, Tegra) |
| [10-device-profile-template.md](10-device-profile-template.md) | Fill-in worksheet for tracking a specific device's port end-to-end |
| [11-troubleshooting-and-debugging.md](11-troubleshooting-and-debugging.md) | Symptom-indexed fixes for every stage of the pipeline |
| [12-oem-restore.md](12-oem-restore.md) | Backing up and restoring stock/OEM firmware — the safety net every other chapter depends on |
| [13-glossary.md](13-glossary.md) | Definitions for EDL, AVB, DAA, SMC, HAL, DT and the other terms used throughout |
| [14-upstreaming.md](14-upstreaming.md) | Giving a finished port back: device profile, postmarketOS port, mainline kernel patches |
| [15-hardware-lab.md](15-hardware-lab.md) | Bench setup: finding a serial console (1.8V vs 3.3V), logic-analyser capture of undocumented buses, safety |

## How to use this for a new/unlisted device

1. Read §1-§8 once, straight through, for the general methodology.
2. Jump to [09-soc-vendor-specifics.md](09-soc-vendor-specifics.md) and
   find your device's SoC vendor (or the closest match) to learn its
   boot-ROM recovery mode, dump/flash tooling, and mainline maturity.
3. Run `./scripts/new-device.sh <codename> "<Display Name>" [vendor] [model]`
   (see [10-device-profile-template.md](10-device-profile-template.md) and
   [scripts/README.md](scripts/README.md)) to scaffold
   `devices/<codename>/profile.md`, and fill it in as you work through
   §1-§6 for your specific device. `./scripts/check-tools.sh` and the
   other scripts in [scripts/](scripts/) automate the mechanical parts of
   §1.
4. Keep [11-troubleshooting-and-debugging.md](11-troubleshooting-and-debugging.md)
   open while bringing the device up — most first-boot issues map
   directly to one of its entries.

Nothing in §1-§8 assumes a specific chipset; every command that differs by
vendor (dump mode, flashing tool, clock/pinctrl naming) is called out and
deferred to §9.

## Devices tracked in this repo

| Device | SoC vendor / chip | Status |
|---|---|---|
| [Blackview BL6000 Pro 5G](devices/blackview-bl6000-pro-5g/profile.md) | MediaTek Dimensity 800 (MT6873) | Profile created; dump files exist locally, not yet cataloged into this repo — see [HANDOFF.md](HANDOFF.md) |
| [Anbernic RG405M](devices/anbernic-rg405m/profile.md) | UNISOC Tiger T618 | Profile created; dump files exist locally, not yet cataloged into this repo — see [HANDOFF.md](HANDOFF.md). Existing GammaOS/LineageOS prior art identified |

**[HANDOFF.md](HANDOFF.md)** is the concrete, per-device checklist for
whoever has physical access to these devices (a local agent, or you) —
exact scripts to run, in order, and what to bring back into this repo
vs. what must never be committed.
