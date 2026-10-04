# Handoff: What a Local (Hardware-Attached) Agent Needs to Do

This repo's guide and device profiles were written in a cloud session
with **no physical device access** — everything that needs a real
device, a real dump, or a USB cable has been left as `TBD` on purpose.
This file is the single, concrete list of what a local agent (one that
can see the actual Blackview BL6000 Pro 5G / Anbernic RG405M, or a USB
port) should do next, and exactly how to get the results back into this
repo.

## One-time machine setup

```bash
cd docs/android-linux-porting
./scripts/check-tools.sh
```

Install whatever it flags as missing for the device you're working on
(at minimum: `adb`, `fastboot`; for the Blackview, `mtkclient`; for the
Anbernic, clone `github.com/TheGammaSqueeze/GammaOS` and read its own
install docs). `mtkclient` in particular needs OS-specific USB setup
(udev rules on Linux so the BROM-mode VCOM port is accessible without
root, or the right driver on Windows) — follow its own README for that,
not this guide.

## Per-device checklist

### Blackview BL6000 Pro 5G (`devices/blackview-bl6000-pro-5g/`)

1. **Confirm the OEM-unlock toggle** — `Settings > About phone`, tap
   build number 7×, then `Settings > Developer options` for "OEM
   unlocking." Record whether it's present in `profile.md` §Identity.
2. **Test BROM read access first, separately from write.** Run
   `mtkclient`'s own read/dump command against this exact unit (check
   its README for current syntax — this guide won't assert it, see
   §12.1) and confirm it actually returns data before assuming anything
   about write access. This answers the open SLA/DAA question in the
   profile.
3. **Get a dump into this repo's workflow**, whichever path worked:
   - If you have root + adb: `./scripts/backup-partitions.sh devices/blackview-bl6000-pro-5g/backups boot dtbo vendor_boot vbmeta vendor system`
   - If you dumped via `mtkclient` onto disk: `./scripts/catalog-dump.sh devices/blackview-bl6000-pro-5g/backups mtkclient boot=<path> vendor=<path> ...`
4. **Unpack what you got:**
   ```bash
   ./scripts/unpack-boot.sh devices/blackview-bl6000-pro-5g/backups/boot.img devices/blackview-bl6000-pro-5g/boot_out/
   ./scripts/extract-kernel-config.sh devices/blackview-bl6000-pro-5g/boot_out/kernel devices/blackview-bl6000-pro-5g/kernel.config
   ./scripts/dump-vendor-partition.sh devices/blackview-bl6000-pro-5g/backups/vendor.img devices/blackview-bl6000-pro-5g/vendor_mnt/
   ```
5. **Fill in `profile.md`** §Identity (`getprop` values), §1 (check off
   what was obtained), §3 (real `compatible` strings from
   `boot_out/device.dts`, real driver list from `vendor_mnt/lib*/modules/`),
   §4, §6 (real `boot.img` header/offsets from `unpack-boot.sh`'s output).
6. **Run the restore round-trip** (§12.5) on a low-risk partition
   (`dtbo`) before any real porting work — this is where "does mtkclient
   actually have write access on this unit" finally gets answered instead
   of guessed at:
   ```bash
   ./scripts/restore-oem.sh devices/blackview-bl6000-pro-5g/backups/manifest.tsv --method plan-only --only dtbo
   # then either --method fastboot (if unlocked) or follow mtkclient's own
   # write command for the plan above, per §12.1
   ```
   Record the result in `profile.md`'s backups section — Y/N, and which
   method actually worked.

### Anbernic RG405M (`devices/anbernic-rg405m/`)

1. **Start with GammaOS, not a raw dump.** Clone
   `github.com/TheGammaSqueeze/GammaOS` and read its kernel/device tree
   and install docs first — it almost certainly already documents a
   working UNISOC download-mode flash procedure for this exact chip
   family. Use that procedure rather than reverse-engineering the
   protocol from scratch.
2. Once you have a working dump (via GammaOS's own tooling or a direct
   UNISOC download-mode dump), same steps as the Blackview above:
   `catalog-dump.sh` or `backup-partitions.sh` → `unpack-boot.sh` →
   `extract-kernel-config.sh` → `dump-vendor-partition.sh` → fill in
   `profile.md`.
3. Run the restore round-trip (§12.5) the same way, recording whether
   the UNISOC download-mode tool actually grants write access on this
   unit — this is unconfirmed in the profile for the same reason as the
   Blackview's SLA/DAA state.

## What comes back into this repo (and what doesn't)

**Commit:** `profile.md` updates, `re-notes.md` entries, `kernel.config`
(text), `device.dts` (text, not the binary `.dtb`), `manifest.tsv`
(checksums and filenames only, no binary content).

**Never commit:** the actual `.img`/`.bin` dump files, the raw `boot_out/kernel`
and `boot_out/ramdisk` binaries, anything under `vendor_mnt/` (HAL `.so`,
vendor `.ko`, firmware blobs). A repo-root `.gitignore` now blocks the
obvious cases, but it's not a substitute for checking `git status` before
committing — the gitignore patterns match the directory layout the
scripts above produce by default; a different output path won't be
caught automatically.

If a local agent is doing this work, it should still follow this
session's own rule: confirm before pushing (`git status`, review the
diff), and never force-push. Normal commits to this branch are fine and
expected.

## If something doesn't match what the profile predicted

That's expected — the profiles were built from public specs and the
guide's general methodology, not from this exact unit. Update the
profile with what's actually true rather than treating a mismatch as an
error in the local agent's work. [11-troubleshooting-and-debugging.md](11-troubleshooting-and-debugging.md)
covers the common cases (BROM mode not responding, checksum mismatches,
unexpected partition layouts, etc.).
