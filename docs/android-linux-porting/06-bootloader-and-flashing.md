# 6. Bootloader, Boot Chain & Flashing

## 6.1 Respect the secure/verified boot chain where you can't bypass it

Every vendor's boot chain follows the same shape, just with different
stage names — a BootROM, one or two SoC-vendor-signed early-boot stages,
then a more flexible bootloader stage that's the actual flashing/boot
interface:

| Vendor | Chain | Flashing interface it hands off to |
|---|---|---|
| Qualcomm | `PBL → SBL/XBL → ABL` | `fastboot` |
| MediaTek | `BROM → Preloader → LK` | `fastboot` (where present) |
| Samsung Exynos | `iROM → BL1 → BL2 → sboot` | Odin protocol (`Heimdall`), sometimes also `fastboot` |
| Allwinner | `BootROM → boot0 → U-Boot` | `fastboot` or `sunxi-tools` FEL |
| Rockchip | `BootROM → idbloader → U-Boot` | `fastboot` or `rkdeveloptool` |
| NVIDIA Tegra | `BootROM → NV-TBOOT/U-Boot` | `fastboot` or `nvflash`/`tegrarcm` |

On devices with an unlockable bootloader, the chain from the last
vendor-controlled stage onward (ABL/LK/sboot/U-Boot) trusts whatever you
flash to `boot`/`dtbo`/equivalent, so you don't need to touch the earlier,
harder-to-RE stages (early SBL/Preloader/BL1/BL2, TrustZone/TEE) at all —
leave them exactly as dumped. See
[09-soc-vendor-specifics.md](09-soc-vendor-specifics.md) for exactly which
stage is "the one fastboot/Odin/U-Boot talks to" for your vendor.

If the device has **no unlock mechanism** at all, that's a hardware
security boundary, not a software porting problem — this guide assumes a
device you can legitimately unlock (OEM unlock toggle, vendor unlock tool,
or a documented BootROM-mode method for that SoC, per §9). Bypassing a
locked bootloader's cryptographic verification is out of scope here.

## 6.2 Repacking the boot image

```bash
# After building Image.gz + dtbs (§4.5) and your initramfs/rootfs (§5):
(cd rootfs && find . | cpio -o -H newc) | gzip > ramdisk.img   # if you need an Android-style
                                                # ramdisk stage (Halium ports
                                                # usually do, to pivot into the
                                                # real rootfs)

# The cmdline below is a Qualcomm/UFS example; console device and root
# path vary per SoC and storage type.
mkbootimg \
  --kernel out/arch/arm64/boot/Image.gz \
  --ramdisk ramdisk.img \
  --dtb "out/arch/arm64/boot/dts/$VENDOR/$BOARD.dtb" \
  --cmdline "console=ttyMSM0,115200n8 root=/dev/sda1 rw" \
  --base 0x80000000 \
  --kernel_offset 0x8000 --ramdisk_offset 0x1000000 --tags_offset 0x100 \
  --header_version 2 \
  -o boot-new.img
```

Match `--base`/offsets/`--header_version` to what `unpack_bootimg`
reported for the *original* `boot.img` (§1.3) — the bootloader expects the
same header version and memory layout unless you've also patched the
bootloader itself. Recent versions of AOSP's `unpack_bootimg` can print
the original image's parameters directly as `mkbootimg` arguments
(`--format=mkbootimg`), which avoids transcription mistakes. Also copy
`--os_version`/`--os_patch_level` from the stock image rather than
leaving them empty.

### 6.2.1 Which layout your device uses

The boot image header version decides where the kernel, ramdisk and DTB
go. Read it from the stock image before building anything:

| Header | Typical devices | Where the DTB goes | Notes |
|---|---|---|---|
| v0 / v1 | Older devices (roughly Android 9 and earlier) | **Appended to the kernel** (`cat Image.gz <board>.dtb > Image.gz-dtb`), not a `--dtb` argument | v1 adds a recovery DTBO field; many bootloaders also read a separate `dtbo` partition. |
| v2 | Android 10-era devices | `--dtb` in `boot.img` (as above) | Base/offsets still come from the header. |
| v3 / v4 | Android 11+ launches, GKI devices | In **`vendor_boot`**, not `boot` | `boot.img` holds only kernel + generic ramdisk with a fixed layout; base, offsets, DTB, vendor ramdisk and vendor cmdline move to `vendor_boot`. |

### 6.2.2 Repacking a v3/v4 pair

On v3/v4 devices you rebuild **two** images, and the final kernel command
line is the concatenation of the vendor cmdline (in `vendor_boot`) and
the boot cmdline:

```bash
# Set these from the stock images first, e.g. via
# unpack_bootimg --format=mkbootimg on boot.img and vendor_boot.img:
# OS_VERSION, OS_PATCH_LEVEL, BOOT_CMDLINE, VENDOR_CMDLINE, BASE, PAGESIZE, DTB
mkbootimg \
  --header_version 4 \
  --kernel out/arch/arm64/boot/Image.gz \
  --ramdisk generic-ramdisk.img \
  --os_version "$OS_VERSION" --os_patch_level "$OS_PATCH_LEVEL" \
  --cmdline "$BOOT_CMDLINE" \
  -o boot-new.img

mkbootimg \
  --header_version 4 \
  --vendor_ramdisk vendor-ramdisk.img \
  --dtb "$DTB" \
  --vendor_cmdline "$VENDOR_CMDLINE" \
  --base "$BASE" --pagesize "$PAGESIZE" \
  --vendor_boot vendor_boot-new.img
```

- Flash or RAM-boot both together. A new `boot` with a stock
  `vendor_boot` (or vice versa) mixes kernels with mismatched DTBs and
  modules.
- `fastboot boot` RAM-boots only a `boot` image. On v3/v4 devices,
  testing a DTB change means flashing `vendor_boot`, so back it up first
  (§6.5, §12).
- On GKI devices, the stock vendor ramdisk contains the vendor kernel
  modules (§4.7). If you replace the kernel, those modules won't load,
  so plan the vendor ramdisk contents accordingly.

## 6.3 vbmeta / AVB considerations

If the device enforces Android Verified Boot (AVB) even with an unlocked
bootloader (common on newer devices — unlocking disables the *enforcement*
but the bootloader may still check a flag), you'll typically need:

```bash
fastboot flash vbmeta --disable-verity --disable-verification vbmeta.img
# or flash a vbmeta.img you've re-signed with the AOSP `avbtool` using the
# device's "test" key path, per the vendor's unlock documentation.
```

Each vendor documents their own AVB handling for unlocked devices; follow
theirs rather than trying to defeat verification outright.

## 6.4 Flashing

```bash
fastboot flash boot boot-new.img
fastboot flash dtbo dtbo-new.img         # if the device uses a separate dtbo partition
fastboot flash vendor_boot vendor_boot-new.img   # newer Android GKI devices split boot further
fastboot flash userdata rootfs.img       # or keep Android's userdata and overlay your rootfs on it

fastboot reboot
```

On devices that don't expose standard `fastboot` (many Samsung Exynos
models), use **Heimdall** against Odin download mode instead:

```bash
heimdall print-pit                        # partition names come from the device's PIT, not a fixed list
heimdall flash --BOOT boot-new.img --DTBO dtbo-new.img   # reboots when done unless --no-reboot
```

And on Allwinner/Rockchip/Tegra tablet-class devices, the equivalent is
`sunxi-fel`, `rkdeveloptool`, or `nvflash` respectively (§9.6) — same
concept, different wire protocol.

Prefer a RAM-boot option (`fastboot boot boot-new.img`, or the
equivalent "boot without flashing" mode for your tool) for every
iteration until the port is solid, and only commit to a real flash once
it's stable — this avoids needing a full re-flash or BootROM-mode
recovery cycle after every kernel tweak.

## 6.4.1 GPT partition-table considerations

Most modern devices of every vendor use a standard GPT partition table on
the storage device, which means standard Linux tools work for inspection
even outside any vendor-specific tool:

```bash
sudo sgdisk -p /dev/sdX        # or: parted /dev/sdX print
                                # (only meaningful if you've dumped the
                                # raw storage device itself, e.g. via a
                                # BootROM-mode full dump, §9 — not
                                # something you do over a live adb shell)
```

If you need to **add** a partition for your Linux rootfs rather than
reusing an existing Android partition (e.g. repurposing `userdata`),
resize/add it with `sgdisk`/`parted` against your *backed-up* raw image,
never against the live device directly, and re-flash the whole modified
image via your SoC's BootROM-mode tool rather than trying to resize a
live GPT table through `fastboot`.

## 6.5 Recovery plan

Before your first flash of anything, back up every partition you're
about to touch and verify you can actually restore from that backup —
see [12-oem-restore.md](12-oem-restore.md) for the full procedure and
[scripts/backup-partitions.sh](scripts/backup-partitions.sh) /
[scripts/restore-oem.sh](scripts/restore-oem.sh) to automate it:

```bash
./scripts/backup-partitions.sh devices/<codename>/backups boot dtbo vendor_boot vbmeta vbmeta_system
```

Know your SoC's unbrick path — EDL for Qualcomm, BROM for MediaTek, Odin
download mode for Samsung Exynos, FEL/maskrom/APX for
Allwinner/Rockchip/Tegra (full table in
[09-soc-vendor-specifics.md](09-soc-vendor-specifics.md) §9.7) — *before*
you need it, and confirm **both** that you can enter it on this exact
device (test the button combo/mode) **and** that it actually grants
write access on this device's chip-level authentication state, not just
read — §9.7's caveat on BROM/EDL/Odin not being a universal read/write
bypass applies directly here. A recovery mode that only lets you read
back partitions is still useful for verifying what's on the device, but
it is not, by itself, your unbrick path if it can't write. The round-trip
test in [12-oem-restore.md](12-oem-restore.md) §12.5 is how you confirm
this *before* you're relying on it.

## Next

→ [07-tools-reference.md](07-tools-reference.md) for the consolidated
tool list, [08-case-studies.md](08-case-studies.md) for real projects that
followed this exact pipeline, and
[09-soc-vendor-specifics.md](09-soc-vendor-specifics.md) for the
per-vendor detail referenced throughout this chapter.
