# Phase 7 — Ghidra reverse-engineering of vendor HAL blobs

The display, camera, and modem HALs on this device are closed-source MediaTek
binaries. When bring-up (Phases 3-6) stalls because a HAL needs something we
cannot see, we reverse-engineer the blob with Ghidra to learn its IPC contract
(device nodes, ioctls, binder services, shared memory) and reproduce it.

## Toolchain (verified working here)

- Ghidra **12.1.2** at `$HOME/ghidra_12.1.2_PUBLIC_20260605`
- Ghidra 12.x runs Python headless scripts through **PyGhidra** (CPython), not
  the old Jython. `run-ghidra.sh` uses `pyghidraRun --headless` and auto-confirms
  the one-time PyGhidra venv install.

## Usage

```bash
cd ubuntu-touch/ghidra

# Analyze a blob (first run installs PyGhidra into a venv, ~1 min):
./run-ghidra.sh /path/to/vendor/lib64/some-hal.so

# Big binaries (camera HAL ~1 MB+) take a while - run in background:
nohup ./run-ghidra.sh /path/to/libcameraservice.so > ghidra.log 2>&1 &
```

Outputs land in `$GHIDRA_OUT` (default `/tmp/ghidra-out`):

| File | Contents |
|---|---|
| `<blob>.functions.txt` | function inventory (address, size, name) |
| `<blob>.decomp.c` | decompiled C for every function |
| `<blob>.strings.txt` | IPC/HAL/device-path strings (`/dev/`, ioctl, binder…) |
| `<blob>.ipc-xrefs.txt` | callers of IPC-ish functions (ioctl/open/socket…) |

The analysis script is `analyze_hal.py` (a PyGhidra post-analysis script). Edit
its `KEYWORDS` / `IPC` lists to target a specific subsystem.

## Worked example: the modem (CCCI) library — DONE

`libccci_util.so` (48 KB, the MediaTek CCCI modem utility lib) was analyzed.
Saved outputs: `artifacts/ghidra/libccci_util.so.*`.

### Modem IPC architecture discovered

The AP talks to the MD6873 modem over **CCCI** (Cross Core Communication
Interface) character devices + shared memory, with an **EEMCS** fallback path.

**Control / config:**
- `/dev/ccci_ccb_ctrl` — CCCI control-block device (the main control channel)
- `/dev/ccci_monitor`, `/dev/ccci_mdl_monitor`, `/dev/ccci_rpc`, `/dev/ccci_fs`
- `/dev/emd_ctl0..4`, `/dev/emd_cfifo1` — modem (EMD) control
- sysfs: `/sys/kernel/ccci/kcfg_setting`, `/sys/kernel/ccci/version`

**ioctls (the kernel ABI to reproduce):**
- `CCCI_IOC_CCB_CTRL_INFO` — control-block info
- `CCCI_IOC_SMEM_BASE`, `CCCI_IOC_SMEM_LEN` — shared-memory region for AP↔MD
- `CCCI_IOC_GET_CCB_CONFIG_LENGTH`

**Data channels (per modem instance ccci/ccci2/ccci3):**
- RIL/AT: `/dev/ccci_ioctl0..4`, `/dev/ccci3_at`, `/dev/eemcs_ril`
- IPC: `/dev/ccci_ipc_1220_0`, `/dev/ccci_ipc_2/4/9`, `/dev/eemcs_ipc_*`
- IMS / VoLTE: `/dev/ccci_imsa`, `imsv`, `imsc`, `imsem`, `imsm`
- Audio: `/dev/ccci_aud`, `ccci2_aud`, `ccci3_aud`, `ccci_raw_audio`,
  `/dev/ccci_pcm_tx`/`rx`
- Logging: `/dev/ccci_md_log_tx`/`rx`/`ctrl`, `/dev/ccci_raw_dhl`
- Misc: `/dev/ccci_uem_tx`/`rx`, `/dev/ccci_wifi_proxy`, `/dev/ccci_woa`,
  `/dev/ccci_raw_netd`, `/dev/ccci_raw_usb`, `/dev/ccci_raw_mdm`

**Modem firmware images:** `/dev/block/by-name/md1img`, `md3img`
(variant string `MTK_ECCCI_C2K` → the enhanced-CCCI C2K modem).

**Key API (105 functions):** `ccci_ccb_register/unregister`, `ccci_ccb_get_fd`,
`ccci_ccb_read_get/read_done/write_alloc/write_done`, `ccci_ccb_query_status`,
`ccci_ccb_poll`, `ccci_smem_get/put`, `find_image_from_pt`,
`restore_image_from_pt`, `query_kcfg_setting`.

### What this means for the port

To get the RIL working under Ubuntu Touch (ofono), the vendor `libccci_util`
+ `ccci_rpc`/`ccci_fs` daemons must run (they own these nodes), and the nodes
above must be bind-mounted into the LXC container (see
`rootfs-overlay/etc/udev/rules.d/70-mt6873.rules` and the ccci group). The
shared-memory ioctls (`CCCI_IOC_SMEM_*`) are how the AP and modem exchange
buffers — this is the contract `ofono` + the MTK RIL HAL rely on. No need to
reimplement the modem; just ensure these nodes/daemons/permissions exist.

## Next RE targets (when the relevant phase stalls)

| Blob | Why |
|---|---|
| `libcameraservice.so` + `vendor/lib64/libmtkcam_metastore.so` | camera bring-up (Phase 7) |
| `vendor/lib64/hw/gralloc.mt6873.so` | GPU buffer allocation (Phase 5) |
| `vendor/lib64/libOpenCL.so` | Mali-G57 compute/EGL (Phase 5) |
| `vendor/lib64/hw/fs1603s.smartpa.mt6873.so` | audio smartpa init (Phase 6) |
| `vendor/bin/mnld` | GNSS daemon (Phase 6) |
