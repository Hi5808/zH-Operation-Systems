# 5. Userspace: Halium Shim vs. Native Rootfs

With a booting kernel (§4), this stage builds what actually runs on top of
it.

## 5.1 Two strategies, and when to mix them

### A. Halium / libhybris compatibility shim

Used by UBports (Ubuntu Touch), postmarketOS's "Halium" devices, and
Sailfish OS's `hybris` ports. Runs a *container* with the original
Android userspace (HALs, `init`, `surfaceflinger` or a GPU shim) inside a
chroot/LXC namespace alongside a normal Linux rootfs, bridged by
`libhybris`, which translates Bionic-ABI calls from the Android HAL `.so`
into glibc-compatible calls the Linux side can use (and vice versa for
things like EGL/GL).

Use this for any subsystem you decided in §3.4 needs the vendor blob:
GPU, camera ISP, DSP-based audio, modem.

```
┌─────────────────────────────────────────┐
│     Linux rootfs (Debian/Ubuntu Touch)    │  <- real init, real Wayland/X11,
│     glibc userspace, systemd/initrd       │     real apps
├─────────────────────────────────────────┤
│   libhybris bridge (bionic <-> glibc)     │
├─────────────────────────────────────────┤
│  Android HAL container ("hybris-boot")    │  <- vendor .so HALs, unmodified,
│  minimal Android init, bionic libc        │     from the dumped /vendor, /system
├─────────────────────────────────────────┤
│         Ported Linux kernel (§4)           │  <- vendor .ko for GPU/modem/DSP
│   (native drivers for touch/sensors/etc)   │     mainline-ish drivers for the rest
└─────────────────────────────────────────┘
```

Key tools/repos: `libhybris`, `halium-boot`/`hybris-boot`, `droidmedia`
(camera/media bridge), `android_vendor_<device>` trees (packaging of the
dumped vendor blobs for the build system), `pmbootstrap` (postmarketOS) or
UBports' `clickable`/device porting guide.

### B. Fully native Linux (no Android container at all)

Used by PinePhone-class devices and any SoC with strong mainline support.
Every subsystem has a real Linux driver and a real open userspace stack
(Mesa for GPU, PulseAudio/PipeWire + ALSA for audio, ModemManager +
oFono/mbim/qmi for modem, etc.). No vendor blobs beyond non-executable
firmware files (which is normal and fine — firmware blobs loaded via
`request_firmware()` are not "running Android code").

Use this for subsystems you decided in §3.4 already have mainline drivers.

### Realistic default

Almost every real-world device port is a **mix**: native drivers for
touch/sensors/PMIC/Wi-Fi, Halium shim for GPU/modem/camera, exactly per the
per-subsystem decisions made in §3.4. You are not choosing A or B for the
whole device — you're choosing per subsystem.

## 5.2 Building the Halium container (if needed)

```bash
# halium-devices style device repo layout:
#   device/<vendor>/<codename>/      -> kernel config, DT, this device's manifest
#   vendor/<vendor>/<codename>/      -> proprietary-blobs.txt listing exactly
#                                       which /vendor,/system files to extract
#                                       from the user's own dump (never checked
#                                       into git as binaries)
./build.sh -d <codename>             # halium build system; produces
                                      # system.img equivalent containing the
                                      # bionic/HAL side
```

The `proprietary-blobs.txt` pattern is the standard, legally clean way to
handle vendor binaries: the repo only contains a *list of paths*; the
build script extracts those exact files from the firmware dump the
*device owner* already has, at build time, on their own machine. Follow
this pattern for anything proprietary in this repo too.

## 5.3 Building the Linux rootfs

```bash
# postmarketOS path (recommended starting point; it already has Halium
# device-porting docs and infra: https://wiki.postmarketos.org/wiki/Porting_to_a_new_device)
pmbootstrap init
pmbootstrap checkout device/<new-device>    # or create a new device port dir
pmbootstrap build linux-<codename>
pmbootstrap install
pmbootstrap export

# or plain debootstrap for a from-scratch Debian/Ubuntu rootfs:
debootstrap --arch=arm64 --foreign bookworm rootfs/ http://deb.debian.org/debian
```

## 5.4 First-boot debugging essentials

- Serial console (UART test points, or `qcom,geni-debug-uart`/similar DT
  node) is worth far more than guessing from a black screen — wire it up
  before your first flash attempt if the board exposes test points.
- `earlycon`/`earlyprintk` kernel cmdline args to get boot log before the
  real console driver is up.
- Keep `fastboot boot <image>` (boots without flashing) as your iteration
  loop wherever the bootloader supports it, instead of flashing every
  attempt.

## Next

→ [06-bootloader-and-flashing.md](06-bootloader-and-flashing.md) to wire
the boot chain together and produce a flashable image.
