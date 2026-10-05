# 18. Validation & Testing

A subsystem that *probes* without error is not the same as one that
*works*. The status table (§10) earns its green marks here: concrete
checks that a driver does its job, not just that it bound. Run these as
each subsystem comes up (§5.5), and record the command + result in the
device profile so "working" means something specific.

## 18.1 The probe-vs-works trap

`dmesg` showing a driver bound, and `/dev` or `/sys` nodes existing, only
proves the kernel matched a driver to a `compatible` string. The driver
can still be talking to the wrong register, missing an init step (§2.9),
or wired to the wrong IRQ (§11.3) and look fine in the log. Every check
below exercises the actual function.

## 18.2 Per-subsystem checks

| Subsystem | Probe says | Actually test |
|---|---|---|
| Display | `drm` card present, panel driver bound | A test pattern or compositor actually lights pixels at the right geometry/orientation; no ghosting/tearing. `modetest -s` (libdrm) drives a mode directly. |
| Touch | `/dev/input/eventN` exists | `evtest` on that node reports coordinates that track your finger, with correct axis orientation (the §2.9 touch matrix) |
| Buttons/gamepad | input node exists | `evtest`/`jstest` maps each physical button to the expected keycode |
| Wi-Fi | interface `wlanN` up | Associate to an AP *and* pass traffic: `ping`, then throughput (`iperf3`) — association without data points to calibration/NVRAM (§11.3) |
| Bluetooth | `hciN` present | Scan, pair, and for audio actually route A2DP to a speaker |
| Audio out | `aplay -l` lists the card | `speaker-test -c2` is audible; check both speaker and headset-jack paths |
| Audio in | capture device listed | `arecord | aplay` loopback captures real sound (mic capture is often the last thing to work, §5.9) |
| Battery/charge | `/sys/class/power_supply/*` present | Capacity tracks over time, and plugging in actually charges (current > 0, capacity rising) |
| GPU accel | Mesa loads | `glmark2`/`eglinfo` shows the hardware renderer, not llvmpipe/software — "loads" ≠ "accelerated" |
| Sensors | `iio` devices present | Values change when you move/cover the device |
| Modem | ModemManager sees it | Registers on a network *and* a test call/SMS/data session works |

## 18.3 Suspend/resume and power

The subsystem most likely to be quietly broken (§5.8):

```bash
# Measure idle draw, suspend, confirm it actually sleeps, then that it wakes:
cat /sys/class/power_supply/*/current_now        # idle current
rtcwake -m mem -s 30                              # suspend to RAM for 30s
# After it returns: did it actually suspend (draw dropped) and wake cleanly?
dmesg | tail                                      # look for resume errors
```

A device that "suspends" but keeps drawing near-active current hasn't
really slept — check which wakeup source or always-on clock is holding
it up. Battery life is a feature; validate it, don't assume it.

## 18.4 Soak and thermals

Short checks miss failures that only appear under sustained load — the
§8 RGOS eMMC ADMA bug surfaced during a long write burst, not a quick
test. So:

- **Storage soak:** `dd if=/dev/zero of=/root/t bs=1M count=2000
  conv=fsync` repeated, then `dmesg | grep -i mmc` for ADMA/timeout
  errors. Make the filesystem journal persistent first so an error on
  one boot survives into the next.
- **Thermals under load:** watch `/sys/class/thermal/thermal_zone*/temp`
  during a GPU or CPU stress run; a ported kernel missing the vendor's
  thermal-throttling config can overheat where stock Android wouldn't.
- **Leave it running.** A device that's solid for ten minutes and reboots
  after an hour has a real bug (watchdog, memory leak, a reserved-memory
  mismatch §4.3) — uptime is a test.

## 18.5 Recording results

Turn each green cell into a line in the profile's status table (§10) with
the command and outcome, e.g. *"Wi-Fi 🟩 — associated to WPA2, iperf3
94 Mbit/s down."* This is what makes a device profile trustworthy to the
next person (§8, §14), and it's the difference between "I think it works"
and "here's how I confirmed it." Automate what you can (a boot-time
script that runs the cheap checks and logs them) so a regression after a
later kernel change is caught, not rediscovered.

## Next

→ [19-hard-subsystems.md](19-hard-subsystems.md) for the three that most
often stay partial — audio, camera, modem — in depth.
