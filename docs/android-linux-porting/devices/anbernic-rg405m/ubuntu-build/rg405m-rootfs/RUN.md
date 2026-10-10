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
If it errors fetching the base rootfs, the CI job URL in `mainline-rootfs-core.yaml`
has drifted — update it to the current UBports xenial arm64 rootfs artifact and re-run.

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
