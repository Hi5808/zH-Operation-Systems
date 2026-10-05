#!/usr/bin/env python3
"""Generate a per-device readiness checklist for a Linux port.

Inspects a devices/<codename>/ folder, marks which data, files, and
information the guide needs as present or missing (based on what's
actually there), tailors the list to a target OS, and prints a readiness
summary. It does NOT build anything — it tells you what you still need
and which tool/chapter provides it. See 10-device-profile-template.md
and 16-feasibility-triage.md.

Usage:
  gen-checklist.py <device-dir> [--target TARGET] [--goal GOAL] [--write]

  <device-dir>  e.g. devices/anbernic-rg405m
  --target      ubuntu-touch | postmarketos | mobian | droidian |
                debian | kali | arch | generic   (default: generic)
  --goal        phone | handheld | general        (default: general)
  --write       also write <device-dir>/checklist.md (default: stdout only)

Targets map to a build path, not a promise of a finished image:
  ubuntu-touch / droidian  -> Halium (vendor HALs in a container, 5.1A)
  postmarketos / mobian    -> native mainline-ish userspace (5.1B)
  debian / kali / arch     -> plain arm64 rootfs on your ported kernel
                              (the distro is "just the rootfs"; the hard
                              part is the kernel, ch.4, which no tool
                              automates)
"""

import argparse
import os
import sys

# (label, relative path(s) to look for, how to get it, chapter)
ACQUIRE = [
    ("Full partition dump / backup", ["backups/manifest.tsv"],
     "scripts/backup-partitions.sh or scripts/catalog-dump.sh", "1, 12"),
    ("boot.img unpacked (kernel/ramdisk)", ["boot_out/kernel"],
     "scripts/unpack-boot.sh boot.img boot_out/", "1.3"),
    ("Device tree source (.dts)", ["boot_out/device.dts", "device.dts"],
     "scripts/unpack-boot.sh (decompiles the DTB)", "1.3, 4.3"),
    ("Kernel config", ["kernel.config"],
     "scripts/extract-kernel-config.sh boot_out/kernel kernel.config", "1.4"),
    ("vendor/system partition extracted", ["vendor_mnt"],
     "scripts/dump-vendor-partition.sh vendor.img vendor_mnt/", "1.5"),
]

UNDERSTAND = [
    ("Hardware inventory filled in (profile §3)", None,
     "fill devices/<codename>/profile.md §3 from device.dts + vendor_mnt", "3"),
    ("RE notes for any no-source driver", ["re-notes.md"],
     "02-reverse-engineering-ghidra.md (§2.9 worked example)", "2"),
    ("Feasibility triage recorded", None,
     "16-feasibility-triage.md — unlock path, write access, restore", "16"),
]

KERNEL = [
    ("Kernel base chosen (source/BSP/mainline)", None, "04-kernel-porting.md §4.1-4.2", "4"),
    ("Defconfig + Linux-userspace options merged", None,
     "04-kernel-porting.md §4.5-4.6 (pmbootstrap kconfig check / Halium checker)", "4.6"),
    ("Reserved-memory regions matched to stock DT", None, "04-kernel-porting.md §4.3", "4.3"),
]

BOOT = [
    ("Boot image header version known", None, "06-bootloader-and-flashing.md §6.2.1", "6"),
    ("Restore round-trip verified (before first flash)", None,
     "12-oem-restore.md §12.5 + scripts/restore-oem.sh", "12"),
    ("Reversible dev path chosen (RAM-boot / SD / A/B)", None,
     "17-reversible-development.md", "17"),
]

# Target-specific userspace inputs.
TARGETS = {
    "ubuntu-touch": ("Halium (5.1A)", [
        "Halium device tree: device/<vendor>/<codename> + vendor/<vendor>/<codename>",
        "proprietary-blobs.txt manifest (paths, not binaries)",
        "libhybris builds against the vendor HALs",
        "Lomiri/UBports rootfs — see docs.ubports.com and §8",
    ]),
    "droidian": ("Halium (5.1A)", [
        "Halium device tree + proprietary-blobs.txt",
        "Droidian adaptation packages — see §5.7, §8",
    ]),
    "postmarketos": ("native (5.1B)", [
        "pmaports device package: pmbootstrap aportgen device-VENDOR-CODENAME",
        "pmaports kernel package: pmbootstrap aportgen linux-VENDOR-CODENAME",
        "kconfig check: pmbootstrap kconfig check",
        "UI choice: Phosh / Plasma Mobile / Sxmo (§5.7)",
    ]),
    "mobian": ("native (5.1B)", [
        "arm64 Debian rootfs (Mobian) + your ported kernel",
        "best when GPU/audio/modem are on the native path (§3.5)",
    ]),
    "debian": ("plain rootfs on your kernel", [
        "debootstrap --arch=arm64 bookworm rootfs/ (§5.3)",
        "your ported kernel + DTB (ch.4) — the rootfs does not port the device",
    ]),
    "kali": ("plain rootfs on your kernel", [
        "Kali arm64 rootfs (kali-arm / debootstrap with Kali repos)",
        "your ported kernel + DTB (ch.4); Kali is a Debian-derived rootfs",
    ]),
    "arch": ("plain rootfs on your kernel", [
        "Arch Linux ARM (alarm) arm64 rootfs, or pacstrap into an arm64 root",
        "your ported kernel + DTB (ch.4)",
    ]),
    "generic": ("undecided", [
        "Pick a target: Halium (ubuntu-touch/droidian) if subsystems need "
        "vendor HALs, native (postmarketos/mobian) if they're mainline, or "
        "a plain rootfs (debian/kali/arch) once the kernel boots (§5.1, §5.7).",
    ]),
}


def present(device_dir, paths):
    if paths is None:
        return None  # not file-detectable; always a manual [ ]
    for p in paths:
        if os.path.exists(os.path.join(device_dir, p)):
            return True
    return False


def mark(state):
    return {True: "[x]", False: "[ ]", None: "[ ]"}[state]


def render_section(title, items, device_dir):
    lines = [f"### {title}", ""]
    done = total = 0
    for item in items:
        label, paths, howto, chap = item
        st = present(device_dir, paths)
        if st is not None:
            total += 1
            done += 1 if st else 0
        auto = "" if paths is None else "  _(auto-detected)_"
        lines.append(f"- {mark(st)} **{label}**{auto}  \n"
                     f"  how: {howto} &middot; see §{chap}")
    lines.append("")
    return lines, done, total


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("device_dir")
    ap.add_argument("--target", default="generic", choices=sorted(TARGETS))
    ap.add_argument("--goal", default="general",
                    choices=["phone", "handheld", "general"])
    ap.add_argument("--write", action="store_true")
    args = ap.parse_args()

    d = args.device_dir.rstrip("/")
    if not os.path.isdir(d):
        sys.exit(f"error: {d} is not a directory (scaffold it with new-device.sh)")

    codename = os.path.basename(d)
    tgt_desc, tgt_items = TARGETS[args.target]

    out = [f"# Port readiness checklist: {codename}", "",
           f"Target: **{args.target}** ({tgt_desc}) &middot; goal: **{args.goal}**  ",
           "Generated by `scripts/gen-checklist.py` — auto-detected items "
           "reflect files present in this folder now; everything else is a "
           "manual gate. This lists what's *needed*, it does not build it.",
           ""]

    total_done = total_all = 0
    for title, items in [("Acquire (ch.1)", ACQUIRE),
                         ("Understand (ch.2-3, 16)", UNDERSTAND),
                         ("Kernel (ch.4)", KERNEL),
                         ("Boot & recovery (ch.6, 12, 17)", BOOT)]:
        sec, done, tot = render_section(title, items, d)
        out += sec
        total_done += done
        total_all += tot

    # cellular only matters for a phone goal
    out += [f"### Userspace — target: {args.target} ({tgt_desc})", ""]
    for it in tgt_items:
        out.append(f"- [ ] {it}")
    if args.goal == "phone":
        out.append("- [ ] Modem path (QMI stack if Qualcomm, else expect "
                    "data-only/none) — §19.3")
    elif args.goal == "handheld":
        out.append("- [ ] Gamepad/controls input mapping — §3, §18")
    # Bridge baseline: a blank map to fill in (§5.1 four-way vocabulary)
    bridge_rows = ["Display", "Touch / input", "GPU", "Audio", "Wi-Fi / BT"]
    if args.goal == "phone":
        bridge_rows.append("Modem")
    if args.goal == "handheld":
        bridge_rows.append("Gamepad / controls")
    bridge_rows += ["Sensors", "Power / charging"]
    out += ["", "### Bridge baseline (fill in — §5.1)", "",
            "Where each subsystem meets the Linux OS: "
            "**Native / Kernel-blob / HAL-shim / Firmware-blob**. "
            "All-Native/Firmware means no Android container.", "",
            "| Subsystem | Bridge | Notes |", "|---|---|---|"]
    out += [f"| {r} | | |" for r in bridge_rows]
    out += ["", "### Validate & give back", "",
            "- [ ] Each subsystem tested, not just probed — §18",
            "- [ ] Status table in profile.md updated — §10",
            "- [ ] Bridge baseline filled in — §5.1, §10",
            "- [ ] Upstream / publish the profile — §14",
            ""]

    pct = (100 * total_done // total_all) if total_all else 0
    out.insert(4, f"**Auto-detected readiness: {total_done}/{total_all} "
                  f"acquisition+setup artifacts present ({pct}%).**\n")

    text = "\n".join(out)
    print(text)
    if args.write:
        with open(os.path.join(d, "checklist.md"), "w") as f:
            f.write(text + "\n")
        print(f"\n[written to {d}/checklist.md]", file=sys.stderr)


if __name__ == "__main__":
    main()
