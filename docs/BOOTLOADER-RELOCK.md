# Bootloader relock / orange-state warning — analysis (2026-10-07)

## Current state (device, read-only)
- `ro.boot.flash.locked = 0` → bootloader UNLOCKED
- `ro.boot.verifiedbootstate = orange` → the warning we want gone
- `ro.oem_unlock_supported = 1`
- Partitions: seccfg=sdc15, vbmeta=sdc6/system=sdc7/vendor=sdc8, lk=sdc37, lk2=sdc38, tee1/2
- Backups present at ~/bl6000pro-backup: seccfg.bin, vbmeta*.bin, lk.bin, lk2(=? verify),
  tee1/2.bin, boot.bin. Safety net for a relock attempt is in place.

## What lk.bin tells us (strings RE)
Supports green/orange/yellow/red. Warning strings:
- orange: "Your device has been unlocked and can't be trusted" (current)
- yellow: "Your device has loaded a different operating system" + "will boot in 5 seconds"
- red: "Your device is corrupt." / "failed verification" (won't boot)
- "oem key and dm_cert key are mismatch" → GREEN needs Blackview's private OEM key (unavailable)

## The tension
- A genuine relock with OUR OWN custom AVB key → **YELLOW** state. Device reports "locked",
  but it STILL shows a warning (different text) + 5s delay. It does NOT remove the message.
- NO message at all (without Blackview's key) requires patching the warning screen out of
  lk.bin (proven approach on RC-GS717: patch the delay/draw path).
- GREEN (no warning, OEM-trusted) is impossible — we don't have Blackview's signing key.

## Recommended path (satisfies "locked" + "no message")
1. Generate a custom AVB key; re-sign our UT vbmeta with it (avbtool).
2. `fastboot flash avb_custom_key` (register our key) — IF this LK/preloader accepts it.
3. Flash the custom-signed vbmeta; `fastboot flashing lock`/`oem lock` → yellow, boots.
4. Patch lk.bin to skip the yellow warning draw + 5s delay; flash patched lk → no message.

## BLOCKING UNKNOWN before ANY flashing: secure-boot (SBC) fuse state
Step 4 (and even booting a patched lk) only works if the SoC's secure-boot fuse is NOT
blown. If SBC is enforced, the preloader/BROM rejects an unsigned/patched lk → we CANNOT
patch the warning out, and relock would strand us at yellow-with-warning at best.
- Determine via BROM/preloader (mtkclient, needs the device in BROM mode — a hardware step
  for the owner). `get_target_config` reports SBC/DAA/SLA.
- Do NOT `fastboot flashing lock` before this is known: locking with a vbmeta the LK can't
  verify → RED → no boot (recoverable only via download-mode reflash of vbmeta/seccfg).

## Risk notes
- Never touch RPMB. Keep ~/bl6000pro-backup intact (seccfg+vbmeta+lk+tee).
- All flashing is the owner's step (download/fastboot mode). Advisor preps images only.
