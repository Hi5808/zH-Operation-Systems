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

Use this for any subsystem you decided in §3.5 needs the vendor blob:
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
UBports' device porting docs (docs.ubports.com).

### B. Fully native Linux (no Android container at all)

Used by PinePhone-class devices and any SoC with strong mainline support.
Every subsystem has a real Linux driver and a real open userspace stack
(Mesa for GPU, PulseAudio/PipeWire + ALSA for audio, ModemManager +
oFono/mbim/qmi for modem, etc.). No vendor blobs beyond non-executable
firmware files (which is normal and fine — firmware blobs loaded via
`request_firmware()` are not "running Android code").

Use this for subsystems you decided in §3.5 already have mainline drivers.

### Realistic default

Almost every real-world device port is a **mix**: native drivers for
touch/sensors/PMIC/Wi-Fi, Halium shim for GPU/modem/camera, exactly per the
per-subsystem decisions made in §3.5. You are not choosing A or B for the
whole device — you're choosing per subsystem.

## 5.2 Building the Halium container (if needed)

```bash
# halium-devices style device repo layout:
#   device/<vendor>/<codename>/      -> kernel config, DT, this device's manifest
#   vendor/<vendor>/<codename>/      -> proprietary-blobs.txt listing exactly
#                                       which /vendor,/system files to extract
#                                       from the user's own dump (never checked
#                                       into git as binaries)
# Build commands differ by Halium version (7.1 / 9 / 10+ / GSI-based);
# follow the porting guide for the version you target rather than a
# fixed command here: https://docs.halium.org and docs.ubports.com
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
pmbootstrap aportgen device-<vendor>-<codename>   # scaffold a new device package
pmbootstrap aportgen linux-<vendor>-<codename>    # scaffold its kernel package
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

## 5.5 Bring-up order

Bring subsystems up in an order where each one gives you the tools to
debug the next:

1. **Serial console** (§15): kernel log before anything else works.
2. **USB networking**: the kernel's USB gadget (RNDIS/NCM via configfs)
   gives you SSH over the USB cable with no display or Wi-Fi.
   postmarketOS enables this by default in its initramfs and documents
   the device address and debug shell on its wiki.
3. **Storage/rootfs mounted**: the system actually boots past initramfs.
4. **Display**, then **touch/buttons**: you can see and interact.
5. **Battery/charging**: before long sessions, so you don't drain the
   device on a kernel that doesn't charge.
6. **Wi-Fi/Bluetooth**, then **audio**, then **modem**, then **camera**,
   roughly in increasing order of difficulty.

## 5.6 The stack per subsystem, on each path

Which userspace component talks to each subsystem depends on whether it
runs natively (§5.1B) or through the Android container (§5.1A):

| Subsystem | Native (mainline drivers) | Halium / libhybris path |
|---|---|---|
| GPU / display | Mesa (Freedreno, Panfrost/Panthor, …) + KMS/DRM | Vendor EGL/GLES via `libhybris`; display via the vendor hwcomposer HAL |
| Audio | ALSA + UCM profiles, PipeWire or PulseAudio | PulseAudio's droid modules talking to the vendor audio HAL |
| Modem | ModemManager (QMI/MBIM, Qualcomm especially) | oFono with a binder/RIL plugin talking to the vendor radio HAL |
| Camera | libcamera (where supported) | `droidmedia` + GStreamer `gst-droid` |
| Sensors | IIO + `iio-sensor-proxy` | Vendor sensors HAL via a hybris sensor bridge |
| Wi-Fi/BT | Mainline driver + firmware, NetworkManager/BlueZ | Usually still native kernel driver + firmware; Android only for unusual vendor stacks |

Component names on the Halium side differ between distributions
(Ubuntu Touch, Droidian, Sailfish OS). Check the distribution you're
targeting for the exact packages rather than mixing parts across them.

## 5.7 Choosing a distribution and UI

| Option | Base | Path | Notes |
|---|---|---|---|
| **postmarketOS** | Alpine | Native, and downstream kernels | UIs: Phosh, Plasma Mobile, Sxmo, others. Best tooling for new device ports (`pmbootstrap`). |
| **Mobian** | Debian | Native | Phosh-focused; best for devices with good mainline support. |
| **Droidian** | Debian | Halium | Phosh on top of the Android container — good fit for devices that need vendor HALs. |
| **Ubuntu Touch** (UBports) | Ubuntu | Halium | Lomiri UI; large existing Halium device base. |
| **Sailfish OS** | Own (Mer/Nemo) | libhybris | Proprietary UI layer on an open base; long history of hybris ports. |

Rule of thumb: if §3.5 put GPU, audio and modem on the native path, start
with postmarketOS or Mobian. If those subsystems need vendor HALs, start
with Droidian or Ubuntu Touch, whose tooling assumes the Halium path.

## 5.8 What "done" means

A port is usable day-to-day when the profile's Status table (§10) shows
working display, touch, charging, Wi-Fi, audio and suspend/resume.
Suspend/resume is the one most often skipped and most often broken.
Without it, battery life makes the device impractical even if everything
else works, so test it early rather than last.

## Next

→ [06-bootloader-and-flashing.md](06-bootloader-and-flashing.md) to wire
the boot chain together and produce a flashable image.
