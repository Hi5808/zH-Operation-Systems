# 17. Reversible Development & Dual-Boot

The fastest way to port a device is to make mistakes cheap. Every
technique here keeps stock Android intact and recovery one step away, so
a bad kernel costs you a reboot, not a reflash — or a brick. This is the
operational complement to §12 (restore) and the discipline behind §4.9's
iteration loop.

## 17.1 The cost ladder, cheapest first

Prefer the highest rung that works on your device:

1. **RAM-boot, nothing written.** `fastboot boot boot-new.img` loads your
   kernel+ramdisk into RAM and boots it once; a power-cycle returns to
   stock. This is the ideal iteration loop — no partition is touched.
   Limits: only boots a `boot` image, so on v3/v4 devices it can't test a
   `vendor_boot` DTB change (§6.2.2); and some bootloaders disable it.
2. **Boot from removable media.** Put your kernel + rootfs on a microSD
   card (or USB-OTG), leave eMMC untouched, and have the bootloader
   prefer the card. Card in → your Linux; card out → stock Android. This
   is the RGOS pattern (§8), and it's the best default for extended
   development: recovery is physically pulling the card.
3. **A/B slot abuse.** On A/B devices, flash your work to the *inactive*
   slot and boot it with `fastboot set_active`. Stock stays in the other
   slot; `set_active` back is the undo. Costs a flash per iteration but
   never risks the known-good slot.
4. **Flash the real partition.** Only once a build is stable. Back up
   first (§12), every time.

## 17.2 Boot-from-SD in practice

What makes rung 2 work is getting the bootloader to choose the card. The
mechanism is device-specific, but the shapes recur:

- **Bootloader already probes external media** (many U-Boot-based and
  some tablet bootloaders): drop a kernel + `extlinux.conf` (or the
  bootloader's expected layout) on a FAT partition and it boots. RGOS
  does exactly this — a GPT partition the SoC's U-Boot recognizes, FAT
  `/boot` with `Image` + `extlinux`, ext4 root, `root=/dev/mmcblk...`.
- **Bootloader doesn't look at the card by default:** you may need to
  flash a *bootloader* that does (the one genuinely higher-risk step —
  back up the stock bootloader first, §12), or chain-load from a minimal
  boot image that pivots to the card.
- **Pick the root device carefully.** The card enumerates as a different
  `mmcblkN` than eMMC; `root=` must point at the card's rootfs, and a
  `PARTUUID=`/`PARTLABEL=` root is more robust than a bare `mmcblkNpM`
  that can renumber.

The payoff: stock Android on eMMC is never modified, so the §12 "verify
your restore path" gate is satisfied by construction — the restore path
is "remove the card."

## 17.3 Keep iterations honest

- **One change per boot** (§4.9, §11.6) — otherwise a fix and a
  regression cancel out invisibly.
- **Serial console attached** (§15) so a RAM-boot that never reaches
  userspace still tells you why.
- **Log what each attempt changed and did** in `re-notes.md` as you go;
  "I'm sure I already tried that" is almost always wrong three days in.
- **Snapshot known-good images** by build identifier. When attempt N
  boots and N+3 doesn't, you want to diff against the last image that
  worked, not reconstruct it from memory.

## 17.4 When reversibility isn't available

Some devices force eMMC writes to test anything (no RAM-boot, no
bootable external media, no A/B). There, every iteration is a §12
backup-and-restore cycle, so:

- Make each flash count — validate harder before committing (§4.9).
- Keep the BootROM unbrick path tested and within reach (§9.7) because
  you *will* lean on it.
- Treat a known eMMC write hazard (the §8 RGOS ADMA bug is the cautionary
  tale) as a reason to get onto removable media *somehow* before trusting
  the device's own storage with your rootfs.

## Next

→ [18-validation-and-testing.md](18-validation-and-testing.md) — once a
build boots, how to confirm each subsystem actually works rather than
merely probes.
