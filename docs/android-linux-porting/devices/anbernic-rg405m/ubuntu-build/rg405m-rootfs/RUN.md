# RG405M native Ubuntu Touch — build + assemble

Prereqs on kino: `sudo apt install -y debos qemu-user-static` (qemu-user-binfmt
already installed). The mainline 7.2.9 kernel is already built; its modules are
staged in `rg405m/modules/`, and the `Image`+`dtb` are in
`~/rg405m/kernel-mainline/linux-7.2.9/arch/arm64/boot/`.

## 1. Build the native UT rootfs (needs sudo; downloads packages)
```sh
cd ~/rg405m/rootfs-builder-debos
sudo debos rg405m.yaml      # -> rg405m-ut-rootfs.tar.gz (native Lomiri rootfs)
```
### ⚠️ Base-rootfs blocker (confirmed 2026-10-10) and options

`rootfs-builder-debos`'s `mainline-rootfs-core.yaml` downloads the base rootfs from
`ci.ubports.com/job/xenial-…-rootfs-arm64` — that **Jenkins job is dead (404)**;
16.04/xenial is EOL and even upstream `main` still points at it. So `sudo ./go.sh`
fails immediately at "Download latest ubuntu touch rootfs from CI".

**Live alternative found:** the native UT rootfs is still served by the
system-image OTA server, e.g. (16.04/arm64/mainline, devel, v1133):
`https://system-image.ubports.com/pool/ubports-0c802f412bf028e1664fe39e54ea58fe6d180131161773bda89efdadecc79ad0.tar.xz`
(357–379 MB). **But** it unpacks under a **`system/` prefix** (system-image
read-only-rootfs format), not as a plain rootfs — so it needs the recipe's
download+unpack replaced with a host extract that strips `system/`
(`tar -xJ --strip-components=1 -C $ROOTDIR`), plus handling of the UBports
system-image overlay model. Non-trivial, and 16.04 is a dead-end base anyway.

**Two real paths (pick one):**
1. **Adapt to the system-image tarball** — rewrite the core recipe's fetch/unpack
   to the live URL above with `--strip-components=1`; iterate on the overlay model.
   Gets a 16.04 native base soonest.
2. **Build the rootfs from scratch** (debootstrap + the UBports Lomiri/Mir apt
   repos) — more work, but base-version-agnostic and the only sane route to the
   **24.04/26.04** bases (which have no native prebuilt at all). The right
   long-term path for "all 3".

The mainline **7.2.9 kernel is built and independent of this** — it drops onto
whichever rootfs we produce.

## 2. Assemble the SD (reuse the proven SPL-compatible layout)
Start from the existing Ubuntu SD image (gives the `uboot` partition the eMMC SPL
already boots), then swap in our kernel + rootfs. On a **spare** card `/dev/sdX`:
```sh
# base layout (uboot + FAT boot + ext4 root), SPL-compatible:
sudo dd if=~/rg405m/kernel-mainline/../rg405m-ubuntu-sdcard.img of=/dev/sdX bs=4M conv=fsync status=progress; sync
# --- FAT boot partition (p2): our 7.2.9 kernel + dtb + extlinux ---
sudo mount /dev/sdX2 /mnt
sudo cp ~/rg405m/kernel-mainline/linux-7.2.9/arch/arm64/boot/Image /mnt/Image
sudo cp ~/rg405m/kernel-mainline/linux-7.2.9/arch/arm64/boot/dts/sprd/ums512-rg405m.dtb /mnt/ums512-rg405m.dtb
sudo mkdir -p /mnt/extlinux && sudo cp ~/rg405m/rootfs-builder-debos/rg405m/extlinux.conf /mnt/extlinux/extlinux.conf
sudo sync && sudo umount /mnt
# --- ext4 root (p3): the native UT rootfs ---
sudo mkfs.ext4 -F -L rgrotate-root /dev/sdX3
sudo mount /dev/sdX3 /mnt
sudo tar -xpf rg405m-ut-rootfs.tar.gz -C /mnt
sudo sync && sudo umount /mnt
```
(If the UT rootfs tarball has a top-level dir, extract its contents to `/mnt` root.)

## 3. Boot
Spare card in → power on → eMMC SPL → SD U-Boot → extlinux → 7.2.9 kernel →
native Lomiri. Console: `/dev/ttyACM0` once USB gadget is up; panel is `tty0`.
Pull the card → stock Android. See FIRST-BOOT-AND-GPU-CHECK.md for the GPU gate.

## Notes
- No Halium/libhybris: GPU is Mesa Panfrost on `/dev/dri/renderD128` (gbm-kms).
- Wi-Fi (`sprdwcn`) + audio (VBC/sc2730) are deferred — not built into 7.2.9 yet.
- Display rotate-270 is via the extlinux cmdline for the console; Lomiri's own
  display rotation is tuned on first boot.
