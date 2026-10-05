# 20. Credits & Reference Resources

Nothing in this guide is done from a blank slate (§"A note on ownership
and credit" in [00-overview.md](00-overview.md)). This chapter names the
projects, trees, and communities whose work a port actually stands on,
organized by what they provide. Credit them when you use them — link the
project, keep its notices — and prefer them over re-deriving anything
(§4.1). This list is a starting map, not exhaustive; add to it as you
find more, and treat your own finished port as the next entry.

## 20.1 Kernel sources & BSP trees

| Source | Provides |
|---|---|
| **Linux mainline** (`git.kernel.org`, `github.com/torvalds/linux`) + the stable trees | The upstream kernel and every mainlined driver — the long-term target (§4.2) |
| **Android Common Kernel** (`android.googlesource.com/kernel/common`) | The GKI branches vendor modules are built against (§4.7) |
| **LineageOS kernel trees** (`github.com/LineageOS/android_kernel_<vendor>_<chip>`) | Cleaned-up, buildable vendor kernel source for a huge range of devices (§4.1, §8) |
| **Qualcomm via CodeLinaro** (`git.codelinaro.org`, ex-CodeAurora) | Qualcomm's released BSP kernel/bootloader source (§4.1) |
| **MediaTek GPLv2 kernel releases** | MediaTek BSP source where published (§4.1, §9.2) |
| **Vendor OSS compliance drops** (per-OEM) | The GPL-required source for your exact device — the first thing to look for (§4.1) |

## 20.2 Device tree (DTS/DTB) references

| Source | Provides |
|---|---|
| mainline `arch/arm64/boot/dts/<vendor>/` | Canonical, reviewed DTs for supported boards — the model to match (§4.3) |
| The vendor BSP's own `.dts`/`.dtsi` | Your device's real DT (prefer over a decompiled `.dtb`, §4.3) |
| **`linux-mdss-dsi-panel-driver-generator`** (msm8916-mainline) | Generates a mainline panel driver + DT from a Qualcomm downstream panel DT (§3.2) |
| postmarketOS / Halium / UBports device trees | Per-device DTs to diff against for the same SoC (§8) |

## 20.3 Driver & subsystem references

| Subsystem | Upstream project(s) | Notes |
|---|---|---|
| GPU | **Mesa** — Freedreno (Adreno), Panfrost / Panthor (Mali), Lima (older Mali) | The open GPU drivers; see §9 for which fits your chip |
| Display panels | kernel `drivers/gpu/drm/panel/`, `drm_panel` / `panel-mipi-dbi` | Where a RE'd panel init sequence (§2.9) becomes a driver |
| Camera | **libcamera** (libcamera.org) | Open ISP pipeline handlers where they exist (§19.2) |
| Modem | **ModemManager**, **libqmi**/**libmbim**, **oFono**, `qrtr`, `rmtfs`, `pd-mapper` | The Qualcomm QMI userspace stack (§19.3) |
| Audio | **ALSA** + **UCM**, **PipeWire**, **PulseAudio** (`pulseaudio-modules-droid` for the Halium path) | DSP routing lives in UCM (§19.1) |
| Sensors | kernel **IIO** subsystem, `iio-sensor-proxy` | Most sensor chips are already mainlined (§3.2) |
| Input / touch | kernel `drivers/input/` (`goodix`, `focaltech`, `synaptics`, …) | Touch controllers usually have a mainline driver (§2.9, §3.2) |
| Wi-Fi/BT | `ath10k`/`ath11k`, `wcn36xx`, `brcmfmac`, `mt76` + linux-firmware | Driver + per-board calibration firmware (§3.2, §11.3) |

## 20.4 Reverse-engineering & flashing tooling

Full install details are in [07-tools-reference.md](07-tools-reference.md);
the people and projects behind them:

- **Ghidra** (NSA) — the decompiler this guide's §2 is built around, plus
  PyGhidra and `analyzeHeadless` for scripting.
- **bkerler** — `mtkclient` (MediaTek BROM) and `edl` (Qualcomm EDL).
- **patrislav1** — `unisoc-unlock` (UNISOC, §9.4).
- **osm0sis** — Android-Image-Kitchen; **vm03** / **ssut** — payload
  dumpers; **PabloCastellano** — `extract-dtb`.
- **erofs-utils**, AOSP `mkbootimg`/`avbtool`, `simg2img`.
- Per-vendor flashers: **Heimdall** (Samsung), `sunxi-tools` (Allwinner),
  `rkdeveloptool` (Rockchip), `qdl` (`linux-msm`).
- **libhybris** and **droidmedia** — the Bionic↔glibc bridge and media
  bridge the whole Halium approach depends on (§5.1).

## 20.5 Communities & knowledge bases

- **postmarketOS** — `pmbootstrap`, the porting wiki, and per-device
  status pages; the template for how this guide tracks devices (§8, §10).
- **UBports / Ubuntu Touch** — the longest-running community mobile-Linux
  OS and its porting docs (§8).
- **Halium** — the shared Android-hardware base (§5.1, §8).
- **Sailfish OS / Jolla & the Mer/Nemo** lineage — a long history of
  `libhybris` ports and documentation (§8).
- **Mainline SoC communities & lists** — `linux-arm-msm` (Qualcomm),
  `linux-mediatek`, `linux-samsung-soc` (Exynos), `linux-sunxi`,
  `linux-rockchip`, `linux-tegra`; and the companies doing much of the
  upstream work (Linaro, Collabora, BayLibre) (§8, §9).
- **Device-specific projects** — e.g. **GammaOS** (`TheGammaSqueeze`) and
  **RGOS** for the UNISOC T618 handhelds (§8), and indexes like
  `awesome-anbernic`. Find the equivalent for your device before
  assuming "from scratch" (§16).
- **elinux.org**, the **linux-sunxi wiki**, and device forums — scattered
  but often the only record of a specific board's test points or quirks
  (§15).

## 20.6 How to credit, concretely

- In a device profile or `re-notes.md`: name the tree/tool you diffed
  against or reused, with a link (§CONTRIBUTING).
- In code you upstream: `Co-developed-by:`/`Signed-off-by:`,
  `Suggested-by:`, and keep original authorship and license headers
  (§14).
- Never strip a license notice or present reused engineering as
  from-scratch work. That's the line the whole ecosystem depends on
  (§"A note on ownership and credit").

## Next

→ Back to [00-overview.md](00-overview.md). If this guide helped, the
best thanks is to add your device's port to the map for the next person.
