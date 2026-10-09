# RG405M — mainline-Linux / Ubuntu build notes

Sanitized build + flash notes from a working **Ubuntu (noble/24.04) arm64 on
mainline-ish `sprd` kernel** bring-up of the RG405M, contributed as reference
for the Ubuntu Touch port plan in the parent folder. This is a **native Linux**
build (Wayland/Weston era tooling), not a Halium container — see
[`../checklist.md`](../checklist.md) bridge-baseline table, which is derived from
the same driver set (RGOS `meta-anbernic`).

- [`BUILD.md`](BUILD.md) — what was built (kernel, DTB, joypad driver, rootfs,
  custom U-Boot, SD image) and the custom-SPL situation.
- [`FLASH.md`](FLASH.md) — how the SD image + custom SPL go onto the device via
  `spd_dump`, boot chain, and recovery.
- [`display-regs-capture.txt`](display-regs-capture.txt) — live DSI host / DPU /
  D-PHY register dump captured on the running device; useful for validating the
  ST7701S panel timings.
- [`stock-boot-analysis.md`](stock-boot-analysis.md) — offline analysis of the
  stock V1.15 `boot`/`vendor_boot`/`dtbo`: the kernel-config gap-check (what to
  enable for a systemd userspace; the kernel is already Halium-ready), the
  129-module driver inventory, the dynamic-super/AVB fstab layout, and the
  regenerate-it-yourself recipe. No vendor files republished.
- [`proprietary-files.txt`](proprietary-files.txt) — manifest (paths + sha256,
  **no binaries**) of the closed vendor files the port references, all hashed
  from the official **Anbernic RG405M V1.15 Unbricker** (`Firmware.pac`):
  Wi-Fi/BT/GNSS firmware, vendor RF config, sprd audio params, and the optional
  Mali-G52 GPU blobs. The `vendor` EROFS was carved from the `.pac` and extracted
  with `fsck.erofs`; the recipe is in the manifest. GammaOS (a third-party ROM)
  is only cited as a cross-reference — its RF/audio match stock, its Mali differs.

## Not included here (deliberately)

The upstream working tree is ~46 GB and most of it does **not** belong in a
public repo:

- **Secrets:** the AVB signing key (`*.pem`) — excluded.
- **Copyrighted blobs:** OEM (Anbernic V1.15) firmware + vendor partition, and
  the third-party GammaOS `vendor`/APKs/Mali blobs — excluded (redistribution not
  permitted). Their paths + hashes + extraction recipe are in
  [`proprietary-files.txt`](proprietary-files.txt) instead, so the port is
  reproducible without republishing vendor binaries.
- **Binaries:** SD/eMMC disk images, bootloader/SPL/U-Boot images, `pac`
  extracts — excluded (size + not source).
- **Raw logs & stock DT dump:** multi-hundred-MB USB console logs and the raw
  stock device-tree dump (carries a per-device serial) — excluded.

The clean, buildable kernel + board device tree + patch series live in the
sibling **`rgos-yocto`** repository (`meta-anbernic`); start there to rebuild.
