# Scripts

Bash automation for the mechanical steps in the guide — these wrap the
exact commands described in [01-firmware-dumping.md](../01-firmware-dumping.md)
and [10-device-profile-template.md](../10-device-profile-template.md) so
you don't hand-run them per device. They don't replace the judgment calls
in §2-§6 (RE work, driver decisions, boot-chain repacking) — those stay
manual by design.

All scripts are POSIX-ish bash, dependency-light, and fail loudly with a
pointer to the relevant doc chapter rather than guessing.

| Script | Wraps | Usage |
|---|---|---|
| `new-device.sh` | §10 device-profile scaffolding | `new-device.sh <codename> "<Display Name>" [SoC vendor] [SoC model]` |
| `check-tools.sh` | §7 tool reference | `check-tools.sh` — reports which CLI tools are installed, with install hints for what's missing |
| `unpack-boot.sh` | §1.3 boot.img unpacking | `unpack-boot.sh <boot.img> [out-dir]` — splits kernel/ramdisk/dtb and decompiles the DTB to `.dts` |
| `extract-kernel-config.sh` | §1.4 kernel config recovery | `extract-kernel-config.sh <kernel-image> [output.config]` — caches a shallow clone of `torvalds/linux` for `extract-ikconfig` |
| `dump-vendor-partition.sh` | §1.5 vendor/system partition extraction | `dump-vendor-partition.sh <image> <out-dir>` — auto-detects sparse/ext4/EROFS and converts/mounts/extracts accordingly |

## Typical flow for a new device

```bash
# 1. Scaffold the profile
./scripts/new-device.sh my-device "My Device Name" Qualcomm "Snapdragon 8 Gen 2 (SM8550)"

# 2. Check what's installed before you need it
./scripts/check-tools.sh

# 3. Once you have boot.img / vendor.img / a kernel image (per §1.1,
#    including the BootROM-mode tool for your SoC vendor, §9):
./scripts/unpack-boot.sh boot.img devices/my-device/boot_out/
./scripts/extract-kernel-config.sh devices/my-device/boot_out/kernel devices/my-device/kernel.config
./scripts/dump-vendor-partition.sh vendor.img devices/my-device/vendor_mnt/
```

Then fill in `devices/my-device/profile.md` §3 onward with what you found
(real `compatible` strings from `devices/my-device/boot_out/device.dts`,
driver list from `devices/my-device/vendor_mnt/lib*/modules/`, etc.) and
move on to [02-reverse-engineering-ghidra.md](../02-reverse-engineering-ghidra.md)
for anything without a public source.

## Why not automate §2-§6 too

RE work (§2) is inherently manual — a script can't decide which register
writes matter. The kernel/DT port (§4), userspace strategy (§5), and
boot-image repacking (§6) all depend on per-device judgment calls the
hardware inventory (§3) feeds into; scripting those would mean hiding
the decisions this guide exists to help you make. If a mechanical,
judgment-free step shows up repeatedly across devices, add a script for
it here rather than before that.
