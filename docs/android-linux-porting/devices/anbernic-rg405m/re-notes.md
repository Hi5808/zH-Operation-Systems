# RE Notes: Anbernic RG405M

Stub — fill in as components are reverse engineered, per
[02-reverse-engineering-ghidra.md](../../02-reverse-engineering-ghidra.md).
Never commit the actual vendor binaries here — only derived notes
(register tables, init sequences, SMC call IDs, etc).

Given the existing GammaOS prior art (see [profile.md](profile.md)),
start by diffing stock firmware drivers against GammaOS's open kernel
source rather than disassembling from zero — most entries here should
end up being "confirmed identical to GammaOS's `<path>`" rather than a
fresh register-table recovery.

## Status: stock firmware dumped & analyzed — no Ghidra RE needed so far

The stock **V1.15** `boot`/`vendor_boot`/`dtbo` and the `vendor` EROFS have been
unpacked offline (no device). Between that and the RGOS BSP, the driver set is
fully known without disassembly — see
[ubuntu-build/stock-boot-analysis.md](ubuntu-build/stock-boot-analysis.md) for
the derived facts and [ubuntu-build/proprietary-files.txt](ubuntu-build/proprietary-files.txt)
for the vendor-file hashes. Entries below are derived notes only (no binaries).

## Display panel (ST7701S)
- Source: stock `vendor_boot` board DT `sprd,initial-command` (DCS init blob) +
  a live DSI-host/DPU/D-PHY register capture from a running unit
  ([ubuntu-build/display-regs-capture.txt](ubuntu-build/display-regs-capture.txt)).
- Result: **recovered, no Ghidra** — RGOS replays the raw DCS init via
  `rocknix,generic-dsi`; timings come straight from the stock `timing0`.

## Driver inventory (stock `vendor_boot` ramdisk, 129 `.ko`)
- Result: **identical approach to RGOS** — every stock module maps to a
  downstream `sprd`/`sc27xx` driver already carried (and patched) by the RGOS
  `meta-anbernic` BSP; see the module→subsystem table in
  [ubuntu-build/stock-boot-analysis.md](ubuntu-build/stock-boot-analysis.md).
  No module here required register-table recovery from a binary.

## GPU (Mali-G52 Bifrost) — own driver, no Halium
- Stock drives it with the proprietary `mali_kbase` + the bionic `libGLES_mali.so`
  (DDK Bifrost; hashes in proprietary-files.txt). The native UT port uses an
  **open stack with no Android container**: Mesa Panfrost first, and — if
  Panfrost's GL on this G52 is insufficient — our **own RE'd/custom Mali-G52 DRM
  driver** paired with Mesa. The OEM `mali_kbase`/DDK is used **only as the RE
  reference** (register map, ioctl ABI), never at runtime. No `libhybris`.
- RE target when the custom driver is needed: the `mali_kbase` ioctl interface
  (job submission, memory management) and the G52 Bifrost job-manager register
  block, cross-referenced against Mesa Panfrost's existing Bifrost support.

## Still open (would need a device-side dump or RE)
- Headset boom-mic **capture** path (profile.md §3, status 🟨) — parked pending
  an Android-side audio HAL capture trace.
