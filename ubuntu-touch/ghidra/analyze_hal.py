# analyze_hal.py - Ghidra headless post-analysis script for BL6000 Pro vendor
# HAL blobs (Phase 7: camera / modem reverse engineering).
#
# Run via run-ghidra.sh (analyzeHeadless ... -postScript analyze_hal.py).
# After Ghidra's auto-analysis this exports, for the imported binary:
#   1. A function inventory (name, address, size) -> <bin>.functions.txt
#   2. Decompiled C for every function          -> <bin>.decomp.c
#   3. Interesting strings (IPC / binder / HAL / device paths) -> <bin>.strings.txt
#   4. Cross-references to IPC-ish imports (ioctl, binder, socket, dlopen)
#                                              -> <bin>.ipc-xrefs.txt
#
# Ghidra headless runs this under Jython (Python 2.7 syntax). The Ghidra API
# objects (currentProgram, state) are injected by the analyzer.
# @category BL6000Pro

import os
from ghidra.app.decompiler import DecompInterface
from ghidra.program.model.symbol import SourceType

prog = currentProgram
name = prog.getName()
listing = prog.getListing()
fm = prog.getFunctionManager()
mem = prog.getMemory()

# Output next to the imported binary (Ghidra sets the project dir; use /tmp).
outdir = os.environ.get("GHIDRA_OUT", "/tmp/ghidra-out")
if not os.path.isdir(outdir):
    os.makedirs(outdir)
base = os.path.join(outdir, name)

print("[analyze_hal] program: %s  arch: %s" % (name, prog.getLanguageID()))

# --- 1. Function inventory ---------------------------------------------------
funcs = list(fm.getFunctions(True))
with open(base + ".functions.txt", "w") as f:
    f.write("# %d functions in %s\n" % (len(funcs), name))
    for fn in funcs:
        f.write("0x%s\t%d\t%s\n" % (fn.getEntryPoint().toString(),
                                     fn.getBody().getNumAddresses(),
                                     fn.getName()))
print("[analyze_hal] wrote %d functions" % len(funcs))

# --- 2. Decompile every function --------------------------------------------
decomp = DecompInterface()
decomp.openProgram(prog)
with open(base + ".decomp.c", "w") as f:
    f.write("/* Decompiled from %s by Ghidra (BL6000 Pro port) */\n" % name)
    for fn in funcs:
        try:
            res = decomp.decompileFunction(fn, 30, None)
            if res is not None and res.decompileCompleted():
                code = res.getDecompiledFunction().getC()
                f.write("\n/* %s @ %s */\n%s\n" % (fn.getName(),
                                                   fn.getEntryPoint(), code))
        except Exception as e:
            f.write("\n/* %s: decompile failed: %s */\n" % (fn.getName(), e))
print("[analyze_hal] decompiled functions -> %s.decomp.c" % base)

# --- 3. Interesting strings --------------------------------------------------
KEYWORDS = ["binder", "ioctl", "/dev/", "hwbinder", "vndbinder", "halservice",
            "camera", "modem", "ccci", "apdu", "socket", "mtk", "mediatek",
            "hal", "aidl", "hidl", "service", "open", "AT+", "ril", "nvram"]
with open(base + ".strings.txt", "w") as f:
    for s in listing.getDefinedData(True):
        try:
            val = s.getValue()
            if val is None:
                continue
            txt = str(val)
        except Exception:
            continue
        low = txt.lower()
        for kw in KEYWORDS:
            if kw in low:
                f.write("0x%s\t%s\n" % (s.getAddress().toString(), txt))
                break
print("[analyze_hal] wrote interesting strings")

# --- 4. Cross-references to IPC-ish imports ----------------------------------
IPC = ["ioctl", "binder", "socket", "connect", "open", "dlopen", "dlsym",
       "write", "read", "send", "recv", "HWBinder", "transact"]
refmgr = prog.getReferenceManager()
with open(base + ".ipc-xrefs.txt", "w") as f:
    for fn in funcs:
        nm = fn.getName().lower()
        for kw in IPC:
            if kw.lower() in nm:
                # who calls this function?
                it = refmgr.getReferencesTo(fn.getEntryPoint())
                callers = [r.getFromAddress().toString() for r in it]
                f.write("%s @ %s  <- called from %d site(s): %s\n" % (
                    fn.getName(), fn.getEntryPoint(), len(callers),
                    ", ".join(callers[:10])))
                break
print("[analyze_hal] wrote IPC cross-references")
print("[analyze_hal] DONE. Outputs in %s" % outdir)
