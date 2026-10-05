# 16. Feasibility Triage — Should You Attempt This Device?

Read this **before** §1. A port can take days or months, and a handful of
device facts decide which it is — or whether it's possible at all. Work
through the gates below first; each "no" either kills the project or
tells you exactly what you're signing up for. None of this needs a
firmware dump — it's web research plus, at most, a few `adb`/`fastboot`
commands on the stock device.

## 16.1 The hard gate: can you run your own code at all?

If you can't get the device to execute a kernel you built, nothing else
matters. Check, in order:

1. **Is there an OEM-unlock path?** Developer Options → "OEM unlocking"
   present and toggleable, *or* a vendor unlock tool, *or* a
   documented BootROM-mode write path for the SoC (§9). If all three are
   absent, stop — this is a hardware security boundary, not a porting
   problem (§6.1).
2. **Does the BootROM recovery mode actually grant writes on this unit?**
   Not just reads. §9.7 — Qualcomm EDL needs a signed loader, MediaTek
   BROM depends on SLA/DAA, etc. "I can dump but not flash" means you can
   study the device but not port to it.
3. **Can you get back to stock?** Confirm the restore path *before*
   starting (§12.5). No verified restore = one bad flash ends the project
   with a brick.

Pass all three and the device is portable in principle. The rest is
effort estimation.

## 16.2 The effort gates: how much will you build?

| Question | Best case | Worst case |
|---|---|---|
| **Does a sibling-device or same-SoC port already exist?** (postmarketOS, Halium, LineageOS, a project like RGOS) | Inherit most of the kernel + DT; you do device-specific peripherals only (§3.1, §8) | Nothing to fork; every driver from the vendor tree or RE |
| **Is GPL kernel source published** for this device or SoC? (§4.1) | Build from real source | Reconstruct from the binary + RE (§2) — far slower |
| **GPU generation?** (§9) | Mesa supports it (Freedreno/Panfrost/Panthor) → native | No open driver → Halium/libhybris shim, or software-only |
| **Modem, if you need cellular?** (§3.2, §9.1) | Qualcomm QMI → `qrtr`/`rmtfs`/ModemManager, well-trodden | Non-Qualcomm vendor protocol → often never fully works |
| **GKI device (Android 12+)?** (§4.7) | — | Vendor modules are KMI-locked; you can't mix kernels freely |
| **Storage/boot quirks?** | Standard GPT + `fastboot` | Odd partition names, authenticated DA, eMMC bugs (§8 RGOS ADMA) |

Each "worst case" doesn't kill the project — it sets the budget. A device
with no prior art, no source, a PowerVR GPU and a non-Qualcomm modem is
*possible*, but it's a months-long RE project, not a weekend.

## 16.3 Scope the goal to the gates

Match ambition to what §16.2 tells you:

- **"Daily driver with working cellular"** needs the modem gate to pass —
  usually only realistic on Qualcomm.
- **"Handheld / tablet / dedicated-purpose device"** (no cellular) drops
  the hardest gate entirely; this is why handhelds like the RG405M (§8)
  are tractable native-Linux targets.
- **"Just boot to a shell over USB/serial"** needs only §16.1 plus a
  kernel + minimal rootfs — a realistic first milestone for almost any
  unlockable device, and the honest thing to aim for before promising a
  phone.

## 16.4 Triage output

Record the answers in the device profile's Identity/§6 fields (§10)
before any dumping. A device that fails §16.1 gets a one-line profile
noting *why* it's not portable — that itself is useful to the next
person who considers it. A device that passes gets a realistic scope
line ("shell + display + Wi-Fi realistic; cellular unlikely, non-QMI
modem") so expectations are set from day one.

## Next

→ [01-firmware-dumping.md](01-firmware-dumping.md) once a device clears
§16.1 — or [10-device-profile-template.md](10-device-profile-template.md)
to record a triage result either way.
