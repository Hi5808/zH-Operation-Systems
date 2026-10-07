---
# data/devices/<codename>/releases/noble.md  (UT 24.04 = "noble")
portType: "Halium 11.0"
kernelVersion: "4.14.x"
installLink: "<YOUR_REPO_URL>#installation"   # manual install until/unless an installer config exists
portStatus:
  - { id: "cellular", value: "+" }
  - { id: "voice-call", value: "+" }        # VoLTE works
  - { id: "sms", value: "+" }
  - { id: "mobile-data", value: "+" }       # LTE
  - { id: "5g", value: "+-" }               # selectable; EN-DC carrier-restricted on test unit
  - { id: "wifi", value: "+" }
  - { id: "bluetooth", value: "+" }         # incl. BLE keyboards
  - { id: "gps", value: "+-" }              # SV lock indoors; outdoor fix untested
  - { id: "camera-photo", value: "+" }      # main + front + ultra-wide (12 MP)
  - { id: "camera-video", value: "+" }      # with audio
  - { id: "flashlight", value: "+" }
  - { id: "audio-speaker", value: "+" }
  - { id: "audio-headphones", value: "+" }
  - { id: "audio-recording", value: "?" }   # mic path present; not independently verified
  - { id: "fingerprint", value: "+" }       # enrol + unlock + single-touch
  - { id: "vibration", value: "+" }
  - { id: "sensors", value: "+" }
  - { id: "battery-charging", value: "+" }
  - { id: "nfc", value: "?" }               # HAL runs; end-to-end untested
---

All core functionality works. Known gaps: no 48 MP (Camera1 can't drive MTK
remosaic), no manual white balance, bootloader shows the orange "unlocked"
warning at boot (cosmetic). A harmless SunWave fingerprint-HAL abort occurs at
boot and self-recovers. See the port repo for details.
