# SMBrix

> A hardware-first custom OS built specifically for the HP Chromebook 14-SMB.

## Concept

SMBrix is purpose-built for one machine. Rather than adapting a general distro and hoping for the best, every decision — kernel config, drivers, storage layout, interface — is made with the Chromebook 14-SMB's exact hardware in mind.

The name comes directly from the machine: **14-SMB** (Small & Medium Business model). It runs on a fully unlocked UEFI layer via MrChromebox, freeing it entirely from ChromeOS constraints.

## Target Hardware

| Component | Spec |
|-----------|------|
| Device | HP Chromebook 14-SMB |
| CPU | Intel Celeron 2955U (Haswell, 2c/2t @ 1.4GHz) |
| GPU | Intel HD Graphics (i915 driver) |
| RAM | 4GB DDR3L |
| Storage | 16GB eMMC |
| Display | 14" 1366x768 |
| WiFi | Intel 7260 AC |
| Bluetooth | 4.0 |
| Firmware | MrChromebox UEFI |

## Design Decisions

### Hardware-first kernel
The kernel will be configured specifically for Haswell microarchitecture, eMMC storage, and the i915 integrated GPU — no bloat for hardware that isn't in this machine.

### CLI as primary interface
The primary interaction layer is the terminal. Every core function (VPN, networking, system management) works headlessly from the command line.

### VPN without a GUI
VPN is handled entirely via CLI tools — no NetworkManager GUI required:
- WireGuard via `wg-quick`
- OpenVPN via `openvpn`
- NetworkManager via `nmcli`

### GUI — undecided
The 16GB eMMC and 4GB RAM make a lightweight GUI possible but not guaranteed. Candidates if included:
- **None** — pure CLI, maximum headroom
- **Openbox + tint2** — minimal window manager, ~150MB overhead
- **LXQt** — lightest full desktop, ~300MB overhead

Decision deferred until base OS and kernel footprint are measured.

### Base OS candidates
| Candidate | Pros | Cons |
|-----------|------|------|
| Debian minimal | Smallest base, rock-solid | Manual setup |
| Ubuntu Server | Great hardware support, familiar | Slightly heavier |
| Kali (stripped) | Already installed, keep tools | Larger base, security-tool overhead |

## Status

`Planning` — Hardware profile documented. Base OS and kernel config TBD.

## Next Steps

- [ ] Choose base OS
- [ ] Measure eMMC partition budget
- [ ] Draft kernel config (Haswell + i915 + eMMC optimizations)
- [ ] Decide GUI inclusion
- [ ] Document package list
