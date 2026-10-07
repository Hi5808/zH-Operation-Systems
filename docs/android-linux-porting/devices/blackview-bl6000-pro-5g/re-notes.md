# RE Notes: Blackview BL6000 Pro 5G

Derived reverse-engineering notes for this device (MediaTek MT6873,
Dimensity 800). Per [02-reverse-engineering-ghidra.md](../../02-reverse-engineering-ghidra.md):
**only derived notes live here** — register tables, power-on sequences,
SMC/ioctl IDs, calling conventions — never the vendor binaries themselves.

Target OS for this port: Ubuntu Touch on a Halium 11 base (vendor HALs in
an LXC container). The same recovered facts apply to a native
postmarketOS/Yocto bring-up — the difference is whether you reuse the
Android HAL (Halium) or write native drivers/UCM from these notes.

Kernel baseline: the dumped vendor kernel is MediaTek's 4.14 `imgsensor`
`v1_1` / `mt6873` tree. Working build referenced below as "#NN" is the
local kernel build number in the port's own tree.

---

## Cameras (MediaTek `imgsensor` v1_1 framework)

The camera subsystem is the MediaTek `CONFIG_CUSTOM_KERNEL_IMGSENSOR`
framework: each sensor is a driver under
`drivers/misc/mediatek/imgsensor/src/common/v1_1/<sensor>/` exposing
register tables + a `platform_power_sequence`. The ISP/3A tuning is the
closed vendor stack (reused via Halium; see §19.2) — these notes cover
sensor *bring-up* (power, MIPI, orientation, calibration), which is what
you must recover to get any frames at all.

### Sensor complement (confirmed from the dump)
| Index | Sensor | Role | Notes |
|---|---|---|---|
| CAM[0] | Sony IMX582 | main (rear) | 48 MP sensor, driven at 12 MP binned; EEPROM calibration (below) |
| CAM[1] | Samsung S5K3P9SP | front | standard bring-up |
| CAM[2] | Samsung S5K3L6XX | ultra-wide (rear) | behind a MIPI switch; power-sequence quirk (below) |
| aux | GC032A | low-res aux | register table reconstructed; low priority |

### IMX582 main — EEPROM OTP / AWB calibration
- The module stores per-unit calibration in an EEPROM at **I2C id `0xA0`**
  reachable on the **sensor's own I2C bus** (not the DT `camera_eeprom0`
  node, which is wired to a different bus — `i2c-8` here — and reads the
  *wrong* module). Lesson: confirm which bus the cal EEPROM actually
  answers on before trusting the DT `cam_cal` node.
- Recovered flow: a `imx582_get_otp_data()` reads the EEPROM in the sensor
  `open()` / `get_imgsensor_id` path; `cam_cal`'s
  `imx582_selective_read_region()` is delegated to that same read so the
  userspace cal path and the sensor agree.
- **AWB application:** the golden/unit ratios read back as `0x411` / `0x3df`;
  applied as sensor digital gains → R `0x10c`, G `0x108`, B `0x100`. Without
  this the main camera has a visible colour cast. These values are
  per-module calibration semantics, not magic constants — read them from
  the unit, don't hardcode another unit's.
- Actuator (AF): the module uses **DW9800AF**. A GT9772AF path exists in
  some vendor variants but was *not* the fitted part here — untested,
  don't assume it.

### S5K3L6XX ultra-wide — MIPI switch + orientation
Two quirks blocked this sensor; both were found by diffing our driver's
behaviour against the stock kernel's `platform_power_sequence` (read out of
the dumped `vmlinux`):
- **No frames until the MIPI switch is driven.** The ultra-wide sits behind
  a MIPI switch toggled by GPIOs (GPIO170/171 on this board). The stock
  power sequence drives the switch as part of bringing up the MAIN2+MAIN3
  sensor group; our port got frames only after replicating that sequence.
  Symptom before the fix: sensor probes/IDs fine but the stream is empty.
- **Image inverted.** The generic base driver set `IMAGE_HV_MIRROR`; stock
  uses `IMAGE_NORMAL` for this mount. Fix is a one-line orientation change.
- Dropping a bogus `GET_MIPI_PIXEL_RATE` override let the framework pick the
  correct rate.

General lesson for MTK multi-camera boards: a sensor that IDs but produces
no frames is almost always a **board-level enable** (MIPI mux, regulator,
reset ordering) that lives in the stock `platform_power_sequence`, not in
the sensor's register table. Recover that sequence from `vmlinux` rather
than guessing.

---

## TEE — TrustKernel (`tkcore`)

This device's secure world is **TrustKernel** (not QSEE/OP-TEE). The kernel
driver is `drivers/misc/mediatek/tkcore/` (version string `3.3p1.4.14p0`);
a compatible out-of-tree source exists in other MT6873-era trees (used here
as a reference to rebuild the driver against the port's 4.14 kernel). The
userspace daemon is `teed`.

### CFI panic in `tee_clkmgr_handle` — the spontaneous-reboot fix
Symptom: random reboots, pinned down from `pstore`/`ramoops`
(`/var/lib/systemd/pstore/console-ramoops`) to a **Control Flow Integrity**
(CFI) kernel BUG in `tee_clkmgr_handle` — triggered on the fingerprint SPI
clock path. Root cause: the TEE clock shim calls kernel clock functions
through an indirect pointer whose **prototype didn't match** the target
(`clk_prepare_enable` / `clk_disable_unprepare`), which CFI rejects.
Fix (in `drivers/misc/mediatek/tkcore/core/peridev.c`): dispatch the known
clock ops by explicit comparison and call them directly with the right
prototype, and return a defined error for the unhandled case instead of
falling through an indirect call:

```c
if (fn == NULL)
    return TEEC_ERROR_NOT_SUPPORTED;                 /* was missing → fall-through */
if (fn == (void *) &clk_prepare_enable && h.argnum == 1)
    return clk_prepare_enable((struct clk *) h.p0) ? TEEC_ERROR_GENERIC : 0;
if (fn == (void *) &clk_disable_unprepare && h.argnum == 1) {
    clk_disable_unprepare((struct clk *) h.p0);
    return 0;
}
```

General lesson: when a vendor driver that worked on the stock (CFI-off or
differently-built) kernel panics under your CFI-enabled build, suspect
indirect calls through function pointers with mismatched prototypes — a
very common failure when porting MTK vendor drivers to a hardened config.

### RPMB path for `teed`
`teed` needs Replay-Protected Memory Block access for secure storage. The
port exposes it by adding ioctls to `drivers/char/rpmb/rpmb-mtk.c`:
`RPMB_IOCTL_TKCORE_{WRITE,READ,GET_CNT,GET_WR_SIZE}` (command numbers
10–13). **Never program the RPMB authentication key** — it is a one-time
fuse-like write; getting it wrong permanently breaks secure storage on the
unit. Read/use the existing key; never (re)write it.

---

## Fingerprint (SunWave, under TrustKernel)

See [19-hard-subsystems.md](../../19-hard-subsystems.md) §19.4 for the
general biometrics methodology; device specifics here.

- **Sensor:** SunWave, hardware id `0x93`. Kernel glue is
  `drivers/misc/mediatek/hct_finger/` (an HCT vendor shim) with
  `sunwave/` (used) and `fortsense/` (not fitted) sub-drivers.
- **TA:** the fingerprint Trusted Application UUID is
  `5b9e0e41-2636-11e1-ad9e0002a5d5c51b`, loaded by TrustKernel at boot
  (`tee_ta_load`). The keybox is imported by the KPH (`KeyPH`) path
  (`verify_ta_data` / `Device config imported` / `key_checksum: Verify
  succeeds` in the TEE log).
- **Identity dependency (important):** the TEE's "get vendor key" step
  checks the device identity. With a generic Halium identity it fails
  ("Get vendor key failed"); it only succeeds when `ro.product.brand` /
  `ro.product.model` present as **`Blackview` / `BL6000Pro`**. On a Halium
  port, bind the correct `build.prop` identity into the container before
  the TEE/fingerprint stack initialises, or enrolment silently never works.
- **HAL boot race:** the Android fingerprint HAL (`SunwaveFingerprintService`)
  crash-loops (SIGABRT in its destructor) if the UI biometrics daemon opens
  it during the init race. Gate the daemon's start on the HAL's HIDL
  registration (an `ExecStartPre` wait) — see §19.4.
- Current status: enrol + unlock work; the port requires two scans to
  unlock, kept intentionally as an anti-accidental-unlock feature (§19.4).

---

## OS userland options recovered-data supports

With the above recovered, this device can host:
- **Ubuntu Touch / Halium** (the path taken): reuse vendor GPU/modem/audio
  HALs in LXC; fastest route to a daily-usable phone. Camera via the Halium
  bridge keeps the vendor ISP (§19.2).
- **postmarketOS / native** (Debian/Ubuntu/Yocto rootfs on the same kernel):
  viable for display/touch/Wi-Fi/audio using the recovered sensor/clock/TEE
  notes; camera and 5G modem are the hard tail (§19.2, §19.3). Audio would
  need a UCM profile derived per §19.1 rather than the Halium droid module.
- A **Yocto** image is a reasonable choice for a single-purpose/appliance
  build on this hardware once the kernel + the above enablement are in place;
  the kernel tree and DT work are shared with the other paths.

---

## Bootloader / verified-boot state (for relock / dual-boot)
- Ships unlockable (`ro.oem_unlock_supported=1`); on the port unit
  `ro.boot.flash.locked=0`, `ro.boot.verifiedbootstate=orange`.
- AVB: the LK supports orange/yellow/green/red. **Green needs Blackview's
  private OEM key (unavailable)**; a relock with a *custom* key lands at
  **yellow — which still shows a warning + 5 s delay**. Fully removing the
  warning requires patching the warning path out of `lk`, which is only
  possible if the SoC secure-boot (SBC) fuse is not enforced — confirm with
  `mtkclient get_target_config` in BROM before attempting (see
  [06-bootloader-and-flashing.md](../../06-bootloader-and-flashing.md)).
- Dual-boot with stock Android is feasible: stock system survives in the
  `super` partition, UT lives as loop-mounted images on `userdata`, and the
  data filesystem is far smaller than its partition (lots of free space for a
  second data area). See §06 "Dual-boot" for the selector-ramdisk mechanism.
