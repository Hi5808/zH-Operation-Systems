# 3. Hardware Identification

Before writing a single line of kernel code, build a complete hardware
inventory. Most of this comes "for free" from the files you already
dumped (§1) plus light RE (§2) — you rarely need to open the device.

## 3.1 SoC & core platform

- `kernel.config` (`CONFIG_ARCH_*`, `CONFIG_SOC_*`) tells you the exact SoC
  family (e.g. Qualcomm SM8250, MediaTek MT6785, Samsung Exynos 9820).
- `device.dts` root node `compatible` string names the exact board.
- `getprop ro.board.platform` / `ro.hardware` (if the device boots Android)
  are quick confirmations.
- Once you know the SoC, check whether it already has *any* mainline or
  postmarketOS/Halium support for a sibling device — SoC-level work
  (clock drivers, pinctrl, interconnect, SMMU) is usually shared across
  every phone using that chip, so you may inherit 80% of the kernel for
  free from an existing port and only need device-specific peripheral work.

## 3.2 Peripheral inventory checklist

Walk the `.dts` node by node; for each, note: compatible string, bus
(I2C/SPI/MIPI/USB), GPIO/IRQ lines, regulators, and whether mainline Linux
already has a driver for that `compatible` string (check
`drivers/*/Kconfig` / `MODULE_DEVICE_TABLE` in current Linux source).

| Subsystem | Where to look | Common finding |
|---|---|---|
| Display panel | `dsi@.../panel@0` node, `vendor/lib/modules/*panel*` | Often a `simple-panel` with init sequence RE'd per §2.3; sometimes already in `drm/panel/panel-*.c` upstream |
| Touchscreen | I2C node under `soc/i2c@.../touch@..` | Synaptics/FocalTech/Goodix/ILITEK chips mostly have mainline drivers already — the work is usually just DT wiring, not new driver code |
| GPU | `gpu@..` compatible (`qcom,adreno-...`, `arm,mali-...`, `mediatek,mt*-mfgsys`, `samsung,exynos-g3d`) | Reused via vendor blob + `libhybris`, or an open driver (Freedreno for Adreno, Panfrost/Panthor/Lima for Mali) depending on generation — see [09-soc-vendor-specifics.md](09-soc-vendor-specifics.md) §9.1-§9.6 for which applies to your vendor |
| Audio codec/DSP | `sound`/`qcom,apr*`/`mediatek,mt*-afe`/`samsung,exynos-snd-*` nodes | Often the hardest subsystem regardless of vendor; may need the vendor's DSP firmware kept as-is, with only the AP-side kernel driver ported |
| Modem | `remoteproc@..`, `qcom,mss`, or vendor-specific equivalent | Reuse vendor modem firmware + a compatible protocol stack (`qrtr`/`rmtfs`/ModemManager on Qualcomm; vendor-specific and often less mature elsewhere — see §9) — essentially never reimplemented from scratch |
| Wi-Fi/BT | `wifi@../bluetooth@..`, usually SDIO/PCIe/USB | Mainline `ath1x`/`brcmfmac`/`wcn36xx`/`wcn3990` drivers frequently already support the chip — check firmware blob naming under `vendor/firmware/` |
| Sensors (accel/gyro/light/prox) | I2C nodes, `iio` subsystem | Almost always already mainlined (Bosch BMI, InvenSense ICM/MPU, STMicro) — vendor-independent, these chips are shared across the whole industry |
| Fingerprint | Often SPI, vendor-proprietary | Usually unsupported upstream; lowest priority, frequently skipped in community ports |
| Battery/charging/PMIC | `qcom,pm8998`, `mediatek,mt6358`, `samsung,s2mpg*`, etc. | Usually has solid mainline support per PMIC family, independent of the AP SoC vendor |
| USB/USB-C PD | `usb@..`, `typec@..` | Depends on PMIC/USB controller; often mainlined per-SoC |

### Clock & pinmux node naming by vendor

The DT nodes that gate every other peripheral's power-on sequence use
different `compatible` prefixes per SoC vendor — recognize these before
assuming a node is something unusual:

| Vendor | Clock controller | Pin controller |
|---|---|---|
| Qualcomm | `qcom,gcc-<chip>` (+ `qcom,rpmh-*` on newer chips) | `qcom,tlmm` |
| MediaTek | `mediatek,mt<chip>-topckgen`/`pericfg` | `mediatek,mt<chip>-pinctrl` |
| Samsung Exynos | `samsung,exynos<chip>-clock` | `samsung,exynos<chip>-pinctrl` |
| Allwinner | `allwinner,sun*i-*-ccu` | `allwinner,sun*i-*-pinctrl` |
| Rockchip | `rockchip,rk*-cru` | `rockchip,rk*-pinctrl` |
| NVIDIA Tegra | `nvidia,tegra*-car` | `nvidia,tegra*-pinmux` |

See [09-soc-vendor-specifics.md](09-soc-vendor-specifics.md) for the full
per-vendor picture (boot chain, dump tooling, GPU/modem specifics) once
you've identified which row above applies to your device.

## 3.3 Memory map & bootloader handoff

Record from the bootloader RE (§2.1) and `.dts` `/memory` + `/reserved-memory`
nodes:

- RAM base/size, and every `reserved-memory` carve-out (TrustZone, modem,
  DSP, framebuffer) — your kernel must declare the same reservations or the
  secure-world firmware will corrupt/crash.
- Where the bootloader expects to find the kernel image, DTB, and
  initramfs in memory, and what calling convention it uses to jump to the
  kernel entry point (register state, cmdline location) — needed for
  §6 (boot chain).

## 3.4 Deciding native-driver vs. HAL-shim per subsystem

For each peripheral, decide:

- **Native mainline driver exists or is portable** (touch, sensors, most
  PMICs, often Wi-Fi/BT) → write/adapt a real Linux driver, get it talking
  directly to the kernel subsystem (`input`, `iio`, `drm`, `regulator`).
- **No open driver, blob required** (GPU, DSP/audio, camera ISP, modem) →
  plan to run the vendor's Android HAL for that subsystem inside the
  `libhybris`/Halium shim layer (§5), talking to the *existing, unmodified*
  vendor kernel driver for that piece while everything else runs a real
  Linux kernel+rootfs.

This mixed strategy — mainline kernel overall, with a thin
Android-compatibility shim for the handful of subsystems that are
infeasible to reverse engineer fully — is exactly how Halium/UBports and
most postmarketOS "non-mainline" device ports work, and is almost always
more realistic than fully reimplementing GPU/modem/DSP stacks from scratch.

## Next

→ [04-kernel-porting.md](04-kernel-porting.md) to turn this inventory into
a buildable kernel tree.
