# 19. Hard Subsystems in Depth: Audio, Camera, Modem

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

## 19.4 The pragmatic sequence

From §5.9's long tail, in order: **audio** is usually worth doing (a
device with sound is much more usable), **modem** only if Qualcomm or if
cellular is the whole point, **camera** last and often skipped. A port
that ships with display, touch, Wi-Fi, audio, charging and suspend —
leaving camera and (non-Qualcomm) modem unfinished — is a real,
useful device, not a failure.

## Next

→ Back to [00-overview.md](00-overview.md), or
[14-upstreaming.md](14-upstreaming.md) to publish what works.
