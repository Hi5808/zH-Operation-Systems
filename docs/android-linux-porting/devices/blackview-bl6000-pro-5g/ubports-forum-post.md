# UBports forum post (draft) — post under Porting / Devices after creating an account

**Title:** [PORT] Ubuntu Touch on the Blackview BL6000 Pro 5G (MT6873, codename HI001)

---

Hi all — sharing a community **Halium 11** port of Ubuntu Touch for the **Blackview
BL6000 Pro 5G** (MediaTek Dimensity 800 / MT6873), codename **HI001**. Built with
reverse-engineered camera/TEE/fingerprint drivers on a MediaTek 4.14 kernel base.

**Status: working daily driver (community / as-is).**

**Working**
- Calls + **VoLTE**, LTE data, SMS
- Wi-Fi, Bluetooth (incl. BLE keyboards), GPS
- Speaker/headphone audio, video recording with sound
- **All three cameras** (main / front / ultra-wide, 12 MP) — photo, video, flash/torch
- **Fingerprint** — enrol, unlock, single-touch
- Vibration, sensors, charging; NFC HAL loads

**Not working / known gaps**
- 48 MP capture — the Camera1/libhybris path can't drive MTK's remosaic feature (stays 12 MP)
- Manual white balance
- Orange "device unlocked" boot warning (cosmetic; bootloader relock WIP)
- Harmless SunWave fingerprint-HAL abort at boot that self-recovers (Android-11 pointer-tagging)

**Build & RE notes:** <YOUR_PUBLIC_REPO_URL> (full `build.sh` + reverse-engineering writeups)
**Install:** manual for now — flash the built boot image + rootfs; back up partitions first.

Happy to answer porting questions. Testers welcome — please report on the thread.
Shared **as-is** (no maintenance promise); kernel source + build recipe are public so anyone
can carry it forward.
