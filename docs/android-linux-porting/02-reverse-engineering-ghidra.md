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

1. Install Ghidra (≥11.x has solid AArch64/Thumb support; 11.3+ bundles
   PyGhidra for CPython scripting) — see
   [07-tools-reference.md](07-tools-reference.md). The headless CLI
   (`support/analyzeHeadless`) and scripting APIs come with the same
   install; no separate package. A JDK is the one external prerequisite.
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

- **Binary diffing (BinDiff + BinExport, or Ghidra's built-in Version Tracking)** — compare the vendor driver against
  a known mainline driver for the same chip family (e.g. Synaptics/FocalTech
  touch controllers, OV/Samsung camera sensors) to spot what's actually
  different instead of RE'ing from zero.
- **Headless batch analysis** — a device ships dozens of vendor `.ko`/`.so`
  files and you rarely want to open each by hand. Ghidra's headless CLI
  imports, auto-analyzes, and runs a script over a binary with no GUI:

  ```bash
  # Ghidra's own CLI (support/analyzeHeadless). Creates/uses a project,
  # imports every module, runs a post-analysis script on each:
  "$GHIDRA_HOME/support/analyzeHeadless" ./proj vendor_modules \
    -import vendor_mnt/lib/modules/*.ko \
    -postScript dump_of_match.py \
    -scriptPath ./ghidra_scripts
  ```

  The script (`dump_of_match.py`) can, for example, pull the
  `of_match_table` compatible strings and `probe` addresses out of every
  module at once, so you get a device-wide map of "which module claims
  which DT node" in one run — the §2.9 step 1 anchor, batched.
- **PyGhidra** (bundled with Ghidra 11.3+; was the external `pyhidra`
  project before that) — write those scripts in real CPython 3 with
  normal `pip` packages available, instead of Ghidra's built-in Jython.
  It also gives an interactive interpreter against an analyzed program,
  which is the fastest way to explore a struct layout or dump a constant
  table (§2.5) without clicking through the GUI. Scripts written for
  PyGhidra run under `analyzeHeadless -postScript` the same way.
- **`ghidra_bridge`** — the older approach: drive a *running* GUI Ghidra
  from an external Python process. Still useful when you want to script
  against a session you're also inspecting by hand; for pure batch work,
  prefer headless + PyGhidra above.
- **HAL interface recovery** — HIDL/AIDL HALs keep their interface
  descriptor strings (e.g. `android.hardware.sensors@2.0::ISensors`) in
  the `.so`; searching for them in Ghidra is the fastest way to map
  vtable entries to interface methods. The matching `.hal`/`.aidl`
  definitions are public in AOSP's `hardware/interfaces` tree, which
  gives you method order and signatures for free.

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

### Worked example: recovering an SMC call contract

Say the GPU won't come out of secure mode without the zap-shader unlock
(§9.1) and you need to know exactly what SMC call the vendor kernel makes
to load it. As with §2.9, the snippet below is representative of the
idiom, not a dump from a specific device.

**1. Find the call sites.** In Ghidra, Search → For Instruction Patterns
for the `smc` mnemonic (AArch64: `smc #0`). Each hit is a call into the
secure monitor. Follow the xrefs up to the small C wrapper around it:

```c
// Ghidra decompiles the SMC wrapper to something like:
long qcom_scm_call(uint svc, uint cmd, ulong a0, ulong a1, ulong a2) {
    reg x0 = 0x02000000 | (svc << 10) | cmd;   // the SMC function ID
    reg x1 = a0; reg x2 = a1; reg x3 = a2;
    smc(0);                                     // trap to EL3
    return x0;                                  // status in x0 on return
}
```

**2. Recover the function ID.** The value built into `x0` is the SMC
Function ID — the thing you must replicate. Decode its fields against the
ARM SMC Calling Convention (SMCCC): bit 31 = call type (fast/yielding),
bit 30 = 32- vs 64-bit, bits 29-24 = owner/service, bits 15-0 =
function number. On Qualcomm the `0x02000000` base + `svc`/`cmd` shifts
*are* Qualcomm's SCM convention; mainline already encodes it in
`drivers/firmware/qcom_scm.c`, so your job is usually to confirm the
`svc`/`cmd` pair the vendor used, not invent the ABI.

**3. Recover the arguments at the call you care about.** Decompile the
caller (the zap-load path here) to see what it passes:

```c
qcom_scm_call(0x01 /*SVC_PIL*/, 0x06 /*CMD_PIL_INIT_IMAGE*/,
              MEM_PA(fw_metadata),   // physical addr of the firmware header
              fw_metadata_size, 0);
// ... later: a MEM_SETUP, then an AUTH_AND_RESET command
```

That tells you the sequence (init-image → mem-setup → auth-and-reset) and
which physical buffers each stage expects — the same "peripheral image
loader" (PIL) handshake mainline's `qcom_scm_pas_*` functions implement.

**4. Map to mainline before writing anything.** For Qualcomm and, to a
lesser extent, other vendors, the SMC/SCM layer is already upstream —
the RE here is to *confirm which documented call the vendor used*, then
use the mainline wrapper, not to hand-roll `smc` instructions in your
driver. You only write new SMC plumbing when the call genuinely has no
mainline equivalent (rare, and worth asking the SoC's mailing list about
before assuming, §14).

**5. Export to `re-notes.md`** — the call contract, never the TZ binary:

```markdown
## GPU zap unlock — SCM/PIL handshake (RE'd from vendor kernel)
- SMC base 0x02000000, SVC_PIL(0x01): INIT_IMAGE(0x06), MEM_SETUP, AUTH_AND_RESET
- Args: physical addr + size of a540_zap metadata (§9.1 for the blob)
- Mainline equivalent: drivers/firmware/qcom_scm.c qcom_scm_pas_* — use it
```

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
  (Qualcomm's CodeLinaro-hosted trees — formerly CodeAurora, shut down in
  2022 — or MediaTek's kernel releases required by GPLv2) for many chips —
  diffing the vendor binary against the matching open BSP source is usually
  far faster than reading raw disassembly, and is the standard first move
  before touching Ghidra at all.

## 2.9 Worked example: recovering a touch-controller init sequence

This walks the §2.3 workflow end to end on a representative I2C touch
driver. The decompiler snippets below are illustrative of the kernel
idioms you'll actually see (real register values differ per chip); the
*method* is what to copy, not the numbers.

**Goal:** no mainline driver binds this panel's touch controller, so you
need the exact power-on + register-init sequence the vendor `probe()`
runs, to feed a `drm_panel`/`input` driver (§4.4).

**1. Find the entry point.** Auto-analysis done, go to the
`of_match_table`. Even in a stripped module it survives (§2.7); Ghidra
shows it as an array of `{char *compatible, void *data}`:

```
00081a40  "focaltech,fts_ts"   00081b00
```

The `compatible` string matches a node in the DTB from §1.3 — follow the
data pointer, or just xref the `probe` function the driver registered.

**2. Define the private struct.** `probe()` opens with:

```c
ts = devm_kzalloc(&client->dev, 0x118, GFP_KERNEL);   // sizeof(struct fts_ts_data)
```

That `0x118` is the struct size — create a 0x118-byte Ghidra structure,
retype `ts`, and the later `*(undefined4 *)(ts + 0x40)` reads become
named fields (§2.5). Do this first; everything downstream gets readable.

**3. Transcribe the power-on sequence.** Follow the regulator/GPIO calls
before any I2C traffic:

```c
regulator_enable(ts->vdd);                 // pull from the DTS regulator name
usleep_range(1000, 1100);
gpiod_set_value(ts->reset_gpio, 0);        // assert reset
usleep_range(10000, 11000);
gpiod_set_value(ts->reset_gpio, 1);        // release reset
msleep(200);                               // mandatory post-reset settle
```

Every delay matters — a missing `msleep` here is the classic "driver
probes cleanly but the panel is black" bug (§11.3).

**4. Transcribe the register writes.** The init itself is usually a loop
over a `static const` table (§2.5). Ghidra shows the table as bytes until
you define the element struct — here a `{u8 reg; u8 val;}` pair:

```c
for (i = 0; i < 7; i++)
    fts_i2c_write(client, init_tbl[i].reg, init_tbl[i].val);
```

Define the 2-byte structure, apply it across the array, and the table
reads out directly:

| reg | val | meaning (from the vendor header if you have it, else note "unknown") |
|---|---|---|
| 0x00 | 0x00 | mode: normal/active |
| 0xA4 | 0x01 | interrupt mode: trigger |
| 0x80 | 0x3C | touch threshold |
| … | … | … |

**5. Note the IRQ contract.** Find `devm_request_threaded_irq` and record
the trigger type (`IRQF_TRIGGER_FALLING` etc.) and which GPIO — a
mismatch here is "device node exists, no input events" (§11.3).

**6. Export to `re-notes.md`.** The committed artifact is a text table,
never the binary (§CONTRIBUTING):

```markdown
## Touchscreen — FocalTech FTS (compatible: focaltech,fts_ts)
- Source: vendor touch .ko, probe() @ 0x81c40 (RE'd, no public source)
- Power-on: vdd on → 1ms → reset low → 10ms → reset high → 200ms
- Init table: 0x00=0x00, 0xA4=0x01, 0x80=0x3C, ...
- IRQ: GPIO<n>, falling-edge, threaded
```

That note is enough to write or wire up a mainline driver without ever
touching the vendor binary again — and if your first boot shows the panel
probing but dead, §11.3 sends you straight back to step 3's delays.

## Next

→ [03-hardware-identification.md](03-hardware-identification.md) to turn
what you recovered into a concrete hardware inventory (SoC, peripherals,
buses) that drives the kernel porting work.
