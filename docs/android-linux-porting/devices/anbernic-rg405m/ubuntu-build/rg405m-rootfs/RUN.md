# RG405M native Ubuntu Touch — build + assemble (from scratch, no Halium)

Builds the native UT rootfs the way UBports builds its modern bases: **Ubuntu Base
+ `repo.ubports.com` + the native `mainline` UT variant** (`ubuntu-touch-core-mainline`
/ `ubuntu-touch-mainline` / `ubuntu-touch-session-wayland`) — no Halium/libhybris —
on our mainline **7.2.9-sprd-ums512** kernel, GPU via Mesa Panfrost (gbm-kms).

Prereqs on kino (already satisfied): `debos` installed, `qemu-user-binfmt` present.
Kernel `Image`+`dtb` built at `~/rg405m/kernel-mainline/linux-7.2.9/arch/arm64/boot/`;
its 149 `.ko` modules staged in `rg405m/modules/`.

## 1. Build the rootfs (needs sudo; downloads ~hundreds of packages)
Staged at `~/rg405m/rootfs-builder-debos/`. Recipe = `rg405m.yaml` (default base **24.04**).
```sh
cd ~/rg405m/rootfs-builder-debos
sudo ./go.sh                       # 24.04 -> rg405m-ut-24.04-rootfs.tar.gz
# 26.04 instead:
sudo debos -t ubuntu_base_version:26.04 -t ut_aptly_archive:26.04-1.x rg405m.yaml
```
(16.04 is a separate legacy path via the system-image rootfs — not this recipe.)

> **fakemachine resources:** `go.sh` runs `debos --memory=6G --scratchsize=20G`.
> The default VM (~2G RAM / ~4G scratch) OOM'd mid Lomiri apt-install. The recipe
> is written for fakemachine (hardcodes its `/scratch`), so `--disable-fakemachine`
> is NOT viable here — bump the VM instead. Host has 30G RAM / 95G disk.


Notes:
- `ubuntu-touch/common-base.yaml` was made version-overridable (its hardcoded
  `26.04`/`26.04-1.x` became `or .ubuntu_base_version`/`or .ut_aptly_archive`).
- `variant: mainline` selects the **native** UT stack (confirmed present in both
  `24.04-1.x` and `26.04-1.x` arm64 UBports dists).

## 2. Assemble the SD (reuse the SPL-compatible layout)
Start from the existing Ubuntu SD image (gives the `uboot` partition the eMMC SPL
boots), then swap in our 7.2.9 kernel + the UT rootfs. On a **spare** card `/dev/sdX`:
```sh
sudo dd if=~/rg405m/rg405m-ubuntu-sdcard.img of=/dev/sdX bs=4M conv=fsync status=progress; sync
# FAT boot (p2): our kernel + dtb + extlinux
sudo mount /dev/sdX2 /mnt
sudo cp ~/rg405m/kernel-mainline/linux-7.2.9/arch/arm64/boot/Image /mnt/Image
sudo cp ~/rg405m/kernel-mainline/linux-7.2.9/arch/arm64/boot/dts/sprd/ums512-rg405m.dtb /mnt/ums512-rg405m.dtb
sudo mkdir -p /mnt/extlinux && sudo cp ~/rg405m/rootfs-builder-debos/rg405m/extlinux.conf /mnt/extlinux/extlinux.conf
sudo sync && sudo umount /mnt
# ext4 root (p3): the native UT rootfs
sudo mkfs.ext4 -F -L rgrotate-root /dev/sdX3
sudo mount /dev/sdX3 /mnt
sudo tar -xpf rg405m-ut-24.04-rootfs.tar.gz -C /mnt
sudo sync && sudo umount /mnt
```

## 3. Boot
Spare card in → SPL → SD U-Boot → extlinux → 7.2.9 kernel → native Lomiri (Mir on
`gbm-kms`/Mesa Panfrost). Console `/dev/ttyACM0`; panel `tty0`. Pull card → stock
Android. See FIRST-BOOT-AND-GPU-CHECK.md for the GPU gate.

## Deferred
Wi-Fi (`sprdwcn`) + audio (VBC/sc2730) aren't in mainline 7.2.9 yet — add in a
later kernel pass. Display rotate-270 is via the extlinux cmdline; Lomiri's own
rotation + gamepad→nav mapping are tuned on first boot.
