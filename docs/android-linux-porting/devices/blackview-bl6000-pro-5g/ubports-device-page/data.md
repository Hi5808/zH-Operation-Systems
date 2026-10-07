---
# Submit under data/devices/<codename>/data.md in
# gitlab.com/ubports/infrastructure/devices.ubuntu-touch.io
# Codename: HI001 (folder: data/devices/hi001/). device ro.product.device=BL6000Pro.
name: Blackview BL6000 Pro 5G
deviceType: phone
description: >
  Rugged MediaTek Dimensity 800 (MT6873) 5G phone. Community Halium 11 port:
  calls/VoLTE, LTE data, SMS, Wi-Fi, Bluetooth, GPS, audio, all three rear/front
  cameras, and fingerprint unlock work. Camera is 12 MP (no 48 MP) and has no
  manual white-balance; see the feature matrix.
tag: unmaintained          # community "as-is" port; remove if you commit to maintaining
subforum: "<FORUM_ID>/ubuntu-touch-for-blackview-bl6000-pro-hi001"   # create a forum thread, put its id here
deviceInfo:
  - { id: "Release", value: "2020" }
  - { id: "SoC", value: "MediaTek Dimensity 800 (MT6873)" }
  - { id: "CPU", value: "4x Cortex-A76 @2.0GHz + 4x Cortex-A55 @2.0GHz" }
  - { id: "GPU", value: "Mali-G57 MP4" }
  - { id: "RAM", value: "8 GB LPDDR4X" }
  - { id: "Storage", value: "256 GB UFS 2.1" }
  - { id: "Display", value: "6.36 in 1080x2300" }
  - { id: "Battery", value: "~4280 mAh" }
contributors:
  - { name: "<YOUR_NAME_OR_HANDLE>", role: "Maintainer", forum: "<FORUM_PROFILE_URL>" }
communityHelp:
  - { name: "UBports Forum thread", link: "https://forums.ubports.com/" }
docLinks:
  - { name: "Port RE notes & build script", link: "<YOUR_PUBLIC_REPO_URL>" }
sources:
  portType: "Halium 11.0"
  kernelSource: "<YOUR_KERNEL_BRANCH_URL>"
  deviceSource: "<YOUR_PORT_REPO_URL>"
  issuesLink: "<YOUR_REPO_URL>/issues"
unimplementedFeatures:
  - "Full-resolution 48 MP capture (Camera1 stack cannot drive MTK remosaic)"
  - "Manual white balance"
seo:
  description: "Ubuntu Touch on the Blackview BL6000 Pro 5G (MediaTek MT6873)"
  keywords: "Blackview, BL6000 Pro, MT6873, Ubuntu Touch, UBports, Halium, port"
---

Community Halium 11 port of Ubuntu Touch for the Blackview BL6000 Pro 5G.
Built with reverse-engineered camera/TEE/fingerprint drivers on a MediaTek 4.14
kernel base. See the linked repo for the full build script and RE notes.
