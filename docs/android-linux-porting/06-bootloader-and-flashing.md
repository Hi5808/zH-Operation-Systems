# 6. Bootloader, Boot Chain & Flashing

## 6.1 Respect the secure/verified boot chain where you can't bypass it

Most Android bootloaders chain-load: `PBL -> SBL/XBL -> ABL/LK -> boot.img
(kernel+ramdisk) or kernel+DTB`. On devices with an unlockable bootloader
(`fastboot oem unlock` / `fastboot flashing unlock`), the chain from
`ABL`/`LK` onward trusts whatever you flash to `boot`/`dtbo`, so you don't
need to touch the earlier, harder-to-RE stages (`xbl`, `tz`, `hyp`) at all
— leave them exactly as dumped.

If the device has **no unlock mechanism** at all, that's a hardware
security boundary, not a software porting problem — this guide assumes a
device you can legitimately unlock (OEM unlock toggle, vendor unlock tool,
or a documented EDL/test-point method for that SoC). Bypassing a locked
bootloader's cryptographic verification is out of scope here.

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

Prefer `fastboot boot boot-new.img` (RAM-boots the image without writing
any partition) for every iteration until the port is solid, and only
`fastboot flash` once it's stable — this avoids needing a full re-flash or
EDL recovery cycle after every kernel tweak.

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

Know your SoC's unbrick path (EDL for Qualcomm, BROM/Preloader mode for
MediaTek, Odin-download mode for Samsung Exynos) *before* you need it.

## Next

→ [07-tools-reference.md](07-tools-reference.md) for the consolidated
tool list, and [08-case-studies.md](08-case-studies.md) for real projects
that followed this exact pipeline.
