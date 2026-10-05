# Operation-Systems

Operating-systems engineering notes and guides.

## Guides

### [Porting Mainline Linux to Any Unsupported Android Device](docs/android-linux-porting/00-overview.md)

A vendor-agnostic, end-to-end methodology for taking an Android device
whose vendor never shipped (or dropped) mainline Linux / Ubuntu Touch /
postmarketOS support, and bringing a real Linux userspace up on it:
dump the firmware, reverse engineer the closed drivers/HALs/bootloader
with Ghidra, rebuild a buildable kernel + device tree, and assemble a
Linux rootfs — reusing vendor blobs through a Halium/libhybris shim only
for the subsystems that need it.

Covers Qualcomm, MediaTek, Samsung Exynos, UNISOC, HiSilicon, and
tablet-class Allwinner/Rockchip/Tegra devices.

**Structure** (`docs/android-linux-porting/`):

- **Guide chapters (00–15):** overview and scope → firmware dumping →
  Ghidra RE → hardware identification → kernel porting → userspace →
  bootloader/flashing → tools → case studies → per-SoC-vendor specifics →
  device-profile template → troubleshooting → OEM restore → glossary →
  upstreaming → hardware lab.
- **`scripts/`:** automation for the mechanical steps — scaffold a device
  profile, unpack a boot image, recover the kernel config, extract vendor
  partitions, back up and restore stock firmware, and a `check-docs.sh`
  consistency checker (run in CI).
- **`templates/`:** the source templates `new-device.sh` renders from.
- **`devices/`:** per-device profiles tracking a specific port end-to-end.
- **`HANDOFF.md`:** the checklist for whoever has physical device access.
- **`CONTRIBUTING.md`:** conventions for contributors (notes not binaries, verify before stating, run the checker).

**Devices tracked:**

| Device | SoC | Notes |
|---|---|---|
| [Anbernic RG405M](docs/android-linux-porting/devices/anbernic-rg405m/profile.md) | UNISOC T618 | Hardware-proven native Yocto port (RGOS); see the §08 case study |
| [Blackview BL6000 Pro 5G](docs/android-linux-porting/devices/blackview-bl6000-pro-5g/profile.md) | MediaTek Dimensity 800 | Profile from research; awaiting a cataloged dump |

This guide is written in the spirit of open-source community etiquette:
document the method, credit the prior work it builds on, and share what's
learned (notes and derived data, never vendor binaries) so the next
device and the next person have somewhere to start. See the overview's
"Why do this", "A note on ownership and credit", and "Why this is shared
openly" sections.
