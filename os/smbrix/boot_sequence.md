# SMBrix Boot Sequence

> HP Chromebook 14-SMB — MrChromebox UEFI → GRUB → Linux Kernel → systemd → Login

---

## Overview

```
Power On
   │
   ▼
[1] MrChromebox UEFI  — hardware init, POST, EFI partition scan
   │
   ▼
[2] GRUB              — bootloader, loads kernel + initramfs
   │
   ▼
[3] Linux Kernel      — hardware bring-up (CPU, RAM, eMMC, i915, iwlwifi)
   │
   ▼
[4] initramfs         — early userspace, mounts root filesystem
   │
   ▼
[5] systemd (PID 1)   — service manager takes over
   │
   ▼
[6] Plymouth          — SMBrix boot logo displays during service startup
   │
   ▼
[7] Core Services     — networking, VPN daemon, firewall, hardware daemons
   │
   ▼
[8] Plymouth exits    — splash clears
   │
   ▼
[9] Getty / Login     — TTY login prompt
   │
   ▼
[10] zsh + tmux       — user shell environment
```

---

## Stage-by-Stage

### Stage 1 — MrChromebox UEFI
**Duration: ~2–3s**

- Firmware initializes CPU (Celeron 2955U / Haswell), RAM (4GB DDR3L), eMMC
- Performs POST (Power-On Self Test)
- Scans EFI System Partition (ESP) on eMMC for bootloader
- Loads GRUB EFI binary from `/boot/efi/EFI/smbrix/grubx64.efi`
- Secure Boot is disabled (MrChromebox full UEFI — no ChromeOS verification)

---

### Stage 2 — GRUB Bootloader
**Duration: ~1–2s**

- GRUB menu displays briefly (1s timeout) then auto-boots
- Loads:
  - Linux kernel image: `/boot/vmlinuz-<version>`
  - initramfs: `/boot/initrd.img-<version>`
- Passes kernel parameters:
  ```
  root=/dev/mmcblk0p3 quiet splash i915.enable_psr=0 nmi_watchdog=0
  ```
  | Parameter | Purpose |
  |-----------|---------|
  | `quiet` | Suppress kernel messages during splash |
  | `splash` | Enable Plymouth boot splash |
  | `i915.enable_psr=0` | Disable Panel Self Refresh (fixes screen flicker on Haswell) |
  | `nmi_watchdog=0` | Reduce CPU overhead on low-power Celeron |

---

### Stage 3 — Linux Kernel Init
**Duration: ~3–5s**

- Kernel decompresses and initializes in memory
- Brings up hardware in order:
  1. **CPU** — Haswell microarchitecture, 2 cores, intel-microcode applied
  2. **RAM** — 4GB DDR3L mapped
  3. **eMMC** — `mmcblk0` detected via `CONFIG_MMC_SDHCI`
  4. **i915** — Intel HD Graphics driver loads, framebuffer initialized
  5. **iwlwifi** — Intel 7260 WiFi driver loads, firmware from `firmware-iwlwifi`
  6. **USB** — USB 2.0 and 3.0 controllers initialized
  7. **Audio** — Intel HD Audio (`snd_hda_intel`) loaded
- Hands off to initramfs

---

### Stage 4 — initramfs (Early Userspace)
**Duration: ~1–2s**

- Temporary root filesystem loaded into RAM
- Runs `init` script to:
  - Load necessary kernel modules
  - Detect and mount real root partition (`/dev/mmcblk0p3`)
  - Hand control to systemd on real root

---

### Stage 5 — systemd (PID 1)
**Duration: ~3–6s total for all services**

- systemd becomes PID 1, reads `/etc/systemd/system/`
- Mounts all partitions per `/etc/fstab`:

  | Device | Mount | Filesystem |
  |--------|-------|------------|
  | `/dev/mmcblk0p1` | `/boot/efi` | FAT32 (EFI) |
  | `/dev/mmcblk0p2` | swap | swap |
  | `/dev/mmcblk0p3` | `/` | ext4 |
  | `/dev/mmcblk0p4` | `/home` | ext4 |

---

### Stage 6 — Plymouth Boot Splash
**Active during Stages 5–7**

- Plymouth starts alongside systemd
- Displays **SMBrix boot logo** (circuit leaf) centered on black background
- Logo fades in smoothly on the 1366x768 display
- Remains visible until all core services are ready
- Any application without its own icon uses `boot_logo.png` as fallback

---

### Stage 7 — Core Services (systemd units)
**Parallel startup during Plymouth splash**

| Service | Unit | Purpose |
|---------|------|---------|
| NetworkManager | `NetworkManager.service` | WiFi + network management |
| Tailscale | `tailscaled.service` | Mesh VPN daemon |
| Firewall | `ufw.service` | Uncomplicated Firewall |
| Thermal | `thermald.service` | Intel CPU thermal management (Haswell) |
| Cron | `cron.service` | Scheduled tasks |
| Logging | `rsyslog.service` | System log management |

---

### Stage 8 — Plymouth Exits
- All core services confirmed ready
- Plymouth clears the boot logo
- Screen transitions to TTY

---

### Stage 9 — Getty / Login Prompt
- `getty` spawns on TTY1
- Login prompt displayed:
  ```
  SMBrix 0.1.0 — HP Chromebook 14-SMB
  smb login: _
  ```

---

### Stage 10 — zsh + tmux
- User logs in → zsh launches with oh-my-zsh
- Default `.zshrc` auto-starts a tmux session named `main`
- tmux opens with a default layout:
  ```
  ┌─────────────────────┬──────────────┐
  │                     │   htop       │
  │   main shell        ├──────────────┤
  │                     │   tailscale  │
  │                     │   status     │
  └─────────────────────┴──────────────┘
  ```
- Active color scheme: **Dracula** (default)
- Emoji enabled in prompt and status bar 🌿

---

## Target Boot Time

| Stage | Target |
|-------|--------|
| UEFI → GRUB | ~3s |
| GRUB → Kernel | ~2s |
| Kernel → systemd | ~5s |
| systemd → Login | ~6s |
| **Total cold boot** | **~16s** |

---

## Debug / Boot Logging

Remove `quiet splash` from GRUB parameters to see full kernel output:
```
root=/dev/mmcblk0p3 i915.enable_psr=0 nmi_watchdog=0
```

View systemd boot log after login:
```zsh
journalctl -b          # full boot log
systemd-analyze        # boot time breakdown
systemd-analyze blame  # which services took longest
```
