# 1. Firmware Dumping & Partition Extraction

Goal: get every partition that matters off the device (or out of an OTA
package) as a plain file you can inspect, and recover the kernel/DTB/modules
in a form a disassembler or kernel build can consume.

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
  - EDL / test-point dumps (Qualcomm) via `qdl`/`QFIL`/`edl.py` if the
    device is otherwise unbootable — gives you *every* partition
    including ones Android never exposes.
- **Factory/engineering images** some vendors publish (Google Pixel,
  Sony Xperia "unlockable bootloader" program, Xiaomi EU/global ROM
  mirrors, etc.).

## 1.2 Unpacking an OTA payload

```bash
# Extract payload.bin from the OTA zip
unzip ota.zip payload.bin

# Use Android's own payload dumper (AOSP update_engine / android-ota-payload-dumper)
pip install update-payload-extractor   # or use: https://github.com/vm03/payload_dumper
python payload_dumper.py payload.bin   # dumps boot.img, vendor.img, system.img, dtbo.img, ...
```

## 1.3 Unpacking boot.img / recovery.img (kernel + ramdisk + DTB)

```bash
# AOSP tool, handles most Android Boot Image Header v0-v4 formats
pip install unpack_bootimg   # https://github.com/osm0sis/Android-Image-Kitchen is the classic alternative
unpack_bootimg --boot_img boot.img --out boot_out/
#   boot_out/kernel        -> raw kernel (zImage/Image.gz/Image, maybe gzip/lz4 compressed)
#   boot_out/ramdisk       -> initramfs cpio (usually gzip)
#   boot_out/dtb           -> device tree blob(s), sometimes appended to kernel

# For devices that append DT to the kernel image, split them:
python split_bootimg.py kernel          # or use `extract-dtb` (https://github.com/PabloCastellano/extract-dtb)
extract-dtb kernel -o dtb/

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
simg2img vendor_sparse.img vendor.img          # android sparse -> raw, if sparse
mkdir vendor_mnt && sudo mount -o loop vendor.img vendor_mnt/   # ext4
# or for EROFS (common on newer devices):
fsck.erofs --extract=vendor_mnt vendor.img     # https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
```

Inside `vendor/lib(64)/hw/`, `vendor/lib(64)/`, and `vendor/firmware/` you
will find the HAL `.so` files, closed-source kernel `.ko` modules
(`vendor/lib/modules/`), and firmware blobs (Wi-Fi/BT NVRAM, modem
firmware, DSP images, trustzone images) — these are your Ghidra targets and
the blobs you'll later load from the Halium shim or flash as-is.

## 1.6 Modem / TrustZone / other "radio" partitions

On Qualcomm devices, also grab `modem`, `tz`, `hyp`, `keymaster`, `abl`,
`xbl`, `devcfg`, `dsp` partitions — these never change OS and can usually be
reused verbatim on the ported Linux system (the applications processor's OS
doesn't talk to the modem directly; it's a separate SoC core managed via a
shared-memory protocol like QMI/RMNET, which you reimplement or reuse from
`oFono`/`ModemManager`/`rmtfs`/`qrtr` userspace tooling — see
[05-rootfs-and-userspace.md](05-rootfs-and-userspace.md)).

## Next

→ [02-reverse-engineering-ghidra.md](02-reverse-engineering-ghidra.md) to
start decompiling the kernel modules and HALs you just extracted.
