# 9. SoC Vendor Specifics

Everything in §1-§6 is written to be SoC-agnostic, but the exact tool,
file names, boot-ROM mode, and mainline driver maturity differ
significantly by chipset vendor. This chapter is the lookup table: find
your SoC family, then go back and apply §1-§6 with these specifics in
mind. If your device uses a chip not listed here, treat it as a strong
signal you're in genuinely uncharted territory — fall back to the generic
methodology and expect to do more from-scratch RE.

## 9.1 Qualcomm (Snapdragon)

- **Boot chain**: `PBL` (mask ROM) → `SBL1`/`XBL` → (`TZ`/`QSEE` secure
  monitor starts here) → `ABL` (Android Bootloader, a fork of Little
  Kernel/LK, this is what `fastboot` talks to) → `boot.img`.
- **Unbrick/full-dump mode**: **EDL (Emergency Download Mode / 9008 mode)**
  — entered via a short on a test point, a special button combo, or
  `adb reboot edl` if ADB is available. Gives raw Firehose-protocol access
  to flash/dump *any* partition, bypassing a locked bootloader's
  restrictions on reading (not writing signed partitions). Tools: `qdl`,
  `edl.py` (bkerler/edl), Qualcomm's own QFIL/QPST (Windows).
- **Partition/eMMC naming**: GPT with `by-name` symlinks
  (`/dev/block/by-name/boot`, `...xbl`, `...tz`, `...modem`, `...dsp`).
- **Clock/pinctrl in DT**: `qcom,gcc-<chip>` (Global Clock Controller),
  `qcom,tlmm` (Top Level Mode Multiplexer = pinctrl), `qcom,rpmh-*` (power
  domains on newer chips).
- **GPU**: Adreno — `qcom,adreno-<rev>`. Open driver: **Freedreno**
  (Mesa), covers most generations reasonably well; the vendor blob route
  (via Halium/libhybris) is the fallback for the newest chips Freedreno
  hasn't caught up to yet.
- **Modem**: separate `remoteproc` core (`qcom,mss`, "modem subsystem"),
  talked to over shared memory (`SMD`/`GLINK`) using **QMI**. Userspace:
  `qrtr`, `rmtfs`, ModemManager's QMI backend. Firmware stays untouched —
  this is the single most successful "never reimplement, just bridge"
  story in the whole mobile-Linux ecosystem.
- **Mainline status**: by far the best of any vendor — `qcom-mainline`
  kernel effort, most recent flagship SoCs (SM8450/SM8550 and newer) get
  mainline support within a year or two of release, maintained largely by
  Linaro/postmarketOS/Qualcomm-employed upstream developers.
- **Reference ports**: huge number of Halium and postmarketOS devices;
  this is the best-trodden path in the whole guide.

## 9.2 MediaTek

- **Boot chain**: **BootROM (BROM)** → **Preloader** → **LK (Little
  Kernel)**, MediaTek's own fork, plays the same bootloader role as
  Qualcomm's ABL → `boot.img`.
- **Unbrick/full-dump mode**: **BROM mode** — hold a specific button
  combo while connecting USB, before the Preloader even runs; BootROM
  exposes a USB download protocol. Tool: **`mtkclient`**
  (bkerler/mtkclient) — the MediaTek equivalent of EDL/qdl.
  **What BROM actually lets you do is set by the chip's SLA/DAA (Secure
  Login Authentication / Download Agent Authentication) fusing, which is
  independent of the Android-level "OEM unlock" toggle — the two don't
  track each other:**
  - **DAA not enforced** (common on older/budget SoCs) — BROM gives full
    read *and* write access to any partition, regardless of whether the
    Android bootloader is unlocked.
  - **DAA/SLA enforced** (more common on newer/flagship MTK chips) — BROM
    requires an authentication handshake first. Some configurations allow
    an unauthenticated **read-only** dump but block writes; others block
    both. `mtkclient` implements known per-chip-generation bypasses
    (e.g. "kamakiri", "hashimoto") for *some* SoCs, but this is a
    chip-specific exploit, not a general guarantee — check
    `mtkclient`'s own device-support notes for your exact chip before
    assuming either read or write access, and never assume BROM alone
    gives you a flashing/unbrick path until you've confirmed write access
    works on this specific device.
- **Partition naming**: GPT, similar `by-name` scheme; also has an older
  non-GPT "pmt"/legacy partition scheme on very old devices.
- **Clock/pinctrl in DT**: `mediatek,mt<chip>-pericfg`/`topckgen` (clock),
  `mediatek,mt<chip>-pinctrl`.
- **GPU**: PowerVR (older MT6xxx) or Arm Mali (newer MT6xxx/Dimensity).
  Mali has decent **Panfrost**/**Panthor** (Mesa) open-driver coverage for
  newer Midgard/Bifrost/Valhall GPUs; PowerVR has essentially no open
  driver — expect to need the vendor blob there.
- **Modem**: on many MediaTek phones the modem is integrated into the same
  die/firmware blob rather than a fully separate subsystem; protocol is
  MediaTek's own (not QMI) — this is usually the hardest part of a
  MediaTek port and the most likely subsystem to stay "Android-side only"
  indefinitely on an unsupported device.
- **Mainline status**: improving but behind Qualcomm — recent Dimensity
  chips have growing upstream support (Collabora/BayLibre-driven), but
  older MT65xx/MT67xx tablet-class chips are mostly community
  (`linux-mtk`/postmarketOS) rather than fully mainline.
- **Reference ports**: numerous Halium devices; `mtkclient`'s own wiki is
  also an excellent source of per-chip partition-layout and unbrick notes.

## 9.3 Samsung Exynos

- **Boot chain**: iROM (mask ROM) → `BL1` → `BL2` → **`sboot`**
  (Samsung's bootloader, descended from U-Boot on some generations) →
  kernel. Samsung devices additionally have **Odin download mode**
  (volume-button combo) as the primary flashing interface, using the
  proprietary Odin/Heimdall protocol rather than standard `fastboot` (many
  Samsung devices don't expose `fastboot` at all, or expose a crippled
  version).
- **Unbrick/full-dump/flash tool**: **Heimdall** (open-source, cross-platform
  Odin-protocol client) or Samsung's own Odin (Windows). Note many recent
  Samsung devices have **no official bootloader unlock** in some regions/
  carrier variants — check `Settings > Developer options > OEM unlocking`
  exists and is toggleable before planning a port; if it's absent, this is
  a hardware/firmware security boundary, not something this guide's
  methodology can get around.
- **Partition naming**: GPT, `by-name` symlinks similar to Qualcomm.
- **Clock/pinctrl in DT**: `samsung,exynos<chip>-clock`,
  `samsung,exynos<chip>-pinctrl`.
- **GPU**: Arm Mali (most Exynos) — good **Panfrost** coverage for
  mid-generation Midgard/Bifrost Mali, same as MediaTek's Mali devices.
  Some Exynos flagship SKUs instead ship a licensed AMD RDNA GPU ("Xclipse")
  with essentially no open driver yet.
- **Modem**: Samsung's own in-house modem (Shannon) on most Exynos
  phones, or a separate Qualcomm modem die on some regional variants
  (common on older Galaxy S models) — check which before assuming the
  Qualcomm QMI approach applies.
- **Mainline status**: solid for *standalone Exynos SoCs used outside
  Samsung's own phones* (Exynos Auto, some Chromebooks); phone-specific
  Exynos (Galaxy S/Note series) has an active but smaller mainlining
  community (`linux-exynos`, Simon Shields/others upstream work) compared
  to Qualcomm.
- **Reference ports**: Halium has several Exynos Galaxy devices; also
  check LineageOS's Exynos kernel trees, which are usually the most
  complete public source available for a given Galaxy model.

## 9.4 UNISOC (formerly Spreadtrum)

- **Boot chain**: BootROM → **FDL1/FDL2** (Flash Download agents,
  loaded over USB, analogous to Qualcomm's Firehose) → bootloader → kernel.
- **Unbrick/full-dump**: UNISOC's SPRD download-mode protocol. Tooling
  is fragmented and vendor/device-specific rather than one universal
  client: community reverse-engineered implementations exist (search
  `sprd_dump`/`unisoc` tooling on GitHub), and for Anbernic's T618/T820
  handheld line specifically, the `unisoc-unlock` Python package
  (`pip install unisoc-unlock`) and the GammaOS project's own flasher
  implement a working unlock/flash flow (confirmed via GammaOS's install
  docs — see `devices/anbernic-rg405m/profile.md` for the device-specific
  detail). Notably, this flow does **not** use the standard Android
  Developer-Options "OEM unlocking" toggle or AOSP `fastboot flashing
  unlock` — UNISOC bootloaders on these devices report their own native
  lock state (a boot-time "LOCK FLAG" message) and are unlocked through a
  vendor-specific USB protocol instead. Treat any given UNISOC device's
  actual unlock/dump tooling as something to search for by exact chip +
  device family, not assumed from this general entry.
- **Mainline/community status**: minimal — UNISOC chips (common in
  budget devices) have very little mainline Linux or Halium community
  support. A UNISOC device port is one of the more "from scratch" cases
  this guide's methodology is designed for; lean harder on §2 Ghidra RE
  since there's less prior art to diff against. The Anbernic/GammaOS
  T618 line is a notable exception with real, working community tooling
  — check for a similar project before assuming "from scratch" applies.

## 9.5 HiSilicon (Kirin) — legacy Huawei devices

- **Boot chain**: proprietary, loosely LK-derived on many models.
- **Status**: due to export restrictions and Huawei's own shift away from
  these chips in newer products, both official source availability and
  community porting activity are sparse. Treat similarly to UNISOC: budget
  for heavy from-scratch RE and expect limited prior art.

## 9.6 Older/tablet-class SoCs: Allwinner, Rockchip, NVIDIA Tegra

Common on tablets rather than phones, but the same pipeline applies and
these actually have **better** mainline support than most phone SoCs:

- **Allwinner**: BootROM → `boot0`/`u-boot` (genuinely U-Boot, not a
  fork-and-rename). Excellent mainline support via the `linux-sunxi`
  community; many Allwinner tablets run fully mainline Linux already.
  Tool: `sunxi-tools`.
- **Rockchip**: BootROM (maskrom mode) → `idbloader`/U-Boot. Strong
  mainline support (`linux-rockchip`), tool: `rkdeveloptool` for
  maskrom-mode flashing/dumping, very similar role to `qdl`/`mtkclient`.
- **NVIDIA Tegra**: BootROM → **NV-TBOOT**/U-Boot, APX/RCM recovery mode
  for unbrick (`nvflash`/`tegrarcm`). Long-running `linux-tegra` mainline
  effort; several community tablet ports exist.

If your "mobile device" is tablet-class on one of these three, you are in
the *best* supported corner of this entire guide — check
`linux-sunxi.org`, the Rockchip wiki, or `elinux.org`'s Tegra pages before
doing any Ghidra work at all; a huge fraction of the driver work is
probably already upstream.

## 9.7 Quick-reference summary table

| Vendor | Boot-ROM recovery mode | Dump/flash tool | GPU open-driver status | Mainline kernel maturity |
|---|---|---|---|---|
| Qualcomm | EDL (9008) | `qdl`, `edl.py`, QFIL | Freedreno (good) | Best |
| MediaTek | BROM | `mtkclient` | Panfrost (Mali, good) / none (PowerVR) | Improving |
| Samsung Exynos | Odin download mode | Heimdall, Odin | Panfrost (Mali, good) / none (Xclipse) | Moderate |
| UNISOC | FDL/SPRD download | community tools, immature | Varies, often poor | Minimal |
| HiSilicon Kirin | vendor-specific | sparse/community | Poor | Minimal |
| Allwinner | FEL/boot0 | `sunxi-tools` | Panfrost/Lima (good) | Excellent |
| Rockchip | Maskrom | `rkdeveloptool` | Panfrost (good) | Excellent |
| NVIDIA Tegra | APX/RCM | `nvflash`/`tegrarcm` | Nouveau (partial) | Good |

**None of these BootROM-level recovery modes are a guaranteed universal
read/write bypass** — each vendor gates the mode behind its own
authentication scheme, independent of the Android-level bootloader-unlock
toggle:

- **Qualcomm EDL**: the Sahara protocol that EDL speaks first needs a
  signed Firehose loader before it'll do much; a generic/leaked loader
  may give limited access, while the device's own vendor-signed loader
  (if you can obtain one) gives full read/write. Not every device's
  loader is publicly available.
- **MediaTek BROM**: gated by SLA/DAA fusing, as detailed in §9.2 above
  — full access on many older/budget chips, authenticated-only (and
  sometimes read-only, sometimes fully blocked) on others.
- **Samsung Odin mode**: generally works for read/write once in download
  mode, but Samsung's KNOX fuse trips (permanently) the moment you flash
  anything not Samsung-signed, which has consequences beyond this guide's
  scope (warranty, some KNOX-gated features) — know this before flashing,
  not after.
- **UNISOC/HiSilicon**: tooling is immature enough that read/write
  behavior is best treated as "unknown until tested" per device.

Treat every entry in this table as "the documented starting point to
investigate for this vendor," not "a guaranteed full-access backdoor" —
confirm actual read/write behavior on your specific chip/firmware
revision with the tool's own device-support notes before planning your
unbrick strategy (§6.5) around it.

## Next

→ [10-device-profile-template.md](10-device-profile-template.md) for a
fill-in worksheet that applies §1-§9 to one specific device, whatever its
SoC vendor.
