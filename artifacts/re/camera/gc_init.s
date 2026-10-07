
../stock-kernel/vmlinux.elf:	file format ELF64-aarch64-little


Disassembly of section .kernel:

ffffff8008b249c4 GC032a_Sensor_Init:
ffffff8008b249c4:      	sub	sp, sp, #96
ffffff8008b249c8:      	stp	x29, x30, [sp, #16]
ffffff8008b249cc:      	stp	x26, x25, [sp, #32]
ffffff8008b249d0:      	stp	x24, x23, [sp, #48]
ffffff8008b249d4:      	stp	x22, x21, [sp, #64]
ffffff8008b249d8:      	stp	x20, x19, [sp, #80]
ffffff8008b249dc:      	add	x29, sp, #16
ffffff8008b249e0:      	adrp	x8, #22597632
ffffff8008b249e4:      	ldr	x8, [x8, #4088]
ffffff8008b249e8:      	mov	w9, #65523
ffffff8008b249ec:      	add	x0, sp, #4
ffffff8008b249f0:      	mov	w1, #2
ffffff8008b249f4:      	mov	w2, #66
ffffff8008b249f8:      	str	x8, [sp, #8]
ffffff8008b249fc:      	strh	w9, [sp, #4]
ffffff8008b24a00:      	bl	#-196776 <iWriteRegI2C>
ffffff8008b24a04:      	mov	w8, #1781
ffffff8008b24a08:      	add	x0, sp, #4
ffffff8008b24a0c:      	mov	w1, #2
ffffff8008b24a10:      	mov	w2, #66
ffffff8008b24a14:      	strh	w8, [sp, #4]
ffffff8008b24a18:      	bl	#-196800 <iWriteRegI2C>
ffffff8008b24a1c:      	mov	w8, #503
ffffff8008b24a20:      	add	x0, sp, #4
ffffff8008b24a24:      	mov	w1, #2
ffffff8008b24a28:      	mov	w2, #66
ffffff8008b24a2c:      	strh	w8, [sp, #4]
ffffff8008b24a30:      	bl	#-196824 <iWriteRegI2C>
ffffff8008b24a34:      	mov	w8, #1016
ffffff8008b24a38:      	add	x0, sp, #4
ffffff8008b24a3c:      	mov	w1, #2
ffffff8008b24a40:      	mov	w2, #66
ffffff8008b24a44:      	strh	w8, [sp, #4]
ffffff8008b24a48:      	bl	#-196848 <iWriteRegI2C>
ffffff8008b24a4c:      	mov	w8, #52985
ffffff8008b24a50:      	add	x0, sp, #4
ffffff8008b24a54:      	mov	w1, #2
ffffff8008b24a58:      	mov	w2, #66
ffffff8008b24a5c:      	strh	w8, [sp, #4]
ffffff8008b24a60:      	bl	#-196872 <iWriteRegI2C>
ffffff8008b24a64:      	mov	w8, #250
ffffff8008b24a68:      	add	x0, sp, #4
ffffff8008b24a6c:      	mov	w1, #2
ffffff8008b24a70:      	mov	w2, #66
ffffff8008b24a74:      	strh	w8, [sp, #4]
ffffff8008b24a78:      	bl	#-196896 <iWriteRegI2C>
ffffff8008b24a7c:      	mov	w8, #764
ffffff8008b24a80:      	add	x0, sp, #4
ffffff8008b24a84:      	mov	w1, #2
ffffff8008b24a88:      	mov	w2, #66
ffffff8008b24a8c:      	strh	w8, [sp, #4]
ffffff8008b24a90:      	bl	#-196920 <iWriteRegI2C>
ffffff8008b24a94:      	mov	w25, #766
ffffff8008b24a98:      	add	x0, sp, #4
ffffff8008b24a9c:      	mov	w1, #2
ffffff8008b24aa0:      	mov	w2, #66
ffffff8008b24aa4:      	strh	w25, [sp, #4]
ffffff8008b24aa8:      	bl	#-196944 <iWriteRegI2C>
ffffff8008b24aac:      	mov	w8, #897
ffffff8008b24ab0:      	add	x0, sp, #4
ffffff8008b24ab4:      	mov	w1, #2
ffffff8008b24ab8:      	mov	w2, #66
ffffff8008b24abc:      	strh	w8, [sp, #4]
ffffff8008b24ac0:      	bl	#-196968 <iWriteRegI2C>
ffffff8008b24ac4:      	mov	w19, #254
ffffff8008b24ac8:      	add	x0, sp, #4
ffffff8008b24acc:      	mov	w1, #2
ffffff8008b24ad0:      	mov	w2, #66
ffffff8008b24ad4:      	strh	w19, [sp, #4]
ffffff8008b24ad8:      	bl	#-196992 <iWriteRegI2C>
ffffff8008b24adc:      	mov	w8, #25719
ffffff8008b24ae0:      	add	x0, sp, #4
ffffff8008b24ae4:      	mov	w1, #2
ffffff8008b24ae8:      	mov	w2, #66
ffffff8008b24aec:      	strh	w8, [sp, #4]
ffffff8008b24af0:      	bl	#-197016 <iWriteRegI2C>
ffffff8008b24af4:      	mov	w8, #16504
ffffff8008b24af8:      	add	x0, sp, #4
ffffff8008b24afc:      	mov	w1, #2
ffffff8008b24b00:      	mov	w2, #66
ffffff8008b24b04:      	strh	w8, [sp, #4]
ffffff8008b24b08:      	bl	#-197040 <iWriteRegI2C>
ffffff8008b24b0c:      	mov	w8, #24697
ffffff8008b24b10:      	add	x0, sp, #4
ffffff8008b24b14:      	mov	w1, #2
ffffff8008b24b18:      	mov	w2, #66
ffffff8008b24b1c:      	strh	w8, [sp, #4]
ffffff8008b24b20:      	bl	#-197064 <iWriteRegI2C>
ffffff8008b24b24:      	add	x0, sp, #4
ffffff8008b24b28:      	mov	w1, #2
ffffff8008b24b2c:      	mov	w2, #66
ffffff8008b24b30:      	strh	w19, [sp, #4]
ffffff8008b24b34:      	bl	#-197084 <iWriteRegI2C>
ffffff8008b24b38:      	mov	w8, #259
ffffff8008b24b3c:      	add	x0, sp, #4
ffffff8008b24b40:      	mov	w1, #2
ffffff8008b24b44:      	mov	w2, #66
ffffff8008b24b48:      	strh	w8, [sp, #4]
ffffff8008b24b4c:      	bl	#-197108 <iWriteRegI2C>
ffffff8008b24b50:      	mov	w8, #52740
ffffff8008b24b54:      	add	x0, sp, #4
ffffff8008b24b58:      	mov	w1, #2
ffffff8008b24b5c:      	mov	w2, #66
ffffff8008b24b60:      	strh	w8, [sp, #4]
ffffff8008b24b64:      	bl	#-197132 <iWriteRegI2C>
ffffff8008b24b68:      	mov	w20, #261
ffffff8008b24b6c:      	add	x0, sp, #4
ffffff8008b24b70:      	mov	w1, #2
ffffff8008b24b74:      	mov	w2, #66
ffffff8008b24b78:      	strh	w20, [sp, #4]
ffffff8008b24b7c:      	bl	#-197156 <iWriteRegI2C>
ffffff8008b24b80:      	mov	w21, #44294
ffffff8008b24b84:      	add	x0, sp, #4
ffffff8008b24b88:      	mov	w1, #2
ffffff8008b24b8c:      	mov	w2, #66
ffffff8008b24b90:      	strh	w21, [sp, #4]
ffffff8008b24b94:      	bl	#-197180 <iWriteRegI2C>
ffffff8008b24b98:      	mov	w22, #7
ffffff8008b24b9c:      	add	x0, sp, #4
ffffff8008b24ba0:      	mov	w1, #2
ffffff8008b24ba4:      	mov	w2, #66
ffffff8008b24ba8:      	strh	w22, [sp, #4]
ffffff8008b24bac:      	bl	#-197204 <iWriteRegI2C>
ffffff8008b24bb0:      	mov	w23, #4104
ffffff8008b24bb4:      	add	x0, sp, #4
ffffff8008b24bb8:      	mov	w1, #2
ffffff8008b24bbc:      	mov	w2, #66
ffffff8008b24bc0:      	strh	w23, [sp, #4]
ffffff8008b24bc4:      	bl	#-197228 <iWriteRegI2C>
ffffff8008b24bc8:      	mov	w8, #10
ffffff8008b24bcc:      	add	x0, sp, #4
ffffff8008b24bd0:      	mov	w1, #2
ffffff8008b24bd4:      	mov	w2, #66
ffffff8008b24bd8:      	strh	w8, [sp, #4]
ffffff8008b24bdc:      	bl	#-197252 <iWriteRegI2C>
ffffff8008b24be0:      	mov	w8, #12
ffffff8008b24be4:      	add	x0, sp, #4
ffffff8008b24be8:      	mov	w1, #2
ffffff8008b24bec:      	mov	w2, #66
ffffff8008b24bf0:      	strh	w8, [sp, #4]
ffffff8008b24bf4:      	bl	#-197276 <iWriteRegI2C>
ffffff8008b24bf8:      	mov	w8, #269
ffffff8008b24bfc:      	add	x0, sp, #4
ffffff8008b24c00:      	mov	w1, #2
ffffff8008b24c04:      	mov	w2, #66
ffffff8008b24c08:      	strh	w8, [sp, #4]
ffffff8008b24c0c:      	bl	#-197300 <iWriteRegI2C>
ffffff8008b24c10:      	mov	w8, #59406
ffffff8008b24c14:      	add	x0, sp, #4
ffffff8008b24c18:      	mov	w1, #2
ffffff8008b24c1c:      	mov	w2, #66
ffffff8008b24c20:      	strh	w8, [sp, #4]
ffffff8008b24c24:      	bl	#-197324 <iWriteRegI2C>
ffffff8008b24c28:      	mov	w8, #527
ffffff8008b24c2c:      	add	x0, sp, #4
ffffff8008b24c30:      	mov	w1, #2
ffffff8008b24c34:      	mov	w2, #66
ffffff8008b24c38:      	strh	w8, [sp, #4]
ffffff8008b24c3c:      	bl	#-197348 <iWriteRegI2C>
ffffff8008b24c40:      	mov	w8, #34832
ffffff8008b24c44:      	add	x0, sp, #4
ffffff8008b24c48:      	mov	w1, #2
ffffff8008b24c4c:      	mov	w2, #66
ffffff8008b24c50:      	strh	w8, [sp, #4]
ffffff8008b24c54:      	bl	#-197372 <iWriteRegI2C>
ffffff8008b24c58:      	mov	w8, #21527
ffffff8008b24c5c:      	add	x0, sp, #4
ffffff8008b24c60:      	mov	w1, #2
ffffff8008b24c64:      	mov	w2, #66
ffffff8008b24c68:      	strh	w8, [sp, #4]
ffffff8008b24c6c:      	bl	#-197396 <iWriteRegI2C>
ffffff8008b24c70:      	mov	w8, #2073
ffffff8008b24c74:      	add	x0, sp, #4
ffffff8008b24c78:      	mov	w1, #2
ffffff8008b24c7c:      	mov	w2, #66
ffffff8008b24c80:      	strh	w8, [sp, #4]
ffffff8008b24c84:      	bl	#-197420 <iWriteRegI2C>
ffffff8008b24c88:      	mov	w8, #2586
ffffff8008b24c8c:      	add	x0, sp, #4
ffffff8008b24c90:      	mov	w1, #2
ffffff8008b24c94:      	mov	w2, #66
ffffff8008b24c98:      	strh	w8, [sp, #4]
ffffff8008b24c9c:      	bl	#-197444 <iWriteRegI2C>
ffffff8008b24ca0:      	mov	w8, #16415
ffffff8008b24ca4:      	add	x0, sp, #4
ffffff8008b24ca8:      	mov	w1, #2
ffffff8008b24cac:      	mov	w2, #66
ffffff8008b24cb0:      	strh	w8, [sp, #4]
ffffff8008b24cb4:      	bl	#-197468 <iWriteRegI2C>
ffffff8008b24cb8:      	mov	w8, #12320
ffffff8008b24cbc:      	add	x0, sp, #4
ffffff8008b24cc0:      	mov	w1, #2
ffffff8008b24cc4:      	mov	w2, #66
ffffff8008b24cc8:      	strh	w8, [sp, #4]
ffffff8008b24ccc:      	bl	#-197492 <iWriteRegI2C>
ffffff8008b24cd0:      	mov	w8, #32814
ffffff8008b24cd4:      	add	x0, sp, #4
ffffff8008b24cd8:      	mov	w1, #2
ffffff8008b24cdc:      	mov	w2, #66
ffffff8008b24ce0:      	strh	w8, [sp, #4]
ffffff8008b24ce4:      	bl	#-197516 <iWriteRegI2C>
ffffff8008b24ce8:      	mov	w8, #11055
ffffff8008b24cec:      	add	x0, sp, #4
ffffff8008b24cf0:      	mov	w1, #2
ffffff8008b24cf4:      	mov	w2, #66
ffffff8008b24cf8:      	strh	w8, [sp, #4]
ffffff8008b24cfc:      	bl	#-197540 <iWriteRegI2C>
ffffff8008b24d00:      	mov	w8, #6704
ffffff8008b24d04:      	add	x0, sp, #4
ffffff8008b24d08:      	mov	w1, #2
ffffff8008b24d0c:      	mov	w2, #66
ffffff8008b24d10:      	strh	w8, [sp, #4]
ffffff8008b24d14:      	bl	#-197564 <iWriteRegI2C>
ffffff8008b24d18:      	add	x0, sp, #4
ffffff8008b24d1c:      	mov	w1, #2
ffffff8008b24d20:      	mov	w2, #66
ffffff8008b24d24:      	strh	w25, [sp, #4]
ffffff8008b24d28:      	bl	#-197584 <iWriteRegI2C>
ffffff8008b24d2c:      	mov	w8, #515
ffffff8008b24d30:      	add	x0, sp, #4
ffffff8008b24d34:      	mov	w1, #2
ffffff8008b24d38:      	mov	w2, #66
ffffff8008b24d3c:      	strh	w8, [sp, #4]
ffffff8008b24d40:      	bl	#-197608 <iWriteRegI2C>
ffffff8008b24d44:      	mov	w8, #55045
ffffff8008b24d48:      	add	x0, sp, #4
ffffff8008b24d4c:      	mov	w1, #2
ffffff8008b24d50:      	mov	w2, #66
ffffff8008b24d54:      	strh	w8, [sp, #4]
ffffff8008b24d58:      	bl	#-197632 <iWriteRegI2C>
ffffff8008b24d5c:      	mov	w8, #24582
ffffff8008b24d60:      	add	x0, sp, #4
ffffff8008b24d64:      	mov	w1, #2
ffffff8008b24d68:      	mov	w2, #66
ffffff8008b24d6c:      	strh	w8, [sp, #4]
ffffff8008b24d70:      	bl	#-197656 <iWriteRegI2C>
ffffff8008b24d74:      	mov	w8, #32776
ffffff8008b24d78:      	add	x0, sp, #4
ffffff8008b24d7c:      	mov	w1, #2
ffffff8008b24d80:      	mov	w2, #66
ffffff8008b24d84:      	strh	w8, [sp, #4]
ffffff8008b24d88:      	bl	#-197680 <iWriteRegI2C>
ffffff8008b24d8c:      	mov	w8, #35090
ffffff8008b24d90:      	add	x0, sp, #4
ffffff8008b24d94:      	mov	w1, #2
ffffff8008b24d98:      	mov	w2, #66
ffffff8008b24d9c:      	strh	w8, [sp, #4]
ffffff8008b24da0:      	bl	#-197704 <iWriteRegI2C>
ffffff8008b24da4:      	add	x0, sp, #4
ffffff8008b24da8:      	mov	w1, #2
ffffff8008b24dac:      	mov	w2, #66
ffffff8008b24db0:      	strh	w19, [sp, #4]
ffffff8008b24db4:      	bl	#-197724 <iWriteRegI2C>
ffffff8008b24db8:      	mov	w8, #536
ffffff8008b24dbc:      	add	x0, sp, #4
ffffff8008b24dc0:      	mov	w1, #2
ffffff8008b24dc4:      	mov	w2, #66
ffffff8008b24dc8:      	strh	w8, [sp, #4]
ffffff8008b24dcc:      	bl	#-197748 <iWriteRegI2C>
ffffff8008b24dd0:      	add	x0, sp, #4
ffffff8008b24dd4:      	mov	w1, #2
ffffff8008b24dd8:      	mov	w2, #66
ffffff8008b24ddc:      	strh	w25, [sp, #4]
ffffff8008b24de0:      	bl	#-197768 <iWriteRegI2C>
ffffff8008b24de4:      	mov	w8, #8768
ffffff8008b24de8:      	add	x0, sp, #4
ffffff8008b24dec:      	mov	w1, #2
ffffff8008b24df0:      	mov	w2, #66
ffffff8008b24df4:      	strh	w8, [sp, #4]
ffffff8008b24df8:      	bl	#-197792 <iWriteRegI2C>
ffffff8008b24dfc:      	mov	w26, #69
ffffff8008b24e00:      	add	x0, sp, #4
ffffff8008b24e04:      	mov	w1, #2
ffffff8008b24e08:      	mov	w2, #66
ffffff8008b24e0c:      	strh	w26, [sp, #4]
ffffff8008b24e10:      	bl	#-197816 <iWriteRegI2C>
ffffff8008b24e14:      	mov	w8, #70
ffffff8008b24e18:      	add	x0, sp, #4
ffffff8008b24e1c:      	mov	w1, #2
ffffff8008b24e20:      	mov	w2, #66
ffffff8008b24e24:      	strh	w8, [sp, #4]
ffffff8008b24e28:      	bl	#-197840 <iWriteRegI2C>
ffffff8008b24e2c:      	mov	w8, #8265
ffffff8008b24e30:      	add	x0, sp, #4
ffffff8008b24e34:      	mov	w1, #2
ffffff8008b24e38:      	mov	w2, #66
ffffff8008b24e3c:      	strh	w8, [sp, #4]
ffffff8008b24e40:      	bl	#-197864 <iWriteRegI2C>
ffffff8008b24e44:      	mov	w8, #15435
ffffff8008b24e48:      	add	x0, sp, #4
ffffff8008b24e4c:      	mov	w1, #2
ffffff8008b24e50:      	mov	w2, #66
ffffff8008b24e54:      	strh	w8, [sp, #4]
ffffff8008b24e58:      	bl	#-197888 <iWriteRegI2C>
ffffff8008b24e5c:      	mov	w8, #8272
ffffff8008b24e60:      	add	x0, sp, #4
ffffff8008b24e64:      	mov	w1, #2
ffffff8008b24e68:      	mov	w2, #66
ffffff8008b24e6c:      	strh	w8, [sp, #4]
ffffff8008b24e70:      	bl	#-197912 <iWriteRegI2C>
ffffff8008b24e74:      	mov	w8, #4162
ffffff8008b24e78:      	add	x0, sp, #4
ffffff8008b24e7c:      	mov	w1, #2
ffffff8008b24e80:      	mov	w2, #66
ffffff8008b24e84:      	strh	w8, [sp, #4]
ffffff8008b24e88:      	bl	#-197936 <iWriteRegI2C>
ffffff8008b24e8c:      	mov	w24, #510
ffffff8008b24e90:      	add	x0, sp, #4
ffffff8008b24e94:      	mov	w1, #2
ffffff8008b24e98:      	mov	w2, #66
ffffff8008b24e9c:      	strh	w24, [sp, #4]
ffffff8008b24ea0:      	bl	#-197960 <iWriteRegI2C>
ffffff8008b24ea4:      	mov	w8, #50442
ffffff8008b24ea8:      	add	x0, sp, #4
ffffff8008b24eac:      	mov	w1, #2
ffffff8008b24eb0:      	mov	w2, #66
ffffff8008b24eb4:      	strh	w8, [sp, #4]
ffffff8008b24eb8:      	bl	#-197984 <iWriteRegI2C>
ffffff8008b24ebc:      	add	x0, sp, #4
ffffff8008b24ec0:      	mov	w1, #2
ffffff8008b24ec4:      	mov	w2, #66
ffffff8008b24ec8:      	strh	w26, [sp, #4]
ffffff8008b24ecc:      	bl	#-198004 <iWriteRegI2C>
ffffff8008b24ed0:      	add	x0, sp, #4
ffffff8008b24ed4:      	mov	w1, #2
ffffff8008b24ed8:      	mov	w2, #66
ffffff8008b24edc:      	strh	w19, [sp, #4]
ffffff8008b24ee0:      	bl	#-198024 <iWriteRegI2C>
ffffff8008b24ee4:      	mov	w8, #65344
ffffff8008b24ee8:      	add	x0, sp, #4
ffffff8008b24eec:      	mov	w1, #2
ffffff8008b24ef0:      	mov	w2, #66
ffffff8008b24ef4:      	strh	w8, [sp, #4]
ffffff8008b24ef8:      	bl	#-198048 <iWriteRegI2C>
ffffff8008b24efc:      	mov	w8, #9537
ffffff8008b24f00:      	add	x0, sp, #4
ffffff8008b24f04:      	mov	w1, #2
ffffff8008b24f08:      	mov	w2, #66
ffffff8008b24f0c:      	strh	w8, [sp, #4]
ffffff8008b24f10:      	bl	#-198072 <iWriteRegI2C>
ffffff8008b24f14:      	mov	w8, #53058
ffffff8008b24f18:      	add	x0, sp, #4
ffffff8008b24f1c:      	mov	w1, #2
ffffff8008b24f20:      	mov	w2, #66
ffffff8008b24f24:      	strh	w8, [sp, #4]
ffffff8008b24f28:      	bl	#-198096 <iWriteRegI2C>
ffffff8008b24f2c:      	mov	w8, #4163
ffffff8008b24f30:      	add	x0, sp, #4
ffffff8008b24f34:      	mov	w1, #2
ffffff8008b24f38:      	mov	w2, #66
ffffff8008b24f3c:      	strh	w8, [sp, #4]
ffffff8008b24f40:      	bl	#-198120 <iWriteRegI2C>
ffffff8008b24f44:      	mov	w8, #33604
ffffff8008b24f48:      	add	x0, sp, #4
ffffff8008b24f4c:      	mov	w1, #2
ffffff8008b24f50:      	mov	w2, #66
ffffff8008b24f54:      	strh	w8, [sp, #4]
ffffff8008b24f58:      	bl	#-198144 <iWriteRegI2C>
ffffff8008b24f5c:      	mov	w8, #8774
ffffff8008b24f60:      	add	x0, sp, #4
ffffff8008b24f64:      	mov	w1, #2
ffffff8008b24f68:      	mov	w2, #66
ffffff8008b24f6c:      	strh	w8, [sp, #4]
ffffff8008b24f70:      	bl	#-198168 <iWriteRegI2C>
ffffff8008b24f74:      	mov	w8, #841
ffffff8008b24f78:      	add	x0, sp, #4
ffffff8008b24f7c:      	mov	w1, #2
ffffff8008b24f80:      	mov	w2, #66
ffffff8008b24f84:      	strh	w8, [sp, #4]
ffffff8008b24f88:      	bl	#-198192 <iWriteRegI2C>
ffffff8008b24f8c:      	mov	w8, #594
ffffff8008b24f90:      	add	x0, sp, #4
ffffff8008b24f94:      	mov	w1, #2
ffffff8008b24f98:      	mov	w2, #66
ffffff8008b24f9c:      	strh	w8, [sp, #4]
ffffff8008b24fa0:      	bl	#-198216 <iWriteRegI2C>
ffffff8008b24fa4:      	mov	w8, #84
ffffff8008b24fa8:      	add	x0, sp, #4
ffffff8008b24fac:      	mov	w1, #2
ffffff8008b24fb0:      	mov	w2, #66
ffffff8008b24fb4:      	strh	w8, [sp, #4]
ffffff8008b24fb8:      	bl	#-198240 <iWriteRegI2C>
ffffff8008b24fbc:      	add	x0, sp, #4
ffffff8008b24fc0:      	mov	w1, #2
ffffff8008b24fc4:      	mov	w2, #66
ffffff8008b24fc8:      	strh	w25, [sp, #4]
ffffff8008b24fcc:      	bl	#-198260 <iWriteRegI2C>
ffffff8008b24fd0:      	mov	w8, #63010
ffffff8008b24fd4:      	add	x0, sp, #4
ffffff8008b24fd8:      	mov	w1, #2
ffffff8008b24fdc:      	mov	w2, #66
ffffff8008b24fe0:      	strh	w8, [sp, #4]
ffffff8008b24fe4:      	bl	#-198284 <iWriteRegI2C>
ffffff8008b24fe8:      	add	x0, sp, #4
ffffff8008b24fec:      	mov	w1, #2
ffffff8008b24ff0:      	mov	w2, #66
ffffff8008b24ff4:      	strh	w24, [sp, #4]
ffffff8008b24ff8:      	bl	#-198304 <iWriteRegI2C>
ffffff8008b24ffc:      	mov	w8, #14529
ffffff8008b25000:      	add	x0, sp, #4
ffffff8008b25004:      	mov	w1, #2
ffffff8008b25008:      	mov	w2, #66
ffffff8008b2500c:      	strh	w8, [sp, #4]
ffffff8008b25010:      	bl	#-198328 <iWriteRegI2C>
ffffff8008b25014:      	mov	w8, #19650
ffffff8008b25018:      	add	x0, sp, #4
ffffff8008b2501c:      	mov	w1, #2
ffffff8008b25020:      	mov	w2, #66
ffffff8008b25024:      	strh	w8, [sp, #4]
ffffff8008b25028:      	bl	#-198352 <iWriteRegI2C>
ffffff8008b2502c:      	mov	w8, #195
ffffff8008b25030:      	add	x0, sp, #4
ffffff8008b25034:      	mov	w1, #2
ffffff8008b25038:      	mov	w2, #66
ffffff8008b2503c:      	strh	w8, [sp, #4]
ffffff8008b25040:      	bl	#-198376 <iWriteRegI2C>
ffffff8008b25044:      	mov	w8, #12996
ffffff8008b25048:      	add	x0, sp, #4
ffffff8008b2504c:      	mov	w1, #2
ffffff8008b25050:      	mov	w2, #66
ffffff8008b25054:      	strh	w8, [sp, #4]
ffffff8008b25058:      	bl	#-198400 <iWriteRegI2C>
ffffff8008b2505c:      	mov	w8, #9413
ffffff8008b25060:      	add	x0, sp, #4
ffffff8008b25064:      	mov	w1, #2
ffffff8008b25068:      	mov	w2, #66
ffffff8008b2506c:      	strh	w8, [sp, #4]
ffffff8008b25070:      	bl	#-198424 <iWriteRegI2C>
ffffff8008b25074:      	mov	w8, #5830
ffffff8008b25078:      	add	x0, sp, #4
ffffff8008b2507c:      	mov	w1, #2
ffffff8008b25080:      	mov	w2, #66
ffffff8008b25084:      	strh	w8, [sp, #4]
ffffff8008b25088:      	bl	#-198448 <iWriteRegI2C>
ffffff8008b2508c:      	mov	w8, #2247
ffffff8008b25090:      	add	x0, sp, #4
ffffff8008b25094:      	mov	w1, #2
ffffff8008b25098:      	mov	w2, #66
ffffff8008b2509c:      	strh	w8, [sp, #4]
ffffff8008b250a0:      	bl	#-198472 <iWriteRegI2C>
ffffff8008b250a4:      	mov	w8, #2248
ffffff8008b250a8:      	add	x0, sp, #4
ffffff8008b250ac:      	mov	w1, #2
ffffff8008b250b0:      	mov	w2, #66
ffffff8008b250b4:      	strh	w8, [sp, #4]
ffffff8008b250b8:      	bl	#-198496 <iWriteRegI2C>
ffffff8008b250bc:      	mov	w8, #201
ffffff8008b250c0:      	add	x0, sp, #4
ffffff8008b250c4:      	mov	w1, #2
ffffff8008b250c8:      	mov	w2, #66
ffffff8008b250cc:      	strh	w8, [sp, #4]
ffffff8008b250d0:      	bl	#-198520 <iWriteRegI2C>
ffffff8008b250d4:      	mov	w8, #8394
ffffff8008b250d8:      	add	x0, sp, #4
ffffff8008b250dc:      	mov	w1, #2
ffffff8008b250e0:      	mov	w2, #66
ffffff8008b250e4:      	strh	w8, [sp, #4]
ffffff8008b250e8:      	bl	#-198544 <iWriteRegI2C>
ffffff8008b250ec:      	mov	w8, #35548
ffffff8008b250f0:      	add	x0, sp, #4
ffffff8008b250f4:      	mov	w1, #2
ffffff8008b250f8:      	mov	w2, #66
ffffff8008b250fc:      	strh	w8, [sp, #4]
ffffff8008b25100:      	bl	#-198568 <iWriteRegI2C>
ffffff8008b25104:      	mov	w8, #41181
ffffff8008b25108:      	add	x0, sp, #4
ffffff8008b2510c:      	mov	w1, #2
ffffff8008b25110:      	mov	w2, #66
ffffff8008b25114:      	strh	w8, [sp, #4]
ffffff8008b25118:      	bl	#-198592 <iWriteRegI2C>
ffffff8008b2511c:      	mov	w8, #42718
ffffff8008b25120:      	add	x0, sp, #4
ffffff8008b25124:      	mov	w1, #2
ffffff8008b25128:      	mov	w2, #66
ffffff8008b2512c:      	strh	w8, [sp, #4]
ffffff8008b25130:      	bl	#-198616 <iWriteRegI2C>
ffffff8008b25134:      	mov	w8, #30175
ffffff8008b25138:      	add	x0, sp, #4
ffffff8008b2513c:      	mov	w1, #2
ffffff8008b25140:      	mov	w2, #66
ffffff8008b25144:      	strh	w8, [sp, #4]
ffffff8008b25148:      	bl	#-198640 <iWriteRegI2C>
ffffff8008b2514c:      	add	x0, sp, #4
ffffff8008b25150:      	mov	w1, #2
ffffff8008b25154:      	mov	w2, #66
ffffff8008b25158:      	strh	w24, [sp, #4]
ffffff8008b2515c:      	bl	#-198660 <iWriteRegI2C>
ffffff8008b25160:      	mov	w8, #2428
ffffff8008b25164:      	add	x0, sp, #4
ffffff8008b25168:      	mov	w1, #2
ffffff8008b2516c:      	mov	w2, #66
ffffff8008b25170:      	strh	w8, [sp, #4]
ffffff8008b25174:      	bl	#-198684 <iWriteRegI2C>
ffffff8008b25178:      	mov	w8, #1637
ffffff8008b2517c:      	add	x0, sp, #4
ffffff8008b25180:      	mov	w1, #2
ffffff8008b25184:      	mov	w2, #66
ffffff8008b25188:      	strh	w8, [sp, #4]
ffffff8008b2518c:      	bl	#-198708 <iWriteRegI2C>
ffffff8008b25190:      	mov	w8, #2172
ffffff8008b25194:      	add	x0, sp, #4
ffffff8008b25198:      	mov	w1, #2
ffffff8008b2519c:      	mov	w2, #66
ffffff8008b251a0:      	strh	w8, [sp, #4]
ffffff8008b251a4:      	bl	#-198732 <iWriteRegI2C>
ffffff8008b251a8:      	mov	w8, #62550
ffffff8008b251ac:      	add	x0, sp, #4
ffffff8008b251b0:      	mov	w1, #2
ffffff8008b251b4:      	mov	w2, #66
ffffff8008b251b8:      	strh	w8, [sp, #4]
ffffff8008b251bc:      	bl	#-198756 <iWriteRegI2C>
ffffff8008b251c0:      	mov	w8, #3942
ffffff8008b251c4:      	add	x0, sp, #4
ffffff8008b251c8:      	mov	w1, #2
ffffff8008b251cc:      	mov	w2, #66
ffffff8008b251d0:      	strh	w8, [sp, #4]
ffffff8008b251d4:      	bl	#-198780 <iWriteRegI2C>
ffffff8008b251d8:      	mov	w8, #33895
ffffff8008b251dc:      	add	x0, sp, #4
ffffff8008b251e0:      	mov	w1, #2
ffffff8008b251e4:      	mov	w2, #66
ffffff8008b251e8:      	strh	w8, [sp, #4]
ffffff8008b251ec:      	bl	#-198804 <iWriteRegI2C>
ffffff8008b251f0:      	mov	w8, #32875
ffffff8008b251f4:      	add	x0, sp, #4
ffffff8008b251f8:      	mov	w1, #2
ffffff8008b251fc:      	mov	w2, #66
ffffff8008b25200:      	strh	w8, [sp, #4]
ffffff8008b25204:      	bl	#-198828 <iWriteRegI2C>
ffffff8008b25208:      	mov	w8, #4717
ffffff8008b2520c:      	add	x0, sp, #4
ffffff8008b25210:      	mov	w1, #2
ffffff8008b25214:      	mov	w2, #66
ffffff8008b25218:      	strh	w8, [sp, #4]
ffffff8008b2521c:      	bl	#-198852 <iWriteRegI2C>
ffffff8008b25220:      	mov	w8, #45166
ffffff8008b25224:      	add	x0, sp, #4
ffffff8008b25228:      	mov	w1, #2
ffffff8008b2522c:      	mov	w2, #66
ffffff8008b25230:      	strh	w8, [sp, #4]
ffffff8008b25234:      	bl	#-198876 <iWriteRegI2C>
ffffff8008b25238:      	mov	w8, #134
ffffff8008b2523c:      	add	x0, sp, #4
ffffff8008b25240:      	mov	w1, #2
ffffff8008b25244:      	mov	w2, #66
ffffff8008b25248:      	strh	w8, [sp, #4]
ffffff8008b2524c:      	bl	#-198900 <iWriteRegI2C>
ffffff8008b25250:      	mov	w8, #135
ffffff8008b25254:      	add	x0, sp, #4
ffffff8008b25258:      	mov	w1, #2
ffffff8008b2525c:      	mov	w2, #66
ffffff8008b25260:      	strh	w8, [sp, #4]
ffffff8008b25264:      	bl	#-198924 <iWriteRegI2C>
ffffff8008b25268:      	mov	w8, #136
ffffff8008b2526c:      	add	x0, sp, #4
ffffff8008b25270:      	mov	w1, #2
ffffff8008b25274:      	mov	w2, #66
ffffff8008b25278:      	strh	w8, [sp, #4]
ffffff8008b2527c:      	bl	#-198948 <iWriteRegI2C>
ffffff8008b25280:      	mov	w8, #137
ffffff8008b25284:      	add	x0, sp, #4
ffffff8008b25288:      	mov	w1, #2
ffffff8008b2528c:      	mov	w2, #66
ffffff8008b25290:      	strh	w8, [sp, #4]
ffffff8008b25294:      	bl	#-198972 <iWriteRegI2C>
ffffff8008b25298:      	mov	w8, #138
ffffff8008b2529c:      	add	x0, sp, #4
ffffff8008b252a0:      	mov	w1, #2
ffffff8008b252a4:      	mov	w2, #66
ffffff8008b252a8:      	strh	w8, [sp, #4]
ffffff8008b252ac:      	bl	#-198996 <iWriteRegI2C>
ffffff8008b252b0:      	mov	w8, #139
ffffff8008b252b4:      	add	x0, sp, #4
ffffff8008b252b8:      	mov	w1, #2
ffffff8008b252bc:      	mov	w2, #66
ffffff8008b252c0:      	strh	w8, [sp, #4]
ffffff8008b252c4:      	bl	#-199020 <iWriteRegI2C>
ffffff8008b252c8:      	mov	w8, #140
ffffff8008b252cc:      	add	x0, sp, #4
ffffff8008b252d0:      	mov	w1, #2
ffffff8008b252d4:      	mov	w2, #66
ffffff8008b252d8:      	strh	w8, [sp, #4]
ffffff8008b252dc:      	bl	#-199044 <iWriteRegI2C>
ffffff8008b252e0:      	mov	w8, #141
ffffff8008b252e4:      	add	x0, sp, #4
ffffff8008b252e8:      	mov	w1, #2
ffffff8008b252ec:      	mov	w2, #66
ffffff8008b252f0:      	strh	w8, [sp, #4]
ffffff8008b252f4:      	bl	#-199068 <iWriteRegI2C>
ffffff8008b252f8:      	mov	w8, #142
ffffff8008b252fc:      	add	x0, sp, #4
ffffff8008b25300:      	mov	w1, #2
ffffff8008b25304:      	mov	w2, #66
ffffff8008b25308:      	strh	w8, [sp, #4]
ffffff8008b2530c:      	bl	#-199092 <iWriteRegI2C>
ffffff8008b25310:      	mov	w8, #143
ffffff8008b25314:      	add	x0, sp, #4
ffffff8008b25318:      	mov	w1, #2
ffffff8008b2531c:      	mov	w2, #66
ffffff8008b25320:      	strh	w8, [sp, #4]
ffffff8008b25324:      	bl	#-199116 <iWriteRegI2C>
ffffff8008b25328:      	mov	w8, #144
ffffff8008b2532c:      	add	x0, sp, #4
ffffff8008b25330:      	mov	w1, #2
ffffff8008b25334:      	mov	w2, #66
ffffff8008b25338:      	strh	w8, [sp, #4]
ffffff8008b2533c:      	bl	#-199140 <iWriteRegI2C>
ffffff8008b25340:      	mov	w8, #145
ffffff8008b25344:      	add	x0, sp, #4
ffffff8008b25348:      	mov	w1, #2
ffffff8008b2534c:      	mov	w2, #66
ffffff8008b25350:      	strh	w8, [sp, #4]
ffffff8008b25354:      	bl	#-199164 <iWriteRegI2C>
ffffff8008b25358:      	mov	w8, #62610
ffffff8008b2535c:      	add	x0, sp, #4
ffffff8008b25360:      	mov	w1, #2
ffffff8008b25364:      	mov	w2, #66
ffffff8008b25368:      	strh	w8, [sp, #4]
ffffff8008b2536c:      	bl	#-199188 <iWriteRegI2C>
ffffff8008b25370:      	mov	w8, #54675
ffffff8008b25374:      	add	x0, sp, #4
ffffff8008b25378:      	mov	w1, #2
ffffff8008b2537c:      	mov	w2, #66
ffffff8008b25380:      	strh	w8, [sp, #4]
ffffff8008b25384:      	bl	#-199212 <iWriteRegI2C>
ffffff8008b25388:      	mov	w8, #20628
ffffff8008b2538c:      	add	x0, sp, #4
ffffff8008b25390:      	mov	w1, #2
ffffff8008b25394:      	mov	w2, #66
ffffff8008b25398:      	strh	w8, [sp, #4]
ffffff8008b2539c:      	bl	#-199236 <iWriteRegI2C>
ffffff8008b253a0:      	mov	w8, #3989
ffffff8008b253a4:      	add	x0, sp, #4
ffffff8008b253a8:      	mov	w1, #2
ffffff8008b253ac:      	mov	w2, #66
ffffff8008b253b0:      	strh	w8, [sp, #4]
ffffff8008b253b4:      	bl	#-199260 <iWriteRegI2C>
ffffff8008b253b8:      	mov	w8, #62614
ffffff8008b253bc:      	add	x0, sp, #4
ffffff8008b253c0:      	mov	w1, #2
ffffff8008b253c4:      	mov	w2, #66
ffffff8008b253c8:      	strh	w8, [sp, #4]
ffffff8008b253cc:      	bl	#-199284 <iWriteRegI2C>
ffffff8008b253d0:      	mov	w8, #11671
ffffff8008b253d4:      	add	x0, sp, #4
ffffff8008b253d8:      	mov	w1, #2
ffffff8008b253dc:      	mov	w2, #66
ffffff8008b253e0:      	strh	w8, [sp, #4]
ffffff8008b253e4:      	bl	#-199308 <iWriteRegI2C>
ffffff8008b253e8:      	mov	w8, #3992
ffffff8008b253ec:      	add	x0, sp, #4
ffffff8008b253f0:      	mov	w1, #2
ffffff8008b253f4:      	mov	w2, #66
ffffff8008b253f8:      	strh	w8, [sp, #4]
ffffff8008b253fc:      	bl	#-199332 <iWriteRegI2C>
ffffff8008b25400:      	mov	w8, #42649
ffffff8008b25404:      	add	x0, sp, #4
ffffff8008b25408:      	mov	w1, #2
ffffff8008b2540c:      	mov	w2, #66
ffffff8008b25410:      	strh	w8, [sp, #4]
ffffff8008b25414:      	bl	#-199356 <iWriteRegI2C>
ffffff8008b25418:      	mov	w8, #11674
ffffff8008b2541c:      	add	x0, sp, #4
ffffff8008b25420:      	mov	w1, #2
ffffff8008b25424:      	mov	w2, #66
ffffff8008b25428:      	strh	w8, [sp, #4]
ffffff8008b2542c:      	bl	#-199380 <iWriteRegI2C>
ffffff8008b25430:      	mov	w8, #3995
ffffff8008b25434:      	add	x0, sp, #4
ffffff8008b25438:      	mov	w1, #2
ffffff8008b2543c:      	mov	w2, #66
ffffff8008b25440:      	strh	w8, [sp, #4]
ffffff8008b25444:      	bl	#-199404 <iWriteRegI2C>
ffffff8008b25448:      	mov	w8, #22940
ffffff8008b2544c:      	add	x0, sp, #4
ffffff8008b25450:      	mov	w1, #2
ffffff8008b25454:      	mov	w2, #66
ffffff8008b25458:      	strh	w8, [sp, #4]
ffffff8008b2545c:      	bl	#-199428 <iWriteRegI2C>
ffffff8008b25460:      	mov	w8, #11677
ffffff8008b25464:      	add	x0, sp, #4
ffffff8008b25468:      	mov	w1, #2
ffffff8008b2546c:      	mov	w2, #66
ffffff8008b25470:      	strh	w8, [sp, #4]
ffffff8008b25474:      	bl	#-199452 <iWriteRegI2C>
ffffff8008b25478:      	mov	w8, #43678
ffffff8008b2547c:      	add	x0, sp, #4
ffffff8008b25480:      	mov	w1, #2
ffffff8008b25484:      	mov	w2, #66
ffffff8008b25488:      	strh	w8, [sp, #4]
ffffff8008b2548c:      	bl	#-199476 <iWriteRegI2C>
ffffff8008b25490:      	mov	w8, #26527
ffffff8008b25494:      	add	x0, sp, #4
ffffff8008b25498:      	mov	w1, #2
ffffff8008b2549c:      	mov	w2, #66
ffffff8008b254a0:      	strh	w8, [sp, #4]
ffffff8008b254a4:      	bl	#-199500 <iWriteRegI2C>
ffffff8008b254a8:      	mov	w8, #22944
ffffff8008b254ac:      	add	x0, sp, #4
ffffff8008b254b0:      	mov	w1, #2
ffffff8008b254b4:      	mov	w2, #66
ffffff8008b254b8:      	strh	w8, [sp, #4]
ffffff8008b254bc:      	bl	#-199524 <iWriteRegI2C>
ffffff8008b254c0:      	mov	w8, #161
ffffff8008b254c4:      	add	x0, sp, #4
ffffff8008b254c8:      	mov	w1, #2
ffffff8008b254cc:      	mov	w2, #66
ffffff8008b254d0:      	strh	w8, [sp, #4]
ffffff8008b254d4:      	bl	#-199548 <iWriteRegI2C>
ffffff8008b254d8:      	mov	w8, #162
ffffff8008b254dc:      	add	x0, sp, #4
ffffff8008b254e0:      	mov	w1, #2
ffffff8008b254e4:      	mov	w2, #66
ffffff8008b254e8:      	strh	w8, [sp, #4]
ffffff8008b254ec:      	bl	#-199572 <iWriteRegI2C>
ffffff8008b254f0:      	mov	w8, #2723
ffffff8008b254f4:      	add	x0, sp, #4
ffffff8008b254f8:      	mov	w1, #2
ffffff8008b254fc:      	mov	w2, #66
ffffff8008b25500:      	strh	w8, [sp, #4]
ffffff8008b25504:      	bl	#-199596 <iWriteRegI2C>
ffffff8008b25508:      	mov	w8, #164
ffffff8008b2550c:      	add	x0, sp, #4
ffffff8008b25510:      	mov	w1, #2
ffffff8008b25514:      	mov	w2, #66
ffffff8008b25518:      	strh	w8, [sp, #4]
ffffff8008b2551c:      	bl	#-199620 <iWriteRegI2C>
ffffff8008b25520:      	mov	w8, #165
ffffff8008b25524:      	add	x0, sp, #4
ffffff8008b25528:      	mov	w1, #2
ffffff8008b2552c:      	mov	w2, #66
ffffff8008b25530:      	strh	w8, [sp, #4]
ffffff8008b25534:      	bl	#-199644 <iWriteRegI2C>
ffffff8008b25538:      	mov	w8, #54438
ffffff8008b2553c:      	add	x0, sp, #4
ffffff8008b25540:      	mov	w1, #2
ffffff8008b25544:      	mov	w2, #66
ffffff8008b25548:      	strh	w8, [sp, #4]
ffffff8008b2554c:      	bl	#-199668 <iWriteRegI2C>
ffffff8008b25550:      	mov	w8, #40871
ffffff8008b25554:      	add	x0, sp, #4
ffffff8008b25558:      	mov	w1, #2
ffffff8008b2555c:      	mov	w2, #66
ffffff8008b25560:      	strh	w8, [sp, #4]
ffffff8008b25564:      	bl	#-199692 <iWriteRegI2C>
ffffff8008b25568:      	mov	w8, #21928
ffffff8008b2556c:      	add	x0, sp, #4
ffffff8008b25570:      	mov	w1, #2
ffffff8008b25574:      	mov	w2, #66
ffffff8008b25578:      	strh	w8, [sp, #4]
ffffff8008b2557c:      	bl	#-199716 <iWriteRegI2C>
ffffff8008b25580:      	mov	w8, #54441
ffffff8008b25584:      	add	x0, sp, #4
ffffff8008b25588:      	mov	w1, #2
ffffff8008b2558c:      	mov	w2, #66
ffffff8008b25590:      	strh	w8, [sp, #4]
ffffff8008b25594:      	bl	#-199740 <iWriteRegI2C>
ffffff8008b25598:      	mov	w8, #40874
ffffff8008b2559c:      	add	x0, sp, #4
ffffff8008b255a0:      	mov	w1, #2
ffffff8008b255a4:      	mov	w2, #66
ffffff8008b255a8:      	strh	w8, [sp, #4]
ffffff8008b255ac:      	bl	#-199764 <iWriteRegI2C>
ffffff8008b255b0:      	mov	w8, #44203
ffffff8008b255b4:      	add	x0, sp, #4
ffffff8008b255b8:      	mov	w1, #2
ffffff8008b255bc:      	mov	w2, #66
ffffff8008b255c0:      	strh	w8, [sp, #4]
ffffff8008b255c4:      	bl	#-199788 <iWriteRegI2C>
ffffff8008b255c8:      	mov	w8, #40876
ffffff8008b255cc:      	add	x0, sp, #4
ffffff8008b255d0:      	mov	w1, #2
ffffff8008b255d4:      	mov	w2, #66
ffffff8008b255d8:      	strh	w8, [sp, #4]
ffffff8008b255dc:      	bl	#-199812 <iWriteRegI2C>
ffffff8008b255e0:      	mov	w8, #21933
ffffff8008b255e4:      	add	x0, sp, #4
ffffff8008b255e8:      	mov	w1, #2
ffffff8008b255ec:      	mov	w2, #66
ffffff8008b255f0:      	strh	w8, [sp, #4]
ffffff8008b255f4:      	bl	#-199836 <iWriteRegI2C>
ffffff8008b255f8:      	mov	w8, #54446
ffffff8008b255fc:      	add	x0, sp, #4
ffffff8008b25600:      	mov	w1, #2
ffffff8008b25604:      	mov	w2, #66
ffffff8008b25608:      	strh	w8, [sp, #4]
ffffff8008b2560c:      	bl	#-199860 <iWriteRegI2C>
ffffff8008b25610:      	mov	w8, #44207
ffffff8008b25614:      	add	x0, sp, #4
ffffff8008b25618:      	mov	w1, #2
ffffff8008b2561c:      	mov	w2, #66
ffffff8008b25620:      	strh	w8, [sp, #4]
ffffff8008b25624:      	bl	#-199884 <iWriteRegI2C>
ffffff8008b25628:      	mov	w8, #54448
ffffff8008b2562c:      	add	x0, sp, #4
ffffff8008b25630:      	mov	w1, #2
ffffff8008b25634:      	mov	w2, #66
ffffff8008b25638:      	strh	w8, [sp, #4]
ffffff8008b2563c:      	bl	#-199908 <iWriteRegI2C>
ffffff8008b25640:      	mov	w8, #41905
ffffff8008b25644:      	add	x0, sp, #4
ffffff8008b25648:      	mov	w1, #2
ffffff8008b2564c:      	mov	w2, #66
ffffff8008b25650:      	strh	w8, [sp, #4]
ffffff8008b25654:      	bl	#-199932 <iWriteRegI2C>
ffffff8008b25658:      	mov	w8, #21938
ffffff8008b2565c:      	add	x0, sp, #4
ffffff8008b25660:      	mov	w1, #2
ffffff8008b25664:      	mov	w2, #66
ffffff8008b25668:      	strh	w8, [sp, #4]
ffffff8008b2566c:      	bl	#-199956 <iWriteRegI2C>
ffffff8008b25670:      	mov	w8, #54451
ffffff8008b25674:      	add	x0, sp, #4
ffffff8008b25678:      	mov	w1, #2
ffffff8008b2567c:      	mov	w2, #66
ffffff8008b25680:      	strh	w8, [sp, #4]
ffffff8008b25684:      	bl	#-199980 <iWriteRegI2C>
ffffff8008b25688:      	mov	w8, #44212
ffffff8008b2568c:      	add	x0, sp, #4
ffffff8008b25690:      	mov	w1, #2
ffffff8008b25694:      	mov	w2, #66
ffffff8008b25698:      	strh	w8, [sp, #4]
ffffff8008b2569c:      	bl	#-200004 <iWriteRegI2C>
ffffff8008b256a0:      	mov	w8, #181
ffffff8008b256a4:      	add	x0, sp, #4
ffffff8008b256a8:      	mov	w1, #2
ffffff8008b256ac:      	mov	w2, #66
ffffff8008b256b0:      	strh	w8, [sp, #4]
ffffff8008b256b4:      	bl	#-200028 <iWriteRegI2C>
ffffff8008b256b8:      	mov	w8, #182
ffffff8008b256bc:      	add	x0, sp, #4
ffffff8008b256c0:      	mov	w1, #2
ffffff8008b256c4:      	mov	w2, #66
ffffff8008b256c8:      	strh	w8, [sp, #4]
ffffff8008b256cc:      	bl	#-200052 <iWriteRegI2C>
ffffff8008b256d0:      	mov	w8, #1463
ffffff8008b256d4:      	add	x0, sp, #4
ffffff8008b256d8:      	mov	w1, #2
ffffff8008b256dc:      	mov	w2, #66
ffffff8008b256e0:      	strh	w8, [sp, #4]
ffffff8008b256e4:      	bl	#-200076 <iWriteRegI2C>
ffffff8008b256e8:      	mov	w8, #54968
ffffff8008b256ec:      	add	x0, sp, #4
ffffff8008b256f0:      	mov	w1, #2
ffffff8008b256f4:      	mov	w2, #66
ffffff8008b256f8:      	strh	w8, [sp, #4]
ffffff8008b256fc:      	bl	#-200100 <iWriteRegI2C>
ffffff8008b25700:      	mov	w8, #36025
ffffff8008b25704:      	add	x0, sp, #4
ffffff8008b25708:      	mov	w1, #2
ffffff8008b2570c:      	mov	w2, #66
ffffff8008b25710:      	strh	w8, [sp, #4]
ffffff8008b25714:      	bl	#-200124 <iWriteRegI2C>
ffffff8008b25718:      	add	x0, sp, #4
ffffff8008b2571c:      	mov	w1, #2
ffffff8008b25720:      	mov	w2, #66
ffffff8008b25724:      	strh	w24, [sp, #4]
ffffff8008b25728:      	bl	#-200144 <iWriteRegI2C>
ffffff8008b2572c:      	mov	w8, #16592
ffffff8008b25730:      	add	x0, sp, #4
ffffff8008b25734:      	mov	w1, #2
ffffff8008b25738:      	mov	w2, #66
ffffff8008b2573c:      	strh	w8, [sp, #4]
ffffff8008b25740:      	bl	#-200168 <iWriteRegI2C>
ffffff8008b25744:      	mov	w8, #63697
ffffff8008b25748:      	add	x0, sp, #4
ffffff8008b2574c:      	mov	w1, #2
ffffff8008b25750:      	mov	w2, #66
ffffff8008b25754:      	strh	w8, [sp, #4]
ffffff8008b25758:      	bl	#-200192 <iWriteRegI2C>
ffffff8008b2575c:      	mov	w8, #210
ffffff8008b25760:      	add	x0, sp, #4
ffffff8008b25764:      	mov	w1, #2
ffffff8008b25768:      	mov	w2, #66
ffffff8008b2576c:      	strh	w8, [sp, #4]
ffffff8008b25770:      	bl	#-200216 <iWriteRegI2C>
ffffff8008b25774:      	mov	w8, #64211
ffffff8008b25778:      	add	x0, sp, #4
ffffff8008b2577c:      	mov	w1, #2
ffffff8008b25780:      	mov	w2, #66
ffffff8008b25784:      	strh	w8, [sp, #4]
ffffff8008b25788:      	bl	#-200240 <iWriteRegI2C>
ffffff8008b2578c:      	mov	w8, #17876
ffffff8008b25790:      	add	x0, sp, #4
ffffff8008b25794:      	mov	w1, #2
ffffff8008b25798:      	mov	w2, #66
ffffff8008b2579c:      	strh	w8, [sp, #4]
ffffff8008b257a0:      	bl	#-200264 <iWriteRegI2C>
ffffff8008b257a4:      	mov	w8, #725
ffffff8008b257a8:      	add	x0, sp, #4
ffffff8008b257ac:      	mov	w1, #2
ffffff8008b257b0:      	mov	w2, #66
ffffff8008b257b4:      	strh	w8, [sp, #4]
ffffff8008b257b8:      	bl	#-200288 <iWriteRegI2C>
ffffff8008b257bc:      	mov	w8, #12502
ffffff8008b257c0:      	add	x0, sp, #4
ffffff8008b257c4:      	mov	w1, #2
ffffff8008b257c8:      	mov	w2, #66
ffffff8008b257cc:      	strh	w8, [sp, #4]
ffffff8008b257d0:      	bl	#-200312 <iWriteRegI2C>
ffffff8008b257d4:      	mov	w8, #64215
ffffff8008b257d8:      	add	x0, sp, #4
ffffff8008b257dc:      	mov	w1, #2
ffffff8008b257e0:      	mov	w2, #66
ffffff8008b257e4:      	strh	w8, [sp, #4]
ffffff8008b257e8:      	bl	#-200336 <iWriteRegI2C>
ffffff8008b257ec:      	mov	w8, #2264
ffffff8008b257f0:      	add	x0, sp, #4
ffffff8008b257f4:      	mov	w1, #2
ffffff8008b257f8:      	mov	w2, #66
ffffff8008b257fc:      	strh	w8, [sp, #4]
ffffff8008b25800:      	bl	#-200360 <iWriteRegI2C>
ffffff8008b25804:      	mov	w8, #2265
ffffff8008b25808:      	add	x0, sp, #4
ffffff8008b2580c:      	mov	w1, #2
ffffff8008b25810:      	mov	w2, #66
ffffff8008b25814:      	strh	w8, [sp, #4]
ffffff8008b25818:      	bl	#-200384 <iWriteRegI2C>
ffffff8008b2581c:      	mov	w8, #22746
ffffff8008b25820:      	add	x0, sp, #4
ffffff8008b25824:      	mov	w1, #2
ffffff8008b25828:      	mov	w2, #66
ffffff8008b2582c:      	strh	w8, [sp, #4]
ffffff8008b25830:      	bl	#-200408 <iWriteRegI2C>
ffffff8008b25834:      	mov	w8, #731
ffffff8008b25838:      	add	x0, sp, #4
ffffff8008b2583c:      	mov	w1, #2
ffffff8008b25840:      	mov	w2, #66
ffffff8008b25844:      	strh	w8, [sp, #4]
ffffff8008b25848:      	bl	#-200432 <iWriteRegI2C>
ffffff8008b2584c:      	add	x0, sp, #4
ffffff8008b25850:      	mov	w1, #2
ffffff8008b25854:      	mov	w2, #66
ffffff8008b25858:      	strh	w19, [sp, #4]
ffffff8008b2585c:      	bl	#-200452 <iWriteRegI2C>
ffffff8008b25860:      	add	x0, sp, #4
ffffff8008b25864:      	mov	w1, #2
ffffff8008b25868:      	mov	w2, #66
ffffff8008b2586c:      	strh	w19, [sp, #4]
ffffff8008b25870:      	bl	#-200472 <iWriteRegI2C>
ffffff8008b25874:      	mov	w8, #186
ffffff8008b25878:      	add	x0, sp, #4
ffffff8008b2587c:      	mov	w1, #2
ffffff8008b25880:      	mov	w2, #66
ffffff8008b25884:      	strh	w8, [sp, #4]
ffffff8008b25888:      	bl	#-200496 <iWriteRegI2C>
ffffff8008b2588c:      	mov	w8, #1211
ffffff8008b25890:      	add	x0, sp, #4
ffffff8008b25894:      	mov	w1, #2
ffffff8008b25898:      	mov	w2, #66
ffffff8008b2589c:      	strh	w8, [sp, #4]
ffffff8008b258a0:      	bl	#-200520 <iWriteRegI2C>
ffffff8008b258a4:      	mov	w8, #2748
ffffff8008b258a8:      	add	x0, sp, #4
ffffff8008b258ac:      	mov	w1, #2
ffffff8008b258b0:      	mov	w2, #66
ffffff8008b258b4:      	strh	w8, [sp, #4]
ffffff8008b258b8:      	bl	#-200544 <iWriteRegI2C>
ffffff8008b258bc:      	mov	w8, #3773
ffffff8008b258c0:      	add	x0, sp, #4
ffffff8008b258c4:      	mov	w1, #2
ffffff8008b258c8:      	mov	w2, #66
ffffff8008b258cc:      	strh	w8, [sp, #4]
ffffff8008b258d0:      	bl	#-200568 <iWriteRegI2C>
ffffff8008b258d4:      	mov	w8, #8894
ffffff8008b258d8:      	add	x0, sp, #4
ffffff8008b258dc:      	mov	w1, #2
ffffff8008b258e0:      	mov	w2, #66
ffffff8008b258e4:      	strh	w8, [sp, #4]
ffffff8008b258e8:      	bl	#-200592 <iWriteRegI2C>
ffffff8008b258ec:      	mov	w8, #12479
ffffff8008b258f0:      	add	x0, sp, #4
ffffff8008b258f4:      	mov	w1, #2
ffffff8008b258f8:      	mov	w2, #66
ffffff8008b258fc:      	strh	w8, [sp, #4]
ffffff8008b25900:      	bl	#-200616 <iWriteRegI2C>
ffffff8008b25904:      	mov	w8, #15808
ffffff8008b25908:      	add	x0, sp, #4
ffffff8008b2590c:      	mov	w1, #2
ffffff8008b25910:      	mov	w2, #66
ffffff8008b25914:      	strh	w8, [sp, #4]
ffffff8008b25918:      	bl	#-200640 <iWriteRegI2C>
ffffff8008b2591c:      	mov	w8, #19137
ffffff8008b25920:      	add	x0, sp, #4
ffffff8008b25924:      	mov	w1, #2
ffffff8008b25928:      	mov	w2, #66
ffffff8008b2592c:      	strh	w8, [sp, #4]
ffffff8008b25930:      	bl	#-200664 <iWriteRegI2C>
ffffff8008b25934:      	mov	w8, #24002
ffffff8008b25938:      	add	x0, sp, #4
ffffff8008b2593c:      	mov	w1, #2
ffffff8008b25940:      	mov	w2, #66
ffffff8008b25944:      	strh	w8, [sp, #4]
ffffff8008b25948:      	bl	#-200688 <iWriteRegI2C>
ffffff8008b2594c:      	mov	w8, #27587
ffffff8008b25950:      	add	x0, sp, #4
ffffff8008b25954:      	mov	w1, #2
ffffff8008b25958:      	mov	w2, #66
ffffff8008b2595c:      	strh	w8, [sp, #4]
ffffff8008b25960:      	bl	#-200712 <iWriteRegI2C>
ffffff8008b25964:      	mov	w8, #31428
ffffff8008b25968:      	add	x0, sp, #4
ffffff8008b2596c:      	mov	w1, #2
ffffff8008b25970:      	mov	w2, #66
ffffff8008b25974:      	strh	w8, [sp, #4]
ffffff8008b25978:      	bl	#-200736 <iWriteRegI2C>
ffffff8008b2597c:      	mov	w8, #34245
ffffff8008b25980:      	add	x0, sp, #4
ffffff8008b25984:      	mov	w1, #2
ffffff8008b25988:      	mov	w2, #66
ffffff8008b2598c:      	strh	w8, [sp, #4]
ffffff8008b25990:      	bl	#-200760 <iWriteRegI2C>
ffffff8008b25994:      	mov	w8, #37062
ffffff8008b25998:      	add	x0, sp, #4
ffffff8008b2599c:      	mov	w1, #2
ffffff8008b259a0:      	mov	w2, #66
ffffff8008b259a4:      	strh	w8, [sp, #4]
ffffff8008b259a8:      	bl	#-200784 <iWriteRegI2C>
ffffff8008b259ac:      	mov	w8, #42439
ffffff8008b259b0:      	add	x0, sp, #4
ffffff8008b259b4:      	mov	w1, #2
ffffff8008b259b8:      	mov	w2, #66
ffffff8008b259bc:      	strh	w8, [sp, #4]
ffffff8008b259c0:      	bl	#-200808 <iWriteRegI2C>
ffffff8008b259c4:      	mov	w8, #46536
ffffff8008b259c8:      	add	x0, sp, #4
ffffff8008b259cc:      	mov	w1, #2
ffffff8008b259d0:      	mov	w2, #66
ffffff8008b259d4:      	strh	w8, [sp, #4]
ffffff8008b259d8:      	bl	#-200832 <iWriteRegI2C>
ffffff8008b259dc:      	mov	w8, #49865
ffffff8008b259e0:      	add	x0, sp, #4
ffffff8008b259e4:      	mov	w1, #2
ffffff8008b259e8:      	mov	w2, #66
ffffff8008b259ec:      	strh	w8, [sp, #4]
ffffff8008b259f0:      	bl	#-200856 <iWriteRegI2C>
ffffff8008b259f4:      	mov	w8, #52426
ffffff8008b259f8:      	add	x0, sp, #4
ffffff8008b259fc:      	mov	w1, #2
ffffff8008b25a00:      	mov	w2, #66
ffffff8008b25a04:      	strh	w8, [sp, #4]
ffffff8008b25a08:      	bl	#-200880 <iWriteRegI2C>
ffffff8008b25a0c:      	mov	w8, #54731
ffffff8008b25a10:      	add	x0, sp, #4
ffffff8008b25a14:      	mov	w1, #2
ffffff8008b25a18:      	mov	w2, #66
ffffff8008b25a1c:      	strh	w8, [sp, #4]
ffffff8008b25a20:      	bl	#-200904 <iWriteRegI2C>
ffffff8008b25a24:      	mov	w8, #57036
ffffff8008b25a28:      	add	x0, sp, #4
ffffff8008b25a2c:      	mov	w1, #2
ffffff8008b25a30:      	mov	w2, #66
ffffff8008b25a34:      	strh	w8, [sp, #4]
ffffff8008b25a38:      	bl	#-200928 <iWriteRegI2C>
ffffff8008b25a3c:      	mov	w8, #60109
ffffff8008b25a40:      	add	x0, sp, #4
ffffff8008b25a44:      	mov	w1, #2
ffffff8008b25a48:      	mov	w2, #66
ffffff8008b25a4c:      	strh	w8, [sp, #4]
ffffff8008b25a50:      	bl	#-200952 <iWriteRegI2C>
ffffff8008b25a54:      	mov	w8, #62926
ffffff8008b25a58:      	add	x0, sp, #4
ffffff8008b25a5c:      	mov	w1, #2
ffffff8008b25a60:      	mov	w2, #66
ffffff8008b25a64:      	strh	w8, [sp, #4]
ffffff8008b25a68:      	bl	#-200976 <iWriteRegI2C>
ffffff8008b25a6c:      	mov	w8, #65487
ffffff8008b25a70:      	add	x0, sp, #4
ffffff8008b25a74:      	mov	w1, #2
ffffff8008b25a78:      	mov	w2, #66
ffffff8008b25a7c:      	strh	w8, [sp, #4]
ffffff8008b25a80:      	bl	#-201000 <iWriteRegI2C>
ffffff8008b25a84:      	add	x0, sp, #4
ffffff8008b25a88:      	mov	w1, #2
ffffff8008b25a8c:      	mov	w2, #66
ffffff8008b25a90:      	strh	w19, [sp, #4]
ffffff8008b25a94:      	bl	#-201020 <iWriteRegI2C>
ffffff8008b25a98:      	mov	w8, #2138
ffffff8008b25a9c:      	add	x0, sp, #4
ffffff8008b25aa0:      	mov	w1, #2
ffffff8008b25aa4:      	mov	w2, #66
ffffff8008b25aa8:      	strh	w8, [sp, #4]
ffffff8008b25aac:      	bl	#-201044 <iWriteRegI2C>
ffffff8008b25ab0:      	mov	w8, #3931
ffffff8008b25ab4:      	add	x0, sp, #4
ffffff8008b25ab8:      	mov	w1, #2
ffffff8008b25abc:      	mov	w2, #66
ffffff8008b25ac0:      	strh	w8, [sp, #4]
ffffff8008b25ac4:      	bl	#-201068 <iWriteRegI2C>
ffffff8008b25ac8:      	mov	w8, #5468
ffffff8008b25acc:      	add	x0, sp, #4
ffffff8008b25ad0:      	mov	w1, #2
ffffff8008b25ad4:      	mov	w2, #66
ffffff8008b25ad8:      	strh	w8, [sp, #4]
ffffff8008b25adc:      	bl	#-201092 <iWriteRegI2C>
ffffff8008b25ae0:      	mov	w8, #7261
ffffff8008b25ae4:      	add	x0, sp, #4
ffffff8008b25ae8:      	mov	w1, #2
ffffff8008b25aec:      	mov	w2, #66
ffffff8008b25af0:      	strh	w8, [sp, #4]
ffffff8008b25af4:      	bl	#-201116 <iWriteRegI2C>
ffffff8008b25af8:      	mov	w8, #10334
ffffff8008b25afc:      	add	x0, sp, #4
ffffff8008b25b00:      	mov	w1, #2
ffffff8008b25b04:      	mov	w2, #66
ffffff8008b25b08:      	strh	w8, [sp, #4]
ffffff8008b25b0c:      	bl	#-201140 <iWriteRegI2C>
ffffff8008b25b10:      	mov	w8, #13919
ffffff8008b25b14:      	add	x0, sp, #4
ffffff8008b25b18:      	mov	w1, #2
ffffff8008b25b1c:      	mov	w2, #66
ffffff8008b25b20:      	strh	w8, [sp, #4]
ffffff8008b25b24:      	bl	#-201164 <iWriteRegI2C>
ffffff8008b25b28:      	mov	w8, #17760
ffffff8008b25b2c:      	add	x0, sp, #4
ffffff8008b25b30:      	mov	w1, #2
ffffff8008b25b34:      	mov	w2, #66
ffffff8008b25b38:      	strh	w8, [sp, #4]
ffffff8008b25b3c:      	bl	#-201188 <iWriteRegI2C>
ffffff8008b25b40:      	mov	w8, #20833
ffffff8008b25b44:      	add	x0, sp, #4
ffffff8008b25b48:      	mov	w1, #2
ffffff8008b25b4c:      	mov	w2, #66
ffffff8008b25b50:      	strh	w8, [sp, #4]
ffffff8008b25b54:      	bl	#-201212 <iWriteRegI2C>
ffffff8008b25b58:      	mov	w8, #27234
ffffff8008b25b5c:      	add	x0, sp, #4
ffffff8008b25b60:      	mov	w1, #2
ffffff8008b25b64:      	mov	w2, #66
ffffff8008b25b68:      	strh	w8, [sp, #4]
ffffff8008b25b6c:      	bl	#-201236 <iWriteRegI2C>
ffffff8008b25b70:      	mov	w8, #32099
ffffff8008b25b74:      	add	x0, sp, #4
ffffff8008b25b78:      	mov	w1, #2
ffffff8008b25b7c:      	mov	w2, #66
ffffff8008b25b80:      	strh	w8, [sp, #4]
ffffff8008b25b84:      	bl	#-201260 <iWriteRegI2C>
ffffff8008b25b88:      	mov	w8, #36196
ffffff8008b25b8c:      	add	x0, sp, #4
ffffff8008b25b90:      	mov	w1, #2
ffffff8008b25b94:      	mov	w2, #66
ffffff8008b25b98:      	strh	w8, [sp, #4]
ffffff8008b25b9c:      	bl	#-201284 <iWriteRegI2C>
ffffff8008b25ba0:      	mov	w8, #39013
ffffff8008b25ba4:      	add	x0, sp, #4
ffffff8008b25ba8:      	mov	w1, #2
ffffff8008b25bac:      	mov	w2, #66
ffffff8008b25bb0:      	strh	w8, [sp, #4]
ffffff8008b25bb4:      	bl	#-201308 <iWriteRegI2C>
ffffff8008b25bb8:      	mov	w8, #41574
ffffff8008b25bbc:      	add	x0, sp, #4
ffffff8008b25bc0:      	mov	w1, #2
ffffff8008b25bc4:      	mov	w2, #66
ffffff8008b25bc8:      	strh	w8, [sp, #4]
ffffff8008b25bcc:      	bl	#-201332 <iWriteRegI2C>
ffffff8008b25bd0:      	mov	w8, #46439
ffffff8008b25bd4:      	add	x0, sp, #4
ffffff8008b25bd8:      	mov	w1, #2
ffffff8008b25bdc:      	mov	w2, #66
ffffff8008b25be0:      	strh	w8, [sp, #4]
ffffff8008b25be4:      	bl	#-201356 <iWriteRegI2C>
ffffff8008b25be8:      	mov	w8, #50024
ffffff8008b25bec:      	add	x0, sp, #4
ffffff8008b25bf0:      	mov	w1, #2
ffffff8008b25bf4:      	mov	w2, #66
ffffff8008b25bf8:      	strh	w8, [sp, #4]
ffffff8008b25bfc:      	bl	#-201380 <iWriteRegI2C>
ffffff8008b25c00:      	mov	w8, #52585
ffffff8008b25c04:      	add	x0, sp, #4
ffffff8008b25c08:      	mov	w1, #2
ffffff8008b25c0c:      	mov	w2, #66
ffffff8008b25c10:      	strh	w8, [sp, #4]
ffffff8008b25c14:      	bl	#-201404 <iWriteRegI2C>
ffffff8008b25c18:      	mov	w8, #54378
ffffff8008b25c1c:      	add	x0, sp, #4
ffffff8008b25c20:      	mov	w1, #2
ffffff8008b25c24:      	mov	w2, #66
ffffff8008b25c28:      	strh	w8, [sp, #4]
ffffff8008b25c2c:      	bl	#-201428 <iWriteRegI2C>
ffffff8008b25c30:      	mov	w8, #56427
ffffff8008b25c34:      	add	x0, sp, #4
ffffff8008b25c38:      	mov	w1, #2
ffffff8008b25c3c:      	mov	w2, #66
ffffff8008b25c40:      	strh	w8, [sp, #4]
ffffff8008b25c44:      	bl	#-201452 <iWriteRegI2C>
ffffff8008b25c48:      	mov	w8, #58220
ffffff8008b25c4c:      	add	x0, sp, #4
ffffff8008b25c50:      	mov	w1, #2
ffffff8008b25c54:      	mov	w2, #66
ffffff8008b25c58:      	strh	w8, [sp, #4]
ffffff8008b25c5c:      	bl	#-201476 <iWriteRegI2C>
ffffff8008b25c60:      	mov	w8, #61549
ffffff8008b25c64:      	add	x0, sp, #4
ffffff8008b25c68:      	mov	w1, #2
ffffff8008b25c6c:      	mov	w2, #66
ffffff8008b25c70:      	strh	w8, [sp, #4]
ffffff8008b25c74:      	bl	#-201500 <iWriteRegI2C>
ffffff8008b25c78:      	mov	w8, #63854
ffffff8008b25c7c:      	add	x0, sp, #4
ffffff8008b25c80:      	mov	w1, #2
ffffff8008b25c84:      	mov	w2, #66
ffffff8008b25c88:      	strh	w8, [sp, #4]
ffffff8008b25c8c:      	bl	#-201524 <iWriteRegI2C>
ffffff8008b25c90:      	mov	w8, #65391
ffffff8008b25c94:      	add	x0, sp, #4
ffffff8008b25c98:      	mov	w1, #2
ffffff8008b25c9c:      	mov	w2, #66
ffffff8008b25ca0:      	strh	w8, [sp, #4]
ffffff8008b25ca4:      	bl	#-201548 <iWriteRegI2C>
ffffff8008b25ca8:      	add	x0, sp, #4
ffffff8008b25cac:      	mov	w1, #2
ffffff8008b25cb0:      	mov	w2, #66
ffffff8008b25cb4:      	strh	w19, [sp, #4]
ffffff8008b25cb8:      	bl	#-201568 <iWriteRegI2C>
ffffff8008b25cbc:      	mov	w8, #20592
ffffff8008b25cc0:      	add	x0, sp, #4
ffffff8008b25cc4:      	mov	w1, #2
ffffff8008b25cc8:      	mov	w2, #66
ffffff8008b25ccc:      	strh	w8, [sp, #4]
ffffff8008b25cd0:      	bl	#-201592 <iWriteRegI2C>
ffffff8008b25cd4:      	add	x0, sp, #4
ffffff8008b25cd8:      	mov	w1, #2
ffffff8008b25cdc:      	mov	w2, #66
ffffff8008b25ce0:      	strh	w19, [sp, #4]
ffffff8008b25ce4:      	bl	#-201612 <iWriteRegI2C>
ffffff8008b25ce8:      	mov	w8, #335
ffffff8008b25cec:      	add	x0, sp, #4
ffffff8008b25cf0:      	mov	w1, #2
ffffff8008b25cf4:      	mov	w2, #66
ffffff8008b25cf8:      	strh	w8, [sp, #4]
ffffff8008b25cfc:      	bl	#-201636 <iWriteRegI2C>
ffffff8008b25d00:      	add	x0, sp, #4
ffffff8008b25d04:      	mov	w1, #2
ffffff8008b25d08:      	mov	w2, #66
ffffff8008b25d0c:      	strh	w24, [sp, #4]
ffffff8008b25d10:      	bl	#-201656 <iWriteRegI2C>
ffffff8008b25d14:      	mov	w8, #13
ffffff8008b25d18:      	add	x0, sp, #4
ffffff8008b25d1c:      	mov	w1, #2
ffffff8008b25d20:      	mov	w2, #66
ffffff8008b25d24:      	strh	w8, [sp, #4]
ffffff8008b25d28:      	bl	#-201680 <iWriteRegI2C>
ffffff8008b25d2c:      	mov	w8, #40978
ffffff8008b25d30:      	add	x0, sp, #4
ffffff8008b25d34:      	mov	w1, #2
ffffff8008b25d38:      	mov	w2, #66
ffffff8008b25d3c:      	strh	w8, [sp, #4]
ffffff8008b25d40:      	bl	#-201704 <iWriteRegI2C>
ffffff8008b25d44:      	mov	w8, #14867
ffffff8008b25d48:      	add	x0, sp, #4
ffffff8008b25d4c:      	mov	w1, #2
ffffff8008b25d50:      	mov	w2, #66
ffffff8008b25d54:      	strh	w8, [sp, #4]
ffffff8008b25d58:      	bl	#-201728 <iWriteRegI2C>
ffffff8008b25d5c:      	mov	w8, #1092
ffffff8008b25d60:      	add	x0, sp, #4
ffffff8008b25d64:      	mov	w1, #2
ffffff8008b25d68:      	mov	w2, #66
ffffff8008b25d6c:      	strh	w8, [sp, #4]
ffffff8008b25d70:      	bl	#-201752 <iWriteRegI2C>
ffffff8008b25d74:      	mov	w8, #12319
ffffff8008b25d78:      	add	x0, sp, #4
ffffff8008b25d7c:      	mov	w1, #2
ffffff8008b25d80:      	mov	w2, #66
ffffff8008b25d84:      	strh	w8, [sp, #4]
ffffff8008b25d88:      	bl	#-201776 <iWriteRegI2C>
ffffff8008b25d8c:      	mov	w8, #16416
ffffff8008b25d90:      	add	x0, sp, #4
ffffff8008b25d94:      	mov	w1, #2
ffffff8008b25d98:      	mov	w2, #66
ffffff8008b25d9c:      	strh	w8, [sp, #4]
ffffff8008b25da0:      	bl	#-201800 <iWriteRegI2C>
ffffff8008b25da4:      	mov	w25, #39462
ffffff8008b25da8:      	add	x0, sp, #4
ffffff8008b25dac:      	mov	w1, #2
ffffff8008b25db0:      	mov	w2, #66
ffffff8008b25db4:      	strh	w25, [sp, #4]
ffffff8008b25db8:      	bl	#-201824 <iWriteRegI2C>
ffffff8008b25dbc:      	mov	w8, #8254
ffffff8008b25dc0:      	add	x0, sp, #4
ffffff8008b25dc4:      	mov	w1, #2
ffffff8008b25dc8:      	mov	w2, #66
ffffff8008b25dcc:      	strh	w8, [sp, #4]
ffffff8008b25dd0:      	bl	#-201848 <iWriteRegI2C>
ffffff8008b25dd4:      	mov	w8, #11583
ffffff8008b25dd8:      	add	x0, sp, #4
ffffff8008b25ddc:      	mov	w1, #2
ffffff8008b25de0:      	mov	w2, #66
ffffff8008b25de4:      	strh	w8, [sp, #4]
ffffff8008b25de8:      	bl	#-201872 <iWriteRegI2C>
ffffff8008b25dec:      	mov	w8, #16448
ffffff8008b25df0:      	add	x0, sp, #4
ffffff8008b25df4:      	mov	w1, #2
ffffff8008b25df8:      	mov	w2, #66
ffffff8008b25dfc:      	strh	w8, [sp, #4]
ffffff8008b25e00:      	bl	#-201896 <iWriteRegI2C>
ffffff8008b25e04:      	mov	w8, #23361
ffffff8008b25e08:      	add	x0, sp, #4
ffffff8008b25e0c:      	mov	w1, #2
ffffff8008b25e10:      	mov	w2, #66
ffffff8008b25e14:      	strh	w8, [sp, #4]
ffffff8008b25e18:      	bl	#-201920 <iWriteRegI2C>
ffffff8008b25e1c:      	mov	w8, #33346
ffffff8008b25e20:      	add	x0, sp, #4
ffffff8008b25e24:      	mov	w1, #2
ffffff8008b25e28:      	mov	w2, #66
ffffff8008b25e2c:      	strh	w8, [sp, #4]
ffffff8008b25e30:      	bl	#-201944 <iWriteRegI2C>
ffffff8008b25e34:      	mov	w8, #46915
ffffff8008b25e38:      	add	x0, sp, #4
ffffff8008b25e3c:      	mov	w1, #2
ffffff8008b25e40:      	mov	w2, #66
ffffff8008b25e44:      	strh	w8, [sp, #4]
ffffff8008b25e48:      	bl	#-201968 <iWriteRegI2C>
ffffff8008b25e4c:      	mov	w8, #2564
ffffff8008b25e50:      	add	x0, sp, #4
ffffff8008b25e54:      	mov	w1, #2
ffffff8008b25e58:      	mov	w2, #66
ffffff8008b25e5c:      	strh	w8, [sp, #4]
ffffff8008b25e60:      	bl	#-201992 <iWriteRegI2C>
ffffff8008b25e64:      	mov	w8, #30978
ffffff8008b25e68:      	add	x0, sp, #4
ffffff8008b25e6c:      	mov	w1, #2
ffffff8008b25e70:      	mov	w2, #66
ffffff8008b25e74:      	strh	w8, [sp, #4]
ffffff8008b25e78:      	bl	#-202016 <iWriteRegI2C>
ffffff8008b25e7c:      	mov	w8, #49155
ffffff8008b25e80:      	add	x0, sp, #4
ffffff8008b25e84:      	mov	w1, #2
ffffff8008b25e88:      	mov	w2, #66
ffffff8008b25e8c:      	strh	w8, [sp, #4]
ffffff8008b25e90:      	bl	#-202040 <iWriteRegI2C>
ffffff8008b25e94:      	add	x0, sp, #4
ffffff8008b25e98:      	mov	w1, #2
ffffff8008b25e9c:      	mov	w2, #66
ffffff8008b25ea0:      	strh	w24, [sp, #4]
ffffff8008b25ea4:      	bl	#-202060 <iWriteRegI2C>
ffffff8008b25ea8:      	mov	w8, #2252
ffffff8008b25eac:      	add	x0, sp, #4
ffffff8008b25eb0:      	mov	w1, #2
ffffff8008b25eb4:      	mov	w2, #66
ffffff8008b25eb8:      	strh	w8, [sp, #4]
ffffff8008b25ebc:      	bl	#-202084 <iWriteRegI2C>
ffffff8008b25ec0:      	mov	w8, #2253
ffffff8008b25ec4:      	add	x0, sp, #4
ffffff8008b25ec8:      	mov	w1, #2
ffffff8008b25ecc:      	mov	w2, #66
ffffff8008b25ed0:      	strh	w8, [sp, #4]
ffffff8008b25ed4:      	bl	#-202108 <iWriteRegI2C>
ffffff8008b25ed8:      	mov	w8, #42190
ffffff8008b25edc:      	add	x0, sp, #4
ffffff8008b25ee0:      	mov	w1, #2
ffffff8008b25ee4:      	mov	w2, #66
ffffff8008b25ee8:      	strh	w8, [sp, #4]
ffffff8008b25eec:      	bl	#-202132 <iWriteRegI2C>
ffffff8008b25ef0:      	mov	w8, #60623
ffffff8008b25ef4:      	add	x0, sp, #4
ffffff8008b25ef8:      	mov	w1, #2
ffffff8008b25efc:      	mov	w2, #66
ffffff8008b25f00:      	strh	w8, [sp, #4]
ffffff8008b25f04:      	bl	#-202156 <iWriteRegI2C>
ffffff8008b25f08:      	add	x0, sp, #4
ffffff8008b25f0c:      	mov	w1, #2
ffffff8008b25f10:      	mov	w2, #66
ffffff8008b25f14:      	strh	w19, [sp, #4]
ffffff8008b25f18:      	bl	#-202176 <iWriteRegI2C>
ffffff8008b25f1c:      	mov	w8, #47233
ffffff8008b25f20:      	add	x0, sp, #4
ffffff8008b25f24:      	mov	w1, #2
ffffff8008b25f28:      	mov	w2, #66
ffffff8008b25f2c:      	strh	w8, [sp, #4]
ffffff8008b25f30:      	bl	#-202200 <iWriteRegI2C>
ffffff8008b25f34:      	mov	w8, #4738
ffffff8008b25f38:      	add	x0, sp, #4
ffffff8008b25f3c:      	mov	w1, #2
ffffff8008b25f40:      	mov	w2, #66
ffffff8008b25f44:      	strh	w8, [sp, #4]
ffffff8008b25f48:      	bl	#-202224 <iWriteRegI2C>
ffffff8008b25f4c:      	mov	w8, #2691
ffffff8008b25f50:      	add	x0, sp, #4
ffffff8008b25f54:      	mov	w1, #2
ffffff8008b25f58:      	mov	w2, #66
ffffff8008b25f5c:      	strh	w8, [sp, #4]
ffffff8008b25f60:      	bl	#-202248 <iWriteRegI2C>
ffffff8008b25f64:      	mov	w8, #388
ffffff8008b25f68:      	add	x0, sp, #4
ffffff8008b25f6c:      	mov	w1, #2
ffffff8008b25f70:      	mov	w2, #66
ffffff8008b25f74:      	strh	w8, [sp, #4]
ffffff8008b25f78:      	bl	#-202272 <iWriteRegI2C>
ffffff8008b25f7c:      	mov	w8, #20614
ffffff8008b25f80:      	add	x0, sp, #4
ffffff8008b25f84:      	mov	w1, #2
ffffff8008b25f88:      	mov	w2, #66
ffffff8008b25f8c:      	strh	w8, [sp, #4]
ffffff8008b25f90:      	bl	#-202296 <iWriteRegI2C>
ffffff8008b25f94:      	mov	w8, #6279
ffffff8008b25f98:      	add	x0, sp, #4
ffffff8008b25f9c:      	mov	w1, #2
ffffff8008b25fa0:      	mov	w2, #66
ffffff8008b25fa4:      	strh	w8, [sp, #4]
ffffff8008b25fa8:      	bl	#-202320 <iWriteRegI2C>
ffffff8008b25fac:      	mov	w8, #4232
ffffff8008b25fb0:      	add	x0, sp, #4
ffffff8008b25fb4:      	mov	w1, #2
ffffff8008b25fb8:      	mov	w2, #66
ffffff8008b25fbc:      	strh	w8, [sp, #4]
ffffff8008b25fc0:      	bl	#-202344 <iWriteRegI2C>
ffffff8008b25fc4:      	mov	w8, #28809
ffffff8008b25fc8:      	add	x0, sp, #4
ffffff8008b25fcc:      	mov	w1, #2
ffffff8008b25fd0:      	mov	w2, #66
ffffff8008b25fd4:      	strh	w8, [sp, #4]
ffffff8008b25fd8:      	bl	#-202368 <iWriteRegI2C>
ffffff8008b25fdc:      	mov	w8, #8330
ffffff8008b25fe0:      	add	x0, sp, #4
ffffff8008b25fe4:      	mov	w1, #2
ffffff8008b25fe8:      	mov	w2, #66
ffffff8008b25fec:      	strh	w8, [sp, #4]
ffffff8008b25ff0:      	bl	#-202392 <iWriteRegI2C>
ffffff8008b25ff4:      	mov	w8, #4235
ffffff8008b25ff8:      	add	x0, sp, #4
ffffff8008b25ffc:      	mov	w1, #2
ffffff8008b26000:      	mov	w2, #66
ffffff8008b26004:      	strh	w8, [sp, #4]
ffffff8008b26008:      	bl	#-202416 <iWriteRegI2C>
ffffff8008b2600c:      	mov	w8, #2188
ffffff8008b26010:      	add	x0, sp, #4
ffffff8008b26014:      	mov	w1, #2
ffffff8008b26018:      	mov	w2, #66
ffffff8008b2601c:      	strh	w8, [sp, #4]
ffffff8008b26020:      	bl	#-202440 <iWriteRegI2C>
ffffff8008b26024:      	mov	w8, #2701
ffffff8008b26028:      	add	x0, sp, #4
ffffff8008b2602c:      	mov	w1, #2
ffffff8008b26030:      	mov	w2, #66
ffffff8008b26034:      	strh	w8, [sp, #4]
ffffff8008b26038:      	bl	#-202464 <iWriteRegI2C>
ffffff8008b2603c:      	add	x0, sp, #4
ffffff8008b26040:      	mov	w1, #2
ffffff8008b26044:      	mov	w2, #66
ffffff8008b26048:      	strh	w19, [sp, #4]
ffffff8008b2604c:      	bl	#-202484 <iWriteRegI2C>
ffffff8008b26050:      	mov	w8, #43663
ffffff8008b26054:      	add	x0, sp, #4
ffffff8008b26058:      	mov	w1, #2
ffffff8008b2605c:      	mov	w2, #66
ffffff8008b26060:      	strh	w8, [sp, #4]
ffffff8008b26064:      	bl	#-202508 <iWriteRegI2C>
ffffff8008b26068:      	mov	w8, #40080
ffffff8008b2606c:      	add	x0, sp, #4
ffffff8008b26070:      	mov	w1, #2
ffffff8008b26074:      	mov	w2, #66
ffffff8008b26078:      	strh	w8, [sp, #4]
ffffff8008b2607c:      	bl	#-202532 <iWriteRegI2C>
ffffff8008b26080:      	mov	w8, #21137
ffffff8008b26084:      	add	x0, sp, #4
ffffff8008b26088:      	mov	w1, #2
ffffff8008b2608c:      	mov	w2, #66
ffffff8008b26090:      	strh	w8, [sp, #4]
ffffff8008b26094:      	bl	#-202556 <iWriteRegI2C>
ffffff8008b26098:      	mov	w8, #914
ffffff8008b2609c:      	add	x0, sp, #4
ffffff8008b260a0:      	mov	w1, #2
ffffff8008b260a4:      	mov	w2, #66
ffffff8008b260a8:      	strh	w8, [sp, #4]
ffffff8008b260ac:      	bl	#-202580 <iWriteRegI2C>
ffffff8008b260b0:      	mov	w8, #915
ffffff8008b260b4:      	add	x0, sp, #4
ffffff8008b260b8:      	mov	w1, #2
ffffff8008b260bc:      	mov	w2, #66
ffffff8008b260c0:      	strh	w8, [sp, #4]
ffffff8008b260c4:      	bl	#-202604 <iWriteRegI2C>
ffffff8008b260c8:      	mov	w8, #2196
ffffff8008b260cc:      	add	x0, sp, #4
ffffff8008b260d0:      	mov	w1, #2
ffffff8008b260d4:      	mov	w2, #66
ffffff8008b260d8:      	strh	w8, [sp, #4]
ffffff8008b260dc:      	bl	#-202628 <iWriteRegI2C>
ffffff8008b260e0:      	mov	w8, #17557
ffffff8008b260e4:      	add	x0, sp, #4
ffffff8008b260e8:      	mov	w1, #2
ffffff8008b260ec:      	mov	w2, #66
ffffff8008b260f0:      	strh	w8, [sp, #4]
ffffff8008b260f4:      	bl	#-202652 <iWriteRegI2C>
ffffff8008b260f8:      	mov	w8, #151
ffffff8008b260fc:      	add	x0, sp, #4
ffffff8008b26100:      	mov	w1, #2
ffffff8008b26104:      	mov	w2, #66
ffffff8008b26108:      	strh	w8, [sp, #4]
ffffff8008b2610c:      	bl	#-202676 <iWriteRegI2C>
ffffff8008b26110:      	mov	w8, #152
ffffff8008b26114:      	add	x0, sp, #4
ffffff8008b26118:      	mov	w1, #2
ffffff8008b2611c:      	mov	w2, #66
ffffff8008b26120:      	strh	w8, [sp, #4]
ffffff8008b26124:      	bl	#-202700 <iWriteRegI2C>
ffffff8008b26128:      	add	x0, sp, #4
ffffff8008b2612c:      	mov	w1, #2
ffffff8008b26130:      	mov	w2, #66
ffffff8008b26134:      	strh	w19, [sp, #4]
ffffff8008b26138:      	bl	#-202720 <iWriteRegI2C>
ffffff8008b2613c:      	mov	w8, #12449
ffffff8008b26140:      	add	x0, sp, #4
ffffff8008b26144:      	mov	w1, #2
ffffff8008b26148:      	mov	w2, #66
ffffff8008b2614c:      	strh	w8, [sp, #4]
ffffff8008b26150:      	bl	#-202744 <iWriteRegI2C>
ffffff8008b26154:      	mov	w8, #16802
ffffff8008b26158:      	add	x0, sp, #4
ffffff8008b2615c:      	mov	w1, #2
ffffff8008b26160:      	mov	w2, #66
ffffff8008b26164:      	strh	w8, [sp, #4]
ffffff8008b26168:      	bl	#-202768 <iWriteRegI2C>
ffffff8008b2616c:      	mov	w8, #12452
ffffff8008b26170:      	add	x0, sp, #4
ffffff8008b26174:      	mov	w1, #2
ffffff8008b26178:      	mov	w2, #66
ffffff8008b2617c:      	strh	w8, [sp, #4]
ffffff8008b26180:      	bl	#-202792 <iWriteRegI2C>
ffffff8008b26184:      	mov	w8, #8357
ffffff8008b26188:      	add	x0, sp, #4
ffffff8008b2618c:      	mov	w1, #2
ffffff8008b26190:      	mov	w2, #66
ffffff8008b26194:      	strh	w8, [sp, #4]
ffffff8008b26198:      	bl	#-202816 <iWriteRegI2C>
ffffff8008b2619c:      	mov	w8, #12458
ffffff8008b261a0:      	add	x0, sp, #4
ffffff8008b261a4:      	mov	w1, #2
ffffff8008b261a8:      	mov	w2, #66
ffffff8008b261ac:      	strh	w8, [sp, #4]
ffffff8008b261b0:      	bl	#-202840 <iWriteRegI2C>
ffffff8008b261b4:      	mov	w8, #12972
ffffff8008b261b8:      	add	x0, sp, #4
ffffff8008b261bc:      	mov	w1, #2
ffffff8008b261c0:      	mov	w2, #66
ffffff8008b261c4:      	strh	w8, [sp, #4]
ffffff8008b261c8:      	bl	#-202864 <iWriteRegI2C>
ffffff8008b261cc:      	add	x0, sp, #4
ffffff8008b261d0:      	mov	w1, #2
ffffff8008b261d4:      	mov	w2, #66
ffffff8008b261d8:      	strh	w19, [sp, #4]
ffffff8008b261dc:      	bl	#-202884 <iWriteRegI2C>
ffffff8008b261e0:      	mov	w8, #15569
ffffff8008b261e4:      	add	x0, sp, #4
ffffff8008b261e8:      	mov	w1, #2
ffffff8008b261ec:      	mov	w2, #66
ffffff8008b261f0:      	strh	w8, [sp, #4]
ffffff8008b261f4:      	bl	#-202908 <iWriteRegI2C>
ffffff8008b261f8:      	mov	w8, #15570
ffffff8008b261fc:      	add	x0, sp, #4
ffffff8008b26200:      	mov	w1, #2
ffffff8008b26204:      	mov	w2, #66
ffffff8008b26208:      	strh	w8, [sp, #4]
ffffff8008b2620c:      	bl	#-202932 <iWriteRegI2C>
ffffff8008b26210:      	mov	w8, #14547
ffffff8008b26214:      	add	x0, sp, #4
ffffff8008b26218:      	mov	w1, #2
ffffff8008b2621c:      	mov	w2, #66
ffffff8008b26220:      	strh	w8, [sp, #4]
ffffff8008b26224:      	bl	#-202956 <iWriteRegI2C>
ffffff8008b26228:      	mov	w8, #62678
ffffff8008b2622c:      	add	x0, sp, #4
ffffff8008b26230:      	mov	w1, #2
ffffff8008b26234:      	mov	w2, #66
ffffff8008b26238:      	strh	w8, [sp, #4]
ffffff8008b2623c:      	bl	#-202980 <iWriteRegI2C>
ffffff8008b26240:      	mov	w8, #7639
ffffff8008b26244:      	add	x0, sp, #4
ffffff8008b26248:      	mov	w1, #2
ffffff8008b2624c:      	mov	w2, #66
ffffff8008b26250:      	strh	w8, [sp, #4]
ffffff8008b26254:      	bl	#-203004 <iWriteRegI2C>
ffffff8008b26258:      	mov	w8, #29661
ffffff8008b2625c:      	add	x0, sp, #4
ffffff8008b26260:      	mov	w1, #2
ffffff8008b26264:      	mov	w2, #66
ffffff8008b26268:      	strh	w8, [sp, #4]
ffffff8008b2626c:      	bl	#-203028 <iWriteRegI2C>
ffffff8008b26270:      	mov	w8, #34014
ffffff8008b26274:      	add	x0, sp, #4
ffffff8008b26278:      	mov	w1, #2
ffffff8008b2627c:      	mov	w2, #66
ffffff8008b26280:      	strh	w8, [sp, #4]
ffffff8008b26284:      	bl	#-203052 <iWriteRegI2C>
ffffff8008b26288:      	add	x0, sp, #4
ffffff8008b2628c:      	mov	w1, #2
ffffff8008b26290:      	mov	w2, #66
ffffff8008b26294:      	strh	w19, [sp, #4]
ffffff8008b26298:      	bl	#-203072 <iWriteRegI2C>
ffffff8008b2629c:      	add	x0, sp, #4
ffffff8008b262a0:      	mov	w1, #2
ffffff8008b262a4:      	mov	w2, #66
ffffff8008b262a8:      	strh	w20, [sp, #4]
ffffff8008b262ac:      	bl	#-203092 <iWriteRegI2C>
ffffff8008b262b0:      	add	x0, sp, #4
ffffff8008b262b4:      	mov	w1, #2
ffffff8008b262b8:      	mov	w2, #66
ffffff8008b262bc:      	strh	w21, [sp, #4]
ffffff8008b262c0:      	bl	#-203112 <iWriteRegI2C>
ffffff8008b262c4:      	add	x0, sp, #4
ffffff8008b262c8:      	mov	w1, #2
ffffff8008b262cc:      	mov	w2, #66
ffffff8008b262d0:      	strh	w22, [sp, #4]
ffffff8008b262d4:      	bl	#-203132 <iWriteRegI2C>
ffffff8008b262d8:      	add	x0, sp, #4
ffffff8008b262dc:      	mov	w1, #2
ffffff8008b262e0:      	mov	w2, #66
ffffff8008b262e4:      	strh	w23, [sp, #4]
ffffff8008b262e8:      	bl	#-203152 <iWriteRegI2C>
ffffff8008b262ec:      	add	x0, sp, #4
ffffff8008b262f0:      	mov	w1, #2
ffffff8008b262f4:      	mov	w2, #66
ffffff8008b262f8:      	strh	w24, [sp, #4]
ffffff8008b262fc:      	bl	#-203172 <iWriteRegI2C>
ffffff8008b26300:      	mov	w8, #37
ffffff8008b26304:      	add	x0, sp, #4
ffffff8008b26308:      	mov	w1, #2
ffffff8008b2630c:      	mov	w2, #66
ffffff8008b26310:      	strh	w8, [sp, #4]
ffffff8008b26314:      	bl	#-203196 <iWriteRegI2C>
ffffff8008b26318:      	add	x0, sp, #4
ffffff8008b2631c:      	mov	w1, #2
ffffff8008b26320:      	mov	w2, #66
ffffff8008b26324:      	strh	w25, [sp, #4]
ffffff8008b26328:      	bl	#-203216 <iWriteRegI2C>
ffffff8008b2632c:      	mov	w8, #295
ffffff8008b26330:      	add	x0, sp, #4
ffffff8008b26334:      	mov	w1, #2
ffffff8008b26338:      	mov	w2, #66
ffffff8008b2633c:      	strh	w8, [sp, #4]
ffffff8008b26340:      	bl	#-203240 <iWriteRegI2C>
ffffff8008b26344:      	mov	w8, #52776
ffffff8008b26348:      	add	x0, sp, #4
ffffff8008b2634c:      	mov	w1, #2
ffffff8008b26350:      	mov	w2, #66
ffffff8008b26354:      	strh	w8, [sp, #4]
ffffff8008b26358:      	bl	#-203264 <iWriteRegI2C>
ffffff8008b2635c:      	mov	w8, #809
ffffff8008b26360:      	add	x0, sp, #4
ffffff8008b26364:      	mov	w1, #2
ffffff8008b26368:      	mov	w2, #66
ffffff8008b2636c:      	strh	w8, [sp, #4]
ffffff8008b26370:      	bl	#-203288 <iWriteRegI2C>
ffffff8008b26374:      	mov	w8, #554
ffffff8008b26378:      	add	x0, sp, #4
ffffff8008b2637c:      	mov	w1, #2
ffffff8008b26380:      	mov	w2, #66
ffffff8008b26384:      	strh	w8, [sp, #4]
ffffff8008b26388:      	bl	#-203312 <iWriteRegI2C>
ffffff8008b2638c:      	mov	w8, #1067
ffffff8008b26390:      	add	x0, sp, #4
ffffff8008b26394:      	mov	w1, #2
ffffff8008b26398:      	mov	w2, #66
ffffff8008b2639c:      	strh	w8, [sp, #4]
ffffff8008b263a0:      	bl	#-203336 <iWriteRegI2C>
ffffff8008b263a4:      	mov	w8, #13868
ffffff8008b263a8:      	add	x0, sp, #4
ffffff8008b263ac:      	mov	w1, #2
ffffff8008b263b0:      	mov	w2, #66
ffffff8008b263b4:      	strh	w8, [sp, #4]
ffffff8008b263b8:      	bl	#-203360 <iWriteRegI2C>
ffffff8008b263bc:      	mov	w8, #1837
ffffff8008b263c0:      	add	x0, sp, #4
ffffff8008b263c4:      	mov	w1, #2
ffffff8008b263c8:      	mov	w2, #66
ffffff8008b263cc:      	strh	w8, [sp, #4]
ffffff8008b263d0:      	bl	#-203384 <iWriteRegI2C>
ffffff8008b263d4:      	mov	w8, #53806
ffffff8008b263d8:      	add	x0, sp, #4
ffffff8008b263dc:      	mov	w1, #2
ffffff8008b263e0:      	mov	w2, #66
ffffff8008b263e4:      	strh	w8, [sp, #4]
ffffff8008b263e8:      	bl	#-203408 <iWriteRegI2C>
ffffff8008b263ec:      	mov	w8, #2863
ffffff8008b263f0:      	add	x0, sp, #4
ffffff8008b263f4:      	mov	w1, #2
ffffff8008b263f8:      	mov	w2, #66
ffffff8008b263fc:      	strh	w8, [sp, #4]
ffffff8008b26400:      	bl	#-203432 <iWriteRegI2C>
ffffff8008b26404:      	mov	w8, #28208
ffffff8008b26408:      	add	x0, sp, #4
ffffff8008b2640c:      	mov	w1, #2
ffffff8008b26410:      	mov	w2, #66
ffffff8008b26414:      	strh	w8, [sp, #4]
ffffff8008b26418:      	bl	#-203456 <iWriteRegI2C>
ffffff8008b2641c:      	mov	w8, #3633
ffffff8008b26420:      	add	x0, sp, #4
ffffff8008b26424:      	mov	w1, #2
ffffff8008b26428:      	mov	w2, #66
ffffff8008b2642c:      	strh	w8, [sp, #4]
ffffff8008b26430:      	bl	#-203480 <iWriteRegI2C>
ffffff8008b26434:      	mov	w8, #28722
ffffff8008b26438:      	add	x0, sp, #4
ffffff8008b2643c:      	mov	w1, #2
ffffff8008b26440:      	mov	w2, #66
ffffff8008b26444:      	strh	w8, [sp, #4]
ffffff8008b26448:      	bl	#-203504 <iWriteRegI2C>
ffffff8008b2644c:      	mov	w8, #4659
ffffff8008b26450:      	add	x0, sp, #4
ffffff8008b26454:      	mov	w1, #2
ffffff8008b26458:      	mov	w2, #66
ffffff8008b2645c:      	strh	w8, [sp, #4]
ffffff8008b26460:      	bl	#-203528 <iWriteRegI2C>
ffffff8008b26464:      	mov	w8, #3124
ffffff8008b26468:      	add	x0, sp, #4
ffffff8008b2646c:      	mov	w1, #2
ffffff8008b26470:      	mov	w2, #66
ffffff8008b26474:      	strh	w8, [sp, #4]
ffffff8008b26478:      	bl	#-203552 <iWriteRegI2C>
ffffff8008b2647c:      	mov	w8, #12348
ffffff8008b26480:      	add	x0, sp, #4
ffffff8008b26484:      	mov	w1, #2
ffffff8008b26488:      	mov	w2, #66
ffffff8008b2648c:      	strh	w8, [sp, #4]
ffffff8008b26490:      	bl	#-203576 <iWriteRegI2C>
ffffff8008b26494:      	add	x0, sp, #4
ffffff8008b26498:      	mov	w1, #2
ffffff8008b2649c:      	mov	w2, #66
ffffff8008b264a0:      	strh	w19, [sp, #4]
ffffff8008b264a4:      	bl	#-203596 <iWriteRegI2C>
ffffff8008b264a8:      	adrp	x9, #22589440
ffffff8008b264ac:      	ldr	x8, [sp, #8]
ffffff8008b264b0:      	ldr	x9, [x9, #4088]
ffffff8008b264b4:      	cmp	x9, x8
ffffff8008b264b8:      	b.ne	#32 <GC032a_Sensor_Init+0x1b14>
ffffff8008b264bc:      	ldp	x20, x19, [sp, #80]
ffffff8008b264c0:      	ldp	x22, x21, [sp, #64]
ffffff8008b264c4:      	ldp	x24, x23, [sp, #48]
ffffff8008b264c8:      	ldp	x26, x25, [sp, #32]
ffffff8008b264cc:      	ldp	x29, x30, [sp, #16]
ffffff8008b264d0:      	add	sp, sp, #96
ffffff8008b264d4:      	ret
ffffff8008b264d8:      	bl	#-9521184 <__stack_chk_fail>

ffffff8008b264dc GC032a_read_cmos_sensor:
ffffff8008b264dc:      	sub	sp, sp, #32
ffffff8008b264e0:      	stp	x29, x30, [sp, #16]
ffffff8008b264e4:      	add	x29, sp, #16
ffffff8008b264e8:      	adrp	x8, #22589440
ffffff8008b264ec:      	ldr	x8, [x8, #4088]
ffffff8008b264f0:      	add	x2, sp, #4
ffffff8008b264f4:      	mov	w1, #1
ffffff8008b264f8:      	mov	w3, #1
ffffff8008b264fc:      	str	x8, [sp, #8]
ffffff8008b26500:      	strb	w0, [sp]
ffffff8008b26504:      	mov	x0, sp
ffffff8008b26508:      	mov	w4, #67
ffffff8008b2650c:      	strh	wzr, [sp, #4]
ffffff8008b26510:      	bl	#-205204 <iReadRegI2C>
ffffff8008b26514:      	adrp	x9, #22589440
ffffff8008b26518:      	ldrh	w0, [sp, #4]
ffffff8008b2651c:      	ldr	x8, [sp, #8]
ffffff8008b26520:      	ldr	x9, [x9, #4088]
ffffff8008b26524:      	cmp	x9, x8
ffffff8008b26528:      	b.ne	#16 <GC032a_read_cmos_sensor+0x5c>
ffffff8008b2652c:      	ldp	x29, x30, [sp, #16]
ffffff8008b26530:      	add	sp, sp, #32
ffffff8008b26534:      	ret
ffffff8008b26538:      	bl	#-9521280 <__stack_chk_fail>
