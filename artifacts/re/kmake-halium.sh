#!/bin/bash
# kmake.sh - build the BL6000 Pro kernel (Xiaomi mt6873 base + our patches)
export PATH=$HOME/bl6000pro-work/toolchain/clang-r383902/bin:$PATH
exec make -C ~/bl6000pro-work/kernel-mt6873 O=$HOME/bl6000pro-work/out-halium ARCH=arm64 CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc) "$@"
