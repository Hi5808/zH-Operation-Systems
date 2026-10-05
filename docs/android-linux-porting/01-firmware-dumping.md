# 1. Firmware Dumping & Partition Extraction

Goal: get every partition that matters off the device (or out of an OTA
package) as a plain file you can inspect, and recover the kernel/DTB/modules
in a form a disassembler or kernel build can consume.

The mechanical parts of §1.3-§1.5 below are automated by
[scripts/unpack-boot.sh](scripts/unpack-boot.sh),
[scripts/extract-kernel-config.sh](scripts/extract-kernel-config.sh), and
[scripts/dump-vendor-partition.sh](scripts/dump-vendor-partition.sh) — see
[scripts/README.md](scripts/README.md). The manual commands are still
given below since the scripts are thin wrappers around exactly these
steps, not a black box.

## 1.1 Sources of firmware

- **OTA / full-firmware ZIP** from the vendor (easiest, most complete,
  no device access required). Modern Android OTAs are usually an A/B
  payload: `payload.bin` inside the zip.
- **Direct device dump**, when you have root or a bootloader-unlocked
  device:
  - `adb shell su -c "dd if=/dev/block/by-name/boot of=/sdcard/boot.img"`
    (repeat for `vendor`, `system`, `dtbo`, `vbmeta`, `persist`, modem
    partitions, etc. — enumerate with `ls -l /dev/block/by-name/`).
  - `fastboot` can't read partitions, only flash/erase, so prefer `dd`
    over a root shell or a custom recovery (TWRP) shell.
  - **BootROM-level recovery-mode dumps** — every major SoC vendor has a
    hardware-level download mode: Qualcomm's EDL (9008 mode, via
    `qdl`/`edl.py`/QFIL), MediaTek's BROM mode (via `mtkclient`),
    Samsung's Odin download mode (via Heimdall), or
    Rockchip/Allwinner/Tegra's maskrom/FEL/APX modes. See
    [09-soc-vendor-specifics.md](09-soc-vendor-specifics.md) §9.7 for the
    exact mode/tool/button-combo per vendor — **and read that section's
    caveat before relying on this**: these modes are *not* a universal
    read/write bypass independent of all lock state. Each vendor gates
    actual read/write access behind its own chip-level authentication
    (Qualcomm's Sahara/Firehose loader signing, MediaTek's SLA/DAA
    fusing, etc.), which is a separate thing from — and doesn't
    necessarily track — the Android-level bootloader-unlock toggle. On
    many older/budget devices this hardware-level mode is wide open
    regardless of Android unlock state (which is exactly why it's the
    preferred dump method there), but on a device with the chip's own
    authentication enforced, it may give read-only access, or need a
    chip-specific bypass that may or may not exist for your exact SoC.
    Confirm actual behavior for your device before planning around it.
- **Factory/engineering images** some vendors publish (Google Pixel,
  Sony Xperia "unlockable bootloader" program, Xiaomi EU/global ROM
  mirrors, etc.).

## 1.2 Unpacking an OTA payload

```bash
# Extract payload.bin from the OTA zip
unzip ota.zip payload.bin

# Community payload dumpers (pick one):
#   https://github.com/vm03/payload_dumper        (Python: python payload_dumper.py payload.bin)
#   https://github.com/ssut/payload-dumper-go     (Go binary: payload-dumper-go payload.bin)
# Both write boot.img, vendor.img, system.img, dtbo.img, ... to an output dir.
```

## 1.3 Unpacking boot.img / recovery.img (kernel + ramdisk + DTB)

```bash
# AOSP's unpack_bootimg handles Android Boot Image Header v0-v4. It lives in
# https://android.googlesource.com/platform/system/tools/mkbootimg (some
# distros also package it as part of "mkbootimg"). Android-Image-Kitchen
# (github.com/osm0sis/Android-Image-Kitchen) is the classic alternative.
unpack_bootimg --boot_img boot.img --out boot_out/
#   boot_out/kernel        -> raw kernel (zImage/Image.gz/Image, maybe gzip/lz4 compressed)
#   boot_out/ramdisk       -> initramfs cpio (usually gzip)
#   boot_out/dtb           -> device tree blob(s), sometimes appended to kernel

# For devices that append DT(s) to the kernel image, split them out with
# extract-dtb (https://github.com/PabloCastellano/extract-dtb):
extract-dtb boot_out/kernel -o dtb/

# Decompile DTB to human-readable .dts source
dtc -I dtb -O dts -o device.dts dtb/00_kernel.dtb
```

## 1.4 Recovering the exact kernel config

Most Android kernels build `/proc/config.gz` into the kernel image or ship
it in `vendor/etc`. Pull it directly if the device is bootable:

```bash
adb shell "zcat /proc/config.gz" > kernel.config

# If unavailable, extract from the raw kernel binary (works even unbooted):
git clone https://github.com/torvalds/linux && cd linux
scripts/extract-ikconfig ../kernel > ../kernel.config
```

This `.config` is one of the most valuable artifacts: it tells you exactly
which drivers, subsystems, and out-of-tree modules (`CONFIG_*_MODULE=y`) the
vendor kernel enables, which narrows what you need to reverse engineer.

## 1.5 Pulling vendor/system partitions for userspace blobs

```bash
# system.img / vendor.img are usually sparse ext4 or erofs
simg2img vendor_sparse.img vendor.img          # android sparse -> raw, if sparse (Debian: android-sdk-libsparse-utils)
mkdir vendor_mnt && sudo mount -o loop vendor.img vendor_mnt/   # ext4
# or for EROFS (common on newer devices):
fsck.erofs --extract=vendor_mnt vendor.img     # erofs-utils >= 1.5 (distro package: erofs-utils)
```

Inside `vendor/lib(64)/hw/`, `vendor/lib(64)/`, and `vendor/firmware/` you
will find the HAL `.so` files, closed-source kernel `.ko` modules
(`vendor/lib/modules/`), and firmware blobs (Wi-Fi/BT NVRAM, modem
firmware, DSP images, trustzone images) — these are your Ghidra targets and
the blobs you'll later load from the Halium shim or flash as-is.

## 1.6 Modem / TrustZone / other "radio" partitions

Also grab every secure-world/co-processor partition your SoC vendor uses
— on Qualcomm that's `modem`, `tz`, `hyp`, `keymaster`, `abl`, `xbl`,
`devcfg`, `dsp`; MediaTek, Exynos, and others have their own equivalents
(see [09-soc-vendor-specifics.md](09-soc-vendor-specifics.md) for naming).
These never change OS and can usually be reused verbatim on the ported
Linux system — the applications processor's OS doesn't talk to the modem
directly on any vendor; it's a separate core managed via a shared-memory
protocol (QMI on Qualcomm, vendor-specific elsewhere), which you reuse
from `oFono`/`ModemManager`/`rmtfs`/`qrtr` userspace tooling where a
compatible protocol stack exists — see
[05-rootfs-and-userspace.md](05-rootfs-and-userspace.md).

## 1.7 Dealing with eMMC vs. UFS storage

- **eMMC** devices expose partitions as `/dev/block/mmcblk0p*`; `dd` and
  the BootROM-mode tools above work uniformly.
- **UFS** devices (most modern flagships) expose
  `/dev/block/sd*`/`/dev/block/by-name/*` via the SCSI/UFS stack; dumping
  mechanics are identical from a tooling perspective, but note that UFS
  (like eMMC) has a replay-protected memory block (RPMB) area used for
  secure storage (e.g. Keymaster/StrongBox key material) — this is
  normally inaccessible and irrelevant to the port; don't expect to dump
  or need it.

## Next

→ [02-reverse-engineering-ghidra.md](02-reverse-engineering-ghidra.md) to
start decompiling the kernel modules and HALs you just extracted.
