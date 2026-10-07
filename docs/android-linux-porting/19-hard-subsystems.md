# 19. Hard Subsystems in Depth: Audio, Camera, Modem, Fingerprint

These three are where ports stall. §5.9 rated them hard; this chapter
says *why*, and what the realistic options are for each. The honest
framing up front: on most devices you will get audio working with
effort, camera partially or not at all, and modem only if it's Qualcomm —
and a device is genuinely useful without all three (§5.8).

## 19.1 Audio

**Why it's hard:** sound isn't one chip. A modern SoC routes audio
through a DSP (ADSP on Qualcomm, the codec's own DSP elsewhere) with a
mixer graph the vendor HAL configured through dozens of control settings.
The codec driver binding is the easy 20%; reproducing the *routing* —
which mixer controls to flip to connect the DAC to the speaker amp, the
mic to the capture path — is the other 80%.

**Native path (ALSA + UCM):**
- The kernel ASoC driver gives you raw ALSA controls (`amixer
  controls`). Playback usually comes first because the path is short.
- The routing lives in a **UCM** (Use Case Manager) profile — text files
  under `/usr/share/alsa/ucm2/` that name the mixer settings for each use
  case (HiFi speaker, headset, voice call). Writing/adapting the UCM for
  your codec is the real work. The settings to put in it come from
  watching what the vendor HAL does (§2) or from a sibling device's UCM.
- PipeWire or PulseAudio sits on top of UCM for routing/volume.
- **Capture (mic) lags playback**, routinely — it needs its own path set
  up and often extra DSP state. RGOS (§8) is the concrete example: speaker
  and headset playback working, the headset boom-mic deliberately parked
  pending an Android-side capture dump. That ordering is typical.

**Halium path:** `pulseaudio-modules-droid` talks to the vendor audio HAL
directly, which keeps the vendor's own routing — the fallback when the
DSP mixer graph is too opaque to reproduce natively.

**Validate** with §18.2's loopback, both speaker and jack, playback and
capture separately.

## 19.2 Camera

**Why it's hard:** the camera is an ISP pipeline, not a sensor you read.
The image sensor is trivial over I2C/CSI; turning its raw stream into a
usable image (3A — autofocus/exposure/white-balance, lens correction,
denoise, format conversion) is done by a complex, vendor-proprietary ISP
with closed tuning data. There is usually no open equivalent.

**Options, best to worst:**
- **libcamera** with an open ISP pipeline handler, where one exists for
  your SoC (some Qualcomm, Rockchip, i.MX, Raspberry Pi). This is the
  clean native answer when available — check libcamera's supported
  pipelines for your SoC before assuming anything.
- **`droidmedia` + `gst-droid`** (Halium path): reuse the Android camera
  HAL through a GStreamer bridge. More likely to produce a working camera
  on a phone than native, because it keeps the vendor ISP stack.
- **Raw/unaccelerated capture:** some sensors can be driven via a plain
  V4L2 path for a raw stream with no 3A — technically "a camera," but
  without autofocus/exposure it's rarely usable for photos.
- **Unsupported.** On many ports the camera is simply left non-functional,
  and that is a legitimate, common outcome — don't block a release on it.

Set expectations accordingly: "working camera" on a non-libcamera SoC
usually means the Halium bridge, and "good photos" usually means you
kept Android's ISP stack, not that you replaced it.

## 19.3 Modem (cellular)

**Why it's hard — and why Qualcomm is the exception:** the modem is a
separate processor running its own closed firmware. The application
processor never speaks to the radio directly; it exchanges messages with
the modem over shared memory. Whether you can port it comes down almost
entirely to *which protocol* that message exchange uses.

- **Qualcomm (QMI) — the tractable case.** The protocol (QMI over QRTR)
  is well understood and has a complete open userspace: `qrtr` (the
  transport), `rmtfs` (serves the modem's remote filesystem — IMEI/
  calibration), `pd-mapper`, and ModemManager's QMI backend for the
  actual connection management. The modem firmware itself stays untouched
  (loaded via `remoteproc`, §3.2). This is the single biggest
  "never reimplement, just bridge" success in mobile Linux — most working
  cellular on ported devices is Qualcomm.
- **MediaTek / UNISOC / Samsung Shannon — usually a dead end.** Their
  AP↔modem protocols are vendor-specific and far less reverse-engineered.
  Some have partial community efforts; most ported devices on these SoCs
  end up data-only, flaky, or with no cellular at all. If cellular is a
  hard requirement, the §16 triage should have flagged a non-Qualcomm
  modem as high-risk before you started.

**Don't wipe the calibration.** On every vendor, the per-unit
RF-calibration/IMEI partitions (`modemst1`/`modemst2`/NV/EFS-equivalents)
must survive untouched (§11.3, §12.4). Losing them can permanently break
the radio — and they're unit-specific, so you can't restore them from
another device.

**Validate** beyond "ModemManager sees it": actual network registration,
then a data session, then SMS/voice if you need them (§18.2).

## 19.4 Fingerprint / biometrics

**Why it's hard:** a fingerprint sensor is not a device you simply read —
the match happens inside the **TEE** (TrustZone/TrustKernel/QSEE), the
template store is sealed to secure storage (RPMB), and the whole chain is
gated on **device identity and key material** provisioned at the factory.
Three independent things have to line up — kernel sensor driver, the TEE
Trusted Application + its keybox, and the Linux-side biometrics service —
and a failure in any one looks the same from the UI ("no reader").

**The layers, bottom to top:**
- **Kernel sensor driver** — usually a vendor shim over SPI/I2C plus an
  interrupt line used as a wake source. IDing the chip (a `0x..` hardware
  id over the bus) is the easy part.
- **TEE TA + keybox** — the matcher runs as a Trusted Application loaded by
  the secure OS; it verifies a per-vendor keybox and, critically, often
  checks the **device identity** (`ro.product.brand`/`model`). A generic
  Halium identity makes the TA refuse with a "get vendor key" style error
  even though the sensor and TA are fine. **Fix:** present the stock
  identity (bind the correct `build.prop`) before the stack initialises.
- **Secure storage (RPMB)** — enrolled templates are sealed here. Reuse the
  existing RPMB key; **never (re)write the RPMB authentication key** — it is
  effectively one-time and a wrong write permanently breaks secure storage.
- **Linux biometrics service** — on Ubuntu Touch this is `biometryd`
  bridging to the Android fingerprint HAL; on other stacks it is `fprintd`.

**Three failure modes worth knowing (all seen on real MTK/TrustKernel ports):**

1. **CFI panic from the TEE clock shim.** A vendor TEE driver that worked on
   the stock kernel can panic your CFI-hardened build when it calls kernel
   clock functions through a function pointer with a mismatched prototype
   (the fingerprint SPI clock path is a common trigger). Find it in
   `pstore`/`ramoops`; fix by dispatching the known clock ops directly with
   the correct prototype instead of through the indirect call. (Worked
   example: Blackview BL6000 Pro re-notes, `tkcore` `tee_clkmgr_handle`.)

2. **HAL boot race.** The Android fingerprint HAL can crash-loop (SIGABRT in
   its destructor) if the Linux biometrics daemon opens it during the init
   race before the HAL has registered. Gate the daemon's start on the HAL's
   HIDL/AIDL registration (a wait in `ExecStartPre`), rather than starting
   them concurrently.

3. **The lazily-cached "unavailable" latch — a general UI-plugin trap.**
   This one is not fingerprint-specific but bites fingerprint hardest. If
   the UI's biometrics API is a **lazily-created, cached singleton** that
   probes the service *once* on first access and falls back to an
   "unavailable" stub when the service's bus name isn't up yet, it latches
   that stale state for the whole session — because the biometrics daemon
   starts *after* the UI shell (it waits for the HAL, tens of seconds). The
   symptom: the reader looks permanently absent until the user toggles the
   fingerprint setting off/on, which rebuilds the UI context after the
   daemon is finally up.
   **General fix:** make the singleton observe the service's lifecycle
   instead of sampling it once — watch the bus name (e.g. a D-Bus
   service-watcher on name-owner changes), start in the "unavailable" state,
   and flip to "available" (rebuilding any lazily-created child objects) when
   the name appears. Build child objects lazily so the constructor never
   blocks on a down service. Also **build the UI plugin against the version
   installed on the device** (the package version usually embeds the commit
   hash): a newer upstream HEAD may bump the library SONAME and change the
   IPC interface, so a HEAD-built plugin won't resolve its dependency and may
   speak a protocol the on-device daemon doesn't understand. Verify with
   `readelf -d <plugin> | grep NEEDED` and `ldd` *on the device* before
   activating, and deploy reversibly (bind-mount the new file over the stock
   path from a writable partition, keep a backup + a kill-switch sentinel).

**Two behaviours that are correct, not bugs — don't "fix" them:**
- **PIN required on the first unlock after each boot.** The TEE/gatekeeper
  needs a prior password auth to unlock the keystore; fingerprint is allowed
  only for lock/unlock cycles *after* that first PIN entry. This is intended
  security.
- **Two scans to unlock.** Some ports settle on requiring two deliberate
  scans. That can be left as an accepted anti-accidental-unlock feature if
  the owner prefers it — "correct" and "preferred" aren't always the same.

**Validate** by enrolling, then testing unlock from both screen-on and
screen-off (the sensor interrupt is typically a wake source), and confirm it
survives a reboot (the first unlock being PIN, then fingerprint thereafter).

## 19.5 The pragmatic sequence

From §5.9's long tail, in order: **audio** is usually worth doing (a
device with sound is much more usable), **modem** only if Qualcomm or if
cellular is the whole point, **camera** last and often skipped. A port
that ships with display, touch, Wi-Fi, audio, charging and suspend —
leaving camera and (non-Qualcomm) modem unfinished — is a real,
useful device, not a failure.

## Next

→ Back to [00-overview.md](00-overview.md), or
[14-upstreaming.md](14-upstreaming.md) to publish what works.
