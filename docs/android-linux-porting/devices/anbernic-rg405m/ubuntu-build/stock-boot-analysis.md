# RG405M — stock boot/kernel analysis (offline, from V1.15 firmware)

Derived facts from the stock **Anbernic V1.15** `boot`, `vendor_boot` and `dtbo`
partitions, to drive the kernel-config and Halium work without touching the
device. **No vendor files are republished here** — regenerate them yourself with
the recipe at the bottom (`unpack_bootimg` + `extract-ikconfig` + `dtc`, all in
[../../07-tools-reference.md](../../07-tools-reference.md) §7.0).

## Boot image facts

| Item | Value |
|---|---|
| boot header version | 4 (AVB `boot_signature`, 4 KiB) |
| kernel | arm64 `Image`, ~38 MB, **`CONFIG_IKCONFIG` present** (full `.config` recoverable) |
| OS / patch | Android 12.0.0 / 2022-07 |
| kernel cmdline (in `vendor_boot`) | `console=ttyS1,115200n8 buildvariant=user` |
| load addrs | kernel `0x8000`, ramdisk `0x05400000`, dtb `0x01f00000`, tags `0x100` |
| `vendor_boot` dtb | one FDT, ~142 KB (the board DT) |
| `dtbo` | two overlays (~30 KB + ~25 KB) |
| vendor ramdisk | LZ4, ~19 MB, **129 kernel modules** + fstab + init rc |

> Note the stock console is **`ttyS1`** (the SoC UART), but this handheld has no
> broken-out UART — the working console for a Linux port is the USB-C **CDC-ACM**
> gadget (`/dev/ttyACM0`), per [ubuntu-build/FLASH.md](FLASH.md).

## Kernel config gap-check (the actionable part)

The stock kernel is **already Halium/Android-container ready** — a UT/Halium port
needs essentially no container-config work on this kernel:

| Config | Stock | Needed for Halium |
|---|---|---|
| `ANDROID_BINDER_IPC`, `ANDROID_BINDERFS` | `=y` | ✅ |
| `ANDROID_BINDER_DEVICES` | `"binder,hwbinder,vndbinder"` | ✅ |
| `ASHMEM`, `MEMFD_CREATE` | `=y` | ✅ |
| `ION`, `DMABUF_HEAPS` | `=y` | ✅ |
| `STAGING` | `=y` | ✅ |
| `SW_SYNC` | not set | optional (timeline sync; usually fine without) |

But for a **glibc + systemd** userspace (Ubuntu Touch / postmarketOS / Debian)
these are **missing and must be enabled** — this is the concrete §4.6
"merge Linux-userspace options" list for this device:

| Config | Stock | Action |
|---|---|---|
| `CONFIG_SYSVIPC` | not set | **enable** (systemd, X/Wayland IPC) |
| `CONFIG_DEVTMPFS` | not set | **enable** (udev/systemd `/dev`) |
| `CONFIG_DEVTMPFS_MOUNT` | absent | **enable** |
| `CONFIG_FHANDLE` | not set | **enable** (systemd requires) |
| `CONFIG_TMPFS_POSIX_ACL` | not set | **enable** (systemd) |
| `CONFIG_TMPFS_XATTR` | not set | **enable** (systemd) |
| `CONFIG_AUTOFS_FS` | not set | **enable** (systemd automount) |
| `CONFIG_UEVENT_HELPER` | not set | ✅ keep off (correct for modern udev) |
| `CONFIG_SYSFS_DEPRECATED` | not set | ✅ keep off |

Already present and correct: `CGROUPS`, `NAMESPACES`/`NET_NS`, `SECCOMP`,
`EXT4_FS`, `IPV6`, `UNIX`, `INOTIFY_USER`, `SIGNALFD`, `TIMERFD`, `EPOLL`.

**GPU:** stock is `CONFIG_DRM=y`, `CONFIG_DRM_SPRD=m`, **`DRM_PANFROST` not set**,
`CONFIG_FB` not set. So stock Android drives the Mali-G52 with the proprietary
`mali_kbase`; the open native port must **add `CONFIG_DRM_PANFROST`** (RGOS
`meta-anbernic` already does) and keep `DRM_SPRD` for the display controller —
matching the GPU row in [checklist.md](checklist.md).

## Driver inventory (129 stock modules → subsystem)

Confirms and extends the [checklist.md](checklist.md) bridge table — these are the
exact stock `.ko`s, i.e. the driver set a native/Halium port must provide:

| Subsystem | Stock modules |
|---|---|
| Display | `sprd-drm`, `sprd-gsp` (GPU scaler/composer) |
| Touch | `gt9xx_ts` (Goodix) |
| Gamepad | `singleadcjoy` |
| Audio | `snd-soc-sprd-card`, `snd-soc-sprd-codec-sc2730(+power/-dev)`, `snd-soc-sprd-vbc-v4`, `snd-soc-sprd-vbc-fe`, `snd-soc-sprd-dummy-codec`, `sprd-dmaengine-pcm`, `sprd-compr-2stage-dma`, `audio-*`/`sprd_audcp_*` |
| PMIC / power | `sc2730-regulator`, `sc27xx_fuel_gauge`, `sc27xx_adc`, `sc27xx_typec`, `sc27xx-poweroff`, `sc27xx-vibra`, `rtc-sc27xx`, `leds-sc27xx-bltc`, `sprd_battery_info` |
| Storage | `sdhci-sprd` |
| USB | `musb_sprd` |
| Bus/IO | `i2c-sprd(+-hw)`, `spi-sprd(+-adi)`, `pinctrl-sprd(+-sharkl5Pro)`, `gpio-sprd`, `gpio-eic-sprd`, `gpio-pmic-eic-sprd`, `pwm-sprd`, `clk-sprd` |
| eFuse/misc | `nvmem-sc27xx-efuse`, `nvmem_sprd_(cache_)efuse`, `misc_sprd_uid`, `sprd_hwspinlock`, `phy-sprd-sharkl5Pro`, `sprd-dma`, `sprd-ion` |
| Camera (unused on a Linux handheld) | `sprd_camera`, `sprd_cpp`, `sprd_flash_drv`, `sprd_camsys_pw_domain` |

No `mali_kbase` module is in the `vendor_boot` ramdisk (it lives in
`vendor_dlkm`/vendor) — consistent with the Panfrost-based open port.

## Partition / fstab layout (dynamic super + AVB)

Stock `fstab.ums512_1h10` (first-stage): `system`, `system_ext`, `vendor`,
`product` are **logical (dynamic-super) EROFS, read-only, AVB-verified**;
`vendor_dlkm` is logical ext4; `/metadata` is a dedicated ext4 partition. A/B
`slotselect` throughout. Implications for the port:

- The Linux rootfs replaces the dynamic-super Android partitions; keep `metadata`
  and the A/B scheme in mind when laying out the SD/eMMC image
  ([FLASH.md](FLASH.md) already boots Ubuntu from SD p3, leaving stock on eMMC).
- AVB is per-partition (`vbmeta`, `vbmeta_system`, `vbmeta_vendor`, …) — relevant
  to the relock/custom-key flow in [12-oem-restore.md](../../12-oem-restore.md).

## Regenerate the raw files yourself

```sh
# boot: kernel + ramdisk, then recover the stock .config
unpack_bootimg --boot_img boot_a.img --out boot_out
scripts/extract-ikconfig boot_out/kernel > stock-kernel.config   # (linux tree)
# vendor_boot: cmdline, board dtb, vendor ramdisk (fstab + *.ko + init rc)
unpack_bootimg --boot_img vendor_boot_a.img --out vboot_out
dtc -I dtb -O dts -o board.dts vboot_out/dtb
lz4 -d vboot_out/vendor_ramdisk00 vr.cpio && mkdir vr && (cd vr && cpio -idm < ../vr.cpio)
# dtbo overlays
unpack_bootimg --boot_img dtbo_a.img --out dtbo_out   # or split on d00dfeed, then dtc
```
