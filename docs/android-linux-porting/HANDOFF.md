# Handoff: Local Agent Checklist

This repo was written in a cloud session with **no physical device
access**. Everything that needs a real device, a real dump, or a USB
cable is on this one checklist. Steps are shared across both devices;
where a device differs, it's called out inline.

| | Blackview BL6000 Pro 5G | Anbernic RG405M |
|---|---|---|
| Folder | `devices/blackview-bl6000-pro-5g/` | `devices/anbernic-rg405m/` |
| SoC | MediaTek Dimensity 800 (MT6873) | UNISOC Tiger T618 |
| Unlock method | Standard Android OEM-unlock toggle + fastboot (confirmed by community) | UNISOC-specific: `unisoc-unlock` or GammaOS web tool (confirmed by GammaOS docs) |
| Dump/flash tool | `mtkclient` (BROM) or SP Flash Tool | GammaOS Next flasher / `unisoc-unlock` |
| Biggest open question | Does BROM give **write** access? (SLA/DAA unknown) | Does unlock grant arbitrary partition read/write, or only GammaOS's install flow? |
| Prior art to start from | None device-specific; request GPL source from Blackview | GammaOS Next `v.1.1.0-ANBERNICT618` |

All commands below run from `docs/android-linux-porting/`. Replace
`$DEV` with the device folder name from the table.

## 0. Machine setup (once)

- [ ] `./scripts/check-tools.sh` — install whatever's missing.
- [ ] Both: `adb`, `fastboot`.
- [ ] Blackview: `mtkclient` + its OS-specific USB setup (udev rules on
      Linux / driver on Windows — follow its README).
- [ ] Anbernic: `pip3 install unisoc-unlock`; clone
      `github.com/TheGammaSqueeze/GammaOSNext`; on Windows, install the
      UNISOC drivers bundled with the GammaOS release.

## 1. Catalog what's already on the laptop (no device needed)

- [ ] Run `catalog-dump.sh` against the existing dump files, recording
      which tool produced them:
      ```bash
      ./scripts/catalog-dump.sh devices/$DEV/backups <tool-used> \
        boot=/path/boot.img vendor=/path/vendor.img dtbo=/path/dtbo.img ...
      ```
- [ ] Sanity-check the manifest without touching any device:
      ```bash
      ./scripts/restore-oem.sh devices/$DEV/backups/manifest.tsv --method plan-only
      ```
- [ ] **Confirm each dump came from *this* physical unit**, not a
      firmware-mirror download. IMEI/calibration partitions
      (`modemst1`/`modemst2`/`persist`/NV-equivalents) must never be
      restored from another unit (§12.4). The Anbernic has no modem, so
      this matters mainly for the Blackview.

## 2. Extract what the profile needs (no device needed)

- [ ] `./scripts/unpack-boot.sh devices/$DEV/backups/boot.img devices/$DEV/boot_out/`
- [ ] `./scripts/extract-kernel-config.sh devices/$DEV/boot_out/kernel devices/$DEV/kernel.config`
- [ ] `./scripts/dump-vendor-partition.sh devices/$DEV/backups/vendor.img devices/$DEV/vendor_mnt/`
- [ ] Anbernic only: also clone GammaOS's kernel/device tree and diff its
      DT against `boot_out/device.dts` — expect GammaOS's to be the more
      complete reference.

## 3. Fill in the profile (no device needed)

From the step-2 output, update `devices/$DEV/profile.md`:

- [ ] §3 hardware table — real `compatible` strings from
      `boot_out/device.dts`; driver list from `vendor_mnt/lib*/modules/`.
      Priority TBDs: Wi-Fi/BT chip model, touchscreen controller, PMIC
      (both); fingerprint vendor (Blackview); gamepad/Hall-stick ADC
      driver (Anbernic).
- [ ] §4 — reserved-memory regions from the `.dts`; note `kernel.config`
      location.
- [ ] §6 — `boot.img` header version/base/offsets from `unpack-boot.sh`
      output.

## 4. On-device checks (device connected)

- [ ] `adb shell getprop ro.board.platform` and `ro.hardware` → profile §Identity.
- [ ] `adb shell "su -c 'ls /dev/block/by-name/'"` (if rooted) → record
      the full partition list; back up anything not already in the
      manifest with `./scripts/backup-partitions.sh devices/$DEV/backups <partitions...>`.
- [ ] Confirm the unlock path matches what research found:
  - Blackview: is "OEM unlocking" in Developer Options? Which works —
    `fastboot flashing unlock` or `fastboot oem unlock`?
  - Anbernic: does the device show `LOCK FLAG IS : UNLOCK!!!` at boot?
    (If yes, it's already unlocked — skip the unlock step.)
  - ⚠ Unlocking wipes the device on both. Steps 1–3 must be done first.
    GammaOS Next install is fresh-install-only — it wipes regardless.

## 5. Prove read/write before relying on it

The single most important open item for both devices (§12.1, §12.5).

- [ ] **Read test:** dump one partition with the device's tool and
      confirm its sha256 matches the manifest.
  - Blackview: `mtkclient` read in BROM mode (check its README for
    current syntax — this guide won't assert it).
  - Anbernic: whatever read path GammaOS's tooling exposes.
- [ ] **Write round-trip** on a low-risk partition (`dtbo`):
      ```bash
      ./scripts/restore-oem.sh devices/$DEV/backups/manifest.tsv --method plan-only --only dtbo
      # then --method fastboot --only dtbo (dry run), then add --yes
      # or use the vendor tool's own write command per the plan
      ```
      Then confirm the device still boots normally.
- [ ] Record in profile.md's "Backups taken before first flash": Y/N,
      and which method actually worked. For the Blackview, this
      answers the SLA/DAA question; for the Anbernic, whether unlock
      access extends beyond GammaOS's own installer.

## 6. Bring results back

- [ ] `git status` — confirm no `.img`, `boot_out/kernel`/`ramdisk`,
      or `vendor_mnt/` content is staged. The root `.gitignore` blocks
      the default paths; anything written elsewhere won't be caught.
- [ ] Commit only: `profile.md`, `re-notes.md`, `kernel.config`,
      `boot_out/device.dts`, `backups/manifest.tsv`.
- [ ] Update the status column in `00-overview.md`'s "Devices tracked"
      table.
- [ ] Normal commit + push to this branch. No force-push.

## If reality doesn't match the profile

Expected — the profiles came from public specs and community reports,
not this exact unit. Update the profile with what's actually true;
a mismatch is a finding, not an error. See
[11-troubleshooting-and-debugging.md](11-troubleshooting-and-debugging.md)
for common cases.
