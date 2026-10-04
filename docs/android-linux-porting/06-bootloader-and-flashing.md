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
mkbootfs rootfs/ | gzip > ramdisk.img          # if you need an Android-style
                                                # ramdisk stage (Halium ports
                                                # usually do, to pivot into the
                                                # real rootfs)

mkbootimg \
  --kernel out/arch/arm64/boot/Image.gz \
  --ramdisk ramdisk.img \
  --dtb out/arch/arm64/boot/dts/<vendor>/<board>.dtb \
  --cmdline "console=ttyMSM0,115200n8 root=/dev/sda1 rw" \
  --base 0x80000000 \
  --kernel_offset 0x8000 --ramdisk_offset 0x1000000 --tags_offset 0x100 \
  --header_version 2 \
  -o boot-new.img
```

Match `--base`/offsets/`--header_version` to what `unpack_bootimg`
reported for the *original* `boot.img` (§1.3) — the bootloader expects the
same header version and memory layout unless you've also patched the
bootloader itself.

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
heimdall flash --BOOT boot-new.img --no-reboot
heimdall flash --DTBO dtbo-new.img
heimdall reboot
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

Before your first flash of anything:

```bash
# Full backup of every partition touched, so a bad flash is a `fastboot
# flash <part> backup.img` away from recovery, not a brick:
for p in boot dtbo vendor_boot vbmeta vbmeta_system; do
  adb shell su -c "dd if=/dev/block/by-name/$p of=/sdcard/backup_$p.img"
done
adb pull /sdcard/  ./backups/
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
it is not, by itself, your unbrick path if it can't write.

## Next

→ [07-tools-reference.md](07-tools-reference.md) for the consolidated
tool list, [08-case-studies.md](08-case-studies.md) for real projects that
followed this exact pipeline, and
[09-soc-vendor-specifics.md](09-soc-vendor-specifics.md) for the
per-vendor detail referenced throughout this chapter.
