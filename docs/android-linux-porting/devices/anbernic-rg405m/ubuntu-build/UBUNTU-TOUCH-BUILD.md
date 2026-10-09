# RG405M — building the Ubuntu Touch (Lomiri) rootfs (native, no Halium)

**This is the deliverable.** A native, Halium-less Ubuntu Touch image — the same
model UBports uses on mainline devices (PinePhone/PineTab): the UBports system
rootfs (Lomiri + Mir + systemd) on **our mainline 7.1 Panfrost kernel**, with Mir
on the **`gbm-kms`** platform and Mesa — no Android container, no libhybris, no
`hwcomposer`.

## Inputs (all already in hand)

- **Kernel:** mainline 7.1 `Image` + `ums512-rg405m.dtb` (Panfrost built-in,
  `arm,mali-bifrost` GPU node) — built on vivo, see [../profile.md](../profile.md) §4.
- **Kernel modules:** `make modules_install` from the same tree (most drivers are
  `=y`, so the module set is small).
- **Firmware + config:** Wi-Fi/BT/GNSS firmware + RF config + audio params from
  the OEM vendor — hashes/paths in [proprietary-files.txt](proprietary-files.txt).
- **Boot:** eMMC SPL already loads U-Boot from the SD `uboot` partition; SD layout
  per [FLASH.md](FLASH.md) (GPT `uboot` + FAT boot + ext4 root).

## How the native rootfs is obtained (resolved)

There is **no prebuilt generic native arm64 rootfs to download**: on
`system-image.ubports.com`, every modern arm64 base (20.04/24.04/26.04) is
**Halium/hybris-only**; the only *native/mainline* rootfs channels are
**16.04/xenial** (`16.04/arm64/mainline/*`, used by PinePhone/PineTab). So the
native UT rootfs is **built**, with UBports' **`rootfs-builder-debos`** (debos
recipe). It is **staged on kino at `~/rg405m/rootfs-builder-debos`**; `debos` is
apt-installable (26.04: `debos` 1.1.7).

- Base rootfs: `mainline-rootfs-core.yaml` pulls the generic UT **xenial/16.04
  mainline** rootfs from UBports CI + applies `mainline-rootfs-mods.yaml`.
  (That base is 16.04 because it's the only native one upstream; the in-recipe CI
  job URL drifts — let `debos` resolve it, or refresh from the current UBports CI.)
- Our device recipe: copy the **`pine64-*`** recipe set (arm64 + mainline + Mir,
  native) → an `rg405m` recipe. **GPU: use `scripts/enable-mesa.sh` (Mesa/Panfrost)
  — skip pine64's `pine64-mali.yaml` Mali-400 blob path**, since our G52 runs on
  open Panfrost.

## Build steps

1. **Build the base native rootfs** (on kino, once `debos` is installed):
   ```sh
   sudo apt install -y debos qemu-user-static   # qemu-user-binfmt already present
   cd ~/rg405m/rootfs-builder-debos
   # adapt from pine64-common.yaml → rg405m.yaml (arm64, Mesa, our kernel/dtb);
   # then run debos on it to produce the rootfs image/tarball.
   ```
2. **Lay it into an ext4 root** on the SD (p3), with the UBports rootfs as `/`.
3. **Kernel + modules + firmware onto the image:**
   - `Image` + `ums512-rg405m.dtb` → the FAT boot partition (+ `extlinux.conf`,
     `root=/dev/mmcblk0p3`), exactly like RGOS's layout so the SPL boots it.
   - `lib/modules/<kver>/` → the rootfs.
   - OEM firmware → `/lib/firmware` (and RF/audio config to the sprd paths).
4. **Graphics = native Mesa, Mir on `gbm-kms`:**
   - Install Mesa (Panfrost gallium) in the rootfs.
   - Set Mir/Lomiri to the **`gbm-kms`** platform (`MIR_SERVER_PLATFORM`/the
     `lomiri`/`unity8` session env), **not** the android/hwcomposer platform.
   - If Panfrost GL on the G52 proves insufficient (per the GPU gate), swap in our
     RE'd/custom Mali DRM driver + its Mesa backend — still `gbm-kms`.
5. **Device tweaks (the only real device-specific work):**
   - **Display:** 640×480 **rotate-270** in the Mir/Lomiri display config.
   - **Input:** touch via native `goodix`; gamepad is a native `js0`
     (`retrogame_joypad`) — map d-pad/A/B to Lomiri navigation, keep `js0` for games.
   - **Audio/Wi-Fi/BT/power:** native sprd/sc27xx drivers (PulseAudio/PipeWire,
     NetworkManager, BlueZ) — *if* the 7.1 tree is missing `sprdwcn`/`sc2730`,
     backport from RGOS first (see [../profile.md](../profile.md) §4).
6. **Assemble the SD image** (GPT: `uboot` + boot + root) and flash to a spare
   card. Boot via the existing SPL ([FLASH.md](FLASH.md)); console `/dev/ttyACM0`.

## Prerequisite: resolve the GPU gate first

Run [FIRST-BOOT-AND-GPU-CHECK.md](FIRST-BOOT-AND-GPU-CHECK.md) once (disposable
harness) to confirm Panfrost renders on the G52 and that Wi-Fi/audio come up on
the 7.1 kernel. That decides (a) Panfrost vs. our own Mali driver and (b) whether
any vendor-driver backport is needed — both of which feed step 4/5 here.

## Explicitly NOT part of this build

No `android-rootfs`/`system.img`, no `halium-boot`/`hybris-boot`, no `libhybris`,
no `hwcomposer`, no `proprietary-files.txt` HAL manifest, no Android container.
The only closed blobs are Wi-Fi/BT/GNSS **firmware** (kernel-loaded) + RF/audio
config — never GPU/HAL userspace.

## Open items to confirm

- The current UBports CI URL for the xenial mainline base rootfs (job names drift;
  `debos` run or the UBports CI dashboard gives the live one).
- **Base is 16.04/xenial** upstream — decide whether that's acceptable or we invest
  in a newer native base (not provided upstream; would be custom debos work).
- Whether `sprdwcn`/`sc2730` are present in the 7.1 tree or need backporting.
- Lomiri `gbm-kms` session wiring specifics on this Mir version.
