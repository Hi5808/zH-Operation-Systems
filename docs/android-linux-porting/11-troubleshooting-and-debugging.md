# 11. Troubleshooting & Debugging

A symptom-indexed reference for when a step in §1-§6 doesn't go as
planned. Cross-references point back to the section with the relevant
background.

## 11.1 "I can't get a firmware dump at all"

| Symptom | Likely cause | Fix |
|---|---|---|
| No OTA/factory image published anywhere | Small/regional vendor, device too old/obscure | Try the BootROM-mode tool for your SoC vendor (§9) to dump live from the device instead of relying on a published image — needs no vendor cooperation, but whether it works depends on the chip's own authentication (§9.7) |
| `adb root`/`su` unavailable, bootloader won't unlock | Carrier-locked variant, or vendor removed unlock entirely | Check XDA/community forums for a known exploit-based root for that exact firmware version; if genuinely none exists, a BootROM-mode dump (§9) may still work, since its access is gated by chip-level authentication (SLA/DAA, signed EDL loaders) rather than the Android unlock toggle — but that authentication can block it too (§9.7) |
| EDL/BROM/Odin mode doesn't respond | Wrong button combo/test-point for this exact model, or driver issue on your PC | Re-check model-specific combo (varies even within one vendor's lineup); on Linux, check `lsusb`/`dmesg` for the right USB VID:PID appearing at all before assuming it's a protocol problem |

## 11.2 "The kernel doesn't boot / no serial output at all"

| Symptom | Likely cause | Fix |
|---|---|---|
| Bootloader messages on serial, then silence | Kernel console not reaching the UART: wrong `earlycon=`/`console=` driver or address | Take the UART node from the stock `.dts`; see §15.2 |
| Totally silent, no `earlycon` output | Wrong `--base`/offsets in the repacked `boot.img` (§6.2), or wrong UART DT node for `earlycon=` | Re-verify offsets against `unpack_bootimg` output for the *stock* image; confirm the UART compatible string/address from the vendor `.dts`, not guessed |
| Bootloader rejects the image outright (red state / "image verification failed") | AVB/vbmeta enforcement still active (§6.3), or the bootloader's header-version expectation doesn't match what you packed | Check `fastboot getvar all` output for lock/AVB state; re-match `--header_version` |
| Boots partway, then resets/reboots in a loop | A `reserved-memory` region mismatch (§3.3/§4.3) — TrustZone or the modem firmware detects corruption and panics, or a watchdog fires because a secure-world SMC call that normal Android init made isn't being made by your init | Diff your `.dts` reserved-memory nodes byte-for-byte against the stock one; check whether stock `init` sends any early SMC/QSEE calls your replacement init skips |
| Boots to kernel log, then nothing (no rootfs) | `root=` cmdline wrong, or initramfs can't find/mount the real rootfs | Double check partition path (`/dev/sda1` vs `/dev/mmcblk0p..` vs a `PARTUUID=` root depending on storage type) |

## 11.3 "Kernel boots but a specific subsystem doesn't work"

| Symptom | Likely cause | Fix |
|---|---|---|
| Display stays black but kernel log shows the panel driver probing successfully | Panel init sequence (§2.3) recovered incompletely — missing a delay or a register write that only matters on real silicon timing | Re-check against the vendor's probe() disassembly for every `msleep`/`usleep_range` call, not just the register writes |
| Touchscreen node present, device node created, but no input events | IRQ line/trigger-type mismatch, or firmware-load path wrong (some touch ICs need a vendor firmware blob loaded via `request_firmware()` at probe time) | Check `cat /proc/interrupts` for the IRQ actually firing; check `dmesg` for firmware-load failures; confirm the blob exists at the path the driver requests |
| Wi-Fi driver loads, firmware loads, but no networks found | Regulatory-domain/board-specific calibration file (`.txt`/`.bin` alongside the main firmware blob, often per-region) missing or wrong variant pulled from `/vendor/firmware` | Make sure you copied *every* file in the chip's firmware directory, not just the main blob — board-specific `nvram.txt`/`bdwlan.bin`-style files are easy to miss |
| GPU: Freedreno/Panfrost loads but renders garbage or GPU-hangs | Needs vendor firmware/`zap` shader for secure-world GPU init on this generation, or the open driver genuinely doesn't support this GPU revision yet | Check Mesa's support matrix for the exact GPU revision; `qcom,adreno` chips often need a small vendor-signed `zap` firmware blob even with Freedreno — check if it's present in `/vendor/firmware` and referenced correctly in DT |
| Modem: `qrtr`/ModemManager sees the device but no signal/data | `remoteproc` firmware load failing, or the RF calibration/NV data partition wasn't preserved | Check `dmesg` for remoteproc load errors; confirm you didn't wipe `modemst1`/`modemst2`/NV partitions during flashing — these hold IMEI/calibration and must survive untouched |
| Audio: playback works, mic doesn't (or vice versa) | DSP-side routing/mixer path not initialized the same way the vendor HAL did it | Compare the ALSA UCM (Use Case Manager) config, if any, against the vendor's audio HAL routing tables recovered in §2; DSP audio is consistently the fiddliest subsystem — budget real time for it |

## 11.3.1 "Linux userspace misbehaves on an Android kernel"

| Symptom | Likely cause | Fix |
|---|---|---|
| systemd fails early, or `/dev` is nearly empty | Missing kernel options systemd needs (devtmpfs, cgroups, fhandle, …) | Run `pmbootstrap kconfig check` or Halium's checker; see §4.6 |
| Root can use the network but normal users get "permission denied" opening sockets | `CONFIG_ANDROID_PARANOID_NETWORK` enabled on a downstream kernel | Disable it, or add users to the Android network GIDs as a stopgap (§4.6) |
| Vendor `.ko` won't load: "disagrees about version of symbol" / "Unknown symbol" / "exec format error" | Module built for a different kernel (GKI KMI mismatch or different version/config) | Use the exact matching kernel, or replace the module with a mainline driver (§4.7) |
| No USB network interface appears on the host | USB gadget configfs or the RNDIS/NCM function not enabled, or the initramfs doesn't set it up | Check the gadget options (§4.6); on postmarketOS, check its USB networking wiki page |

## 11.4 "Halium/libhybris container issues"

| Symptom | Likely cause | Fix |
|---|---|---|
| HAL container won't start / crashes immediately | Bionic libc version mismatch with what the HAL `.so` expects, or missing dependency `.so` not pulled into `proprietary-blobs.txt` | On your host, run `readelf -d` on every HAL `.so` to list its `NEEDED` libraries and make sure every dependency is listed |
| `libhybris` EGL/GL calls segfault | ABI mismatch between the Android HAL's expected EGL platform and what libhybris presents | Check libhybris's own device-compatibility notes for your GPU vendor; this is a well-known rough edge, check Halium's issue tracker for your SoC family first |
| SELinux/seccomp denials in logs even though you're not running Android proper | Leftover policy from the stock `/vendor` blobs being loaded in a context that still checks against Android's device-side policy | Either keep a minimal matching policy or disable it for the container context, following whatever the Halium device template for a similar SoC already does |

## 11.5 "It worked, then an update broke it"

- Vendor firmware updates can change the ABI a HAL `.so` expects, rotate
  AVB/anti-rollback counters (bricking a device flashed with an older
  signed stage if the vendor burns anti-rollback fuses), or change
  partition layouts.
- Keep every firmware version you've ever successfully dumped/ported
  against, named by build number, in your own backups (§6.5) — "which
  exact vendor build was this RE'd against" is a question you will need
  to answer again later.

## 11.6 General debugging discipline

- Change one variable at a time: don't modify the kernel config, DT, and
  init sequence all at once between boot attempts — you won't know which
  change fixed or broke anything.
- Prefer `fastboot boot`/RAM-boot equivalents (§6.4) for every iteration;
  reserve real flashing for a build you're reasonably confident in.
- When stuck, re-read the relevant vendor `probe()` disassembly (§2.3)
  before assuming the issue is elsewhere — most "mystery" hardware bugs in
  this kind of port trace back to one missed register write or delay in
  the init sequence, not a deep architectural problem.
