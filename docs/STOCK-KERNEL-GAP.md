# Stock kernel vs ours: what is missing (2026-10-06)

Method: every text symbol in the stock vmlinux (nm.txt, LTO hashes and .cfi_jt
stripped) minus every text symbol in our out-halium/vmlinux. 55,845 stock vs
133,078 ours, **445 stock functions missing** (full list:
artifacts/re/stock-missing-functions.txt). Grouped by need:

## Needed (device features)
| Area | Missing in ours | Effect | Fix |
|---|---|---|---|
| Main camera autofocus | GT9772AF_*_Main, BU63169AF_*_Main | none: the HAL uses DW9800AF (present) for IMX582; AF verified working | GT9772AF added anyway (e5ad6243c) |
| Ultra-wide MIPI path | stock platform_power_sequence (MIPI switch EN=0/SEL=0 for MAIN2 + MAIN3) | ultra-wide streams but no frames reach SENINF | **fixed** (kernel #35) |
| Camera calibration | imx582_get_otp_data, imx582_selective_read_region, load_imx582_awb, BL24SA64_write_region | no OTP/EEPROM AWB/LSC → CamCal ERR_NO_PARTNO, worse colour/shading, grain | port stock imx582 OTP read path (EEPROM BL24SA64) |
| Fingerprint | sf_* / sunwave_* (SunWave), fsfp_* / fortsense_* (FortSense), hct_finger_plat_probe | no fingerprint reader driver | port vendor FP driver (pick the fitted sensor by ID) |
| Charging thermal | mtkcooler_bcct(_2nd)*, _cl_abcct*, clbcct_*, chrlmt_*, mtk_chr_get_* | no charge-current thermal throttling | enable MTK bcct/abcct coolers in config |
| Custom keys | kpd_customkey_f1/f2_handler | programmable side key not mapped | port kpd custom key handling |
| Headset mic switch | hct_accdet_mic_switch, hct_acc_gpio_set, get_acc_select_gpio | headset mic path switching | port HCT accdet glue |

## Alternate modules (only if fitted)
IMX582CTS, S5K3L6XXCTS, S5K3P9SPCTS sensors; DW9714AF/DW9800AF/DW9800WAF/FP5510E2AF
lens variants for Main2/Main3/Sub2. Second-source parts; add only if a unit
reports them.

## Not needed / no user effect
- hct_* device-info registry (58, proc/sysfs hardware info)
- gc032a/yuvcamera: depth "brightness probe", see WORKLOG
- nvt_mp_* touchscreen self-test, spi_slave/spislv test, perfmgr background, CAMERA_HW_Reg_Debug6-8
- fuse passthrough, unix_attach_fds, deadline/bictcp/elf (renamed static copies, present under other names)
- kbase/mdw/mdp/venc/primary_display helpers (renamed or refactored in our tree)
