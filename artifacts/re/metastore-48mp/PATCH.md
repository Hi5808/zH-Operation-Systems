# 48 MP patch — libmtkcam_metastore.so (IMX582 main)

RE'd function: constructCustStaticMetadata_DEVICE_SCALER_SENSOR_DRVNAME_IMX582CTS_MIPI_RAW
(st_value 0x64024; Ghidra image base 0x100000 → 0x164024). It builds tag 0xd000a
(SCALER_AVAILABLE_STREAM_CONFIGURATIONS) + min-frame-duration + stall-duration tables as
{format,width,height,dir} tuples via IEntry::push_back. JPEG = format 0x21 (BLOB).

Stock JPEG max = 4000x3000 (12 MP). 48 MP (8000x6000) existed only as the custom2 sensor
remosaic mode, never advertised to apps.

PATCH (file offsets == vaddr; movz w8 re-encode 0x52800000|(imm<<5)|8):
3 JPEG (0x21) width sites 4000->8000 and their height sites 3000->6000, consistent across
all three tables; the 3 YUV (0x23) sites left at 4000x3000 so preview/video are unaffected.
| width off | 08 f4 81 52 -> 08 e8 83 52 | height off | 08 77 81 52 -> 08 ee 82 52 |
| 0x641bc | #4000->#8000 | 0x641d0 | #3000->#6000 |  (stream config)
| 0x64c14 |              | 0x64c28 |              |  (min frame duration)
| 0x65690 |              | 0x656a4 |              |  (stall duration)

RISK: if the ISP/Camera1 path can't route an 8000x6000 request through the remosaic feature,
capture may fail/upscale rather than true 48 MP remosaic. Reversible (bind-mount + killswitch).
Verify: camera HAL opens (no metadata rejection), app offers 8000x6000, captured JPEG is
8000x6000 AND genuinely detailed (not upscaled).

## DEPLOY MECHANISM (validated 2026-10-07)
libmtkcam_metastore.so lives on the RO `vendor` logical partition, mounted INTO the android
LXC container. A host-side systemd bind does NOT reach the container mount ns, and the
container config is on the RO UT rootfs. Working method:
1. Patched .so at /userdata/bl6000pro-48mp/libmtkcam_metastore.so (stock backed up alongside).
2. Build a modified android lxc config = stock /var/lib/lxc/android/config + line:
   `lxc.mount.entry = /userdata/bl6000pro-48mp/libmtkcam_metastore.so vendor/lib64/libmtkcam_metastore.so none bind,optional 0 0`
   stored at /userdata/bl6000pro-48mp/android-config.
3. Service bl6000pro-camera-48mp.service (Before=lxc-android-config) bind-mounts that modified
   config over /var/lib/lxc/android/config. Kill switch: /userdata/bl6000pro-48mp/48mp.off.
VERIFY inside the container (host /android/vendor shows STOCK — wrong path):
  `python3 -c "print(open('/proc/$(pgrep -x camerahalserver)/root/vendor/lib64/libmtkcam_metastore.so','rb').read().count(bytes.fromhex('08e88352')))"` → 3 = active.
VALIDATED: patch active in-container, camerahalserver running (metadata accepted, no reject).

## REMAINING (physical): capture test
Launch camera, select max resolution, capture. Confirm the JPEG is 8000x6000 AND genuinely
detailed (remosaic ran) rather than an upscaled 4000x3000. If capture fails or upscales, the
Camera1/compat path isn't routing through the remosaic feature → then drive remosaicenable via
a Camera2 path, or revert (48mp.off) and leave at 12 MP.

## OUTCOME (2026-10-07): ROUTE 1 IS A DEAD END for the Camera1/compat stack
With the patch active, the camera app CRASHED on capture: dmesg showed the MTK JPEG encoder
clock engaging (mtk_jpeg_clk_on) then the app dying — the Camera1 / libhybris-compat capture
path cannot configure/encode an 8000x6000 stream (the HAL advertises it, but the legacy capture
pipeline chokes). camerahalserver itself stayed up; the client (lomiri-camera-app) died.
REVERTED via kill switch (/userdata/bl6000pro-48mp/48mp.off) + service disabled; a reboot
restored stock metastore and the camera app runs cleanly again at 12 MP.

CONCLUSION: advertising 48 MP in metadata is necessary but NOT sufficient. Real 48 MP needs the
MTK vendor remosaic FEATURE path (request tag `remosaicenable`, MTK_FEATURE_REMOSAIC), which is
only drivable from a **Camera2** client. qtubuntu-camera is Camera1-era via the compat layer and
cannot issue those vendor request tags. So 48 MP is NOT achievable with the current UT camera
stack. Options for a future attempt: (a) a Camera2-capable capture path/app on UT, or
(b) a much deeper HAL patch to force remosaic internally on a normal 12MP+ request — high risk.
RECOMMENDATION: leave at 12 MP (stock, working). Keep this RE as a documented dead end.
