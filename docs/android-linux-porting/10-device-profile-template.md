# 10. Device Profile Template

Run, from `docs/android-linux-porting/`:

```bash
./scripts/new-device.sh <codename> "<Display Name>" [SoC vendor] [SoC model]
```

to scaffold `devices/<codename>/profile.md` and `re-notes.md` from the
canonical templates in [templates/](templates/) (see
[scripts/README.md](scripts/README.md) for the full script list). This
is the single source of truth for "what do we know about this device,"
and makes the rest of the port mechanical instead of ad hoc — this is
what makes the guide work for *any* device rather than just the one it
was written against.

No script access? Copy
[templates/profile.md.tmpl](templates/profile.md.tmpl) and
[templates/re-notes.md.tmpl](templates/re-notes.md.tmpl) by hand into
`devices/<codename>/`, replacing the `@@CODENAME@@`/`@@DISPLAY_NAME@@`/
`@@SOC_VENDOR@@`/`@@SOC_MODEL@@` placeholders yourself.

## What each section of the profile covers

- **Identity** — manufacturer/model/codename, Android version, SoC
  vendor/model (points to [09-soc-vendor-specifics.md](09-soc-vendor-specifics.md)),
  bootloader unlock method, RAM/storage type.
- **§1 Firmware acquired** — checklist mirroring
  [01-firmware-dumping.md](01-firmware-dumping.md): OTA/factory image,
  direct dump, BootROM-mode dump, `kernel.config`, `.dts`/DTB, mounted
  vendor/system partitions. `scripts/unpack-boot.sh`,
  `scripts/extract-kernel-config.sh`, and `scripts/dump-vendor-partition.sh`
  automate the mechanical parts of this section.
- **§2 Reverse engineering notes** — points at this device's `re-notes.md`
  (never commit the vendor binaries themselves, only your derived notes),
  per [02-reverse-engineering-ghidra.md](02-reverse-engineering-ghidra.md).
- **§3 Hardware inventory** — the full peripheral table from
  [03-hardware-identification.md](03-hardware-identification.md) §3.2,
  filled in for this device specifically: compatible string, bus,
  whether a mainline driver exists, native-vs-blob-shim decision.
- **§4 Kernel** — kernel base chosen, defconfig/DT locations in this
  repo, reserved-memory regions, working cmdline — per
  [04-kernel-porting.md](04-kernel-porting.md).
- **§5 Userspace strategy** — native vs. Halium/libhybris shim per
  subsystem, `proprietary-blobs.txt` location, rootfs base — per
  [05-rootfs-and-userspace.md](05-rootfs-and-userspace.md).
- **§6 Boot chain** — boot stages for this SoC vendor, `boot.img`
  header/offsets, AVB handling, confirmed unbrick path — per
  [06-bootloader-and-flashing.md](06-bootloader-and-flashing.md).
- **Status table** — subsystem-by-subsystem working/broken/blob-shimmed
  state, in the same spirit as postmarketOS's wiki pages; update this as
  you go rather than only at the end.
- **Backups taken before first flash** — a final checklist gate before
  touching real hardware, per [06-bootloader-and-flashing.md](06-bootloader-and-flashing.md) §6.5.

## Generating a readiness checklist

Once a device folder exists, `scripts/gen-checklist.py <device-dir> --target <os> --goal <phone|handheld|general>` turns this template's requirements into a tailored, auto-checked checklist: it marks which artifacts (dump, DTS, kernel config, vendor tree, ...) are already present, lists what each still-missing item needs and the chapter/script that provides it, and adds the target-OS-specific inputs (Halium device tree for Ubuntu Touch/Droidian; pmaports packages for postmarketOS; a plain arm64 rootfs for Debian/Kali/Arch on your ported kernel). It plans the work; it does not build the image (ch.4-6 and the real build tools do that). `--write` saves it as `checklist.md` in the device folder.

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
