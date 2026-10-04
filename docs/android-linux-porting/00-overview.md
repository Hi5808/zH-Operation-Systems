# Porting Mainline Linux to an Unsupported Android Device

## What this guide covers

A high-level, end-to-end methodology for taking an Android device whose
vendor never shipped (or stopped shipping) a mainline Linux / Ubuntu Touch /
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
