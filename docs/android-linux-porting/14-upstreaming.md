# 14. Upstreaming: Giving the Port Back

A port that only lives on your device helps one person. The same work,
upstreamed, becomes the prior art the next person starts from (see
"Why this is shared openly" in [00-overview.md](00-overview.md)). This
chapter covers the three realistic destinations, from smallest effort to
largest.

## 14.1 Publish the device profile (smallest step)

Even if nothing else gets upstreamed, a completed `devices/<codename>/`
folder (profile, RE notes, `kernel.config`, `device.dts`, manifest — no
binaries, see [HANDOFF.md](HANDOFF.md) §6) is already useful to the next
person with the same device or SoC.

## 14.2 postmarketOS device port

postmarketOS accepts both mainline and downstream-kernel devices, so this
is often the most achievable "official" destination.

- Scaffold packages with `pmbootstrap aportgen device-<vendor>-<codename>`
  and `pmbootstrap aportgen linux-<vendor>-<codename>`.
- New devices start in the **testing** category; moving to community/main
  requires more working subsystems and an active maintainer. Check the
  current category requirements on wiki.postmarketos.org, since they change.
- Create the device's wiki page with a feature table — your profile's
  Status table maps onto it directly.
- Submit the packages to the postmarketOS `pmaports` repository as a merge
  request, following its contributing guide.

## 14.3 Mainline Linux kernel patches (largest step)

Worth it for any driver, DT, or SoC support you wrote cleanly against
mainline (§4.4). The kernel's own documentation is the authority here —
read `Documentation/process/submitting-patches.rst` first.

```bash
# In your kernel tree, one logical change per commit:
git format-patch -o outgoing/ origin/master..HEAD
./scripts/checkpatch.pl outgoing/*.patch          # fix every warning you can
./scripts/get_maintainer.pl outgoing/*.patch      # who and which lists to send to
git send-email --to=<maintainer> --cc=<lists> outgoing/*.patch
```

Things that commonly get patches rejected:

- **Device tree bindings** must be YAML schemas under
  `Documentation/devicetree/bindings/` and pass
  `make dt_binding_check`; board `.dts` files must pass `make dtbs_check`.
  A new `compatible` string without a binding won't be accepted.
- **Copied vendor code.** Downstream drivers usually need rewriting to
  current kernel APIs and style, not just cleanup. A small clean driver
  (§4.4) upstreams far more easily than a ported 3,000-line vendor one.
- **Missing `Signed-off-by`.** Every patch needs it, certifying the
  Developer Certificate of Origin. You can only certify code you have the
  right to submit. Register tables and init sequences you documented from
  RE are generally fine to describe in your own driver code; pasting
  decompiled vendor code is not.
- **Reviews come back.** Expect several revisions (v2, v3, …), each sent
  with a changelog below the `---` line.

Send to the SoC's list (see [08-case-studies.md](08-case-studies.md)):
`linux-arm-msm` (Qualcomm), `linux-mediatek` (MediaTek),
`linux-samsung-soc` (Exynos), `linux-sunxi`, `linux-rockchip`,
`linux-tegra`. `get_maintainer.pl` will list these for you.

## 14.4 Credit, both ways

Credit the prior art you built on (§"A note on ownership and credit" in
[00-overview.md](00-overview.md)), and in the kernel, credit co-authors
with `Co-developed-by:` + `Signed-off-by:` pairs, or `Suggested-by:` /
`Reported-by:` where those apply. That's the same etiquette in its
formal, upstream form.
