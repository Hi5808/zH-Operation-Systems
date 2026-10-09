# RG405M mainline Linux — build state

> Sanitized for public release: Wi-Fi SSID, device serial, and internal
> hostnames removed. Local paths kept as `$BUILD` (the build tree) for clarity.

Base: `beebono/rg-rotate-linux` at `$BUILD/rg-rotate-linux`
- kernel changes: branch `rg405m` in the `src/linux-7-1-sprd` submodule
- superproject: commit `c690509` (U-Boot build-script fix)

## Built ✅

| Artifact | Path | Notes |
|---|---|---|
| Kernel `Image` | `src/linux-7-1-sprd/arch/arm64/boot/Image` | 30 MB; `ums512_defconfig` + `CONFIG_JOYSTICK_ROCKNIX_SINGLEADC=y` |
| Board DTB | `.../dts/sprd/ums512-rg405m.dtb` | 75 KB; ST7701S panel (init seq translated from stock `sprd,initial-command`), `goodix,gt911` 640×480, `rocknix,singleadc-joypad`, no discrete amp |
| Joypad driver | `drivers/input/joystick/rocknix-singleadc-joypad.c` + `rocknix-input-polldev.h` | ported from `ROCKNIX/rocknix-joypad`; `input-polldev` → `input_setup_polling` shim; 0 warnings; in `vmlinux` |
| initramfs | `build/initramfs/initramfs.cpio.gz` | 3.5 MB busybox |
| Ubuntu rootfs | `src/rootfs-build/ubuntu-noble-arm64.tar` | 348 MB; noble arm64; `openssh-server` + `network-manager` + `wpasupplicant` + `iw` + `rfkill` + `bluez` + `joystick` + `alsa-utils` + `i2c-tools` + `gpiod` |
| **Custom U-Boot** | `$BUILD/uboot_rg405m.img` | 3.0 MB; DHTB-wrapped; SHA256 `ced25420…`. Built with `HOSTCC=gcc-13` + `KCFLAGS=-std=gnu11 -Wno-error=…` (vendored U-Boot predates gcc 14) |
| **SD image** | `$BUILD/rg405m-ubuntu-sdcard.img` | 4.2 GB; SHA256 `24d428fe…` |

SD image GPT: p1 `uboot` (**custom U-Boot spliced in**), p2 FAT boot (`Image` +
`ums512-rg405m.dtb` + `initramfs.cpio.gz` + `extlinux/extlinux.conf`,
`root=/dev/mmcblk0p3`), p3 ext4 Ubuntu.
A Wi-Fi profile is baked into the dev image (SSID **redacted** — set your own in
`/etc/NetworkManager/system-connections/`). SSH enabled, root login permitted,
host keys generated on first boot (`ssh-hostkeys.service`). **Dev image only —
set a root password on first login.**

## SPL — built (nosec) ✅

The SD-boot path needs a **custom SPL** on eMMC (stock SPL only loads U-Boot from
eMMC `uboot_a`, not from the SD). Per the repo's `src/spl/README.md`:

- The from-source SPL was verified with **`gcc-aarch64-linux-gnu` 11.4 on
  Ubuntu 22.04** + i386 multilib (the vendored chipram tree mixes 32-bit ARM
  FDL1 and 64-bit, and the packer `imgheaderinsert` is an i386 ELF). gcc 13/15
  break it (`typedef int bool` under C23, `-Werror=implicit-*`, and the FDL1
  part needs `arm-linux-gnueabi-as`). Flag-patching is not enough.
- The **binary-patch-stock-SPL** path (the README's "recommended path") does
  **not** include SD boot — explicitly.
- The stock RG405M `spl_a` is **RSA-2048 signed** (`rsa2048_0`). If the unit has
  secure boot **fused** (normal for a signed-SPL device), the BootROM rejects
  any unsigned from-source SPL — you then need Unisoc's `rsa2048_0.pem` (from
  the BSP `bsp_build-master/packimage_scripts/config/`) for `./build.sh signed`.
  If **not fused**, `./build.sh nosec` boots.

### Remaining steps (need `sudo` on the build host and/or the device)

1. `sudo apt install gcc-11-aarch64-linux-gnu gcc-11-arm-linux-gnueabi \
     make bison flex python3 libc6:i386 libstdc++6:i386 zlib1g:i386`
   (i.e. `src/spl/scripts/setup-toolchain.sh` on a box where the default
   `gcc-aarch64-linux-gnu` is 11 — or point `CROSS_COMPILE` at the `-11` binaries).
2. Put the RG405M in FDL mode (Home+Back combo) and read the efuse secure-boot
   state with `spd_dump` (or just try flashing `nosec` and see if the BootROM
   rejects it — recovery via BootROM download mode is always possible).
3. `cd src/spl && CROSS_COMPILE=aarch64-linux-gnu- ./build.sh nosec`
   (or `signed` with `rsa2048_0.pem` if fused) → `out/nosec/spl_a_nosec.img`.
4. Flash with `spd_dump`: `write_part spl_a out/.../spl_a_*.img`,
   `write_part spl_b …`, then `dd` the SD image to a card and boot.
   (The SD image already carries the custom U-Boot in p1.)

## Host tooling worked around (no sudo)

`mtools`, `mmdebstrap`, `arch-test`, and a full `gcc-11` aarch64 cross were
`apt-get download` + `dpkg-deb -x`'d into `~/.local/{pkgroot,xgcc11}`. The
kernel's `binfmt_misc` already registers `qemu-aarch64` (`F` flag), so
`mmdebstrap --mode=unshare --skip=check/qemu` runs the emulated dpkg phase in a
user namespace. `gcc-13`/`g++-13` were `sudo apt install`ed for the U-Boot host
tools.

## Also verify on hardware

- ST7701S init sequence actually lights the panel (`rocknix,generic-dsi`
  replays the raw DCS blob; timings from stock `timing0`).
- Analog-stick calibration (`button-adc-*` and per-axis tuning in the DT).
- The RG Rotate U-Boot's DRAM config on RG405M silicon (same T618, DRAM
  auto-detect is on, so likely fine — but unverified).
- Speaker ext-PA enable GPIO (RG405M has no discrete amp; internal codec path).
