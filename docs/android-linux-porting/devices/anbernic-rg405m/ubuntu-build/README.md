# RG405M — Ubuntu Touch build + references

**The deliverable is Ubuntu Touch (Lomiri)** — build doc:
[`UBUNTU-TOUCH-BUILD.md`](UBUNTU-TOUCH-BUILD.md). Everything else in this folder is
**reference material or test harness** for that port, not the product:

- A working **plain Ubuntu / mainline `sprd` kernel** bring-up (`BUILD.md`,
  `FLASH.md`) — the *reference* that proved the kernel, Panfrost, DT and SD-boot.
  It is **not** the OS we ship; it's the harness the UT build reuses.
- The **OEM** stock-firmware analysis + vendor-file manifest.

All native (no Halium container anywhere) — see
[`../checklist.md`](../checklist.md) bridge-baseline table (driver set from RGOS
`meta-anbernic`).

- [`BUILD.md`](BUILD.md) — what was built (kernel, DTB, joypad driver, rootfs,
  custom U-Boot, SD image) and the custom-SPL situation.
- [`FLASH.md`](FLASH.md) — how the SD image + custom SPL go onto the device via
  `spd_dump`, boot chain, and recovery.
- [`display-regs-capture.txt`](display-regs-capture.txt) — live DSI host / DPU /
  D-PHY register dump captured on the running device; useful for validating the
  ST7701S panel timings.
- [`UBUNTU-TOUCH-BUILD.md`](UBUNTU-TOUCH-BUILD.md) — **the deliverable**: building
  the native (no-Halium) Ubuntu Touch / Lomiri rootfs on the Panfrost kernel (Mir
  on `gbm-kms` + Mesa). The other build docs here are references/harness, not the OS.
- [`FIRST-BOOT-AND-GPU-CHECK.md`](FIRST-BOOT-AND-GPU-CHECK.md) — paste-ready
  on-device command sheet: flash a spare SD, boot over `/dev/ttyACM0` (SPL already
  handles it), smoke-test display/input/Wi-Fi/audio, and run the **GPU gate**
  (Panfrost vs. our own Mali driver) using the built reference Ubuntu image —
  before the UT rootfs exists.
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
