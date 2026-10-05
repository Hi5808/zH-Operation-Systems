# Contributing

This guide is a shared reference. Contributions that keep it accurate,
honest, and useful to the next person are welcome. The conventions below
are what make it trustworthy — please follow them.

## The one rule: notes, not binaries

**Never commit vendor firmware or any binary derived from it.** Not
partition images (`.img`), raw `kernel`/`ramdisk`/`.dtb`, HAL `.so`,
vendor `.ko`, or firmware blobs. The repo's `.gitignore` blocks the
default paths the scripts produce, but it is not a substitute for
checking `git status` before you commit.

What you *do* commit is the understanding derived from those binaries:

- Decompiled-to-source device trees (`device.dts`), not the `.dtb`.
- `kernel.config` (text).
- `manifest.tsv` (checksums and filenames only — no image content).
- Your own RE notes: register tables, init sequences, SMC call IDs,
  protocol notes. These are your derived work, not the vendor's binary.
- Patches and defconfig diffs.

This is both a legal line (see the overview's scope notes) and the thing
that makes a contribution useful: the next person needs the method and
the findings, not a copy of a binary they already have on their own
device.

## Accuracy over completeness

The guide earns trust by being right, not by being long. So:

- **Don't state a tool, command, flag, or fact you haven't verified.**
  If you're not sure, say "unverified" or "varies — check <source>"
  rather than inventing a confident answer. Several existing sections
  carry explicit "confirm this on your device" caveats for exactly this
  reason; that's the house style, not a weakness.
- **Mark hardware-proven facts as such.** In device profiles, a claim
  that comes from a running device reads differently from one inferred
  from specs. Say which it is.
- **Prefer primary sources.** Link the project's own docs / the kernel
  source / the tool's README, not a forum summary, when you can.

## Running the checks

Before you open a PR, run the consistency checker:

```bash
./scripts/check-docs.sh
```

It validates that internal links resolve, the chapter index is complete,
scripts pass `bash -n` and shellcheck, every referenced script exists,
and every fenced ```bash block parses. CI runs the same thing on every
PR (`.github/workflows/check-docs.yml`), so a green local run means a
green PR.

For shell scripts specifically, keep them `shellcheck -S warning` clean.

## Adding a device

Use the scaffold rather than copying an existing profile by hand:

```bash
./scripts/new-device.sh CODENAME "Display Name" "SoC vendor" "SoC model"
```

Then fill in `devices/CODENAME/profile.md` as you work through the
chapters, and add a row to the "Devices tracked" table in
`00-overview.md`. A device profile is useful even when the port is
incomplete — the hardware inventory and status table help the next
person whether or not the device fully boots Linux yet.

## Writing style

- Fenced command blocks should be **paste-safe**: no bare `<angle>`
  placeholders in a runnable line (they act as shell redirections). Use
  quoted `UPPERCASE` tokens or a leading comment that names the value.
- Keep cross-references as section numbers (`§4.6`) and relative links;
  the checker validates the links.
- New chapters: add the file, add it to the `00-overview.md` index table,
  and link it from the chapters it relates to.

## Credit

If your contribution builds on someone else's work — a kernel tree, a
tool, another project's device port — name it and link it. That's the
etiquette the whole ecosystem runs on; see the overview's "A note on
ownership and credit."
