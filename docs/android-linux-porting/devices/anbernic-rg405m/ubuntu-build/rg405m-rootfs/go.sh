#!/bin/sh
# One-shot: build the native RG405M Ubuntu Touch rootfs.
# Use fakemachine (the recipe assumes its /scratch mount) but give it plenty of
# RAM + scratch — the default (~2G RAM / ~4G scratch) OOM'd during the big
# Lomiri apt install. Bump both well above the installed-rootfs size.
cd "$(dirname "$0")" || exit 1
exec debos --memory=6G --scratchsize=20G rg405m.yaml
