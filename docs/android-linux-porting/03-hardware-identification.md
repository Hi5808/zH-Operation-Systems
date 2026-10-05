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
  every phone using that chip, so you may inherit much of the kernel
  from an existing port and only need device-specific peripheral work.

## 3.2 Peripheral inventory checklist

Walk the `.dts` node by node; for each, note: compatible string, bus
(I2C/SPI/MIPI/USB), GPIO/IRQ lines, regulators, and whether mainline Linux
already has a driver for that `compatible` string (check
`drivers/*/Kconfig` / `MODULE_DEVICE_TABLE` in current Linux source).

| Subsystem | Where to look | Common finding |
|---|---|---|
| Display panel | `dsi@.../panel@0` node, `vendor/lib/modules/*panel*` | Check `drivers/gpu/drm/panel/` upstream first. Mainline's generic `panel-simple` only covers panels that need no init commands; most phone DSI panels need a small dedicated driver built from the init sequence (§2.3). For Qualcomm downstream DTs, `linux-mdss-dsi-panel-driver-generator` (msm8916-mainline project) generates that driver from the vendor DT automatically |
| Touchscreen | I2C node under `soc/i2c@.../touch@..` | Synaptics/FocalTech/Goodix/ILITEK chips mostly have mainline drivers already — the work is usually just DT wiring, not new driver code |
| GPU | `gpu@..` compatible (`qcom,adreno-...`; Mali uses `arm,mali-*` such as `arm,mali-bifrost`/`arm,mali-valhall-jm`, often alongside an SoC-specific compatible) | Reused via vendor blob + `libhybris`, or an open driver (Freedreno for Adreno, Panfrost/Panthor/Lima for Mali) depending on generation — see [09-soc-vendor-specifics.md](09-soc-vendor-specifics.md) §9.1-§9.6 for which applies to your vendor |
| Audio codec/DSP | `sound`, `qcom,apr*`/`qcom,q6*`, `mediatek,mt*-afe*` nodes | Often the hardest subsystem regardless of vendor; may need the vendor's DSP firmware kept as-is, with only the AP-side kernel driver ported |
| Modem | `remoteproc@..`, `qcom,mss`, or vendor-specific equivalent | Reuse vendor modem firmware + a compatible protocol stack (`qrtr`/`rmtfs`/ModemManager on Qualcomm; vendor-specific and often less mature elsewhere — see §9) — essentially never reimplemented from scratch |
| Wi-Fi/BT | `wifi@../bluetooth@..`, usually SDIO/PCIe/USB | Mainline `ath10k`/`ath11k` (Qualcomm, incl. WCN3990 via ath10k), `wcn36xx`, `brcmfmac` (Broadcom/Cypress), `mt76` (MediaTek) frequently already support the chip — check firmware blob naming under `vendor/firmware/` |
| Sensors (accel/gyro/light/prox) | I2C nodes, `iio` subsystem | Almost always already mainlined (Bosch BMI, InvenSense ICM/MPU, STMicro) — vendor-independent, these chips are shared across the whole industry |
| Fingerprint | Often SPI, vendor-proprietary | Usually unsupported upstream; lowest priority, frequently skipped in community ports |
| Battery/charging/PMIC | `qcom,pm8998`, `mediatek,mt6358`, `samsung,s2mps*`, etc. | Usually has solid mainline support per PMIC family, independent of the AP SoC vendor |
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
  initramfs in memory — taken from the stock `boot.img` header (§1.3),
  needed for §6. On arm64 you don't need to reverse engineer the jump
  into the kernel: the handoff is standardized (DTB physical address in
  `x0`, MMU off) by the kernel's `Documentation/arch/arm64/booting.rst`,
  and the command line travels inside the DTB's `/chosen` node. 32-bit
  ARM devices are similar but may still pass ATAGs on very old
  bootloaders.

## 3.4 Identifying hardware from the running device

If stock Android still boots, the live system often answers §3.2 faster
than the dumped `.dts`, because it shows what actually probed:

```bash
# Full live device tree (needs dtc on the host; pull the tree first)
adb shell "su -c 'tar -C /sys/firmware/devicetree -cf - base'" > dt.tar
mkdir dt && tar -xf dt.tar -C dt && dtc -I fs -O dts -o live.dts dt/base

adb shell ls /sys/bus/i2c/devices/          # every I2C device the kernel bound
adb shell "cat /sys/bus/i2c/devices/*/name" # their driver/chip names
adb shell cat /proc/interrupts              # which drivers own which IRQs
adb shell "su -c lsmod"                     # vendor modules actually loaded
adb shell "su -c dmesg" > dmesg.txt         # probe messages name chips and firmware files
adb shell getevent -il                      # input devices: touchscreen, buttons, sticks
adb shell dumpsys sensorservice             # sensor list with vendor and model names
adb shell ls /sys/class/power_supply/       # battery/charger driver names
```

Some of these need root (`su`) on recent Android versions; `getevent`
and `dumpsys` generally work over plain `adb shell`. The live tree
matters because the dumped DTB may contain several board variants, while
`/sys/firmware/devicetree` shows the one this unit actually booted with.

## 3.5 Deciding native-driver vs. HAL-shim per subsystem

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
