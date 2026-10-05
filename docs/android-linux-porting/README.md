# Porting Mainline Linux to Any Unsupported Android Device

This folder is the guide. Start at **[00-overview.md](00-overview.md)** —
it has the full chapter index, the pipeline diagram, and reading paths
for different goals.

Quick orientation:

- **Chapters** `00`–`19` — the methodology, in order (triage → dump → RE
  → kernel → userspace → flash → validate → upstream), plus reference
  chapters (tools, per-vendor specifics, troubleshooting, glossary, …).
- **[scripts/](scripts/)** — automation for the mechanical steps; run
  [`scripts/check-docs.sh`](scripts/check-docs.sh) to validate the guide.
- **[templates/](templates/)** — device-profile templates `new-device.sh`
  renders from.
- **[devices/](devices/)** — per-device port profiles.
- **[HANDOFF.md](HANDOFF.md)** — checklist for physical-device work.
- **[CONTRIBUTING.md](CONTRIBUTING.md)** — the full contributor conventions.

New to a device? Run `./scripts/new-device.sh CODENAME "Display Name" VENDOR MODEL`.
