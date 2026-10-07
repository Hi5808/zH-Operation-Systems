
format ELF64-aarch64-little


tion .kernel:

eature_control$abb3d18ce96cf025cc17a76c06f66f80:
     	sub	sp, sp, #80
     	stp	x29, x30, [sp, #16]
     	stp	x24, x23, [sp, #32]
     	stp	x22, x21, [sp, #48]
     	stp	x20, x19, [sp, #64]
     	add	x29, sp, #16
     	adrp	x8, #22626304
     	ldr	x8, [x8, #4088]
     	mov	w21, w0
     	adrp	x0, #13344768
     	mov	x19, x1
     	add	x0, x0, #3629
     	mov	w1, w21
     	mov	x20, x2
     	str	x8, [sp, #8]
     	bl	#-8844216 <printk>
     	sub	w8, w21, #3002
     	cmp	w8, #136
     	b.hi	#3764 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	adrp	x9, #14864384
     	add	x9, x9, #2216
     	adr	x10, #16
     	ldrh	w11, [x9, x8, lsl #1]
     	add	x10, x10, x11, lsl #2
     	br	x10
     	adrp	x8, #28520448
     	ldrb	w8, [x8, #1664]
     	mov	w9, #4896
     	adrp	x10, #28520448
     	cmp	w8, #0
     	csel	w8, w9, wzr, ne
     	strh	w8, [x19]
     	ldr	w8, [x10, #1636]
     	mov	w9, #4
     	strh	w8, [x19, #2]
     	str	w9, [x20]
     	b	#3692 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	adrp	x8, #28520448
     	ldrb	w8, [x8, #1608]
     	mov	w9, #14336
     	movk	w9, #7324, lsl #16
     	mov	w10, #4
     	cmp	w8, #0
     	csel	w8, w9, wzr, ne
     	str	w8, [x19]
     	str	w10, [x20]
     	b	#3652 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	ldr	w21, [x19]
     	adrp	x19, #28520448
     	add	x19, x19, #1572
     	mov	x0, x19
     	bl	#8571160 <_raw_spin_lock_irqsave>
     	mov	x1, x0
     	and	w23, w21, #0xffff
     	adrp	x8, #23580672
     	mov	x0, x19
     	str	w23, [x8, #3224]
     	bl	#8571424 <_raw_spin_unlock_irqrestore>
     	mov	x0, x19
     	bl	#8571060 <_raw_spin_lock>
     	adrp	x22, #28520448
     	ldr	w8, [x22, #1692]
     	add	w9, w23, #5
     	mov	w10, #65535
     	adrp	x20, #28520448
     	sub	w11, w8, #5
     	cmp	w11, w23
     	csel	w8, w9, w8, lo
     	cmp	w8, w10
     	csel	w8, w8, w10, lo
     	mov	x0, x19
     	str	w8, [x20, #1636]
     	bl	#8571296 <_raw_spin_unlock>
     	adrp	x10, #28520448
     	ldrb	w10, [x10, #1712]
     	cmp	w23, #4
     	mov	w8, #4
     	mov	w9, #65530
     	csel	w8, w21, w8, hi
     	cmp	w9, w8, uxth
     	mov	w9, #-6
     	csel	w21, w8, w9, hi
     	cmp	w10, #1
     	b.ne	#2000 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x91c>
     	adrp	x19, #28520448
     	ldrb	w9, [x19, #1608]
     	ldr	w8, [x20, #1636]
     	cmp	w9, #0
     	mov	w9, #62886
     	movk	w9, #14, lsl #16
     	csel	w9, w9, wzr, ne
     	udiv	w9, w9, w8
     	and	w9, w9, #0xffff
     	sub	w10, w9, #297
     	cmp	w10, #8
     	b.hi	#2304 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xa7c>
     	adrp	x0, #13828096
     	add	x0, x0, #868
     	mov	w1, #296
     	mov	w2, wzr
     	bl	#-8844556 <printk>
     	ldrb	w8, [x19, #1608]
     	cmp	w8, #0
     	mov	w8, #3312
     	b	#2312 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xaa8>
     	ldrh	w0, [x19]
     	bl	#9148 <set_gain>
     	b	#3408 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	ldp	w8, w9, [x19]
     	adrp	x10, #23584768
     	ldrb	w2, [x10, #4028]
     	lsr	w10, w8, #8
     	strb	w8, [sp, #1]
     	lsr	w8, w9, #8
     	strb	w10, [sp]
     	strb	w8, [sp, #2]
     	strb	w9, [sp, #3]
     	b	#3356 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xef0>
     	ldrh	w8, [x19]
     	adrp	x9, #23584768
     	ldrb	w4, [x9, #4028]
     	add	x0, sp, #4
     	rev	w8, w8
     	lsr	w8, w8, #16
     	mov	x2, sp
     	mov	w1, #2
     	mov	w3, #1
     	strh	wzr, [sp]
     	strh	w8, [sp, #4]
     	bl	#-169220 <iReadRegI2C>
     	ldrh	w8, [sp]
     	str	w8, [x19, #4]
     	b	#3308 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	mov	w8, #-1
     	b	#1540 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x81c>
     	ldr	w20, [x19]
     	adrp	x0, #12464128
     	add	x0, x0, #1754
     	and	w19, w20, #0xffff
     	mov	w1, w19
     	bl	#-8844716 <printk>
     	cbz	w19, #3272 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	adrp	x0, #28520448
     	add	x0, x0, #1572
     	bl	#8570720 <_raw_spin_lock>
     	cmp	w19, #150
     	b.eq	#2432 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xbc8>
     	cmp	w19, #300
     	b.ne	#2440 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xbd8>
     	adrp	x8, #28520448
     	ldrb	w8, [x8, #1712]
     	tbz	w8, #0, #2428 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xbd8>
     	mov	w20, #296
     	b	#2420 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xbd8>
     	adrp	x20, #28520448
     	add	x20, x20, #1572
     	mov	x0, x20
     	bl	#8570668 <_raw_spin_lock>
     	adrp	x21, #23584768
     	mov	w8, #90
     	mov	x0, x20
     	strb	w8, [x21, #4028]
     	bl	#8570936 <_raw_spin_unlock>
     	ldrb	w4, [x21, #4028]
     	add	x0, sp, #4
     	mov	x2, sp
     	mov	w1, #2
     	mov	w3, #1
     	strh	wzr, [sp]
     	strh	wzr, [sp, #4]
     	bl	#-169384 <iReadRegI2C>
     	ldrb	w4, [x21, #4028]
     	ldrh	w22, [sp]
     	mov	w20, #256
     	add	x0, sp, #4
     	mov	x2, sp
     	mov	w1, #2
     	mov	w3, #1
     	strh	wzr, [sp]
     	strh	w20, [sp, #4]
     	bl	#-169424 <iReadRegI2C>
     	ldrh	w8, [sp]
     	mov	w23, #12486
     	orr	w2, w8, w22, lsl #8
     	cmp	w2, w23
     	adrp	x22, #33239040
     	str	w2, [x19]
     	b.ne	#12 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x2f8>
     	ldr	w8, [x22, #3232]
     	cbz	w8, #276 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x408>
     	ldrb	w1, [x21, #4028]
     	adrp	x0, #13549568
     	add	x0, x0, #2126
     	mov	w3, #12486
     	bl	#-8844932 <printk>
     	ldrb	w4, [x21, #4028]
     	add	x0, sp, #4
     	mov	x2, sp
     	mov	w1, #2
     	mov	w3, #1
     	strh	wzr, [sp]
     	strh	wzr, [sp, #4]
     	bl	#-169512 <iReadRegI2C>
     	ldrb	w4, [x21, #4028]
     	ldrh	w24, [sp]
     	add	x0, sp, #4
     	mov	x2, sp
     	mov	w1, #2
     	mov	w3, #1
     	strh	wzr, [sp]
     	strh	w20, [sp, #4]
     	bl	#-169548 <iReadRegI2C>
     	ldrh	w8, [sp]
     	orr	w2, w8, w24, lsl #8
     	cmp	w2, w23
     	str	w2, [x19]
     	b.ne	#12 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x36c>
     	ldr	w8, [x22, #3232]
     	cbz	w8, #160 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x408>
     	ldrb	w1, [x21, #4028]
     	adrp	x0, #13549568
     	add	x0, x0, #2126
     	mov	w3, #12486
     	mov	w23, #12486
     	bl	#-8845052 <printk>
     	adrp	x20, #28520448
     	add	x20, x20, #1572
     	mov	x0, x20
     	bl	#8570384 <_raw_spin_lock>
     	mov	w8, #32
     	mov	x0, x20
     	strb	w8, [x21, #4028]
     	bl	#8570656 <_raw_spin_unlock>
     	ldrb	w4, [x21, #4028]
     	add	x0, sp, #4
     	mov	x2, sp
     	mov	w1, #2
     	mov	w3, #1
     	strh	wzr, [sp]
     	strh	wzr, [sp, #4]
     	bl	#-169664 <iReadRegI2C>
     	ldrb	w4, [x21, #4028]
     	ldrh	w20, [sp]
     	mov	w8, #256
     	add	x0, sp, #4
     	mov	x2, sp
     	mov	w1, #2
     	mov	w3, #1
     	strh	wzr, [sp]
     	strh	w8, [sp, #4]
     	bl	#-169704 <iReadRegI2C>
     	ldrh	w8, [sp]
     	orr	w2, w8, w20, lsl #8
     	cmp	w2, w23
     	str	w2, [x19]
     	b.ne	#2876 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xf38>
     	ldr	w8, [x22, #3232]
     	cbnz	w8, #2868 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xf38>
     	ldrb	w1, [x21, #4028]
     	adrp	x0, #13549568
     	add	x0, x0, #1916
     	mov	w2, #12486
     	mov	w3, #12486
     	bl	#-8845208 <printk>
     	b	#2780 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	ldrb	w8, [x19]
     	ldrh	w2, [x19, #2]
     	adrp	x0, #13824000
     	add	x0, x0, #3447
     	cmp	w8, #0
     	cset	w19, ne
     	mov	w1, w19
     	bl	#-8845244 <printk>
     	adrp	x20, #28520448
     	add	x20, x20, #1572
     	mov	x0, x20
     	bl	#8570192 <_raw_spin_lock>
     	adrp	x8, #28520448
     	strb	w19, [x8, #1712]
     	b	#696 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x714>
     	ldrb	w19, [x19]
     	adrp	x0, #13381632
     	add	x0, x0, #81
     	cmp	w19, #0
     	cset	w1, ne
     	bl	#-8845296 <printk>
     	mov	w8, #562
     	strh	w8, [sp]
     	strb	wzr, [sp, #2]
     	cbz	w19, #1200 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x934>
     	adrp	x19, #23584768
     	ldrb	w2, [x19, #4028]
     	mov	w8, #128
     	mov	x0, sp
     	mov	w1, #4
     	strb	w8, [sp, #3]
     	bl	#-168388 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #1074
     	movk	w8, #32768, lsl #16
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-168416 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #1586
     	movk	w8, #32768, lsl #16
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-168444 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #2098
     	movk	w8, #32768, lsl #16
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-168472 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #12850
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-168496 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #13362
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-168520 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #41010
     	movk	w8, #1, lsl #16
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-168548 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #51
     	movk	w8, #256, lsl #16
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-168576 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #52
     	movk	w8, #256, lsl #16
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-168604 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #564
     	movk	w8, #78, lsl #16
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-168632 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #26674
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-168656 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #6
     	movk	w8, #512, lsl #16
     	b	#1160 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xa44>
     	ldr	w20, [x19]
     	ldr	w19, [x19, #8]
     	adrp	x0, #13340672
     	add	x0, x0, #3780
     	mov	w1, w20
     	mov	w2, w19
     	bl	#-8845652 <printk>
     	cmp	w20, #4
     	b.hi	#1804 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xcec>
     	adrp	x8, #14864384
     	add	x8, x8, #2508
     	adr	x9, #16
     	ldrh	w10, [x8, x20, lsl #1]
     	add	x9, x9, x10, lsl #2
     	br	x9
     	mov	w8, #14336
     	movk	w8, #7324, lsl #16
     	udiv	w8, w8, w19
     	add	w8, w8, w8, lsl #2
     	lsl	w22, w8, #1
     	mov	w8, #32983
     	adrp	x19, #28520448
     	movk	w8, #54827, lsl #16
     	add	x19, x19, #1572
     	umull	x8, w22, w8
     	mov	x0, x19
     	lsr	x20, x8, #44
     	bl	#8569716 <_raw_spin_lock>
     	mov	w9, #40607
     	movk	w9, #243, lsl #16
     	sub	w8, w20, #3260
     	cmp	w22, w9
     	adrp	x21, #28528640
     	csel	w8, w8, wzr, hi
     	strh	w8, [x21, #3240]
     	and	w8, w8, #0xffff
     	adrp	x20, #28520448
     	adrp	x10, #28520448
     	add	w8, w8, #3260
     	b	#2052 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xe60>
     	ldr	w20, [x19]
     	ldr	x19, [x19, #8]
     	adrp	x0, #13344768
     	add	x0, x0, #3224
     	mov	w1, w20
     	bl	#-8845808 <printk>
     	cmp	w20, #4
     	b.hi	#2176 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	adrp	x8, #14864384
     	add	x8, x8, #2498
     	adr	x9, #16
     	ldrh	w10, [x8, x20, lsl #1]
     	add	x9, x9, x10, lsl #2
     	br	x9
     	mov	w8, #300
     	str	w8, [x19]
     	b	#2140 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	mov	w8, #20129
     	movk	w8, #17522, lsl #16
     	b	#368 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x81c>
     	ldr	w1, [x19]
     	adrp	x0, #13238272
     	add	x0, x0, #1018
     	bl	#-8845880 <printk>
     	adrp	x20, #28520448
     	add	x20, x20, #1572
     	mov	x0, x20
     	bl	#8569556 <_raw_spin_lock>
     	ldr	x8, [x19]
     	adrp	x9, #28528640
     	strh	w8, [x9, #3256]
     	b	#56 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x714>
     	ldrb	w1, [x19]
     	adrp	x0, #13238272
     	add	x0, x0, #1358
     	bl	#-8845928 <printk>
     	adrp	x20, #28520448
     	add	x20, x20, #1572
     	mov	x0, x20
     	bl	#8569508 <_raw_spin_lock>
     	ldrb	w8, [x19]
     	adrp	x9, #28528640
     	cmp	w8, #0
     	cset	w8, ne
     	strb	w8, [x9, #3264]
     	mov	x0, x20
     	bl	#8569768 <_raw_spin_unlock>
     	b	#2016 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	ldr	w9, [x19]
     	ldr	x8, [x19, #8]
     	sub	w9, w9, #1
     	cmp	w9, #3
     	b.hi	#1404 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xcac>
     	adrp	x10, #14864384
     	add	x10, x10, #2490
     	adr	x11, #16
     	ldrh	w12, [x10, x9, lsl #1]
     	add	x11, x11, x12, lsl #2
     	br	x11
     	adrp	x9, #14860288
     	add	x9, x9, #2084
     	b	#1412 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xcd8>
     	ldrh	w1, [x19]
     	ldrh	w2, [x19, #8]
     	ldrh	w3, [x19, #16]
     	adrp	x0, #13160448
     	add	x0, x0, #1588
     	bl	#-8846056 <printk>
     	ldrh	w21, [x19]
     	ldr	x20, [x19, #16]
     	ldrh	w2, [x19, #8]
     	adrp	x0, #12562432
     	add	x0, x0, #3559
     	and	w3, w20, #0xffff
     	mov	w1, w21
     	bl	#-8846088 <printk>
     	adrp	x8, #28528640
     	ldrb	w8, [x8, #3264]
     	cbz	w8, #1892 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	adrp	x19, #28520448
     	add	x19, x19, #1572
     	mov	x0, x19
     	bl	#8569336 <_raw_spin_lock>
     	adrp	x8, #28520448
     	ldr	w8, [x8, #1692]
     	add	w9, w21, #5
     	mov	w10, #65535
     	mov	x0, x19
     	sub	w11, w8, #5
     	cmp	w11, w21
     	csel	w8, w9, w8, lo
     	cmp	w8, w10
     	csel	w8, w8, w10, lo
     	adrp	x9, #28520448
     	str	w8, [x9, #1636]
     	bl	#8569572 <_raw_spin_unlock>
     	mov	w0, w20
     	bl	#7552 <set_gain>
     	b	#1812 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	ldr	x1, [x19]
     	adrp	x0, #13053952
     	add	x0, x0, #922
     	bl	#-8846196 <printk>
     	mov	w8, #1
     	b	#28 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x81c>
     	ldr	x1, [x19]
     	adrp	x0, #13053952
     	add	x0, x0, #1037
     	bl	#-8846220 <printk>
     	adrp	x8, #23584768
     	ldr	w8, [x8, #4036]
     	mov	w9, #4
     	str	w8, [x19]
     	str	w9, [x20]
     	b	#1748 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	ldr	x1, [x19]
     	adrp	x0, #13053952
     	add	x0, x0, #984
     	bl	#-8846260 <printk>
     	ldr	w1, [x19]
     	adrp	x0, #13344768
     	adrp	x8, #23584768
     	add	x0, x0, #1923
     	str	w1, [x8, #4036]
     	bl	#-8846284 <printk>
     	b	#1704 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	ldr	x8, [x19]
     	cmp	x8, #3
     	b.eq	#16 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x870>
     	cmp	x8, #2
     	b.eq	#8 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x870>
     	cmp	x8, #1
     	ldr	x8, [x19, #8]
     	mov	w9, #14336
     	movk	w9, #7324, lsl #16
     	str	w9, [x8]
     	b	#1660 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	ldr	x8, [x19]
     	cmp	x8, #3
     	b.eq	#808 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xbb4>
     	cmp	x8, #2
     	b.eq	#8 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x89c>
     	cmp	x8, #1
     	ldr	x8, [x19, #8]
     	mov	w9, #4896
     	movk	w9, #3260, lsl #16
     	str	w9, [x8]
     	b	#1616 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	mov	w8, #64
     	mov	w9, #1024
     	b	#76 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x904>
     	mov	w8, #100
     	mov	w9, #1
     	mov	w10, #2
     	stp	x8, x9, [x19]
     	str	x10, [x19, #16]
     	b	#1580 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	mov	w8, #4
     	str	x8, [x19, #8]
     	b	#1568 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	ldr	x0, [x19, #8]
     	cbz	x0, #396 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xa70>
     	adrp	x1, #14864384
     	add	x1, x1, #2524
     	mov	w2, #3844
     	bl	#-11093552 <memcpy>
     	b	#1540 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	mov	w8, #1
     	mov	w9, #5
     	stp	x8, x9, [x19, #8]
     	b	#1524 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	ldr	x8, [x19, #8]
     	mov	w9, #1
     	str	w9, [x8]
     	b	#1508 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	ldr	w8, [x20, #1636]
     	adrp	x10, #23584768
     	ldrb	w2, [x10, #4028]
     	mov	w9, #16387
     	strh	w9, [sp]
     	b	#552 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xb58>
     	adrp	x19, #23584768
     	ldrb	w2, [x19, #4028]
     	mov	x0, sp
     	mov	w1, #4
     	strb	wzr, [sp, #3]
     	bl	#-169580 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #1074
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-169604 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #1586
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-169628 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #2098
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-169652 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #12850
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-169676 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #13362
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-169700 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #41010
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-169724 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #51
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-169748 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #52
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-169772 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #564
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-169796 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #26674
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-169820 <iWriteRegI2C>
     	ldrb	w2, [x19, #4028]
     	mov	w8, #6
     	mov	x0, sp
     	mov	w1, #4
     	str	w8, [sp]
     	bl	#-169844 <iWriteRegI2C>
     	adrp	x19, #28516352
     	add	x19, x19, #1572
     	mov	x0, x19
     	bl	#8568640 <_raw_spin_lock>
     	mov	x0, x19
     	bl	#8568920 <_raw_spin_unlock>
     	b	#1168 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	mov	w8, #3844
     	str	x8, [x19]
     	b	#1156 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	sub	w9, w9, #147
     	cmp	w9, #3
     	b.hi	#-356 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x920>
     	adrp	x0, #13824000
     	add	x0, x0, #868
     	mov	w1, #146
     	mov	w2, wzr
     	bl	#-8846868 <printk>
     	ldrb	w8, [x19, #1608]
     	cmp	w8, #0
     	mov	w8, #6715
     	adrp	x0, #28516352
     	add	x0, x0, #1572
     	csel	w23, w8, wzr, ne
     	bl	#8568556 <_raw_spin_lock>
     	ldr	w8, [x22, #1692]
     	adrp	x19, #28524544
     	cmp	w23, w8
     	csel	w9, w23, w8, hi
     	sub	w10, w9, w8
     	cmp	w9, #16, lsl #12
     	str	w9, [x20, #1636]
     	strh	w10, [x19, #3240]
     	b.lo	#20 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xaec>
     	mov	w9, #65535
     	mvn	w8, w8
     	str	w9, [x20, #1636]
     	strh	w8, [x19, #3240]
     	adrp	x0, #28516352
     	add	x0, x0, #1572
     	bl	#8568780 <_raw_spin_unlock>
     	ldrh	w1, [x19, #3240]
     	adrp	x0, #13819904
     	add	x0, x0, #3302
     	mov	w2, wzr
     	bl	#-8846980 <printk>
     	ldr	w8, [x20, #1636]
     	adrp	x19, #23580672
     	ldrb	w2, [x19, #4028]
     	mov	w9, #16387
     	strh	w9, [sp]
     	lsr	w9, w8, #8
     	mov	x0, sp
     	mov	w1, #4
     	strb	w9, [sp, #2]
     	strb	w8, [sp, #3]
     	bl	#-170072 <iWriteRegI2C>
     	adrp	x8, #28516352
     	ldrb	w8, [x8, #1664]
     	ldrb	w2, [x19, #4028]
     	mov	w9, #4896
     	mov	w10, #16899
     	cmp	w8, #0
     	strh	w10, [sp]
     	csel	w8, w9, wzr, ne
     	lsr	w9, w8, #8
     	mov	x0, sp
     	mov	w1, #4
     	strb	w9, [sp, #2]
     	strb	w8, [sp, #3]
     	bl	#-170128 <iWriteRegI2C>
     	adrp	x9, #23580672
     	ldrb	w2, [x9, #4028]
     	mov	w8, #514
     	strh	w8, [sp]
     	lsr	w8, w21, #8
     	mov	x0, sp
     	mov	w1, #4
     	and	w19, w21, #0xffff
     	strb	w8, [sp, #2]
     	strb	w21, [sp, #3]
     	bl	#-170172 <iWriteRegI2C>
     	ldr	w2, [x20, #1636]
     	adrp	x0, #13180928
     	add	x0, x0, #3357
     	mov	w1, w19
     	bl	#-8847144 <printk>
     	b	#844 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	ldr	x8, [x19, #8]
     	mov	w9, #4896
     	movk	w9, #816, lsl #16
     	str	w9, [x8]
     	b	#824 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	adrp	x8, #28516352
     	ldrb	w8, [x8, #1712]
     	tbz	w8, #0, #8 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xbd8>
     	mov	w20, #146
     	adrp	x19, #28516352
     	add	x19, x19, #1572
     	adrp	x21, #28524544
     	mov	x0, x19
     	strh	w20, [x21, #3256]
     	bl	#8568532 <_raw_spin_unlock>
     	ldrh	w20, [x21, #3256]
     	adrp	x0, #13824000
     	add	x0, x0, #868
     	mov	w2, #1
     	mov	w1, w20
     	bl	#-8847232 <printk>
     	adrp	x8, #28516352
     	ldrb	w8, [x8, #1608]
     	mov	w9, #14336
     	movk	w9, #7324, lsl #16
     	mov	x0, x19
     	cmp	w8, #0
     	csel	w8, w9, wzr, ne
     	udiv	w8, w8, w20
     	add	w8, w8, w8, lsl #2
     	mov	w9, #32983
     	lsl	w8, w8, #1
     	movk	w9, #54827, lsl #16
     	umull	x8, w8, w9
     	lsr	x21, x8, #44
     	bl	#8568160 <_raw_spin_lock>
     	adrp	x8, #28516352
     	ldr	w9, [x8, #1692]
     	adrp	x19, #28516352
     	adrp	x20, #28524544
     	cmp	w21, w9
     	csel	w10, w21, w9, hi
     	sub	w11, w10, w9
     	cmp	w10, #16, lsl #12
     	str	w10, [x19, #1636]
     	strh	w11, [x20, #3240]
     	b.lo	#20 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xc80>
     	mov	w10, #65535
     	mvn	w9, w9
     	str	w10, [x19, #1636]
     	strh	w9, [x20, #3240]
     	adrp	x0, #28516352
     	add	x0, x0, #1572
     	str	w10, [x8, #1692]
     	bl	#8568372 <_raw_spin_unlock>
     	ldrh	w1, [x20, #3240]
     	adrp	x0, #13819904
     	add	x0, x0, #3302
     	mov	w2, wzr
     	bl	#-8847388 <printk>
     	ldr	w8, [x19, #1636]
     	b	#500 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xe9c>
     	adrp	x9, #14856192
     	add	x9, x9, #2052
     	b	#36 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xcd8>
     	adrp	x9, #14856192
     	add	x9, x9, #2116
     	b	#24 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xcd8>
     	adrp	x9, #14856192
     	add	x9, x9, #2148
     	b	#12 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xcd8>
     	adrp	x9, #14856192
     	add	x9, x9, #2180
     	ldp	x11, x10, [x9, #16]
     	ldp	x9, x12, [x9]
     	stp	x11, x10, [x8, #16]
     	stp	x9, x12, [x8]
     	b	#532 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	mov	w8, #14336
     	movk	w8, #7324, lsl #16
     	udiv	w8, w8, w19
     	add	w8, w8, w8, lsl #2
     	lsl	w23, w8, #1
     	mov	w8, #32983
     	adrp	x19, #28516352
     	movk	w8, #54827, lsl #16
     	add	x19, x19, #1572
     	umull	x8, w23, w8
     	mov	x0, x19
     	lsr	x21, x8, #44
     	bl	#8567940 <_raw_spin_lock>
     	mov	w9, #40607
     	movk	w9, #243, lsl #16
     	sub	w8, w21, #3260
     	cmp	w23, w9
     	adrp	x22, #28524544
     	csel	w8, w8, wzr, hi
     	strh	w8, [x22, #3240]
     	and	w8, w8, #0xffff
     	adrp	x21, #28516352
     	adrp	x10, #28516352
     	add	w8, w8, #3260
     	mov	x0, x19
     	str	w8, [x21, #1636]
     	str	w8, [x10, #1692]
     	bl	#8568168 <_raw_spin_unlock>
     	adrp	x9, #23576576
     	ldr	w8, [x21, #1636]
     	ldr	w9, [x9, #3224]
     	cmp	w8, w9
     	b.ls	#124 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xde8>
     	ldrh	w1, [x22, #3240]
     	adrp	x0, #13819904
     	add	x0, x0, #3302
     	mov	w2, wzr
     	bl	#-8847612 <printk>
     	ldr	w8, [x21, #1636]
     	adrp	x19, #23580672
     	ldrb	w2, [x19, #4028]
     	mov	w9, #16387
     	strh	w9, [sp]
     	lsr	w9, w8, #8
     	mov	x0, sp
     	mov	w1, #4
     	strb	w9, [sp, #2]
     	strb	w8, [sp, #3]
     	bl	#-170704 <iWriteRegI2C>
     	adrp	x8, #28516352
     	ldrb	w8, [x8, #1664]
     	ldrb	w2, [x19, #4028]
     	mov	w9, #4896
     	mov	w10, #16899
     	cmp	w8, #0
     	csel	w8, w9, wzr, ne
     	lsr	w9, w8, #8
     	mov	x0, sp
     	mov	w1, #4
     	strh	w10, [sp]
     	strb	w9, [sp, #2]
     	strb	w8, [sp, #3]
     	bl	#-170760 <iWriteRegI2C>
     	adrp	x0, #13819904
     	add	x0, x0, #2168
     	mov	w1, w20
     	b	#-1444 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x850>
     	cbnz	w19, #-2044 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0x5fc>
     	b	#256 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	mov	w8, #14336
     	movk	w8, #7324, lsl #16
     	udiv	w8, w8, w19
     	add	w8, w8, w8, lsl #2
     	lsl	w22, w8, #1
     	mov	w8, #32983
     	adrp	x19, #28516352
     	movk	w8, #54827, lsl #16
     	add	x19, x19, #1572
     	umull	x8, w22, w8
     	mov	x0, x19
     	lsr	x20, x8, #44
     	bl	#8567664 <_raw_spin_lock>
     	mov	w9, #2335
     	movk	w9, #61, lsl #16
     	sub	w8, w20, #816
     	cmp	w22, w9
     	adrp	x21, #28524544
     	csel	w8, w8, wzr, hi
     	strh	w8, [x21, #3240]
     	and	w8, w8, #0xffff
     	adrp	x20, #28516352
     	adrp	x10, #28516352
     	add	w8, w8, #816
     	mov	x0, x19
     	str	w8, [x20, #1636]
     	str	w8, [x10, #1692]
     	bl	#8567892 <_raw_spin_unlock>
     	adrp	x9, #23576576
     	ldr	w8, [x20, #1636]
     	ldr	w9, [x9, #3224]
     	cmp	w8, w9
     	b.ls	#124 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	ldrh	w1, [x21, #3240]
     	adrp	x0, #13819904
     	add	x0, x0, #3302
     	mov	w2, wzr
     	bl	#-8847888 <printk>
     	ldr	w8, [x20, #1636]
     	adrp	x19, #23580672
     	ldrb	w2, [x19, #4028]
     	mov	w9, #16387
     	strh	w9, [sp]
     	lsr	w9, w8, #8
     	mov	x0, sp
     	mov	w1, #4
     	strb	w9, [sp, #2]
     	strb	w8, [sp, #3]
     	bl	#-170980 <iWriteRegI2C>
     	adrp	x8, #28516352
     	ldrb	w8, [x8, #1664]
     	mov	w9, #4896
     	ldrb	w2, [x19, #4028]
     	mov	w10, #16899
     	cmp	w8, #0
     	csel	w8, w9, wzr, ne
     	lsr	w9, w8, #8
     	strh	w10, [sp]
     	strb	w9, [sp, #2]
     	strb	w8, [sp, #3]
     	mov	x0, sp
     	mov	w1, #4
     	bl	#-171036 <iWriteRegI2C>
     	adrp	x9, #22622208
     	ldr	x8, [sp, #8]
     	ldr	x9, [x9, #4088]
     	cmp	x9, x8
     	b.ne	#96 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xf6c>
     	ldp	x20, x19, [sp, #64]
     	ldp	x22, x21, [sp, #48]
     	ldp	x24, x23, [sp, #32]
     	ldp	x29, x30, [sp, #16]
     	mov	w0, wzr
     	add	sp, sp, #80
     	ret
     	mov	w8, #1200
     	str	w8, [x19]
     	b	#-56 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	ldrb	w1, [x21, #4028]
     	adrp	x0, #13545472
     	add	x0, x0, #2126
     	mov	w3, #12486
     	bl	#-8848068 <printk>
     	ldr	w8, [x19]
     	cmp	w8, w23
     	b.ne	#12 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xf60>
     	ldr	w8, [x22, #3232]
     	cbz	w8, #-96 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	mov	w8, #-1
     	str	w8, [x19]
     	b	#-108 <feature_control$abb3d18ce96cf025cc17a76c06f66f80+0xefc>
     	bl	#-9488688 <__stack_chk_fail>
