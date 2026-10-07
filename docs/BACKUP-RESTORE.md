# Full Backup & Restore via BROM

## Why this works even if Ubuntu bricks the phone

**BROM** (Boot ROM) is code burned into the MediaTek SoC at manufacture. It
runs *before* the preloader, the bootloader, and any OS. It is **mask ROM**, so:

- It cannot be erased or overwritten by flashing.
- It always responds to `mtkclient`, no matter what is (or isn't) on the flash.
- The only requirements are a working SoC and entering BROM mode
  (**power off → hold Volume-Up while plugging in USB**).

Because the bootloader is **unlocked**, the BROM write-protection is disabled,
so we have full read **and** write access. That makes this backup a genuine
"unbrickable" recovery point.

> The one thing that would break this is a **hardware** failure. Software,
> however, is always recoverable via BROM.

---

## What gets backed up

`backup-all.sh` reads **every partition** via `mtkclient rl`, except `userdata`
(which is hundreds of GB and is wiped on restore anyway). That includes:

- Boot chain: `preloader`, `lk`, `lk2`, `boot`, `recovery`, `dtbo`, `vbmeta*`
- OS: `super` (system + vendor + product), `cache`
- Firmware: `md1img` (modem), `cam_vpu*`, `scp*`, `sspm*`, `mcupm*`, `spmfw`, `gz*`, `tee*`
- Device identity: `nvram`, `nvdata`, `nvcfg`, `persist`, `protect1/2`, `proinfo`, `seccfg`, `otp`, `frp`, `logo`, `misc`, `para`, `expdb`
- GPT: `pgpt`, `sgpt`

Plus a text dump of the **partition table** and **device info** for reference.

---

## Creating the backup

1. Power the phone **off**.
2. Hold **Volume-Up** and plug in the USB cable (keeps it in BROM mode).
3. Run:

```bash
MTKCLIENT_DIR=/tmp/mtkclient \
BACKUP_DIR=$HOME/bl6000pro-backup \
    ./scripts/backup-all.sh
```

4. Generate checksums so you can verify integrity later:

```bash
cd $HOME/bl6000pro-backup
sha256sum *.img > SHA256SUMS
```

5. **Copy the backup off this machine** (external drive / another host). A
   backup stored on the machine you're modifying is not a real backup.

---

## Restoring

1. Put the phone back in **BROM mode** (power off → hold Volume-Up → plug USB).
2. Run:

```bash
MTKCLIENT_DIR=/tmp/mtkclient \
BACKUP_DIR=$HOME/bl6000pro-backup \
    ./scripts/restore-all.sh
```

3. Type `YES` when prompted. `mtkclient wl` writes every image back to its
   partition, then the device is reset.

The device should boot back into stock Android 11.

---

## Notes & caveats

- **Restore only your own dump.** `nvram` / `nvdata` / `persist` contain
  device-specific calibration and IMEI. Flashing someone else's copy can
  corrupt radio calibration.
- If `wl` complains about a missing partition, it usually means the on-device
  GPT doesn't contain that name — this is normal for a few vendor partitions
  and can be ignored, or handled with `mtk.py w <part> <file>` individually.
- To restore a **single** partition (e.g. only `boot`):

  ```bash
  python3 mtk.py w boot /path/to/backup/boot.img
  ```

- **Whole-flash image (optional, ~full eMMC size):** if you want an
  image-level copy that also survives GPT damage, use
  `python3 mtk.py rf fullflash.bin` / `wf fullflash.bin`. This is very large
  (the eMMC is ~256 GB), so it is usually unnecessary for development.

- **Alternative tool:** SP Flash Tool can also restore if you generate a
  scatter file. `mtkclient`'s GPT-driven `wl` is simpler and works from the
  same backup directory, so it is the recommended path here.
