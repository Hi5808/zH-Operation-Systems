#!/bin/sh
# One-shot: build the native RG405M Ubuntu Touch rootfs.
# --disable-fakemachine: run on the host (no VM) so the big apt install isn't
#   limited by fakemachine's RAM/scratch (which crashed mid-install). Uses the
#   host's qemu-user-binfmt for the arm64 chroot.
cd "$(dirname "$0")" || exit 1
exec debos --disable-fakemachine rg405m.yaml
