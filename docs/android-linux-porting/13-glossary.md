# 13. Glossary

Terms used throughout this guide, with the chapter where each matters most.

| Term | Meaning | See |
|---|---|---|
| **A/B partitions** | Two copies of system partitions (`boot_a`/`boot_b`, …) so updates install to the inactive slot. Affects which partition name you flash. | §1, §6 |
| **ABL** | Android Bootloader — Qualcomm's final bootloader stage (a Little Kernel derivative); what `fastboot` talks to. | §9.1 |
| **AOSP** | Android Open Source Project — the open-source base of Android, including tools like `mkbootimg`, `fastboot`, `avbtool`. | §1, §6 |
| **AVB** | Android Verified Boot — cryptographic verification of boot partitions, configured via `vbmeta`. Has a rollback index that only moves forward. | §6.3, §12.4 |
| **BROM** | MediaTek's BootROM — the mask-ROM first stage, with a USB download mode used by `mtkclient`/SP Flash Tool. Access gated by SLA/DAA. | §9.2 |
| **BSP** | Board Support Package — the vendor's kernel, drivers, and configs for a SoC/board. | §4.1 |
| **Bionic** | Android's C library. Incompatible with glibc, which is why `libhybris` exists. | §5 |
| **DAA / SLA** | Download Agent Authentication / Secure Login Authentication — MediaTek chip-level fusing that decides what BROM mode allows. Independent of the Android OEM-unlock toggle. | §9.2, §9.7 |
| **DT / DTB / DTS / DTBO** | Device Tree: hardware description the kernel reads at boot. DTB = compiled binary, DTS = source text, DTBO = overlay partition applied on top. | §1.3, §4.3 |
| **`compatible` string** | The DT property that binds a hardware node to a driver (e.g. `qcom,adreno-...`). The key to matching vendor hardware with mainline drivers. | §3.2 |
| **EDL** | Qualcomm Emergency Download mode (USB "9008"), speaking Sahara then Firehose. Needs a signed loader for full access. | §9.1, §9.7 |
| **eMMC / UFS** | The two common phone storage types. Same dump workflow; UFS is faster and shows up as SCSI (`sd*`) devices. | §1.7 |
| **FDL1/FDL2** | UNISOC's Flash Download agents, loaded over USB in download mode (role similar to Qualcomm Firehose). | §9.4 |
| **Firehose / Sahara** | The two protocols in Qualcomm EDL: Sahara loads a programmer, Firehose (the programmer) reads/writes flash. | §9.7 |
| **GKI** | Generic Kernel Image — Google's push (Android 12+) to a common kernel with vendor code in loadable modules. Splits boot into `boot` + `vendor_boot`. | §4, §6.4 |
| **GPL** | GNU General Public License. The Linux kernel is GPLv2, so vendors must provide kernel source on request. | §4.1 |
| **HAL** | Hardware Abstraction Layer — Android's userspace driver layer (`.so` files in `/vendor/lib*/hw/`). HIDL/AIDL define its interfaces. | §2, §5 |
| **Halium** | Project providing a common Android-hardware base for Linux mobile OSes, using `libhybris` to run vendor HALs. | §5.1, §8 |
| **`ikconfig`** | Kernel option that embeds the build `.config` in the kernel (`/proc/config.gz`), recoverable with `extract-ikconfig`. | §1.4 |
| **KNOX fuse** | Samsung's one-time hardware fuse, permanently tripped by flashing unsigned firmware. A restore doesn't reset it. | §9.7, §12.4 |
| **`libhybris`** | Compatibility layer that lets glibc-based Linux userspace load Bionic-based Android HAL libraries. | §5.1 |
| **LK** | Little Kernel — small bootloader OS used (in forked form) by MediaTek and older Qualcomm devices. | §9.2 |
| **Mainline** | The upstream Linux kernel (`torvalds/linux`), as opposed to a vendor's downstream fork. | §4.2 |
| **Mask ROM / BootROM** | Immutable first-stage code in the SoC. Its USB recovery modes (EDL, BROM, maskrom, FEL, APX) are the deepest dump/unbrick paths. | §9 |
| **Mesa: Freedreno / Panfrost / Panthor / Lima** | Open GPU drivers: Freedreno (Qualcomm Adreno), Panfrost (Arm Mali Midgard/Bifrost/Valhall-JM), Panthor (Mali Valhall-CSF), Lima (Mali Utgard). | §9 |
| **OEM unlock** | Android Developer-Options toggle permitting `fastboot flashing unlock`. Not all vendors provide it; UNISOC devices may use their own mechanism. | §6.1, §9.4 |
| **pmbootstrap** | postmarketOS's build/flash/porting tool. | §5.3 |
| **Preloader** | MediaTek's second boot stage, between BROM and LK. | §9.2 |
| **QMI** | Qualcomm MSM Interface — the protocol for talking to Qualcomm's modem and other remote processors. | §5, §9.1 |
| **remoteproc** | Linux framework for booting and managing co-processors (modem, DSP). | §3.2 |
| **Reserved memory** | DT-declared RAM regions owned by firmware (TrustZone, modem, DSP). Must match the vendor's DT exactly or boot will fail. | §3.3, §4.3 |
| **RPMB** | Replay Protected Memory Block — authenticated storage area on eMMC/UFS used by secure firmware. Not something you dump or need. | §1.7 |
| **Scatter file** | MediaTek's partition-layout file (e.g. `MT6873_Android_scatter.txt`) used by SP Flash Tool. | §9.2 |
| **SMC** | Secure Monitor Call — the ARM instruction the normal-world kernel uses to call into TrustZone. | §2.6 |
| **SoC** | System on Chip — CPU, GPU, modem, DSP and controllers on one die. | §3.1 |
| **Sparse image** | Android's compressed partition-image format; convert with `simg2img` before mounting. | §1.5 |
| **TrustZone / TEE** | ARM's secure world and the trusted OS running there (QSEE, TEEGRIS, etc.). Usually left untouched. | §2.6 |
| **UART** | Serial console, often via board test points. The most reliable first-boot debug output. | §5.4, §11 |
| **vbmeta** | The partition holding AVB verification metadata. | §6.3 |
| **`vendor_boot`** | Partition (boot header v3+) holding the vendor ramdisk and DTB, split out from `boot`. | §6.4 |
