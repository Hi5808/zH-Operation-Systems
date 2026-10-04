# 12. OEM/Stock Restore Procedures

Every risky operation in §4-§6 is only safe to attempt if you have a
tested, verified way back to stock. This chapter formalizes that as its
own workflow rather than leaving it as a one-off checklist item, and the
scripts in [scripts/](scripts/) automate the parts of it that are
mechanical.

**Read §12.1 before using the restore script.** It exists specifically
because "this recovery mode works regardless of lock state" is the kind
of claim that sounds right and isn't reliably true (see
[09-soc-vendor-specifics.md](09-soc-vendor-specifics.md) §9.7) — a
restore procedure you haven't verified can write is not a restore
procedure, it's a hope.

## 12.1 What this guide can and can't promise you

There are exactly two write paths this guide asserts with full
confidence, because their syntax is stable, official, and documented by
their own maintainers:

- **`fastboot flash <partition> <image>`** — works once the bootloader
  is unlocked. Cannot read a partition back for verification (AOSP
  limitation) — you only get to verify the source file's checksum before
  flashing, not the result after.
- **adb + root `dd`** — works once the device is booted and rooted.
  *Can* read back and verify after writing, which makes it the stronger
  of the two when both are available.

For every BootROM-mode tool (`mtkclient`, `Heimdall`, `qdl`,
`rkdeveloptool`, `sunxi-fel`, `nvflash`) — the tools §9 recommends
specifically *because* they can work before you have root or an unlocked
bootloader — this guide does **not** assert exact write-command flag
syntax, because:

1. Those tools' CLIs vary across versions and forks.
2. Whether they can write *at all* on your specific chip/firmware is
   gated by that vendor's own authentication (SLA/DAA, Sahara/Firehose
   loader signing, etc. — §9.7), which is unknowable from a doc, only
   from actually running the tool against the device.

So `restore-oem.sh` (§12.3) gives you a checksum-verified **plan** for
those tools — which file goes to which partition — and tells you to run
that vendor tool's own write command yourself, checked against its own
`--help`/docs for the version you actually have. Asserting a flag name
I haven't verified is exactly the mistake this chapter exists to avoid
repeating.

## 12.2 The manifest format

Both backup and restore scripts share one format: a tab-separated
`manifest.tsv` with one header row and one row per partition:

```
partition	file	sha256	size_bytes	source_method	timestamp_utc
boot	boot.img	<sha256>	<bytes>	adb-dd	2024-01-01T00:00:00Z
vendor_boot	vendor_boot.img	<sha256>	<bytes>	mtkclient	2024-01-01T00:05:00Z
```

- `file` is relative to the manifest's own directory — keep the manifest
  and the images together.
- `source_method` is a free-text record of how the file was obtained
  (`adb-dd`, or the name of whatever BootROM-mode tool you used) — it
  travels with the backup for your own future reference, it isn't acted
  on by the restore logic.
- Checksums are mandatory and checked before every restore attempt —
  `restore-oem.sh` refuses to flash a file whose hash doesn't match what
  was recorded at backup time (see §12.4 for why this matters beyond
  "detecting bit-rot").

## 12.3 The scripts

| Script | Purpose |
|---|---|
| [scripts/backup-partitions.sh](scripts/backup-partitions.sh) | Dumps a list of partitions via adb+root `dd`, builds the manifest |
| [scripts/catalog-dump.sh](scripts/catalog-dump.sh) | Builds/extends a manifest from partition image files you already have (e.g. from a BootROM-mode tool's own dump) — doesn't dump anything itself |
| [scripts/restore-oem.sh](scripts/restore-oem.sh) | Replays a manifest back onto the device: `fastboot` or `adb-dd` methods actually write; `plan-only` prints a checksum-verified plan for you to execute with your vendor tool |

```bash
# Path A: device is rooted and booted -- back up directly
./scripts/backup-partitions.sh devices/my-device/backups boot dtbo vendor_boot vbmeta vbmeta_system

# Path B: you already dumped via mtkclient/Heimdall/qdl/etc. onto your laptop
./scripts/catalog-dump.sh devices/my-device/backups mtkclient \
  boot=/path/to/boot.img vendor=/path/to/vendor.img

# Restore: dry run first (default -- prints the plan, writes nothing)
./scripts/restore-oem.sh devices/my-device/backups/manifest.tsv --method fastboot

# Only once the plan above looks right:
./scripts/restore-oem.sh devices/my-device/backups/manifest.tsv --method fastboot --yes

# For a BootROM-mode tool instead of fastboot/adb:
./scripts/restore-oem.sh devices/my-device/backups/manifest.tsv --method plan-only
# -> gives you the checksum-verified partition/file list; run your
#    vendor tool's own write command against each one yourself.
```

Both write methods (`fastboot`, `adb-dd`) default to a dry run and
require `--yes` to actually write anything, check that exactly one
device is connected before writing (refusing if zero or more than one
are visible, to avoid flashing the wrong unit), and support `--only
part1,part2` to scope a restore to specific partitions rather than
replaying the whole manifest by default.

## 12.4 What a restore can't undo

A successful write is not the same as a successful restore. Known limits:

- **Anti-rollback counters.** AVB (and some SoC secure-boot schemes)
  maintain a rollback index that only moves forward. If a newer signed
  `boot`/`vbmeta`/etc. has ever booted on this unit, flashing an older
  signed version back may be *refused by the device itself* even though
  the write command reports success — see
  [02-reverse-engineering-ghidra.md](02-reverse-engineering-ghidra.md)
  §2.6 and [06-bootloader-and-flashing.md](06-bootloader-and-flashing.md)
  §6.3. This is a hardware fuse, not a software state `restore-oem.sh`
  can detect or reset.
- **Samsung KNOX.** Flashing anything not Samsung-signed permanently
  trips the KNOX warranty fuse the moment it happens — restoring
  stock firmware afterward does not reset that fuse. Know this before
  your first non-stock flash, not after (§9.7).
- **Unit-specific data.** Partitions holding IMEI/RF-calibration data
  (`modemst1`/`modemst2`/`persist`/EFS-equivalents, naming varies by
  vendor) are unique **per physical unit**. Backing up and restoring
  *this device's own* copy is fine and expected. Flashing a *different*
  unit's dump of these partitions onto your device can permanently break
  the modem/IMEI on both devices — never mix these across units, and be
  extra careful that `catalog-dump.sh` isn't pointed at a dump from
  someone else's device out of a shared firmware-mirror download.
- **A restore is only as good as the backup.** If §1's firmware dump
  was taken *after* something was already wrong (a partially-flashed
  state, a corrupted partition), restoring it faithfully reproduces that
  problem. This is why §12.5's round-trip test exists — to catch this
  before you need the backup for real.

## 12.5 Verify the round trip before you need it

Add this as a gating step in the device profile (§10) before any real
porting work: back up, then immediately do a no-op restore of a single
low-risk partition (one that's easy to re-flash either way, e.g. `dtbo`)
and confirm both that the write succeeds and that the device still boots
normally afterward. This confirms:

1. The dump you took is actually valid (not truncated/corrupted).
2. Your chosen write path actually has write access on this unit (per
   §12.1's caveat — don't assume it from §9's general per-vendor notes).
3. You know the exact working command before you're in a position where
   you need it under pressure after a bad flash.

A backup you've never successfully restored from is unverified, not
ready.

## Next

Return to [00-overview.md](00-overview.md), or to whichever chapter sent
you here — this chapter is referenced from
[06-bootloader-and-flashing.md](06-bootloader-and-flashing.md) §6.5 and
[10-device-profile-template.md](10-device-profile-template.md).
