
vmlinux.elf:	file format ELF64-aarch64-little


Disassembly of section .kernel:

ffffff8008b1cb8c open$abb3d18ce96cf025cc17a76c06f66f80:
ffffff8008b1cb8c:      	sub	sp, sp, #112
ffffff8008b1cb90:      	stp	x29, x30, [sp, #16]
ffffff8008b1cb94:      	str	x27, [sp, #32]
ffffff8008b1cb98:      	stp	x26, x25, [sp, #48]
ffffff8008b1cb9c:      	stp	x24, x23, [sp, #64]
ffffff8008b1cba0:      	stp	x22, x21, [sp, #80]
ffffff8008b1cba4:      	stp	x20, x19, [sp, #96]
ffffff8008b1cba8:      	add	x29, sp, #16
ffffff8008b1cbac:      	adrp	x8, #22630400
ffffff8008b1cbb0:      	ldr	x8, [x8, #4088]
ffffff8008b1cbb4:      	adrp	x0, #13488128
ffffff8008b1cbb8:      	add	x0, x0, #2167
ffffff8008b1cbbc:      	str	x8, [sp, #8]
ffffff8008b1cbc0:      	bl	#-8841408 <printk>
ffffff8008b1cbc4:      	adrp	x19, #28524544
ffffff8008b1cbc8:      	adrp	x20, #12619776
ffffff8008b1cbcc:      	adrp	x27, #14868480
ffffff8008b1cbd0:      	mov	x24, xzr
ffffff8008b1cbd4:      	mov	w21, #90
ffffff8008b1cbd8:      	add	x19, x19, #1572
ffffff8008b1cbdc:      	adrp	x22, #23588864
ffffff8008b1cbe0:      	mov	w25, #256
ffffff8008b1cbe4:      	adrp	x23, #33243136
ffffff8008b1cbe8:      	mov	w26, #12486
ffffff8008b1cbec:      	add	x20, x20, #3868
ffffff8008b1cbf0:      	add	x27, x27, #196
ffffff8008b1cbf4:      	mov	x0, x19
ffffff8008b1cbf8:      	bl	#8573988 <_raw_spin_lock>
ffffff8008b1cbfc:      	mov	x0, x19
ffffff8008b1cc00:      	strb	w21, [x22, #4028]
ffffff8008b1cc04:      	bl	#8574264 <_raw_spin_unlock>
ffffff8008b1cc08:      	ldrb	w4, [x22, #4028]
ffffff8008b1cc0c:      	mov	x0, sp
ffffff8008b1cc10:      	add	x2, sp, #4
ffffff8008b1cc14:      	mov	w1, #2
ffffff8008b1cc18:      	mov	w3, #1
ffffff8008b1cc1c:      	strh	wzr, [sp, #4]
ffffff8008b1cc20:      	strh	wzr, [sp]
ffffff8008b1cc24:      	bl	#-166056 <iReadRegI2C>
ffffff8008b1cc28:      	ldrb	w4, [x22, #4028]
ffffff8008b1cc2c:      	ldrh	w21, [sp, #4]
ffffff8008b1cc30:      	mov	x0, sp
ffffff8008b1cc34:      	add	x2, sp, #4
ffffff8008b1cc38:      	mov	w1, #2
ffffff8008b1cc3c:      	mov	w3, #1
ffffff8008b1cc40:      	strh	wzr, [sp, #4]
ffffff8008b1cc44:      	strh	w25, [sp]
ffffff8008b1cc48:      	bl	#-166092 <iReadRegI2C>
ffffff8008b1cc4c:      	ldrh	w8, [sp, #4]
ffffff8008b1cc50:      	orr	w2, w8, w21, lsl #8
ffffff8008b1cc54:      	cmp	w2, w26
ffffff8008b1cc58:      	b.ne	#12 <open$abb3d18ce96cf025cc17a76c06f66f80+0xd8>
ffffff8008b1cc5c:      	ldr	w8, [x23, #3232]
ffffff8008b1cc60:      	cbz	w8, #156 <open$abb3d18ce96cf025cc17a76c06f66f80+0x170>
ffffff8008b1cc64:      	ldrb	w1, [x22, #4028]
ffffff8008b1cc68:      	mov	x0, x20
ffffff8008b1cc6c:      	bl	#-8841580 <printk>
ffffff8008b1cc70:      	ldrb	w4, [x22, #4028]
ffffff8008b1cc74:      	mov	x0, sp
ffffff8008b1cc78:      	add	x2, sp, #4
ffffff8008b1cc7c:      	mov	w1, #2
ffffff8008b1cc80:      	mov	w3, #1
ffffff8008b1cc84:      	strh	wzr, [sp, #4]
ffffff8008b1cc88:      	strh	wzr, [sp]
ffffff8008b1cc8c:      	bl	#-166160 <iReadRegI2C>
ffffff8008b1cc90:      	ldrb	w4, [x22, #4028]
ffffff8008b1cc94:      	ldrh	w21, [sp, #4]
ffffff8008b1cc98:      	mov	x0, sp
ffffff8008b1cc9c:      	add	x2, sp, #4
ffffff8008b1cca0:      	mov	w1, #2
ffffff8008b1cca4:      	mov	w3, #1
ffffff8008b1cca8:      	strh	wzr, [sp, #4]
ffffff8008b1ccac:      	strh	w25, [sp]
ffffff8008b1ccb0:      	bl	#-166196 <iReadRegI2C>
ffffff8008b1ccb4:      	ldrh	w8, [sp, #4]
ffffff8008b1ccb8:      	orr	w21, w8, w21, lsl #8
ffffff8008b1ccbc:      	cmp	w21, w26
ffffff8008b1ccc0:      	b.ne	#12 <open$abb3d18ce96cf025cc17a76c06f66f80+0x140>
ffffff8008b1ccc4:      	ldr	w8, [x23, #3232]
ffffff8008b1ccc8:      	cbz	w8, #52 <open$abb3d18ce96cf025cc17a76c06f66f80+0x170>
ffffff8008b1cccc:      	ldrb	w1, [x22, #4028]
ffffff8008b1ccd0:      	mov	x0, x20
ffffff8008b1ccd4:      	mov	w2, w21
ffffff8008b1ccd8:      	bl	#-8841688 <printk>
ffffff8008b1ccdc:      	cmp	w21, w26
ffffff8008b1cce0:      	b.eq	#48 <open$abb3d18ce96cf025cc17a76c06f66f80+0x184>
ffffff8008b1cce4:      	add	x8, x27, x24
ffffff8008b1cce8:      	ldrb	w21, [x8, #332]
ffffff8008b1ccec:      	add	x24, x24, #1
ffffff8008b1ccf0:      	cmp	x24, #2
ffffff8008b1ccf4:      	b.ne	#-256 <open$abb3d18ce96cf025cc17a76c06f66f80+0x68>
ffffff8008b1ccf8:      	b	#32 <open$abb3d18ce96cf025cc17a76c06f66f80+0x18c>
ffffff8008b1ccfc:      	ldrb	w1, [x22, #4028]
ffffff8008b1cd00:      	adrp	x0, #12619776
ffffff8008b1cd04:      	add	x0, x0, #3754
ffffff8008b1cd08:      	mov	w2, #12486
ffffff8008b1cd0c:      	bl	#-8841740 <printk>
ffffff8008b1cd10:      	ldr	w8, [x23, #3232]
ffffff8008b1cd14:      	cbz	w8, #12 <open$abb3d18ce96cf025cc17a76c06f66f80+0x194>
ffffff8008b1cd18:      	mov	w0, #16
ffffff8008b1cd1c:      	b	#2048 <open$abb3d18ce96cf025cc17a76c06f66f80+0x990>
ffffff8008b1cd20:      	adrp	x0, #13488128
ffffff8008b1cd24:      	add	x0, x0, #3656
ffffff8008b1cd28:      	bl	#-8841768 <printk>
ffffff8008b1cd2c:      	ldrb	w2, [x22, #4028]
ffffff8008b1cd30:      	mov	w20, #1
ffffff8008b1cd34:      	add	x0, sp, #4
ffffff8008b1cd38:      	mov	w1, #4
ffffff8008b1cd3c:      	str	w20, [sp, #4]
ffffff8008b1cd40:      	bl	#-164840 <iWriteRegI2C>
ffffff8008b1cd44:      	adrp	x8, #22904832
ffffff8008b1cd48:      	ldr	x8, [x8, #352]
ffffff8008b1cd4c:      	mov	w9, #24528
ffffff8008b1cd50:      	movk	w9, #49152, lsl #16
ffffff8008b1cd54:      	mul	x8, x8, x9
ffffff8008b1cd58:      	lsr	x0, x8, #32
ffffff8008b1cd5c:      	bl	#8440164 <__delay>
ffffff8008b1cd60:      	ldrb	w2, [x22, #4028]
ffffff8008b1cd64:      	mov	w8, #33840
ffffff8008b1cd68:      	movk	w8, #5139, lsl #16
ffffff8008b1cd6c:      	add	x0, sp, #4
ffffff8008b1cd70:      	mov	w1, #4
ffffff8008b1cd74:      	str	w8, [sp, #4]
ffffff8008b1cd78:      	bl	#-164896 <iWriteRegI2C>
ffffff8008b1cd7c:      	ldrb	w2, [x22, #4028]
ffffff8008b1cd80:      	mov	w8, #26162
ffffff8008b1cd84:      	movk	w8, #256, lsl #16
ffffff8008b1cd88:      	add	x0, sp, #4
ffffff8008b1cd8c:      	mov	w1, #4
ffffff8008b1cd90:      	str	w8, [sp, #4]
ffffff8008b1cd94:      	bl	#-164924 <iWriteRegI2C>
ffffff8008b1cd98:      	ldrb	w2, [x22, #4028]
ffffff8008b1cd9c:      	mov	w8, #16946
ffffff8008b1cda0:      	movk	w8, #8224, lsl #16
ffffff8008b1cda4:      	add	x0, sp, #4
ffffff8008b1cda8:      	mov	w1, #4
ffffff8008b1cdac:      	str	w8, [sp, #4]
ffffff8008b1cdb0:      	bl	#-164952 <iWriteRegI2C>
ffffff8008b1cdb4:      	ldrb	w2, [x22, #4028]
ffffff8008b1cdb8:      	mov	w8, #27184
ffffff8008b1cdbc:      	movk	w8, #19503, lsl #16
ffffff8008b1cdc0:      	add	x0, sp, #4
ffffff8008b1cdc4:      	mov	w1, #4
ffffff8008b1cdc8:      	str	w8, [sp, #4]
ffffff8008b1cdcc:      	bl	#-164980 <iWriteRegI2C>
ffffff8008b1cdd0:      	ldrb	w2, [x22, #4028]
ffffff8008b1cdd4:      	mov	w8, #27696
ffffff8008b1cdd8:      	movk	w8, #458, lsl #16
ffffff8008b1cddc:      	add	x0, sp, #4
ffffff8008b1cde0:      	mov	w1, #4
ffffff8008b1cde4:      	str	w8, [sp, #4]
ffffff8008b1cde8:      	bl	#-165008 <iWriteRegI2C>
ffffff8008b1cdec:      	ldrb	w2, [x22, #4028]
ffffff8008b1cdf0:      	mov	w8, #31280
ffffff8008b1cdf4:      	movk	w8, #8205, lsl #16
ffffff8008b1cdf8:      	add	x0, sp, #4
ffffff8008b1cdfc:      	mov	w1, #4
ffffff8008b1ce00:      	str	w8, [sp, #4]
ffffff8008b1ce04:      	bl	#-165036 <iWriteRegI2C>
ffffff8008b1ce08:      	ldrb	w2, [x22, #4028]
ffffff8008b1ce0c:      	mov	w8, #40496
ffffff8008b1ce10:      	movk	w8, #11520, lsl #16
ffffff8008b1ce14:      	add	x0, sp, #4
ffffff8008b1ce18:      	mov	w1, #4
ffffff8008b1ce1c:      	str	w8, [sp, #4]
ffffff8008b1ce20:      	bl	#-165064 <iWriteRegI2C>
ffffff8008b1ce24:      	ldrb	w2, [x22, #4028]
ffffff8008b1ce28:      	mov	w8, #29232
ffffff8008b1ce2c:      	movk	w8, #4864, lsl #16
ffffff8008b1ce30:      	add	x0, sp, #4
ffffff8008b1ce34:      	mov	w1, #4
ffffff8008b1ce38:      	str	w8, [sp, #4]
ffffff8008b1ce3c:      	bl	#-165092 <iWriteRegI2C>
ffffff8008b1ce40:      	ldrb	w2, [x22, #4028]
ffffff8008b1ce44:      	mov	w8, #29744
ffffff8008b1ce48:      	movk	w8, #30473, lsl #16
ffffff8008b1ce4c:      	add	x0, sp, #4
ffffff8008b1ce50:      	mov	w1, #4
ffffff8008b1ce54:      	str	w8, [sp, #4]
ffffff8008b1ce58:      	bl	#-165120 <iWriteRegI2C>
ffffff8008b1ce5c:      	ldrb	w2, [x22, #4028]
ffffff8008b1ce60:      	mov	w8, #30256
ffffff8008b1ce64:      	movk	w8, #4500, lsl #16
ffffff8008b1ce68:      	add	x0, sp, #4
ffffff8008b1ce6c:      	mov	w1, #4
ffffff8008b1ce70:      	str	w8, [sp, #4]
ffffff8008b1ce74:      	bl	#-165148 <iWriteRegI2C>
ffffff8008b1ce78:      	ldrb	w2, [x22, #4028]
ffffff8008b1ce7c:      	mov	w8, #9264
ffffff8008b1ce80:      	movk	w8, #5632, lsl #16
ffffff8008b1ce84:      	add	x0, sp, #4
ffffff8008b1ce88:      	mov	w1, #4
ffffff8008b1ce8c:      	str	w8, [sp, #4]
ffffff8008b1ce90:      	bl	#-165176 <iWriteRegI2C>
ffffff8008b1ce94:      	ldrb	w2, [x22, #4028]
ffffff8008b1ce98:      	mov	w8, #28720
ffffff8008b1ce9c:      	movk	w8, #61, lsl #16
ffffff8008b1cea0:      	add	x0, sp, #4
ffffff8008b1cea4:      	mov	w1, #4
ffffff8008b1cea8:      	str	w8, [sp, #4]
ffffff8008b1ceac:      	bl	#-165204 <iWriteRegI2C>
ffffff8008b1ceb0:      	ldrb	w2, [x22, #4028]
ffffff8008b1ceb4:      	mov	w8, #560
ffffff8008b1ceb8:      	movk	w8, #14, lsl #16
ffffff8008b1cebc:      	add	x0, sp, #4
ffffff8008b1cec0:      	mov	w1, #4
ffffff8008b1cec4:      	str	w8, [sp, #4]
ffffff8008b1cec8:      	bl	#-165232 <iWriteRegI2C>
ffffff8008b1cecc:      	ldrb	w2, [x22, #4028]
ffffff8008b1ced0:      	mov	w8, #1584
ffffff8008b1ced4:      	movk	w8, #16, lsl #16
ffffff8008b1ced8:      	add	x0, sp, #4
ffffff8008b1cedc:      	mov	w1, #4
ffffff8008b1cee0:      	str	w8, [sp, #4]
ffffff8008b1cee4:      	bl	#-165260 <iWriteRegI2C>
ffffff8008b1cee8:      	ldrb	w2, [x22, #4028]
ffffff8008b1ceec:      	mov	w8, #2608
ffffff8008b1cef0:      	movk	w8, #12, lsl #16
ffffff8008b1cef4:      	add	x0, sp, #4
ffffff8008b1cef8:      	mov	w1, #4
ffffff8008b1cefc:      	str	w8, [sp, #4]
ffffff8008b1cf00:      	bl	#-165288 <iWriteRegI2C>
ffffff8008b1cf04:      	ldrb	w2, [x22, #4028]
ffffff8008b1cf08:      	mov	w8, #4144
ffffff8008b1cf0c:      	movk	w8, #4, lsl #16
ffffff8008b1cf10:      	add	x0, sp, #4
ffffff8008b1cf14:      	mov	w1, #4
ffffff8008b1cf18:      	str	w8, [sp, #4]
ffffff8008b1cf1c:      	bl	#-165316 <iWriteRegI2C>
ffffff8008b1cf20:      	ldrb	w2, [x22, #4028]
ffffff8008b1cf24:      	mov	w8, #6192
ffffff8008b1cf28:      	movk	w8, #197, lsl #16
ffffff8008b1cf2c:      	add	x0, sp, #4
ffffff8008b1cf30:      	mov	w1, #4
ffffff8008b1cf34:      	str	w8, [sp, #4]
ffffff8008b1cf38:      	bl	#-165344 <iWriteRegI2C>
ffffff8008b1cf3c:      	ldrb	w2, [x22, #4028]
ffffff8008b1cf40:      	mov	w8, #14896
ffffff8008b1cf44:      	movk	w8, #1026, lsl #16
ffffff8008b1cf48:      	add	x0, sp, #4
ffffff8008b1cf4c:      	mov	w1, #4
ffffff8008b1cf50:      	str	w8, [sp, #4]
ffffff8008b1cf54:      	bl	#-165372 <iWriteRegI2C>
ffffff8008b1cf58:      	ldrb	w2, [x22, #4028]
ffffff8008b1cf5c:      	mov	w8, #21044
ffffff8008b1cf60:      	movk	w8, #256, lsl #16
ffffff8008b1cf64:      	add	x0, sp, #4
ffffff8008b1cf68:      	mov	w1, #4
ffffff8008b1cf6c:      	str	w8, [sp, #4]
ffffff8008b1cf70:      	bl	#-165400 <iWriteRegI2C>
ffffff8008b1cf74:      	ldrb	w2, [x22, #4028]
ffffff8008b1cf78:      	mov	w8, #21556
ffffff8008b1cf7c:      	movk	w8, #256, lsl #16
ffffff8008b1cf80:      	add	x0, sp, #4
ffffff8008b1cf84:      	mov	w1, #4
ffffff8008b1cf88:      	str	w8, [sp, #4]
ffffff8008b1cf8c:      	bl	#-165428 <iWriteRegI2C>
ffffff8008b1cf90:      	ldrb	w2, [x22, #4028]
ffffff8008b1cf94:      	mov	w8, #22068
ffffff8008b1cf98:      	movk	w8, #256, lsl #16
ffffff8008b1cf9c:      	add	x0, sp, #4
ffffff8008b1cfa0:      	mov	w1, #4
ffffff8008b1cfa4:      	str	w8, [sp, #4]
ffffff8008b1cfa8:      	bl	#-165456 <iWriteRegI2C>
ffffff8008b1cfac:      	ldrb	w2, [x22, #4028]
ffffff8008b1cfb0:      	mov	w8, #22580
ffffff8008b1cfb4:      	movk	w8, #256, lsl #16
ffffff8008b1cfb8:      	add	x0, sp, #4
ffffff8008b1cfbc:      	mov	w1, #4
ffffff8008b1cfc0:      	str	w8, [sp, #4]
ffffff8008b1cfc4:      	bl	#-165484 <iWriteRegI2C>
ffffff8008b1cfc8:      	ldrb	w2, [x22, #4028]
ffffff8008b1cfcc:      	mov	w8, #23092
ffffff8008b1cfd0:      	movk	w8, #512, lsl #16
ffffff8008b1cfd4:      	add	x0, sp, #4
ffffff8008b1cfd8:      	mov	w1, #4
ffffff8008b1cfdc:      	str	w8, [sp, #4]
ffffff8008b1cfe0:      	bl	#-165512 <iWriteRegI2C>
ffffff8008b1cfe4:      	ldrb	w2, [x22, #4028]
ffffff8008b1cfe8:      	mov	w8, #23604
ffffff8008b1cfec:      	movk	w8, #5120, lsl #16
ffffff8008b1cff0:      	add	x0, sp, #4
ffffff8008b1cff4:      	mov	w1, #4
ffffff8008b1cff8:      	str	w8, [sp, #4]
ffffff8008b1cffc:      	bl	#-165540 <iWriteRegI2C>
ffffff8008b1d000:      	ldrb	w2, [x22, #4028]
ffffff8008b1d004:      	mov	w8, #24116
ffffff8008b1d008:      	movk	w8, #512, lsl #16
ffffff8008b1d00c:      	add	x0, sp, #4
ffffff8008b1d010:      	mov	w1, #4
ffffff8008b1d014:      	str	w8, [sp, #4]
ffffff8008b1d018:      	bl	#-165568 <iWriteRegI2C>
ffffff8008b1d01c:      	ldrb	w2, [x22, #4028]
ffffff8008b1d020:      	mov	w8, #24628
ffffff8008b1d024:      	movk	w8, #5120, lsl #16
ffffff8008b1d028:      	add	x0, sp, #4
ffffff8008b1d02c:      	mov	w1, #4
ffffff8008b1d030:      	str	w8, [sp, #4]
ffffff8008b1d034:      	bl	#-165596 <iWriteRegI2C>
ffffff8008b1d038:      	ldrb	w2, [x22, #4028]
ffffff8008b1d03c:      	mov	w8, #25652
ffffff8008b1d040:      	movk	w8, #1536, lsl #16
ffffff8008b1d044:      	add	x0, sp, #4
ffffff8008b1d048:      	mov	w1, #4
ffffff8008b1d04c:      	str	w8, [sp, #4]
ffffff8008b1d050:      	bl	#-165624 <iWriteRegI2C>
ffffff8008b1d054:      	ldrb	w2, [x22, #4028]
ffffff8008b1d058:      	mov	w8, #26164
ffffff8008b1d05c:      	movk	w8, #4608, lsl #16
ffffff8008b1d060:      	add	x0, sp, #4
ffffff8008b1d064:      	mov	w1, #4
ffffff8008b1d068:      	str	w8, [sp, #4]
ffffff8008b1d06c:      	bl	#-165652 <iWriteRegI2C>
ffffff8008b1d070:      	ldrb	w2, [x22, #4028]
ffffff8008b1d074:      	mov	w8, #26676
ffffff8008b1d078:      	movk	w8, #4608, lsl #16
ffffff8008b1d07c:      	add	x0, sp, #4
ffffff8008b1d080:      	mov	w1, #4
ffffff8008b1d084:      	str	w8, [sp, #4]
ffffff8008b1d088:      	bl	#-165680 <iWriteRegI2C>
ffffff8008b1d08c:      	ldrb	w2, [x22, #4028]
ffffff8008b1d090:      	mov	w8, #27188
ffffff8008b1d094:      	movk	w8, #4608, lsl #16
ffffff8008b1d098:      	add	x0, sp, #4
ffffff8008b1d09c:      	mov	w1, #4
ffffff8008b1d0a0:      	str	w8, [sp, #4]
ffffff8008b1d0a4:      	bl	#-165708 <iWriteRegI2C>
ffffff8008b1d0a8:      	ldrb	w2, [x22, #4028]
ffffff8008b1d0ac:      	mov	w8, #27700
ffffff8008b1d0b0:      	movk	w8, #4608, lsl #16
ffffff8008b1d0b4:      	add	x0, sp, #4
ffffff8008b1d0b8:      	mov	w1, #4
ffffff8008b1d0bc:      	str	w8, [sp, #4]
ffffff8008b1d0c0:      	bl	#-165736 <iWriteRegI2C>
ffffff8008b1d0c4:      	ldrb	w2, [x22, #4028]
ffffff8008b1d0c8:      	mov	w8, #28212
ffffff8008b1d0cc:      	movk	w8, #4608, lsl #16
ffffff8008b1d0d0:      	add	x0, sp, #4
ffffff8008b1d0d4:      	mov	w1, #4
ffffff8008b1d0d8:      	str	w8, [sp, #4]
ffffff8008b1d0dc:      	bl	#-165764 <iWriteRegI2C>
ffffff8008b1d0e0:      	ldrb	w2, [x22, #4028]
ffffff8008b1d0e4:      	mov	w8, #28724
ffffff8008b1d0e8:      	movk	w8, #4608, lsl #16
ffffff8008b1d0ec:      	add	x0, sp, #4
ffffff8008b1d0f0:      	mov	w1, #4
ffffff8008b1d0f4:      	str	w8, [sp, #4]
ffffff8008b1d0f8:      	bl	#-165792 <iWriteRegI2C>
ffffff8008b1d0fc:      	ldrb	w2, [x22, #4028]
ffffff8008b1d100:      	mov	w8, #29236
ffffff8008b1d104:      	movk	w8, #2048, lsl #16
ffffff8008b1d108:      	add	x0, sp, #4
ffffff8008b1d10c:      	mov	w1, #4
ffffff8008b1d110:      	str	w8, [sp, #4]
ffffff8008b1d114:      	bl	#-165820 <iWriteRegI2C>
ffffff8008b1d118:      	ldrb	w2, [x22, #4028]
ffffff8008b1d11c:      	mov	w8, #29748
ffffff8008b1d120:      	movk	w8, #1024, lsl #16
ffffff8008b1d124:      	add	x0, sp, #4
ffffff8008b1d128:      	mov	w1, #4
ffffff8008b1d12c:      	str	w8, [sp, #4]
ffffff8008b1d130:      	bl	#-165848 <iWriteRegI2C>
ffffff8008b1d134:      	ldrb	w2, [x22, #4028]
ffffff8008b1d138:      	mov	w8, #30260
ffffff8008b1d13c:      	movk	w8, #17408, lsl #16
ffffff8008b1d140:      	add	x0, sp, #4
ffffff8008b1d144:      	mov	w1, #4
ffffff8008b1d148:      	str	w8, [sp, #4]
ffffff8008b1d14c:      	bl	#-165876 <iWriteRegI2C>
ffffff8008b1d150:      	ldrb	w2, [x22, #4028]
ffffff8008b1d154:      	mov	w8, #30772
ffffff8008b1d158:      	movk	w8, #1024, lsl #16
ffffff8008b1d15c:      	add	x0, sp, #4
ffffff8008b1d160:      	mov	w1, #4
ffffff8008b1d164:      	str	w8, [sp, #4]
ffffff8008b1d168:      	bl	#-165904 <iWriteRegI2C>
ffffff8008b1d16c:      	ldrb	w2, [x22, #4028]
ffffff8008b1d170:      	mov	w8, #31284
ffffff8008b1d174:      	movk	w8, #17408, lsl #16
ffffff8008b1d178:      	add	x0, sp, #4
ffffff8008b1d17c:      	mov	w1, #4
ffffff8008b1d180:      	str	w8, [sp, #4]
ffffff8008b1d184:      	bl	#-165932 <iWriteRegI2C>
ffffff8008b1d188:      	ldrb	w2, [x22, #4028]
ffffff8008b1d18c:      	mov	w8, #32308
ffffff8008b1d190:      	movk	w8, #1536, lsl #16
ffffff8008b1d194:      	add	x0, sp, #4
ffffff8008b1d198:      	mov	w1, #4
ffffff8008b1d19c:      	str	w8, [sp, #4]
ffffff8008b1d1a0:      	bl	#-165960 <iWriteRegI2C>
ffffff8008b1d1a4:      	ldrb	w2, [x22, #4028]
ffffff8008b1d1a8:      	mov	w8, #32820
ffffff8008b1d1ac:      	movk	w8, #4096, lsl #16
ffffff8008b1d1b0:      	add	x0, sp, #4
ffffff8008b1d1b4:      	mov	w1, #4
ffffff8008b1d1b8:      	str	w8, [sp, #4]
ffffff8008b1d1bc:      	bl	#-165988 <iWriteRegI2C>
ffffff8008b1d1c0:      	ldrb	w2, [x22, #4028]
ffffff8008b1d1c4:      	mov	w8, #33332
ffffff8008b1d1c8:      	movk	w8, #4096, lsl #16
ffffff8008b1d1cc:      	add	x0, sp, #4
ffffff8008b1d1d0:      	mov	w1, #4
ffffff8008b1d1d4:      	str	w8, [sp, #4]
ffffff8008b1d1d8:      	bl	#-166016 <iWriteRegI2C>
ffffff8008b1d1dc:      	ldrb	w2, [x22, #4028]
ffffff8008b1d1e0:      	mov	w8, #33844
ffffff8008b1d1e4:      	movk	w8, #4096, lsl #16
ffffff8008b1d1e8:      	add	x0, sp, #4
ffffff8008b1d1ec:      	mov	w1, #4
ffffff8008b1d1f0:      	str	w8, [sp, #4]
ffffff8008b1d1f4:      	bl	#-166044 <iWriteRegI2C>
ffffff8008b1d1f8:      	ldrb	w2, [x22, #4028]
ffffff8008b1d1fc:      	mov	w8, #34356
ffffff8008b1d200:      	movk	w8, #4096, lsl #16
ffffff8008b1d204:      	add	x0, sp, #4
ffffff8008b1d208:      	mov	w1, #4
ffffff8008b1d20c:      	str	w8, [sp, #4]
ffffff8008b1d210:      	bl	#-166072 <iWriteRegI2C>
ffffff8008b1d214:      	ldrb	w2, [x22, #4028]
ffffff8008b1d218:      	mov	w8, #34868
ffffff8008b1d21c:      	movk	w8, #4096, lsl #16
ffffff8008b1d220:      	add	x0, sp, #4
ffffff8008b1d224:      	mov	w1, #4
ffffff8008b1d228:      	str	w8, [sp, #4]
ffffff8008b1d22c:      	bl	#-166100 <iWriteRegI2C>
ffffff8008b1d230:      	ldrb	w2, [x22, #4028]
ffffff8008b1d234:      	mov	w8, #35380
ffffff8008b1d238:      	movk	w8, #4096, lsl #16
ffffff8008b1d23c:      	add	x0, sp, #4
ffffff8008b1d240:      	mov	w1, #4
ffffff8008b1d244:      	str	w8, [sp, #4]
ffffff8008b1d248:      	bl	#-166128 <iWriteRegI2C>
ffffff8008b1d24c:      	ldrb	w2, [x22, #4028]
ffffff8008b1d250:      	mov	w8, #36404
ffffff8008b1d254:      	movk	w8, #3072, lsl #16
ffffff8008b1d258:      	add	x0, sp, #4
ffffff8008b1d25c:      	mov	w1, #4
ffffff8008b1d260:      	str	w8, [sp, #4]
ffffff8008b1d264:      	bl	#-166156 <iWriteRegI2C>
ffffff8008b1d268:      	ldrb	w2, [x22, #4028]
ffffff8008b1d26c:      	mov	w8, #36916
ffffff8008b1d270:      	movk	w8, #19456, lsl #16
ffffff8008b1d274:      	add	x0, sp, #4
ffffff8008b1d278:      	mov	w1, #4
ffffff8008b1d27c:      	str	w8, [sp, #4]
ffffff8008b1d280:      	bl	#-166184 <iWriteRegI2C>
ffffff8008b1d284:      	ldrb	w2, [x22, #4028]
ffffff8008b1d288:      	mov	w8, #37428
ffffff8008b1d28c:      	movk	w8, #3072, lsl #16
ffffff8008b1d290:      	add	x0, sp, #4
ffffff8008b1d294:      	mov	w1, #4
ffffff8008b1d298:      	str	w8, [sp, #4]
ffffff8008b1d29c:      	bl	#-166212 <iWriteRegI2C>
ffffff8008b1d2a0:      	ldrb	w2, [x22, #4028]
ffffff8008b1d2a4:      	mov	w8, #37940
ffffff8008b1d2a8:      	movk	w8, #19456, lsl #16
ffffff8008b1d2ac:      	add	x0, sp, #4
ffffff8008b1d2b0:      	mov	w1, #4
ffffff8008b1d2b4:      	str	w8, [sp, #4]
ffffff8008b1d2b8:      	bl	#-166240 <iWriteRegI2C>
ffffff8008b1d2bc:      	ldrb	w2, [x22, #4028]
ffffff8008b1d2c0:      	mov	w8, #38452
ffffff8008b1d2c4:      	movk	w8, #8192, lsl #16
ffffff8008b1d2c8:      	add	x0, sp, #4
ffffff8008b1d2cc:      	mov	w1, #4
ffffff8008b1d2d0:      	str	w8, [sp, #4]
ffffff8008b1d2d4:      	bl	#-166268 <iWriteRegI2C>
ffffff8008b1d2d8:      	ldrb	w2, [x22, #4028]
ffffff8008b1d2dc:      	mov	w8, #38964
ffffff8008b1d2e0:      	movk	w8, #1536, lsl #16
ffffff8008b1d2e4:      	add	x0, sp, #4
ffffff8008b1d2e8:      	mov	w1, #4
ffffff8008b1d2ec:      	str	w8, [sp, #4]
ffffff8008b1d2f0:      	bl	#-166296 <iWriteRegI2C>
ffffff8008b1d2f4:      	ldrb	w2, [x22, #4028]
ffffff8008b1d2f8:      	mov	w8, #39476
ffffff8008b1d2fc:      	movk	w8, #2048, lsl #16
ffffff8008b1d300:      	add	x0, sp, #4
ffffff8008b1d304:      	mov	w1, #4
ffffff8008b1d308:      	str	w8, [sp, #4]
ffffff8008b1d30c:      	bl	#-166324 <iWriteRegI2C>
ffffff8008b1d310:      	ldrb	w2, [x22, #4028]
ffffff8008b1d314:      	mov	w8, #39988
ffffff8008b1d318:      	movk	w8, #2048, lsl #16
ffffff8008b1d31c:      	add	x0, sp, #4
ffffff8008b1d320:      	mov	w1, #4
ffffff8008b1d324:      	str	w8, [sp, #4]
ffffff8008b1d328:      	bl	#-166352 <iWriteRegI2C>
ffffff8008b1d32c:      	ldrb	w2, [x22, #4028]
ffffff8008b1d330:      	mov	w8, #40500
ffffff8008b1d334:      	movk	w8, #2048, lsl #16
ffffff8008b1d338:      	add	x0, sp, #4
ffffff8008b1d33c:      	mov	w1, #4
ffffff8008b1d340:      	str	w8, [sp, #4]
ffffff8008b1d344:      	bl	#-166380 <iWriteRegI2C>
ffffff8008b1d348:      	ldrb	w2, [x22, #4028]
ffffff8008b1d34c:      	mov	w8, #41012
ffffff8008b1d350:      	movk	w8, #2048, lsl #16
ffffff8008b1d354:      	add	x0, sp, #4
ffffff8008b1d358:      	mov	w1, #4
ffffff8008b1d35c:      	str	w8, [sp, #4]
ffffff8008b1d360:      	bl	#-166408 <iWriteRegI2C>
ffffff8008b1d364:      	ldrb	w2, [x22, #4028]
ffffff8008b1d368:      	mov	w8, #41524
ffffff8008b1d36c:      	movk	w8, #2048, lsl #16
ffffff8008b1d370:      	add	x0, sp, #4
ffffff8008b1d374:      	mov	w1, #4
ffffff8008b1d378:      	str	w8, [sp, #4]
ffffff8008b1d37c:      	bl	#-166436 <iWriteRegI2C>
ffffff8008b1d380:      	ldrb	w2, [x22, #4028]
ffffff8008b1d384:      	mov	w8, #42036
ffffff8008b1d388:      	movk	w8, #2048, lsl #16
ffffff8008b1d38c:      	add	x0, sp, #4
ffffff8008b1d390:      	mov	w1, #4
ffffff8008b1d394:      	str	w8, [sp, #4]
ffffff8008b1d398:      	bl	#-166464 <iWriteRegI2C>
ffffff8008b1d39c:      	ldrb	w2, [x22, #4028]
ffffff8008b1d3a0:      	mov	w8, #43060
ffffff8008b1d3a4:      	movk	w8, #6656, lsl #16
ffffff8008b1d3a8:      	add	x0, sp, #4
ffffff8008b1d3ac:      	mov	w1, #4
ffffff8008b1d3b0:      	str	w8, [sp, #4]
ffffff8008b1d3b4:      	bl	#-166492 <iWriteRegI2C>
ffffff8008b1d3b8:      	ldrb	w2, [x22, #4028]
ffffff8008b1d3bc:      	mov	w8, #43572
ffffff8008b1d3c0:      	movk	w8, #10752, lsl #16
ffffff8008b1d3c4:      	add	x0, sp, #4
ffffff8008b1d3c8:      	mov	w1, #4
ffffff8008b1d3cc:      	str	w8, [sp, #4]
ffffff8008b1d3d0:      	bl	#-166520 <iWriteRegI2C>
ffffff8008b1d3d4:      	ldrb	w2, [x22, #4028]
ffffff8008b1d3d8:      	mov	w8, #44084
ffffff8008b1d3dc:      	movk	w8, #6656, lsl #16
ffffff8008b1d3e0:      	add	x0, sp, #4
ffffff8008b1d3e4:      	mov	w1, #4
ffffff8008b1d3e8:      	str	w8, [sp, #4]
ffffff8008b1d3ec:      	bl	#-166548 <iWriteRegI2C>
ffffff8008b1d3f0:      	ldrb	w2, [x22, #4028]
ffffff8008b1d3f4:      	mov	w8, #44596
ffffff8008b1d3f8:      	movk	w8, #10752, lsl #16
ffffff8008b1d3fc:      	add	x0, sp, #4
ffffff8008b1d400:      	mov	w1, #4
ffffff8008b1d404:      	str	w8, [sp, #4]
ffffff8008b1d408:      	bl	#-166576 <iWriteRegI2C>
ffffff8008b1d40c:      	ldrb	w2, [x22, #4028]
ffffff8008b1d410:      	mov	w8, #45108
ffffff8008b1d414:      	movk	w8, #32768, lsl #16
ffffff8008b1d418:      	add	x0, sp, #4
ffffff8008b1d41c:      	mov	w1, #4
ffffff8008b1d420:      	str	w8, [sp, #4]
ffffff8008b1d424:      	bl	#-166604 <iWriteRegI2C>
ffffff8008b1d428:      	ldrb	w2, [x22, #4028]
ffffff8008b1d42c:      	mov	w8, #45620
ffffff8008b1d430:      	movk	w8, #1536, lsl #16
ffffff8008b1d434:      	add	x0, sp, #4
ffffff8008b1d438:      	mov	w1, #4
ffffff8008b1d43c:      	str	w8, [sp, #4]
ffffff8008b1d440:      	bl	#-166632 <iWriteRegI2C>
ffffff8008b1d444:      	ldrb	w2, [x22, #4028]
ffffff8008b1d448:      	mov	w8, #41522
ffffff8008b1d44c:      	add	x0, sp, #4
ffffff8008b1d450:      	mov	w1, #4
ffffff8008b1d454:      	str	w8, [sp, #4]
ffffff8008b1d458:      	bl	#-166656 <iWriteRegI2C>
ffffff8008b1d45c:      	ldrb	w2, [x22, #4028]
ffffff8008b1d460:      	mov	w8, #42034
ffffff8008b1d464:      	add	x0, sp, #4
ffffff8008b1d468:      	mov	w1, #4
ffffff8008b1d46c:      	str	w8, [sp, #4]
ffffff8008b1d470:      	bl	#-166680 <iWriteRegI2C>
ffffff8008b1d474:      	ldrb	w2, [x22, #4028]
ffffff8008b1d478:      	mov	w8, #42546
ffffff8008b1d47c:      	add	x0, sp, #4
ffffff8008b1d480:      	mov	w1, #4
ffffff8008b1d484:      	str	w8, [sp, #4]
ffffff8008b1d488:      	bl	#-166704 <iWriteRegI2C>
ffffff8008b1d48c:      	ldrb	w2, [x22, #4028]
ffffff8008b1d490:      	mov	w8, #43058
ffffff8008b1d494:      	add	x0, sp, #4
ffffff8008b1d498:      	mov	w1, #4
ffffff8008b1d49c:      	str	w8, [sp, #4]
ffffff8008b1d4a0:      	bl	#-166728 <iWriteRegI2C>
ffffff8008b1d4a4:      	ldrb	w2, [x22, #4028]
ffffff8008b1d4a8:      	add	x0, sp, #4
ffffff8008b1d4ac:      	mov	w1, #4
ffffff8008b1d4b0:      	str	w20, [sp, #4]
ffffff8008b1d4b4:      	bl	#-166748 <iWriteRegI2C>
ffffff8008b1d4b8:      	adrp	x19, #28520448
ffffff8008b1d4bc:      	add	x19, x19, #1572
ffffff8008b1d4c0:      	mov	x0, x19
ffffff8008b1d4c4:      	bl	#8571736 <_raw_spin_lock>
ffffff8008b1d4c8:      	adrp	x9, #28520448
ffffff8008b1d4cc:      	strb	w20, [x9, #1608]
ffffff8008b1d4d0:      	adrp	x9, #28520448
ffffff8008b1d4d4:      	strb	w20, [x9, #1664]
ffffff8008b1d4d8:      	adrp	x9, #28520448
ffffff8008b1d4dc:      	mov	w10, #3260
ffffff8008b1d4e0:      	str	w10, [x9, #1636]
ffffff8008b1d4e4:      	adrp	x9, #28520448
ffffff8008b1d4e8:      	adrp	x8, #28520448
ffffff8008b1d4ec:      	str	w10, [x9, #1692]
ffffff8008b1d4f0:      	adrp	x9, #28528640
ffffff8008b1d4f4:      	adrp	x10, #28528640
ffffff8008b1d4f8:      	strb	wzr, [x8, #1712]
ffffff8008b1d4fc:      	adrp	x8, #28528640
ffffff8008b1d500:      	strh	wzr, [x9, #3240]
ffffff8008b1d504:      	mov	w9, #300
ffffff8008b1d508:      	mov	x0, x19
ffffff8008b1d50c:      	strb	wzr, [x10, #3264]
ffffff8008b1d510:      	strh	w9, [x8, #3256]
ffffff8008b1d514:      	bl	#8571944 <_raw_spin_unlock>
ffffff8008b1d518:      	mov	w0, wzr
ffffff8008b1d51c:      	adrp	x9, #22626304
ffffff8008b1d520:      	ldr	x8, [sp, #8]
ffffff8008b1d524:      	ldr	x9, [x9, #4088]
ffffff8008b1d528:      	cmp	x9, x8
ffffff8008b1d52c:      	b.ne	#36 <open$abb3d18ce96cf025cc17a76c06f66f80+0x9c4>
ffffff8008b1d530:      	ldp	x20, x19, [sp, #96]
ffffff8008b1d534:      	ldp	x22, x21, [sp, #80]
ffffff8008b1d538:      	ldp	x24, x23, [sp, #64]
ffffff8008b1d53c:      	ldp	x26, x25, [sp, #48]
ffffff8008b1d540:      	ldr	x27, [sp, #32]
ffffff8008b1d544:      	ldp	x29, x30, [sp, #16]
ffffff8008b1d548:      	add	sp, sp, #112
ffffff8008b1d54c:      	ret
ffffff8008b1d550:      	bl	#-9484440 <__stack_chk_fail>
