# 2. Reverse Engineering Closed Components with Ghidra

With raw partitions and extracted `.ko`/`.so`/firmware blobs in hand
(§1), this step recovers the *information* needed to either (a) write a
clean-room open driver, or (b) wire the vendor's existing binary into the
new OS via a shim, without needing to rewrite it.

## 2.1 What you're actually reverse engineering, and why

| Component | Why you RE it | Typical outcome |
|---|---|---|
| Vendor `.ko` kernel modules (touchscreen, sensors, camera ISP, fingerprint, display panel) | Kernel driver ABI is stable-ish; often these can be rebuilt against a newer/mainline kernel almost unmodified once you know the exact structs/ioctls they use | Patched/recompiled out-of-tree module, or a from-scratch mainline driver once you understand the chip's register protocol |
| HAL `.so` (`vendor/lib64/hw/*.so`) | Userspace-to-kernel ioctl/sysfs protocol for GPU, audio DSP, camera, sensors | Either reused as-is behind `libhybris` (Halium approach), or reimplemented against the open kernel driver |
| Bootloader (`abl`/`lk`/`u-boot` derivative) | Boot chain, fastboot command set, how it hands off to the kernel (ATAGs vs DTB, cmdline, memory layout) | Know how to make it boot *your* kernel/initramfs instead of the stock one |
| TrustZone / `tz`, `keymaster`, `hyp` images | Usually left untouched and reused; RE only needed to understand what the normal-world kernel must call (SMC calls) to keep secure boot/verified boot/HW-backed features from breaking the device | SMC call table, calling convention |
| Modem/DSP firmware | Rarely reversed in full; goal is just the shared-memory/QMI protocol used to talk to it from Linux | Protocol notes, not a rewritten firmware |

## 2.2 Setting up Ghidra for ARM/AArch64 Android binaries

1. Install Ghidra (≥11.x has solid AArch64/Thumb support) —
   see [07-tools-reference.md](07-tools-reference.md).
2. Import binaries as **ELF**, not raw — Android `.ko`/`.so` are standard
   ELFs; Ghidra's ELF loader auto-detects `EM_ARM`/`EM_AARCH64` and endianness.
3. For bare bootloaders (`abl.elf`, `lk.bin`, `u-boot.bin`) that aren't a
   normal ELF, import as **raw binary**, then manually set:
   - Language: `AARCH64:LE:64:v8A` (or `ARM:LE:32:v7` for 32-bit SoCs).
   - Base address: find it from the vendor's `unpack_bootimg` header
     (`kernel_addr`) or from known SoC memory maps (e.g. Qualcomm SBLs
     typically load at a fixed `0x8...` physical address — cross-check
     against public leaks/datasheets for the same SoC family).
4. Use the **Kernel Module analyzer** approach for `.ko` files: Ghidra
   doesn't resolve `EXPORT_SYMBOL` relocations automatically for out-of-tree
   modules. Cross-reference `Module.symvers`/`modules.dep` from the dumped
   vendor kernel build (if present in `/vendor` or `/system/lib/modules`)
   to resolve what each imported symbol actually is.

## 2.3 Recovering driver init sequences (the highest-value RE work)

Most "need to RE" driver work for porting a touchscreen/sensor/display
panel comes down to recovering:

- **Pinmux / clock enable sequence** — which GPIOs, regulators, and clocks
  get toggled, in what order, before the chip is probed (compare against
  the vendor DTB you already have from §1.3; the `.dts` often already
  encodes most of this declaratively, so Ghidra RE is only needed for
  *undocumented* bit-banged init that happens in driver `probe()`/`init()`
  rather than via the DT-described regulator/pinctrl framework).
- **I2C/SPI/MIPI-DSI register writes at probe time** — set a breakpoint
  strategy: use Ghidra's decompiler on `probe()` to dump the sequence of
  `regmap_write`/`i2c_smbus_write_byte_data` calls as a table of
  `(register, value, delay)` tuples. This table is exactly what a mainline
  Linux driver (or a DT-described `panel-simple`/`drm_panel` driver) needs.
- **Interrupt handling & calling convention into userspace** — what ioctls
  / sysfs nodes / `/dev` nodes the HAL expects, so a replacement or shimmed
  driver exposes compatible nodes.

Practical Ghidra workflow:

1. Open the `.ko`, let auto-analysis finish.
2. Find `module_init`/`probe` via the `MODULE_DEVICE_TABLE`/`of_match_table`
   symbol (Ghidra will show it as a global array of `{compatible string,
   data pointer}` — the compatible string is the same one in the DTB, so
   this cross-reference is free and exact).
3. Decompile `probe()`, follow calls into
   `regmap_write`/`gpiod_set_value`/`clk_set_rate`/`regulator_enable`, and
   transcribe the sequence.
4. Save it as a Ghidra **Function Comment** or export via
   Ghidra's scripting console (Python/Java) to a structured file — this
   becomes your porting notes, committed to the repo (never commit the
   binary itself).

## 2.4 Useful Ghidra scripts/plugins for this workflow

- **Kalkulator/BinDiff-style diffing** — compare the vendor driver against
  a known mainline driver for the same chip family (e.g. Synaptics/FocalTech
  touch controllers, OV/Samsung camera sensors) to spot what's actually
  different instead of RE'ing from zero.
- **`ghidra_bridge`** — script Ghidra from an external Python process to
  batch-process dozens of `.ko` files the same way (handy when a device
  ships 50+ vendor modules).
- **Android HAL-aware scripts** (community Ghidra scripts exist for
  recovering AIDL/HIDL interface vtables from HAL `.so` files) — useful when
  the thing you're RE'ing is a HAL rather than a kernel module.

## 2.5 Calling conventions & structure recovery (any ARM SoC)

This applies identically regardless of SoC vendor — it's an ARM/AArch64
ABI concern, not a chip-specific one.

- **AArch64 (ARMv8, 64-bit)**: standard AAPCS64 — first 8 integer/pointer
  args in `x0`-`x7`, return value in `x0` (or `x0`/`x1` for 128-bit/struct
  returns), `x29`/`x30` frame pointer/link register. Ghidra's analyzer
  gets this right automatically almost all the time; the manual work is
  recognizing kernel-specific calling patterns like `container_of`-style
  pointer arithmetic (a function receiving a generic `struct device *` or
  `struct i2c_client *` and immediately subtracting an offset to reach a
  driver-private struct — Ghidra shows this as raw pointer math; manually
  define the private struct's layout once you see the pattern repeated and
  apply it as a Ghidra data type for much more readable decompilation).
- **AArch32 (ARMv7, 32-bit, older/budget SoCs)**: first 4 args in
  `r0`-`r3`, rest on stack, return in `r0`/`r1`. Watch for **Thumb-2**
  interworking — Ghidra needs the low bit of a function's address (the
  "Thumb bit") to disassemble it correctly; if a function looks like
  garbage, check whether it should be analyzed as Thumb instead of ARM
  mode (Ghidra's auto-analysis usually gets this right from ELF symbol
  info, but raw/stripped blobs sometimes need a manual override).
- **Recovering a driver's private state struct**: in a `probe()`
  function, the pattern `devm_kzalloc(dev, sizeof(X), ...)` followed by
  dozens of field reads/writes at different offsets is your cue to define
  a Ghidra structure `X` and retype the pointer — this single step turns
  an unreadable wall of `*(undefined4 *)(param_1 + 0x48)` into named field
  accesses and usually resolves 80% of the confusion in RE'ing a vendor
  driver.
- **Resolving regmap/ioctl constant tables**: vendor drivers frequently
  define register-address/value tables as a `static const` array of
  structs. Once you've defined the struct layout (register, value,
  delay_us is a common three-field shape), Ghidra's "Create Structure"
  + "Apply data type" on the array turns the whole init-sequence table
  into an immediately readable, exportable list — this *is* the artifact
  you want for a new mainline driver, so plan to export it (Ghidra
  scripting, or just manually transcribing a short table) directly into
  your porting notes.

## 2.6 TrustZone / QSEE / secure monitor firmware

Every major vendor has an equivalent of Qualcomm's TrustZone/QSEE,
MediaTek's/Samsung's TEE images, etc. — a separate, signed firmware image
running in the ARM TrustZone secure world, handling verified boot, DRM
keys, and sometimes modem/DSP firmware authentication.

- **Goal is narrow**: you almost never need to fully reverse the secure
  firmware itself. What you need is the **SMC (Secure Monitor Call) ABI**
  — which SMC function IDs the normal-world (Linux) kernel must call, in
  what order, during boot and during normal operation, to avoid a secure
  watchdog panic or a feature silently failing.
- **How to find it quickly**: grep the vendor's normal-world kernel
  (`.ko`/`vmlinux`) for `smc`/`hvc` instruction use (Ghidra will show these
  as distinct mnemonics you can search for directly — Search → For
  Instruction Patterns), then decompile the small wrapper functions around
  each call site rather than the secure firmware itself. This gives you
  the SMC function-ID/argument contract from the *caller* side, which is
  all a new kernel driver needs to replicate.
- **Anti-rollback/fuse concerns**: some secure firmware enforces an
  anti-rollback counter that can permanently prevent flashing an older
  signed stage once a newer one has booted. This is a hardware fuse, not
  something RE helps with — always check the vendor's own documentation
  on anti-rollback behavior before experimenting with older bootloader/TZ
  images.

## 2.7 Handling stripped, obfuscated, or packed vendor binaries

- **Stripped `.ko`/`.so` with no symbols**: still has
  `MODULE_DEVICE_TABLE`/`of_match_table` data structures intact (they're
  referenced by the module-loading infrastructure, so they survive
  stripping) — use those as anchor points per §2.3 even with zero symbol
  names elsewhere.
- **Packed/compressed sections** (occasionally seen in bootloader stage1/2
  images to save space): `binwalk -e` to check for embedded
  compressed/archived regions before assuming raw disassembly is the right
  starting point; decompress to a flat binary, then re-import to Ghidra at
  the correct base address.
- **Control-flow obfuscation**: rare in Android driver code (vendors
  generally don't bother obfuscating kernel modules/HALs the way malware
  authors do), but if you hit it, Ghidra's P-Code and the decompiler's
  "Simplify" options handle most compiler-generated noise; genuine
  hand-obfuscation on a device driver is unusual enough that it's worth
  double-checking you're not looking at a copy-protection/DRM component
  instead of a hardware driver — those are a different (and generally out
  of scope for device-porting) problem.

## 2.8 Cross-referencing with public symbol/debug info

- Many vendor kernels, even stripped, retain enough of `vmlinux`/`.ko`
  `.symtab` for Ghidra to label functions — check before assuming a blind
  disassembly.
- SoC vendors (Qualcomm, MediaTek) publish partial kernel source
  (`CodeAurora`/the Linux-kernel upstream BSP trees, or MediaTek's kernel
  releases required by GPLv2) for many chips — diffing the vendor binary
  against the matching open BSP source is usually far faster than reading
  raw disassembly, and is the standard first move before touching Ghidra at
  all.

## Next

→ [03-hardware-identification.md](03-hardware-identification.md) to turn
what you recovered into a concrete hardware inventory (SoC, peripherals,
buses) that drives the kernel porting work.
