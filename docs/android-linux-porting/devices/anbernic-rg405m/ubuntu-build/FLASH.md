# RG405M — flashing the mainline Linux SD image

> Sanitized for public release: internal hostnames removed. The build host is
> referred to as "the host"; artifacts live under `$BUILD` on it.

All artifacts are under `$BUILD/` on the host.

| File | sha256 (short) | Goes where |
|---|---|---|
| `rg405m-ubuntu-sdcard.img` (4.2 GB) | `24d428fe…` | the microSD card (custom U-Boot spliced into p1) |
| `splloader_nosec.img` (128 KiB) | `430f1c8d…` | eMMC **`splloader`** partition via `spd_dump` |
| `splloader_stock_backup.img` (61956 B) | `c8e9fb78…` | **stock SPL backup** — restore target |
| `spl_a_nosec.img` / `spl_b_nosec.img` (4 MiB) | `ea8e7b76…` | raw packer output; **do not flash directly** — 4 MiB would overrun the 256 KiB `splloader` partition. `splloader_nosec.img` is the first 128 KiB of this (full ~53 KiB DHTB image + zero pad). |
| `uboot_rg405m.img` (3 MB) | | already inside the SD image p1 |

Boot chain once flashed: BootROM → **custom SPL** (eMMC `splloader`) → **custom U-Boot** (SD p1)
→ `extlinux` picks SD `mmc 1:2` first → our `Image` + `ums512-rg405m.dtb`
→ Ubuntu on the SD card p3. With no card inserted, the SPL falls through to eMMC
and GammaOS still boots.

## Device facts confirmed (session "bootloader")

- SoC exposes a **single `splloader` partition, size `0x40000` (256 KiB)** — there
  is no `spl_a` / `spl_b` pair on this unit.
- FDL/BootROM download mode **works**; `spd_dump` connects (`BSL_REP_VER "SPRD3"`),
  gets past the BROM check, loads FDL1/FDL2. Unsigned (`nosec`) images are accepted
  in this path, so the `signed` build is **not** required.
- Stock `splloader` backed up to `$BUILD/splloader_stock_backup.img` (61956 B,
  DHTB header, sha `c8e9fb78…`). A second copy is kept on a separate host.

## 1. Write the SD card

Readback sha `24d428fe…` verified. Partitions:
`p1` 16M (U-Boot) · `p2` 128M vfat `RGROTATE_BT` (Image + dtb + initramfs + extlinux)
· `p3` 4G ext4 `rgrotate-root` (Ubuntu 24.04).

To redo: `sudo dd if=$BUILD/rg405m-ubuntu-sdcard.img of=/dev/sdX bs=4M conv=fsync status=progress`
(`sdX` = the reader — check `lsblk` first).

## 2. Flash the SPL to eMMC  (run on the host, RG405M on USB)

1. **Power the RG405M off completely** (hold power, shut down — not just screen off).
2. Start `spd_dump` first so it is waiting:

   ```sh
   cd $BUILD/rg-rotate-linux/tools/spd_dump
   sudo ./spd_dump --wait 600 keep_charge 1 \
     fdl $BUILD/tools/fdl/fdl1-dl.bin 0x5500 \
     fdl $BUILD/tools/fdl/fdl2-dl.bin 0x9EFFFE00 exec \
     read_part splloader 0 0x40000 $BUILD/splloader_stock_backup2.img \
     write_part splloader $BUILD/splloader_nosec.img \
     poweroff
   ```

3. When it prints **`Waiting for … connection`**, hold **POWER + VOL-DOWN + BACK**
   together and plug USB into the host. Keep holding until it starts printing
   `CHECK_BAUD` / FDL / partition progress.

That one line: re-backs-up the stock SPL (to `…_backup2.img`, keep as a check
against the first backup), writes the 128 KiB `nosec` SPL, powers off.

### If `write_part splloader` is rejected (signature / secure-boot)

Recoverable, not bricked — the BootROM just drops back to download mode. Restore
stock and rethink: `write_part splloader $BUILD/splloader_stock_backup.img`.
The `signed` path needs Unisoc `rsa2048_0.pem` + `sprd_sign` (not vendored):
`cd $BUILD/rg-rotate-linux/src/spl && PATH=~/.local/xbin:$PATH CROSS_COMPILE=aarch64-linux-gnu- ./build.sh signed`.

## 3. Boot

Insert the microSD, power on. USB-C enumerates a CDC-ACM console
(`/dev/ttyACM0` on the host) — autologin root, this board has no broken-out UART.
NetworkManager auto-joins the baked Wi-Fi profile (set your own SSID/PSK); SSH
root/password enabled (dev image — set a password on first login).

Watch for:
- **Boots to Ubuntu** → `/dev/ttyACM0`, send `dmesg`.
- **`spd_dump` error on `write_part splloader`** → paste it; restore stock, try `signed`.
- **Screen dark, no `ttyACM0`, GammaOS doesn't boot either** → hold POWER+VOL-DOWN+BACK,
  reconnect USB, `write_part splloader $BUILD/splloader_stock_backup.img`, `poweroff`.

## Recovery

Stock GammaOS is otherwise untouched on eMMC — only `splloader` is rewritten.
Keep the stock SPL backup (`splloader_stock_backup.img`, plus a copy on a second
host). BootROM download mode is always reachable via POWER+VOL-DOWN+BACK.
