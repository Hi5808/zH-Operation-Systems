
vmlinux.elf:	file format ELF64-aarch64-little


Disassembly of section .kernel:

ffffff8008b1e5ec control$abb3d18ce96cf025cc17a76c06f66f80:
ffffff8008b1e5ec:      	sub	sp, sp, #80
ffffff8008b1e5f0:      	stp	x29, x30, [sp, #16]
ffffff8008b1e5f4:      	str	x23, [sp, #32]
ffffff8008b1e5f8:      	stp	x22, x21, [sp, #48]
ffffff8008b1e5fc:      	stp	x20, x19, [sp, #64]
ffffff8008b1e600:      	add	x29, sp, #16
ffffff8008b1e604:      	adrp	x8, #22622208
ffffff8008b1e608:      	ldr	x8, [x8, #4088]
ffffff8008b1e60c:      	mov	w19, w0
ffffff8008b1e610:      	adrp	x0, #13340672
ffffff8008b1e614:      	add	x0, x0, #3224
ffffff8008b1e618:      	mov	w1, w19
ffffff8008b1e61c:      	str	x8, [sp, #8]
ffffff8008b1e620:      	bl	#-8848160 <printk>
ffffff8008b1e624:      	adrp	x20, #28516352
ffffff8008b1e628:      	add	x20, x20, #1572
ffffff8008b1e62c:      	mov	x0, x20
ffffff8008b1e630:      	bl	#8567276 <_raw_spin_lock>
ffffff8008b1e634:      	mov	x0, x20
ffffff8008b1e638:      	bl	#8567556 <_raw_spin_unlock>
ffffff8008b1e63c:      	cmp	w19, #4
ffffff8008b1e640:      	b.hi	#40 <control$abb3d18ce96cf025cc17a76c06f66f80+0x7c>
ffffff8008b1e644:      	adrp	x9, #14860288
ffffff8008b1e648:      	mov	w8, w19
ffffff8008b1e64c:      	add	x9, x9, #2518
ffffff8008b1e650:      	adr	x10, #16
ffffff8008b1e654:      	ldrb	w11, [x9, x8]
ffffff8008b1e658:      	add	x10, x10, x11, lsl #2
ffffff8008b1e65c:      	br	x10
ffffff8008b1e660:      	bl	#-139744 <preview>
ffffff8008b1e664:      	b	#5416 <control$abb3d18ce96cf025cc17a76c06f66f80+0x15a0>
ffffff8008b1e668:      	adrp	x0, #12017664
ffffff8008b1e66c:      	add	x0, x0, #1674
ffffff8008b1e670:      	bl	#-8848240 <printk>
ffffff8008b1e674:      	bl	#-139764 <preview>
ffffff8008b1e678:      	mov	w0, #4
ffffff8008b1e67c:      	b	#5396 <control$abb3d18ce96cf025cc17a76c06f66f80+0x15a4>
ffffff8008b1e680:      	adrp	x0, #13479936
ffffff8008b1e684:      	add	x0, x0, #3656
ffffff8008b1e688:      	bl	#-8848264 <printk>
ffffff8008b1e68c:      	adrp	x19, #28516352
ffffff8008b1e690:      	add	x19, x19, #1572
ffffff8008b1e694:      	mov	x0, x19
ffffff8008b1e698:      	bl	#8567172 <_raw_spin_lock>
ffffff8008b1e69c:      	adrp	x20, #28524544
ffffff8008b1e6a0:      	ldrh	w8, [x20, #3256]
ffffff8008b1e6a4:      	mov	w9, #52429
ffffff8008b1e6a8:      	movk	w9, #52428, lsl #16
ffffff8008b1e6ac:      	adrp	x0, #13766656
ffffff8008b1e6b0:      	mul	x8, x8, x9
ffffff8008b1e6b4:      	lsr	x1, x8, #35
ffffff8008b1e6b8:      	add	x0, x0, #2143
ffffff8008b1e6bc:      	bl	#-8848316 <printk>
ffffff8008b1e6c0:      	adrp	x8, #28516352
ffffff8008b1e6c4:      	mov	w9, #1
ffffff8008b1e6c8:      	adrp	x10, #28516352
ffffff8008b1e6cc:      	adrp	x11, #28516352
ffffff8008b1e6d0:      	mov	w12, #3260
ffffff8008b1e6d4:      	adrp	x13, #28516352
ffffff8008b1e6d8:      	adrp	x14, #28516352
ffffff8008b1e6dc:      	mov	x0, x19
ffffff8008b1e6e0:      	strb	w9, [x8, #1608]
ffffff8008b1e6e4:      	strb	w9, [x10, #1664]
ffffff8008b1e6e8:      	str	w12, [x11, #1636]
ffffff8008b1e6ec:      	str	w12, [x13, #1692]
ffffff8008b1e6f0:      	strb	wzr, [x14, #1712]
ffffff8008b1e6f4:      	bl	#8567368 <_raw_spin_unlock>
ffffff8008b1e6f8:      	ldrh	w0, [x20, #3256]
ffffff8008b1e6fc:      	bl	#5840 <capture_setting>
ffffff8008b1e700:      	adrp	x0, #13328384
ffffff8008b1e704:      	add	x0, x0, #749
ffffff8008b1e708:      	mov	w1, wzr
ffffff8008b1e70c:      	bl	#-8848396 <printk>
ffffff8008b1e710:      	mov	x0, x19
ffffff8008b1e714:      	bl	#8567048 <_raw_spin_lock>
ffffff8008b1e718:      	mov	x0, x19
ffffff8008b1e71c:      	bl	#8567328 <_raw_spin_unlock>
ffffff8008b1e720:      	adrp	x8, #23580672
ffffff8008b1e724:      	ldrb	w2, [x8, #4028]
ffffff8008b1e728:      	b	#5200 <control$abb3d18ce96cf025cc17a76c06f66f80+0x158c>
ffffff8008b1e72c:      	adrp	x0, #13479936
ffffff8008b1e730:      	mov	w21, #8176
ffffff8008b1e734:      	add	x0, x0, #3656
ffffff8008b1e738:      	movk	w21, #16384, lsl #16
ffffff8008b1e73c:      	bl	#-8848444 <printk>
ffffff8008b1e740:      	adrp	x19, #28516352
ffffff8008b1e744:      	add	x19, x19, #1572
ffffff8008b1e748:      	mov	x0, x19
ffffff8008b1e74c:      	bl	#8566992 <_raw_spin_lock>
ffffff8008b1e750:      	adrp	x8, #28516352
ffffff8008b1e754:      	mov	w22, #1
ffffff8008b1e758:      	adrp	x9, #28516352
ffffff8008b1e75c:      	adrp	x10, #28516352
ffffff8008b1e760:      	mov	w11, #3260
ffffff8008b1e764:      	adrp	x12, #28516352
ffffff8008b1e768:      	adrp	x13, #28516352
ffffff8008b1e76c:      	mov	x0, x19
ffffff8008b1e770:      	strb	w22, [x8, #1608]
ffffff8008b1e774:      	strb	w22, [x9, #1664]
ffffff8008b1e778:      	str	w11, [x10, #1636]
ffffff8008b1e77c:      	str	w11, [x12, #1692]
ffffff8008b1e780:      	strb	wzr, [x13, #1712]
ffffff8008b1e784:      	bl	#8567224 <_raw_spin_unlock>
ffffff8008b1e788:      	adrp	x8, #28524544
ffffff8008b1e78c:      	ldrh	w1, [x8, #3256]
ffffff8008b1e790:      	adrp	x0, #13197312
ffffff8008b1e794:      	add	x0, x0, #181
ffffff8008b1e798:      	bl	#-8848536 <printk>
ffffff8008b1e79c:      	adrp	x20, #23580672
ffffff8008b1e7a0:      	ldrb	w2, [x20, #4028]
ffffff8008b1e7a4:      	mov	x0, sp
ffffff8008b1e7a8:      	mov	w1, #4
ffffff8008b1e7ac:      	str	w22, [sp]
ffffff8008b1e7b0:      	bl	#-171608 <iWriteRegI2C>
ffffff8008b1e7b4:      	mov	w19, #100
ffffff8008b1e7b8:      	mov	w22, #1280
ffffff8008b1e7bc:      	adrp	x23, #22896640
ffffff8008b1e7c0:      	ldrb	w4, [x20, #4028]
ffffff8008b1e7c4:      	add	x0, sp, #4
ffffff8008b1e7c8:      	mov	x2, sp
ffffff8008b1e7cc:      	mov	w1, #2
ffffff8008b1e7d0:      	mov	w3, #1
ffffff8008b1e7d4:      	strh	wzr, [sp]
ffffff8008b1e7d8:      	strh	w22, [sp, #4]
ffffff8008b1e7dc:      	bl	#-173152 <iReadRegI2C>
ffffff8008b1e7e0:      	ldrh	w8, [sp]
ffffff8008b1e7e4:      	cmp	w8, #255
ffffff8008b1e7e8:      	b.eq	#472 <control$abb3d18ce96cf025cc17a76c06f66f80+0x3d4>
ffffff8008b1e7ec:      	ldr	x8, [x23, #352]
ffffff8008b1e7f0:      	mul	x8, x8, x21
ffffff8008b1e7f4:      	lsr	x0, x8, #32
ffffff8008b1e7f8:      	bl	#8433352 <__delay>
ffffff8008b1e7fc:      	subs	w19, w19, #1
ffffff8008b1e800:      	b.ne	#-64 <control$abb3d18ce96cf025cc17a76c06f66f80+0x1d4>
ffffff8008b1e804:      	b	#456 <control$abb3d18ce96cf025cc17a76c06f66f80+0x3e0>
ffffff8008b1e808:      	adrp	x19, #13479936
ffffff8008b1e80c:      	add	x19, x19, #3656
ffffff8008b1e810:      	mov	w21, #8176
ffffff8008b1e814:      	mov	x0, x19
ffffff8008b1e818:      	movk	w21, #16384, lsl #16
ffffff8008b1e81c:      	bl	#-8848668 <printk>
ffffff8008b1e820:      	adrp	x20, #28516352
ffffff8008b1e824:      	add	x20, x20, #1572
ffffff8008b1e828:      	mov	x0, x20
ffffff8008b1e82c:      	bl	#8566768 <_raw_spin_lock>
ffffff8008b1e830:      	adrp	x8, #28516352
ffffff8008b1e834:      	mov	w22, #1
ffffff8008b1e838:      	adrp	x9, #28516352
ffffff8008b1e83c:      	adrp	x10, #28516352
ffffff8008b1e840:      	mov	w11, #816
ffffff8008b1e844:      	adrp	x12, #28516352
ffffff8008b1e848:      	adrp	x13, #28524544
ffffff8008b1e84c:      	adrp	x14, #28516352
ffffff8008b1e850:      	mov	x0, x20
ffffff8008b1e854:      	strb	w22, [x8, #1608]
ffffff8008b1e858:      	strb	w22, [x9, #1664]
ffffff8008b1e85c:      	str	w11, [x10, #1636]
ffffff8008b1e860:      	str	w11, [x12, #1692]
ffffff8008b1e864:      	strh	wzr, [x13, #3240]
ffffff8008b1e868:      	strb	wzr, [x14, #1712]
ffffff8008b1e86c:      	bl	#8566992 <_raw_spin_unlock>
ffffff8008b1e870:      	mov	x0, x19
ffffff8008b1e874:      	bl	#-8848756 <printk>
ffffff8008b1e878:      	adrp	x20, #23580672
ffffff8008b1e87c:      	ldrb	w2, [x20, #4028]
ffffff8008b1e880:      	mov	x0, sp
ffffff8008b1e884:      	mov	w1, #4
ffffff8008b1e888:      	str	w22, [sp]
ffffff8008b1e88c:      	bl	#-171828 <iWriteRegI2C>
ffffff8008b1e890:      	mov	w19, #100
ffffff8008b1e894:      	mov	w22, #1280
ffffff8008b1e898:      	adrp	x23, #22896640
ffffff8008b1e89c:      	ldrb	w4, [x20, #4028]
ffffff8008b1e8a0:      	add	x0, sp, #4
ffffff8008b1e8a4:      	mov	x2, sp
ffffff8008b1e8a8:      	mov	w1, #2
ffffff8008b1e8ac:      	mov	w3, #1
ffffff8008b1e8b0:      	strh	wzr, [sp]
ffffff8008b1e8b4:      	strh	w22, [sp, #4]
ffffff8008b1e8b8:      	bl	#-173372 <iReadRegI2C>
ffffff8008b1e8bc:      	ldrh	w8, [sp]
ffffff8008b1e8c0:      	cmp	w8, #255
ffffff8008b1e8c4:      	b.eq	#1672 <control$abb3d18ce96cf025cc17a76c06f66f80+0x960>
ffffff8008b1e8c8:      	ldr	x8, [x23, #352]
ffffff8008b1e8cc:      	mul	x8, x8, x21
ffffff8008b1e8d0:      	lsr	x0, x8, #32
ffffff8008b1e8d4:      	bl	#8433132 <__delay>
ffffff8008b1e8d8:      	subs	w19, w19, #1
ffffff8008b1e8dc:      	b.ne	#-64 <control$abb3d18ce96cf025cc17a76c06f66f80+0x2b0>
ffffff8008b1e8e0:      	b	#1656 <control$abb3d18ce96cf025cc17a76c06f66f80+0x96c>
ffffff8008b1e8e4:      	adrp	x19, #13479936
ffffff8008b1e8e8:      	add	x19, x19, #3656
ffffff8008b1e8ec:      	mov	w21, #8176
ffffff8008b1e8f0:      	mov	x0, x19
ffffff8008b1e8f4:      	movk	w21, #16384, lsl #16
ffffff8008b1e8f8:      	bl	#-8848888 <printk>
ffffff8008b1e8fc:      	adrp	x20, #28516352
ffffff8008b1e900:      	add	x20, x20, #1572
ffffff8008b1e904:      	mov	x0, x20
ffffff8008b1e908:      	bl	#8566548 <_raw_spin_lock>
ffffff8008b1e90c:      	adrp	x8, #28516352
ffffff8008b1e910:      	mov	w22, #1
ffffff8008b1e914:      	adrp	x9, #28516352
ffffff8008b1e918:      	adrp	x10, #28516352
ffffff8008b1e91c:      	mov	w11, #3260
ffffff8008b1e920:      	adrp	x12, #28516352
ffffff8008b1e924:      	adrp	x13, #28524544
ffffff8008b1e928:      	adrp	x14, #28516352
ffffff8008b1e92c:      	mov	x0, x20
ffffff8008b1e930:      	strb	w22, [x8, #1608]
ffffff8008b1e934:      	strb	w22, [x9, #1664]
ffffff8008b1e938:      	str	w11, [x10, #1636]
ffffff8008b1e93c:      	str	w11, [x12, #1692]
ffffff8008b1e940:      	strh	wzr, [x13, #3240]
ffffff8008b1e944:      	strb	wzr, [x14, #1712]
ffffff8008b1e948:      	bl	#8566772 <_raw_spin_unlock>
ffffff8008b1e94c:      	mov	x0, x19
ffffff8008b1e950:      	bl	#-8848976 <printk>
ffffff8008b1e954:      	adrp	x20, #23580672
ffffff8008b1e958:      	ldrb	w2, [x20, #4028]
ffffff8008b1e95c:      	mov	x0, sp
ffffff8008b1e960:      	mov	w1, #4
ffffff8008b1e964:      	str	w22, [sp]
ffffff8008b1e968:      	bl	#-172048 <iWriteRegI2C>
ffffff8008b1e96c:      	mov	w19, #100
ffffff8008b1e970:      	mov	w22, #1280
ffffff8008b1e974:      	adrp	x23, #22896640
ffffff8008b1e978:      	ldrb	w4, [x20, #4028]
ffffff8008b1e97c:      	add	x0, sp, #4
ffffff8008b1e980:      	mov	x2, sp
ffffff8008b1e984:      	mov	w1, #2
ffffff8008b1e988:      	mov	w3, #1
ffffff8008b1e98c:      	strh	wzr, [sp]
ffffff8008b1e990:      	strh	w22, [sp, #4]
ffffff8008b1e994:      	bl	#-173592 <iReadRegI2C>
ffffff8008b1e998:      	ldrh	w8, [sp]
ffffff8008b1e99c:      	cmp	w8, #255
ffffff8008b1e9a0:      	b.eq	#2892 <control$abb3d18ce96cf025cc17a76c06f66f80+0xf00>
ffffff8008b1e9a4:      	ldr	x8, [x23, #352]
ffffff8008b1e9a8:      	mul	x8, x8, x21
ffffff8008b1e9ac:      	lsr	x0, x8, #32
ffffff8008b1e9b0:      	bl	#8432912 <__delay>
ffffff8008b1e9b4:      	subs	w19, w19, #1
ffffff8008b1e9b8:      	b.ne	#-64 <control$abb3d18ce96cf025cc17a76c06f66f80+0x38c>
ffffff8008b1e9bc:      	b	#2876 <control$abb3d18ce96cf025cc17a76c06f66f80+0xf0c>
ffffff8008b1e9c0:      	adrp	x0, #11956224
ffffff8008b1e9c4:      	add	x0, x0, #1214
ffffff8008b1e9c8:      	bl	#-8849096 <printk>
ffffff8008b1e9cc:      	ldrb	w2, [x20, #4028]
ffffff8008b1e9d0:      	mov	w8, #17411
ffffff8008b1e9d4:      	movk	w8, #2048, lsl #16
ffffff8008b1e9d8:      	mov	x0, sp
ffffff8008b1e9dc:      	mov	w1, #4
ffffff8008b1e9e0:      	str	w8, [sp]
ffffff8008b1e9e4:      	bl	#-172172 <iWriteRegI2C>
ffffff8008b1e9e8:      	ldrb	w2, [x20, #4028]
ffffff8008b1e9ec:      	mov	w8, #17923
ffffff8008b1e9f0:      	movk	w8, #2048, lsl #16
ffffff8008b1e9f4:      	mov	x0, sp
ffffff8008b1e9f8:      	mov	w1, #4
ffffff8008b1e9fc:      	str	w8, [sp]
ffffff8008b1ea00:      	bl	#-172200 <iWriteRegI2C>
ffffff8008b1ea04:      	ldrb	w2, [x20, #4028]
ffffff8008b1ea08:      	mov	w8, #18435
ffffff8008b1ea0c:      	movk	w8, #30480, lsl #16
ffffff8008b1ea10:      	mov	x0, sp
ffffff8008b1ea14:      	mov	w1, #4
ffffff8008b1ea18:      	str	w8, [sp]
ffffff8008b1ea1c:      	bl	#-172228 <iWriteRegI2C>
ffffff8008b1ea20:      	ldrb	w2, [x20, #4028]
ffffff8008b1ea24:      	mov	w8, #18947
ffffff8008b1ea28:      	movk	w8, #14092, lsl #16
ffffff8008b1ea2c:      	mov	x0, sp
ffffff8008b1ea30:      	mov	w1, #4
ffffff8008b1ea34:      	str	w8, [sp]
ffffff8008b1ea38:      	bl	#-172256 <iWriteRegI2C>
ffffff8008b1ea3c:      	ldrb	w2, [x20, #4028]
ffffff8008b1ea40:      	mov	w8, #19459
ffffff8008b1ea44:      	movk	w8, #28688, lsl #16
ffffff8008b1ea48:      	mov	x0, sp
ffffff8008b1ea4c:      	mov	w1, #4
ffffff8008b1ea50:      	str	w8, [sp]
ffffff8008b1ea54:      	bl	#-172284 <iWriteRegI2C>
ffffff8008b1ea58:      	ldrb	w2, [x20, #4028]
ffffff8008b1ea5c:      	mov	w8, #19971
ffffff8008b1ea60:      	movk	w8, #12300, lsl #16
ffffff8008b1ea64:      	mov	x0, sp
ffffff8008b1ea68:      	mov	w1, #4
ffffff8008b1ea6c:      	str	w8, [sp]
ffffff8008b1ea70:      	bl	#-172312 <iWriteRegI2C>
ffffff8008b1ea74:      	ldrb	w2, [x20, #4028]
ffffff8008b1ea78:      	mov	w8, #9
ffffff8008b1ea7c:      	mov	x0, sp
ffffff8008b1ea80:      	mov	w1, #4
ffffff8008b1ea84:      	str	w8, [sp]
ffffff8008b1ea88:      	bl	#-172336 <iWriteRegI2C>
ffffff8008b1ea8c:      	ldrb	w2, [x20, #4028]
ffffff8008b1ea90:      	mov	w8, #32771
ffffff8008b1ea94:      	movk	w8, #256, lsl #16
ffffff8008b1ea98:      	mov	x0, sp
ffffff8008b1ea9c:      	mov	w1, #4
ffffff8008b1eaa0:      	str	w8, [sp]
ffffff8008b1eaa4:      	bl	#-172364 <iWriteRegI2C>
ffffff8008b1eaa8:      	ldrb	w2, [x20, #4028]
ffffff8008b1eaac:      	mov	w8, #33283
ffffff8008b1eab0:      	movk	w8, #256, lsl #16
ffffff8008b1eab4:      	mov	x0, sp
ffffff8008b1eab8:      	mov	w1, #4
ffffff8008b1eabc:      	str	w8, [sp]
ffffff8008b1eac0:      	bl	#-172392 <iWriteRegI2C>
ffffff8008b1eac4:      	ldrb	w2, [x20, #4028]
ffffff8008b1eac8:      	mov	w8, #33795
ffffff8008b1eacc:      	movk	w8, #256, lsl #16
ffffff8008b1ead0:      	mov	x0, sp
ffffff8008b1ead4:      	mov	w1, #4
ffffff8008b1ead8:      	str	w8, [sp]
ffffff8008b1eadc:      	bl	#-172420 <iWriteRegI2C>
ffffff8008b1eae0:      	ldrb	w2, [x20, #4028]
ffffff8008b1eae4:      	mov	w8, #34307
ffffff8008b1eae8:      	movk	w8, #256, lsl #16
ffffff8008b1eaec:      	mov	x0, sp
ffffff8008b1eaf0:      	mov	w1, #4
ffffff8008b1eaf4:      	str	w8, [sp]
ffffff8008b1eaf8:      	bl	#-172448 <iWriteRegI2C>
ffffff8008b1eafc:      	ldrb	w2, [x20, #4028]
ffffff8008b1eb00:      	mov	w8, #5121
ffffff8008b1eb04:      	movk	w8, #12291, lsl #16
ffffff8008b1eb08:      	mov	x0, sp
ffffff8008b1eb0c:      	mov	w1, #4
ffffff8008b1eb10:      	str	w8, [sp]
ffffff8008b1eb14:      	bl	#-172476 <iWriteRegI2C>
ffffff8008b1eb18:      	ldrb	w2, [x20, #4028]
ffffff8008b1eb1c:      	mov	w8, #4097
ffffff8008b1eb20:      	movk	w8, #512, lsl #16
ffffff8008b1eb24:      	mov	x0, sp
ffffff8008b1eb28:      	mov	w1, #4
ffffff8008b1eb2c:      	str	w8, [sp]
ffffff8008b1eb30:      	bl	#-172504 <iWriteRegI2C>
ffffff8008b1eb34:      	ldrb	w2, [x20, #4028]
ffffff8008b1eb38:      	mov	w8, #13825
ffffff8008b1eb3c:      	movk	w8, #24, lsl #16
ffffff8008b1eb40:      	mov	x0, sp
ffffff8008b1eb44:      	mov	w1, #4
ffffff8008b1eb48:      	str	w8, [sp]
ffffff8008b1eb4c:      	bl	#-172532 <iWriteRegI2C>
ffffff8008b1eb50:      	ldrb	w2, [x20, #4028]
ffffff8008b1eb54:      	mov	w8, #1027
ffffff8008b1eb58:      	movk	w8, #1024, lsl #16
ffffff8008b1eb5c:      	mov	x0, sp
ffffff8008b1eb60:      	mov	w1, #4
ffffff8008b1eb64:      	str	w8, [sp]
ffffff8008b1eb68:      	bl	#-172560 <iWriteRegI2C>
ffffff8008b1eb6c:      	ldrb	w2, [x20, #4028]
ffffff8008b1eb70:      	mov	w8, #1539
ffffff8008b1eb74:      	movk	w8, #30720, lsl #16
ffffff8008b1eb78:      	mov	x0, sp
ffffff8008b1eb7c:      	mov	w1, #4
ffffff8008b1eb80:      	str	w8, [sp]
ffffff8008b1eb84:      	bl	#-172588 <iWriteRegI2C>
ffffff8008b1eb88:      	ldrb	w2, [x20, #4028]
ffffff8008b1eb8c:      	mov	w19, #7740
ffffff8008b1eb90:      	mov	x0, sp
ffffff8008b1eb94:      	mov	w1, #4
ffffff8008b1eb98:      	str	w19, [sp]
ffffff8008b1eb9c:      	bl	#-172612 <iWriteRegI2C>
ffffff8008b1eba0:      	ldrb	w2, [x20, #4028]
ffffff8008b1eba4:      	mov	w8, #3075
ffffff8008b1eba8:      	movk	w8, #1024, lsl #16
ffffff8008b1ebac:      	mov	x0, sp
ffffff8008b1ebb0:      	mov	w1, #4
ffffff8008b1ebb4:      	str	w8, [sp]
ffffff8008b1ebb8:      	bl	#-172640 <iWriteRegI2C>
ffffff8008b1ebbc:      	ldrb	w2, [x20, #4028]
ffffff8008b1ebc0:      	mov	w8, #3587
ffffff8008b1ebc4:      	movk	w8, #25600, lsl #16
ffffff8008b1ebc8:      	mov	x0, sp
ffffff8008b1ebcc:      	mov	w1, #4
ffffff8008b1ebd0:      	str	w8, [sp]
ffffff8008b1ebd4:      	bl	#-172668 <iWriteRegI2C>
ffffff8008b1ebd8:      	ldrb	w2, [x20, #4028]
ffffff8008b1ebdc:      	mov	w8, #5692
ffffff8008b1ebe0:      	mov	x0, sp
ffffff8008b1ebe4:      	mov	w1, #4
ffffff8008b1ebe8:      	str	w8, [sp]
ffffff8008b1ebec:      	bl	#-172692 <iWriteRegI2C>
ffffff8008b1ebf0:      	ldrb	w2, [x20, #4028]
ffffff8008b1ebf4:      	mov	w8, #3
ffffff8008b1ebf8:      	movk	w8, #1536, lsl #16
ffffff8008b1ebfc:      	mov	x0, sp
ffffff8008b1ec00:      	mov	w1, #4
ffffff8008b1ec04:      	str	w8, [sp]
ffffff8008b1ec08:      	bl	#-172720 <iWriteRegI2C>
ffffff8008b1ec0c:      	ldrb	w2, [x20, #4028]
ffffff8008b1ec10:      	mov	w8, #16899
ffffff8008b1ec14:      	movk	w8, #8211, lsl #16
ffffff8008b1ec18:      	mov	x0, sp
ffffff8008b1ec1c:      	mov	w1, #4
ffffff8008b1ec20:      	str	w8, [sp]
ffffff8008b1ec24:      	bl	#-172748 <iWriteRegI2C>
ffffff8008b1ec28:      	ldrb	w2, [x20, #4028]
ffffff8008b1ec2c:      	mov	w8, #16387
ffffff8008b1ec30:      	movk	w8, #48140, lsl #16
ffffff8008b1ec34:      	mov	x0, sp
ffffff8008b1ec38:      	mov	w1, #4
ffffff8008b1ec3c:      	str	w8, [sp]
ffffff8008b1ec40:      	bl	#-172776 <iWriteRegI2C>
ffffff8008b1ec44:      	ldrb	w2, [x20, #4028]
ffffff8008b1ec48:      	mov	w8, #50232
ffffff8008b1ec4c:      	movk	w8, #2304, lsl #16
ffffff8008b1ec50:      	mov	x0, sp
ffffff8008b1ec54:      	mov	w1, #4
ffffff8008b1ec58:      	str	w8, [sp]
ffffff8008b1ec5c:      	bl	#-172804 <iWriteRegI2C>
ffffff8008b1ec60:      	ldrb	w2, [x20, #4028]
ffffff8008b1ec64:      	mov	w8, #55352
ffffff8008b1ec68:      	movk	w8, #10752, lsl #16
ffffff8008b1ec6c:      	mov	x0, sp
ffffff8008b1ec70:      	mov	w1, #4
ffffff8008b1ec74:      	str	w8, [sp]
ffffff8008b1ec78:      	bl	#-172832 <iWriteRegI2C>
ffffff8008b1ec7c:      	ldrb	w2, [x20, #4028]
ffffff8008b1ec80:      	mov	w8, #55864
ffffff8008b1ec84:      	movk	w8, #2560, lsl #16
ffffff8008b1ec88:      	mov	x0, sp
ffffff8008b1ec8c:      	mov	w1, #4
ffffff8008b1ec90:      	str	w8, [sp]
ffffff8008b1ec94:      	bl	#-172860 <iWriteRegI2C>
ffffff8008b1ec98:      	ldrb	w2, [x20, #4028]
ffffff8008b1ec9c:      	mov	w8, #56376
ffffff8008b1eca0:      	movk	w8, #2816, lsl #16
ffffff8008b1eca4:      	mov	x0, sp
ffffff8008b1eca8:      	mov	w1, #4
ffffff8008b1ecac:      	str	w8, [sp]
ffffff8008b1ecb0:      	bl	#-172888 <iWriteRegI2C>
ffffff8008b1ecb4:      	ldrb	w2, [x20, #4028]
ffffff8008b1ecb8:      	mov	w8, #49720
ffffff8008b1ecbc:      	movk	w8, #2560, lsl #16
ffffff8008b1ecc0:      	mov	x0, sp
ffffff8008b1ecc4:      	mov	w1, #4
ffffff8008b1ecc8:      	str	w8, [sp]
ffffff8008b1eccc:      	bl	#-172916 <iWriteRegI2C>
ffffff8008b1ecd0:      	ldrb	w2, [x20, #4028]
ffffff8008b1ecd4:      	mov	w8, #49208
ffffff8008b1ecd8:      	movk	w8, #3840, lsl #16
ffffff8008b1ecdc:      	mov	x0, sp
ffffff8008b1ece0:      	mov	w1, #4
ffffff8008b1ece4:      	str	w8, [sp]
ffffff8008b1ece8:      	bl	#-172944 <iWriteRegI2C>
ffffff8008b1ecec:      	ldrb	w2, [x20, #4028]
ffffff8008b1ecf0:      	mov	w8, #54840
ffffff8008b1ecf4:      	movk	w8, #2560, lsl #16
ffffff8008b1ecf8:      	mov	x0, sp
ffffff8008b1ecfc:      	mov	w1, #4
ffffff8008b1ed00:      	str	w8, [sp]
ffffff8008b1ed04:      	bl	#-172972 <iWriteRegI2C>
ffffff8008b1ed08:      	ldrb	w2, [x20, #4028]
ffffff8008b1ed0c:      	mov	w8, #54328
ffffff8008b1ed10:      	movk	w8, #2304, lsl #16
ffffff8008b1ed14:      	mov	x0, sp
ffffff8008b1ed18:      	mov	w1, #4
ffffff8008b1ed1c:      	str	w8, [sp]
ffffff8008b1ed20:      	bl	#-173000 <iWriteRegI2C>
ffffff8008b1ed24:      	ldrb	w2, [x20, #4028]
ffffff8008b1ed28:      	mov	w8, #45112
ffffff8008b1ed2c:      	movk	w8, #3840, lsl #16
ffffff8008b1ed30:      	mov	x0, sp
ffffff8008b1ed34:      	mov	w1, #4
ffffff8008b1ed38:      	str	w8, [sp]
ffffff8008b1ed3c:      	bl	#-173028 <iWriteRegI2C>
ffffff8008b1ed40:      	ldrb	w2, [x20, #4028]
ffffff8008b1ed44:      	mov	w8, #12857
ffffff8008b1ed48:      	movk	w8, #24, lsl #16
ffffff8008b1ed4c:      	mov	x0, sp
ffffff8008b1ed50:      	mov	w1, #4
ffffff8008b1ed54:      	str	w8, [sp]
ffffff8008b1ed58:      	bl	#-173056 <iWriteRegI2C>
ffffff8008b1ed5c:      	ldrb	w2, [x20, #4028]
ffffff8008b1ed60:      	mov	w8, #14393
ffffff8008b1ed64:      	movk	w8, #3072, lsl #16
ffffff8008b1ed68:      	mov	x0, sp
ffffff8008b1ed6c:      	mov	w1, #4
ffffff8008b1ed70:      	str	w8, [sp]
ffffff8008b1ed74:      	bl	#-173084 <iWriteRegI2C>
ffffff8008b1ed78:      	ldrb	w2, [x20, #4028]
ffffff8008b1ed7c:      	mov	w8, #8200
ffffff8008b1ed80:      	movk	w8, #45060, lsl #16
ffffff8008b1ed84:      	mov	x0, sp
ffffff8008b1ed88:      	mov	w1, #4
ffffff8008b1ed8c:      	str	w8, [sp]
ffffff8008b1ed90:      	bl	#-173112 <iWriteRegI2C>
ffffff8008b1ed94:      	ldrb	w2, [x20, #4028]
ffffff8008b1ed98:      	mov	w8, #3128
ffffff8008b1ed9c:      	movk	w8, #36864, lsl #16
ffffff8008b1eda0:      	mov	x0, sp
ffffff8008b1eda4:      	mov	w1, #4
ffffff8008b1eda8:      	str	w8, [sp]
ffffff8008b1edac:      	bl	#-173140 <iWriteRegI2C>
ffffff8008b1edb0:      	ldrb	w2, [x20, #4028]
ffffff8008b1edb4:      	mov	w8, #25648
ffffff8008b1edb8:      	movk	w8, #53231, lsl #16
ffffff8008b1edbc:      	mov	x0, sp
ffffff8008b1edc0:      	mov	w1, #4
ffffff8008b1edc4:      	str	w8, [sp]
ffffff8008b1edc8:      	bl	#-173168 <iWriteRegI2C>
ffffff8008b1edcc:      	ldrb	w2, [x20, #4028]
ffffff8008b1edd0:      	mov	w8, #39984
ffffff8008b1edd4:      	movk	w8, #16390, lsl #16
ffffff8008b1edd8:      	mov	x0, sp
ffffff8008b1eddc:      	mov	w1, #4
ffffff8008b1ede0:      	str	w8, [sp]
ffffff8008b1ede4:      	bl	#-173196 <iWriteRegI2C>
ffffff8008b1ede8:      	ldrb	w2, [x20, #4028]
ffffff8008b1edec:      	mov	w8, #36912
ffffff8008b1edf0:      	movk	w8, #136, lsl #16
ffffff8008b1edf4:      	mov	x0, sp
ffffff8008b1edf8:      	mov	w1, #4
ffffff8008b1edfc:      	str	w8, [sp]
ffffff8008b1ee00:      	bl	#-173224 <iWriteRegI2C>
ffffff8008b1ee04:      	ldrb	w2, [x20, #4028]
ffffff8008b1ee08:      	mov	w8, #14386
ffffff8008b1ee0c:      	movk	w8, #3072, lsl #16
ffffff8008b1ee10:      	mov	x0, sp
ffffff8008b1ee14:      	mov	w1, #4
ffffff8008b1ee18:      	str	w8, [sp]
ffffff8008b1ee1c:      	bl	#-173252 <iWriteRegI2C>
ffffff8008b1ee20:      	ldrb	w2, [x20, #4028]
ffffff8008b1ee24:      	mov	w8, #18993
ffffff8008b1ee28:      	movk	w8, #95, lsl #16
ffffff8008b1ee2c:      	mov	x0, sp
ffffff8008b1ee30:      	mov	w1, #4
ffffff8008b1ee34:      	str	w8, [sp]
ffffff8008b1ee38:      	bl	#-173280 <iWriteRegI2C>
ffffff8008b1ee3c:      	ldrb	w2, [x20, #4028]
ffffff8008b1ee40:      	mov	w8, #45618
ffffff8008b1ee44:      	mov	x0, sp
ffffff8008b1ee48:      	mov	w1, #4
ffffff8008b1ee4c:      	str	w8, [sp]
ffffff8008b1ee50:      	bl	#-173304 <iWriteRegI2C>
ffffff8008b1ee54:      	ldrb	w2, [x20, #4028]
ffffff8008b1ee58:      	mov	w8, #46130
ffffff8008b1ee5c:      	mov	x0, sp
ffffff8008b1ee60:      	mov	w1, #4
ffffff8008b1ee64:      	str	w8, [sp]
ffffff8008b1ee68:      	bl	#-173328 <iWriteRegI2C>
ffffff8008b1ee6c:      	ldrb	w2, [x20, #4028]
ffffff8008b1ee70:      	mov	w8, #46642
ffffff8008b1ee74:      	mov	x0, sp
ffffff8008b1ee78:      	mov	w1, #4
ffffff8008b1ee7c:      	str	w8, [sp]
ffffff8008b1ee80:      	bl	#-173352 <iWriteRegI2C>
ffffff8008b1ee84:      	ldrb	w2, [x20, #4028]
ffffff8008b1ee88:      	mov	w8, #47154
ffffff8008b1ee8c:      	mov	x0, sp
ffffff8008b1ee90:      	mov	w1, #4
ffffff8008b1ee94:      	str	w8, [sp]
ffffff8008b1ee98:      	bl	#-173376 <iWriteRegI2C>
ffffff8008b1ee9c:      	ldrb	w2, [x20, #4028]
ffffff8008b1eea0:      	mov	w8, #51
ffffff8008b1eea4:      	mov	x0, sp
ffffff8008b1eea8:      	mov	w1, #4
ffffff8008b1eeac:      	str	w8, [sp]
ffffff8008b1eeb0:      	bl	#-173400 <iWriteRegI2C>
ffffff8008b1eeb4:      	ldrb	w2, [x20, #4028]
ffffff8008b1eeb8:      	mov	w8, #52
ffffff8008b1eebc:      	mov	x0, sp
ffffff8008b1eec0:      	mov	w1, #4
ffffff8008b1eec4:      	str	w8, [sp]
ffffff8008b1eec8:      	bl	#-173424 <iWriteRegI2C>
ffffff8008b1eecc:      	ldrb	w2, [x20, #4028]
ffffff8008b1eed0:      	mov	w8, #564
ffffff8008b1eed4:      	movk	w8, #16974, lsl #16
ffffff8008b1eed8:      	mov	x0, sp
ffffff8008b1eedc:      	mov	w1, #4
ffffff8008b1eee0:      	str	w8, [sp]
ffffff8008b1eee4:      	bl	#-173452 <iWriteRegI2C>
ffffff8008b1eee8:      	ldrb	w2, [x20, #4028]
ffffff8008b1eeec:      	mov	w8, #45618
ffffff8008b1eef0:      	movk	w8, #1536, lsl #16
ffffff8008b1eef4:      	mov	x0, sp
ffffff8008b1eef8:      	mov	w1, #4
ffffff8008b1eefc:      	str	w8, [sp]
ffffff8008b1ef00:      	bl	#-173480 <iWriteRegI2C>
ffffff8008b1ef04:      	ldrb	w2, [x20, #4028]
ffffff8008b1ef08:      	mov	w8, #46130
ffffff8008b1ef0c:      	movk	w8, #1536, lsl #16
ffffff8008b1ef10:      	mov	x0, sp
ffffff8008b1ef14:      	mov	w1, #4
ffffff8008b1ef18:      	str	w8, [sp]
ffffff8008b1ef1c:      	bl	#-173508 <iWriteRegI2C>
ffffff8008b1ef20:      	ldrb	w2, [x20, #4028]
ffffff8008b1ef24:      	mov	w8, #46642
ffffff8008b1ef28:      	movk	w8, #1536, lsl #16
ffffff8008b1ef2c:      	mov	x0, sp
ffffff8008b1ef30:      	mov	w1, #4
ffffff8008b1ef34:      	str	w8, [sp]
ffffff8008b1ef38:      	bl	#-173536 <iWriteRegI2C>
ffffff8008b1ef3c:      	ldrb	w2, [x20, #4028]
ffffff8008b1ef40:      	mov	w8, #47154
ffffff8008b1ef44:      	movk	w8, #1536, lsl #16
ffffff8008b1ef48:      	b	#2884 <control$abb3d18ce96cf025cc17a76c06f66f80+0x14a0>
ffffff8008b1ef4c:      	adrp	x0, #11956224
ffffff8008b1ef50:      	add	x0, x0, #1214
ffffff8008b1ef54:      	bl	#-8850516 <printk>
ffffff8008b1ef58:      	ldrb	w2, [x20, #4028]
ffffff8008b1ef5c:      	mov	w8, #17411
ffffff8008b1ef60:      	movk	w8, #16387, lsl #16
ffffff8008b1ef64:      	mov	x0, sp
ffffff8008b1ef68:      	mov	w1, #4
ffffff8008b1ef6c:      	str	w8, [sp]
ffffff8008b1ef70:      	bl	#-173592 <iWriteRegI2C>
ffffff8008b1ef74:      	ldrb	w2, [x20, #4028]
ffffff8008b1ef78:      	mov	w8, #17923
ffffff8008b1ef7c:      	movk	w8, #24578, lsl #16
ffffff8008b1ef80:      	mov	x0, sp
ffffff8008b1ef84:      	mov	w1, #4
ffffff8008b1ef88:      	str	w8, [sp]
ffffff8008b1ef8c:      	bl	#-173620 <iWriteRegI2C>
ffffff8008b1ef90:      	ldrb	w2, [x20, #4028]
ffffff8008b1ef94:      	mov	w8, #18435
ffffff8008b1ef98:      	movk	w8, #16141, lsl #16
ffffff8008b1ef9c:      	mov	x0, sp
ffffff8008b1efa0:      	mov	w1, #4
ffffff8008b1efa4:      	str	w8, [sp]
ffffff8008b1efa8:      	bl	#-173648 <iWriteRegI2C>
ffffff8008b1efac:      	ldrb	w2, [x20, #4028]
ffffff8008b1efb0:      	mov	w8, #18947
ffffff8008b1efb4:      	movk	w8, #57097, lsl #16
ffffff8008b1efb8:      	mov	x0, sp
ffffff8008b1efbc:      	mov	w1, #4
ffffff8008b1efc0:      	str	w8, [sp]
ffffff8008b1efc4:      	bl	#-173676 <iWriteRegI2C>
ffffff8008b1efc8:      	ldrb	w2, [x20, #4028]
ffffff8008b1efcc:      	mov	w8, #19459
ffffff8008b1efd0:      	movk	w8, #32770, lsl #16
ffffff8008b1efd4:      	mov	x0, sp
ffffff8008b1efd8:      	mov	w1, #4
ffffff8008b1efdc:      	str	w8, [sp]
ffffff8008b1efe0:      	bl	#-173704 <iWriteRegI2C>
ffffff8008b1efe4:      	ldrb	w2, [x20, #4028]
ffffff8008b1efe8:      	mov	w8, #19971
ffffff8008b1efec:      	movk	w8, #57345, lsl #16
ffffff8008b1eff0:      	mov	x0, sp
ffffff8008b1eff4:      	mov	w1, #4
ffffff8008b1eff8:      	str	w8, [sp]
ffffff8008b1effc:      	bl	#-173732 <iWriteRegI2C>
ffffff8008b1f000:      	ldrb	w2, [x20, #4028]
ffffff8008b1f004:      	mov	w8, #9
ffffff8008b1f008:      	movk	w8, #17409, lsl #16
ffffff8008b1f00c:      	mov	x0, sp
ffffff8008b1f010:      	mov	w1, #4
ffffff8008b1f014:      	str	w8, [sp]
ffffff8008b1f018:      	bl	#-173760 <iWriteRegI2C>
ffffff8008b1f01c:      	ldrb	w2, [x20, #4028]
ffffff8008b1f020:      	mov	w8, #32771
ffffff8008b1f024:      	movk	w8, #256, lsl #16
ffffff8008b1f028:      	mov	x0, sp
ffffff8008b1f02c:      	mov	w1, #4
ffffff8008b1f030:      	str	w8, [sp]
ffffff8008b1f034:      	bl	#-173788 <iWriteRegI2C>
ffffff8008b1f038:      	ldrb	w2, [x20, #4028]
ffffff8008b1f03c:      	mov	w8, #33283
ffffff8008b1f040:      	movk	w8, #256, lsl #16
ffffff8008b1f044:      	mov	x0, sp
ffffff8008b1f048:      	mov	w1, #4
ffffff8008b1f04c:      	str	w8, [sp]
ffffff8008b1f050:      	bl	#-173816 <iWriteRegI2C>
ffffff8008b1f054:      	ldrb	w2, [x20, #4028]
ffffff8008b1f058:      	mov	w8, #33795
ffffff8008b1f05c:      	movk	w8, #256, lsl #16
ffffff8008b1f060:      	mov	x0, sp
ffffff8008b1f064:      	mov	w1, #4
ffffff8008b1f068:      	str	w8, [sp]
ffffff8008b1f06c:      	bl	#-173844 <iWriteRegI2C>
ffffff8008b1f070:      	ldrb	w2, [x20, #4028]
ffffff8008b1f074:      	mov	w8, #34307
ffffff8008b1f078:      	movk	w8, #1792, lsl #16
ffffff8008b1f07c:      	mov	x0, sp
ffffff8008b1f080:      	mov	w1, #4
ffffff8008b1f084:      	str	w8, [sp]
ffffff8008b1f088:      	bl	#-173872 <iWriteRegI2C>
ffffff8008b1f08c:      	ldrb	w2, [x20, #4028]
ffffff8008b1f090:      	mov	w8, #5121
ffffff8008b1f094:      	movk	w8, #12291, lsl #16
ffffff8008b1f098:      	mov	x0, sp
ffffff8008b1f09c:      	mov	w1, #4
ffffff8008b1f0a0:      	str	w8, [sp]
ffffff8008b1f0a4:      	bl	#-173900 <iWriteRegI2C>
ffffff8008b1f0a8:      	ldrb	w2, [x20, #4028]
ffffff8008b1f0ac:      	mov	w8, #4097
ffffff8008b1f0b0:      	movk	w8, #512, lsl #16
ffffff8008b1f0b4:      	mov	x0, sp
ffffff8008b1f0b8:      	mov	w1, #4
ffffff8008b1f0bc:      	str	w8, [sp]
ffffff8008b1f0c0:      	bl	#-173928 <iWriteRegI2C>
ffffff8008b1f0c4:      	ldrb	w2, [x20, #4028]
ffffff8008b1f0c8:      	mov	w8, #13825
ffffff8008b1f0cc:      	movk	w8, #24, lsl #16
ffffff8008b1f0d0:      	mov	x0, sp
ffffff8008b1f0d4:      	mov	w1, #4
ffffff8008b1f0d8:      	str	w8, [sp]
ffffff8008b1f0dc:      	bl	#-173956 <iWriteRegI2C>
ffffff8008b1f0e0:      	ldrb	w2, [x20, #4028]
ffffff8008b1f0e4:      	mov	w8, #1027
ffffff8008b1f0e8:      	movk	w8, #1024, lsl #16
ffffff8008b1f0ec:      	mov	x0, sp
ffffff8008b1f0f0:      	mov	w1, #4
ffffff8008b1f0f4:      	str	w8, [sp]
ffffff8008b1f0f8:      	bl	#-173984 <iWriteRegI2C>
ffffff8008b1f0fc:      	ldrb	w2, [x20, #4028]
ffffff8008b1f100:      	mov	w8, #1539
ffffff8008b1f104:      	movk	w8, #30720, lsl #16
ffffff8008b1f108:      	mov	x0, sp
ffffff8008b1f10c:      	mov	w1, #4
ffffff8008b1f110:      	str	w8, [sp]
ffffff8008b1f114:      	bl	#-174012 <iWriteRegI2C>
ffffff8008b1f118:      	ldrb	w2, [x20, #4028]
ffffff8008b1f11c:      	mov	w19, #7740
ffffff8008b1f120:      	mov	x0, sp
ffffff8008b1f124:      	mov	w1, #4
ffffff8008b1f128:      	str	w19, [sp]
ffffff8008b1f12c:      	bl	#-174036 <iWriteRegI2C>
ffffff8008b1f130:      	ldrb	w2, [x20, #4028]
ffffff8008b1f134:      	mov	w8, #3075
ffffff8008b1f138:      	movk	w8, #768, lsl #16
ffffff8008b1f13c:      	mov	x0, sp
ffffff8008b1f140:      	mov	w1, #4
ffffff8008b1f144:      	str	w8, [sp]
ffffff8008b1f148:      	bl	#-174064 <iWriteRegI2C>
ffffff8008b1f14c:      	ldrb	w2, [x20, #4028]
ffffff8008b1f150:      	mov	w8, #3587
ffffff8008b1f154:      	movk	w8, #23808, lsl #16
ffffff8008b1f158:      	mov	x0, sp
ffffff8008b1f15c:      	mov	w1, #4
ffffff8008b1f160:      	str	w8, [sp]
ffffff8008b1f164:      	bl	#-174092 <iWriteRegI2C>
ffffff8008b1f168:      	ldrb	w2, [x20, #4028]
ffffff8008b1f16c:      	mov	w8, #5692
ffffff8008b1f170:      	movk	w8, #768, lsl #16
ffffff8008b1f174:      	mov	x0, sp
ffffff8008b1f178:      	mov	w1, #4
ffffff8008b1f17c:      	str	w8, [sp]
ffffff8008b1f180:      	bl	#-174120 <iWriteRegI2C>
ffffff8008b1f184:      	ldrb	w2, [x20, #4028]
ffffff8008b1f188:      	mov	w8, #3
ffffff8008b1f18c:      	movk	w8, #1536, lsl #16
ffffff8008b1f190:      	mov	x0, sp
ffffff8008b1f194:      	mov	w1, #4
ffffff8008b1f198:      	str	w8, [sp]
ffffff8008b1f19c:      	bl	#-174148 <iWriteRegI2C>
ffffff8008b1f1a0:      	ldrb	w2, [x20, #4028]
ffffff8008b1f1a4:      	mov	w8, #16899
ffffff8008b1f1a8:      	movk	w8, #8211, lsl #16
ffffff8008b1f1ac:      	mov	x0, sp
ffffff8008b1f1b0:      	mov	w1, #4
ffffff8008b1f1b4:      	str	w8, [sp]
ffffff8008b1f1b8:      	bl	#-174176 <iWriteRegI2C>
ffffff8008b1f1bc:      	ldrb	w2, [x20, #4028]
ffffff8008b1f1c0:      	mov	w8, #16387
ffffff8008b1f1c4:      	movk	w8, #12291, lsl #16
ffffff8008b1f1c8:      	mov	x0, sp
ffffff8008b1f1cc:      	mov	w1, #4
ffffff8008b1f1d0:      	str	w8, [sp]
ffffff8008b1f1d4:      	bl	#-174204 <iWriteRegI2C>
ffffff8008b1f1d8:      	ldrb	w2, [x20, #4028]
ffffff8008b1f1dc:      	mov	w8, #50232
ffffff8008b1f1e0:      	movk	w8, #1536, lsl #16
ffffff8008b1f1e4:      	mov	x0, sp
ffffff8008b1f1e8:      	mov	w1, #4
ffffff8008b1f1ec:      	str	w8, [sp]
ffffff8008b1f1f0:      	bl	#-174232 <iWriteRegI2C>
ffffff8008b1f1f4:      	ldrb	w2, [x20, #4028]
ffffff8008b1f1f8:      	mov	w8, #55352
ffffff8008b1f1fc:      	movk	w8, #768, lsl #16
ffffff8008b1f200:      	mov	x0, sp
ffffff8008b1f204:      	mov	w1, #4
ffffff8008b1f208:      	str	w8, [sp]
ffffff8008b1f20c:      	bl	#-174260 <iWriteRegI2C>
ffffff8008b1f210:      	ldrb	w2, [x20, #4028]
ffffff8008b1f214:      	mov	w8, #55864
ffffff8008b1f218:      	movk	w8, #768, lsl #16
ffffff8008b1f21c:      	mov	x0, sp
ffffff8008b1f220:      	mov	w1, #4
ffffff8008b1f224:      	str	w8, [sp]
ffffff8008b1f228:      	bl	#-174288 <iWriteRegI2C>
ffffff8008b1f22c:      	ldrb	w2, [x20, #4028]
ffffff8008b1f230:      	mov	w8, #56376
ffffff8008b1f234:      	movk	w8, #5888, lsl #16
ffffff8008b1f238:      	mov	x0, sp
ffffff8008b1f23c:      	mov	w1, #4
ffffff8008b1f240:      	str	w8, [sp]
ffffff8008b1f244:      	bl	#-174316 <iWriteRegI2C>
ffffff8008b1f248:      	ldrb	w2, [x20, #4028]
ffffff8008b1f24c:      	mov	w8, #49720
ffffff8008b1f250:      	movk	w8, #2048, lsl #16
ffffff8008b1f254:      	mov	x0, sp
ffffff8008b1f258:      	mov	w1, #4
ffffff8008b1f25c:      	str	w8, [sp]
ffffff8008b1f260:      	bl	#-174344 <iWriteRegI2C>
ffffff8008b1f264:      	ldrb	w2, [x20, #4028]
ffffff8008b1f268:      	mov	w8, #49208
ffffff8008b1f26c:      	mov	x0, sp
ffffff8008b1f270:      	mov	w1, #4
ffffff8008b1f274:      	str	w8, [sp]
ffffff8008b1f278:      	bl	#-174368 <iWriteRegI2C>
ffffff8008b1f27c:      	ldrb	w2, [x20, #4028]
ffffff8008b1f280:      	mov	w8, #54840
ffffff8008b1f284:      	movk	w8, #4864, lsl #16
ffffff8008b1f288:      	mov	x0, sp
ffffff8008b1f28c:      	mov	w1, #4
ffffff8008b1f290:      	str	w8, [sp]
ffffff8008b1f294:      	bl	#-174396 <iWriteRegI2C>
ffffff8008b1f298:      	ldrb	w2, [x20, #4028]
ffffff8008b1f29c:      	mov	w8, #54328
ffffff8008b1f2a0:      	movk	w8, #1280, lsl #16
ffffff8008b1f2a4:      	mov	x0, sp
ffffff8008b1f2a8:      	mov	w1, #4
ffffff8008b1f2ac:      	str	w8, [sp]
ffffff8008b1f2b0:      	bl	#-174424 <iWriteRegI2C>
ffffff8008b1f2b4:      	ldrb	w2, [x20, #4028]
ffffff8008b1f2b8:      	mov	w8, #45112
ffffff8008b1f2bc:      	movk	w8, #512, lsl #16
ffffff8008b1f2c0:      	mov	x0, sp
ffffff8008b1f2c4:      	mov	w1, #4
ffffff8008b1f2c8:      	str	w8, [sp]
ffffff8008b1f2cc:      	bl	#-174452 <iWriteRegI2C>
ffffff8008b1f2d0:      	ldrb	w2, [x20, #4028]
ffffff8008b1f2d4:      	mov	w8, #12857
ffffff8008b1f2d8:      	movk	w8, #24, lsl #16
ffffff8008b1f2dc:      	mov	x0, sp
ffffff8008b1f2e0:      	mov	w1, #4
ffffff8008b1f2e4:      	str	w8, [sp]
ffffff8008b1f2e8:      	bl	#-174480 <iWriteRegI2C>
ffffff8008b1f2ec:      	ldrb	w2, [x20, #4028]
ffffff8008b1f2f0:      	mov	w8, #14393
ffffff8008b1f2f4:      	movk	w8, #3104, lsl #16
ffffff8008b1f2f8:      	mov	x0, sp
ffffff8008b1f2fc:      	mov	w1, #4
ffffff8008b1f300:      	str	w8, [sp]
ffffff8008b1f304:      	bl	#-174508 <iWriteRegI2C>
ffffff8008b1f308:      	ldrb	w2, [x20, #4028]
ffffff8008b1f30c:      	mov	w8, #8200
ffffff8008b1f310:      	movk	w8, #47616, lsl #16
ffffff8008b1f314:      	mov	x0, sp
ffffff8008b1f318:      	mov	w1, #4
ffffff8008b1f31c:      	str	w8, [sp]
ffffff8008b1f320:      	bl	#-174536 <iWriteRegI2C>
ffffff8008b1f324:      	ldrb	w2, [x20, #4028]
ffffff8008b1f328:      	mov	w8, #3128
ffffff8008b1f32c:      	movk	w8, #8960, lsl #16
ffffff8008b1f330:      	mov	x0, sp
ffffff8008b1f334:      	mov	w1, #4
ffffff8008b1f338:      	str	w8, [sp]
ffffff8008b1f33c:      	bl	#-174564 <iWriteRegI2C>
ffffff8008b1f340:      	ldrb	w2, [x20, #4028]
ffffff8008b1f344:      	mov	w8, #25648
ffffff8008b1f348:      	movk	w8, #53227, lsl #16
ffffff8008b1f34c:      	mov	x0, sp
ffffff8008b1f350:      	mov	w1, #4
ffffff8008b1f354:      	str	w8, [sp]
ffffff8008b1f358:      	bl	#-174592 <iWriteRegI2C>
ffffff8008b1f35c:      	ldrb	w2, [x20, #4028]
ffffff8008b1f360:      	mov	w8, #39984
ffffff8008b1f364:      	movk	w8, #6, lsl #16
ffffff8008b1f368:      	mov	x0, sp
ffffff8008b1f36c:      	mov	w1, #4
ffffff8008b1f370:      	str	w8, [sp]
ffffff8008b1f374:      	bl	#-174620 <iWriteRegI2C>
ffffff8008b1f378:      	ldrb	w2, [x20, #4028]
ffffff8008b1f37c:      	mov	w8, #36912
ffffff8008b1f380:      	movk	w8, #128, lsl #16
ffffff8008b1f384:      	mov	x0, sp
ffffff8008b1f388:      	mov	w1, #4
ffffff8008b1f38c:      	str	w8, [sp]
ffffff8008b1f390:      	bl	#-174648 <iWriteRegI2C>
ffffff8008b1f394:      	ldrb	w2, [x20, #4028]
ffffff8008b1f398:      	mov	w8, #14386
ffffff8008b1f39c:      	movk	w8, #2560, lsl #16
ffffff8008b1f3a0:      	mov	x0, sp
ffffff8008b1f3a4:      	mov	w1, #4
ffffff8008b1f3a8:      	str	w8, [sp]
ffffff8008b1f3ac:      	bl	#-174676 <iWriteRegI2C>
ffffff8008b1f3b0:      	ldrb	w2, [x20, #4028]
ffffff8008b1f3b4:      	mov	w8, #18993
ffffff8008b1f3b8:      	movk	w8, #95, lsl #16
ffffff8008b1f3bc:      	mov	x0, sp
ffffff8008b1f3c0:      	mov	w1, #4
ffffff8008b1f3c4:      	str	w8, [sp]
ffffff8008b1f3c8:      	bl	#-174704 <iWriteRegI2C>
ffffff8008b1f3cc:      	ldrb	w2, [x20, #4028]
ffffff8008b1f3d0:      	mov	w8, #45618
ffffff8008b1f3d4:      	movk	w8, #1536, lsl #16
ffffff8008b1f3d8:      	mov	x0, sp
ffffff8008b1f3dc:      	mov	w1, #4
ffffff8008b1f3e0:      	str	w8, [sp]
ffffff8008b1f3e4:      	bl	#-174732 <iWriteRegI2C>
ffffff8008b1f3e8:      	ldrb	w2, [x20, #4028]
ffffff8008b1f3ec:      	mov	w8, #46130
ffffff8008b1f3f0:      	movk	w8, #1536, lsl #16
ffffff8008b1f3f4:      	mov	x0, sp
ffffff8008b1f3f8:      	mov	w1, #4
ffffff8008b1f3fc:      	str	w8, [sp]
ffffff8008b1f400:      	bl	#-174760 <iWriteRegI2C>
ffffff8008b1f404:      	ldrb	w2, [x20, #4028]
ffffff8008b1f408:      	mov	w8, #46642
ffffff8008b1f40c:      	movk	w8, #1536, lsl #16
ffffff8008b1f410:      	mov	x0, sp
ffffff8008b1f414:      	mov	w1, #4
ffffff8008b1f418:      	str	w8, [sp]
ffffff8008b1f41c:      	bl	#-174788 <iWriteRegI2C>
ffffff8008b1f420:      	ldrb	w2, [x20, #4028]
ffffff8008b1f424:      	mov	w8, #47154
ffffff8008b1f428:      	movk	w8, #1536, lsl #16
ffffff8008b1f42c:      	mov	x0, sp
ffffff8008b1f430:      	mov	w1, #4
ffffff8008b1f434:      	str	w8, [sp]
ffffff8008b1f438:      	bl	#-174816 <iWriteRegI2C>
ffffff8008b1f43c:      	ldrb	w2, [x20, #4028]
ffffff8008b1f440:      	mov	w8, #51
ffffff8008b1f444:      	mov	x0, sp
ffffff8008b1f448:      	mov	w1, #4
ffffff8008b1f44c:      	str	w8, [sp]
ffffff8008b1f450:      	bl	#-174840 <iWriteRegI2C>
ffffff8008b1f454:      	ldrb	w2, [x20, #4028]
ffffff8008b1f458:      	mov	w8, #52
ffffff8008b1f45c:      	mov	x0, sp
ffffff8008b1f460:      	mov	w1, #4
ffffff8008b1f464:      	str	w8, [sp]
ffffff8008b1f468:      	bl	#-174864 <iWriteRegI2C>
ffffff8008b1f46c:      	ldrb	w2, [x20, #4028]
ffffff8008b1f470:      	mov	w8, #564
ffffff8008b1f474:      	movk	w8, #16462, lsl #16
ffffff8008b1f478:      	mov	x0, sp
ffffff8008b1f47c:      	mov	w1, #4
ffffff8008b1f480:      	str	w8, [sp]
ffffff8008b1f484:      	bl	#-174892 <iWriteRegI2C>
ffffff8008b1f488:      	ldrb	w2, [x20, #4028]
ffffff8008b1f48c:      	mov	w8, #45618
ffffff8008b1f490:      	movk	w8, #2560, lsl #16
ffffff8008b1f494:      	mov	x0, sp
ffffff8008b1f498:      	mov	w1, #4
ffffff8008b1f49c:      	str	w8, [sp]
ffffff8008b1f4a0:      	bl	#-174920 <iWriteRegI2C>
ffffff8008b1f4a4:      	ldrb	w2, [x20, #4028]
ffffff8008b1f4a8:      	mov	w8, #46130
ffffff8008b1f4ac:      	movk	w8, #2560, lsl #16
ffffff8008b1f4b0:      	mov	x0, sp
ffffff8008b1f4b4:      	mov	w1, #4
ffffff8008b1f4b8:      	str	w8, [sp]
ffffff8008b1f4bc:      	bl	#-174948 <iWriteRegI2C>
ffffff8008b1f4c0:      	ldrb	w2, [x20, #4028]
ffffff8008b1f4c4:      	mov	w8, #46642
ffffff8008b1f4c8:      	movk	w8, #2560, lsl #16
ffffff8008b1f4cc:      	mov	x0, sp
ffffff8008b1f4d0:      	mov	w1, #4
ffffff8008b1f4d4:      	str	w8, [sp]
ffffff8008b1f4d8:      	bl	#-174976 <iWriteRegI2C>
ffffff8008b1f4dc:      	ldrb	w2, [x20, #4028]
ffffff8008b1f4e0:      	mov	w8, #47154
ffffff8008b1f4e4:      	movk	w8, #2560, lsl #16
ffffff8008b1f4e8:      	b	#1444 <control$abb3d18ce96cf025cc17a76c06f66f80+0x14a0>
ffffff8008b1f4ec:      	adrp	x0, #11952128
ffffff8008b1f4f0:      	add	x0, x0, #1214
ffffff8008b1f4f4:      	bl	#-8851956 <printk>
ffffff8008b1f4f8:      	ldrb	w2, [x20, #4028]
ffffff8008b1f4fc:      	mov	w8, #17411
ffffff8008b1f500:      	movk	w8, #49152, lsl #16
ffffff8008b1f504:      	mov	x0, sp
ffffff8008b1f508:      	mov	w1, #4
ffffff8008b1f50c:      	str	w8, [sp]
ffffff8008b1f510:      	bl	#-175032 <iWriteRegI2C>
ffffff8008b1f514:      	ldrb	w2, [x20, #4028]
ffffff8008b1f518:      	mov	w8, #17923
ffffff8008b1f51c:      	movk	w8, #59393, lsl #16
ffffff8008b1f520:      	mov	x0, sp
ffffff8008b1f524:      	mov	w1, #4
ffffff8008b1f528:      	str	w8, [sp]
ffffff8008b1f52c:      	bl	#-175060 <iWriteRegI2C>
ffffff8008b1f530:      	ldrb	w2, [x20, #4028]
ffffff8008b1f534:      	mov	w8, #18435
ffffff8008b1f538:      	movk	w8, #48911, lsl #16
ffffff8008b1f53c:      	mov	x0, sp
ffffff8008b1f540:      	mov	w1, #4
ffffff8008b1f544:      	str	w8, [sp]
ffffff8008b1f548:      	bl	#-175088 <iWriteRegI2C>
ffffff8008b1f54c:      	ldrb	w2, [x20, #4028]
ffffff8008b1f550:      	mov	w8, #18947
ffffff8008b1f554:      	movk	w8, #22282, lsl #16
ffffff8008b1f558:      	mov	x0, sp
ffffff8008b1f55c:      	mov	w1, #4
ffffff8008b1f560:      	str	w8, [sp]
ffffff8008b1f564:      	bl	#-175116 <iWriteRegI2C>
ffffff8008b1f568:      	ldrb	w2, [x20, #4028]
ffffff8008b1f56c:      	mov	w8, #19459
ffffff8008b1f570:      	movk	w8, #32775, lsl #16
ffffff8008b1f574:      	mov	x0, sp
ffffff8008b1f578:      	mov	w1, #4
ffffff8008b1f57c:      	str	w8, [sp]
ffffff8008b1f580:      	bl	#-175144 <iWriteRegI2C>
ffffff8008b1f584:      	ldrb	w2, [x20, #4028]
ffffff8008b1f588:      	mov	w8, #19971
ffffff8008b1f58c:      	movk	w8, #14340, lsl #16
ffffff8008b1f590:      	mov	x0, sp
ffffff8008b1f594:      	mov	w1, #4
ffffff8008b1f598:      	str	w8, [sp]
ffffff8008b1f59c:      	bl	#-175172 <iWriteRegI2C>
ffffff8008b1f5a0:      	ldrb	w2, [x20, #4028]
ffffff8008b1f5a4:      	mov	w8, #9
ffffff8008b1f5a8:      	movk	w8, #8705, lsl #16
ffffff8008b1f5ac:      	mov	x0, sp
ffffff8008b1f5b0:      	mov	w1, #4
ffffff8008b1f5b4:      	str	w8, [sp]
ffffff8008b1f5b8:      	bl	#-175200 <iWriteRegI2C>
ffffff8008b1f5bc:      	ldrb	w2, [x20, #4028]
ffffff8008b1f5c0:      	mov	w8, #32771
ffffff8008b1f5c4:      	movk	w8, #256, lsl #16
ffffff8008b1f5c8:      	mov	x0, sp
ffffff8008b1f5cc:      	mov	w1, #4
ffffff8008b1f5d0:      	str	w8, [sp]
ffffff8008b1f5d4:      	bl	#-175228 <iWriteRegI2C>
ffffff8008b1f5d8:      	ldrb	w2, [x20, #4028]
ffffff8008b1f5dc:      	mov	w8, #33283
ffffff8008b1f5e0:      	movk	w8, #256, lsl #16
ffffff8008b1f5e4:      	mov	x0, sp
ffffff8008b1f5e8:      	mov	w1, #4
ffffff8008b1f5ec:      	str	w8, [sp]
ffffff8008b1f5f0:      	bl	#-175256 <iWriteRegI2C>
ffffff8008b1f5f4:      	ldrb	w2, [x20, #4028]
ffffff8008b1f5f8:      	mov	w8, #33795
ffffff8008b1f5fc:      	movk	w8, #256, lsl #16
ffffff8008b1f600:      	mov	x0, sp
ffffff8008b1f604:      	mov	w1, #4
ffffff8008b1f608:      	str	w8, [sp]
ffffff8008b1f60c:      	bl	#-175284 <iWriteRegI2C>
ffffff8008b1f610:      	ldrb	w2, [x20, #4028]
ffffff8008b1f614:      	mov	w8, #34307
ffffff8008b1f618:      	movk	w8, #768, lsl #16
ffffff8008b1f61c:      	mov	x0, sp
ffffff8008b1f620:      	mov	w1, #4
ffffff8008b1f624:      	str	w8, [sp]
ffffff8008b1f628:      	bl	#-175312 <iWriteRegI2C>
ffffff8008b1f62c:      	ldrb	w2, [x20, #4028]
ffffff8008b1f630:      	mov	w8, #5121
ffffff8008b1f634:      	movk	w8, #12291, lsl #16
ffffff8008b1f638:      	mov	x0, sp
ffffff8008b1f63c:      	mov	w1, #4
ffffff8008b1f640:      	str	w8, [sp]
ffffff8008b1f644:      	bl	#-175340 <iWriteRegI2C>
ffffff8008b1f648:      	ldrb	w2, [x20, #4028]
ffffff8008b1f64c:      	mov	w8, #4097
ffffff8008b1f650:      	movk	w8, #512, lsl #16
ffffff8008b1f654:      	mov	x0, sp
ffffff8008b1f658:      	mov	w1, #4
ffffff8008b1f65c:      	str	w8, [sp]
ffffff8008b1f660:      	bl	#-175368 <iWriteRegI2C>
ffffff8008b1f664:      	ldrb	w2, [x20, #4028]
ffffff8008b1f668:      	mov	w8, #13825
ffffff8008b1f66c:      	movk	w8, #24, lsl #16
ffffff8008b1f670:      	mov	x0, sp
ffffff8008b1f674:      	mov	w1, #4
ffffff8008b1f678:      	str	w8, [sp]
ffffff8008b1f67c:      	bl	#-175396 <iWriteRegI2C>
ffffff8008b1f680:      	ldrb	w2, [x20, #4028]
ffffff8008b1f684:      	mov	w8, #1027
ffffff8008b1f688:      	movk	w8, #1024, lsl #16
ffffff8008b1f68c:      	mov	x0, sp
ffffff8008b1f690:      	mov	w1, #4
ffffff8008b1f694:      	str	w8, [sp]
ffffff8008b1f698:      	bl	#-175424 <iWriteRegI2C>
ffffff8008b1f69c:      	ldrb	w2, [x20, #4028]
ffffff8008b1f6a0:      	mov	w8, #1539
ffffff8008b1f6a4:      	movk	w8, #30720, lsl #16
ffffff8008b1f6a8:      	mov	x0, sp
ffffff8008b1f6ac:      	mov	w1, #4
ffffff8008b1f6b0:      	str	w8, [sp]
ffffff8008b1f6b4:      	bl	#-175452 <iWriteRegI2C>
ffffff8008b1f6b8:      	ldrb	w2, [x20, #4028]
ffffff8008b1f6bc:      	mov	w19, #7740
ffffff8008b1f6c0:      	mov	x0, sp
ffffff8008b1f6c4:      	mov	w1, #4
ffffff8008b1f6c8:      	str	w19, [sp]
ffffff8008b1f6cc:      	bl	#-175476 <iWriteRegI2C>
ffffff8008b1f6d0:      	ldrb	w2, [x20, #4028]
ffffff8008b1f6d4:      	mov	w8, #3075
ffffff8008b1f6d8:      	movk	w8, #768, lsl #16
ffffff8008b1f6dc:      	mov	x0, sp
ffffff8008b1f6e0:      	mov	w1, #4
ffffff8008b1f6e4:      	str	w8, [sp]
ffffff8008b1f6e8:      	bl	#-175504 <iWriteRegI2C>
ffffff8008b1f6ec:      	ldrb	w2, [x20, #4028]
ffffff8008b1f6f0:      	mov	w8, #3587
ffffff8008b1f6f4:      	movk	w8, #33280, lsl #16
ffffff8008b1f6f8:      	mov	x0, sp
ffffff8008b1f6fc:      	mov	w1, #4
ffffff8008b1f700:      	str	w8, [sp]
ffffff8008b1f704:      	bl	#-175532 <iWriteRegI2C>
ffffff8008b1f708:      	ldrb	w2, [x20, #4028]
ffffff8008b1f70c:      	mov	w8, #5692
ffffff8008b1f710:      	movk	w8, #512, lsl #16
ffffff8008b1f714:      	mov	x0, sp
ffffff8008b1f718:      	mov	w1, #4
ffffff8008b1f71c:      	str	w8, [sp]
ffffff8008b1f720:      	bl	#-175560 <iWriteRegI2C>
ffffff8008b1f724:      	ldrb	w2, [x20, #4028]
ffffff8008b1f728:      	mov	w8, #3
ffffff8008b1f72c:      	movk	w8, #1536, lsl #16
ffffff8008b1f730:      	mov	x0, sp
ffffff8008b1f734:      	mov	w1, #4
ffffff8008b1f738:      	str	w8, [sp]
ffffff8008b1f73c:      	bl	#-175588 <iWriteRegI2C>
ffffff8008b1f740:      	ldrb	w2, [x20, #4028]
ffffff8008b1f744:      	mov	w8, #16899
ffffff8008b1f748:      	movk	w8, #8211, lsl #16
ffffff8008b1f74c:      	mov	x0, sp
ffffff8008b1f750:      	mov	w1, #4
ffffff8008b1f754:      	str	w8, [sp]
ffffff8008b1f758:      	bl	#-175616 <iWriteRegI2C>
ffffff8008b1f75c:      	ldrb	w2, [x20, #4028]
ffffff8008b1f760:      	mov	w8, #16387
ffffff8008b1f764:      	movk	w8, #48140, lsl #16
ffffff8008b1f768:      	mov	x0, sp
ffffff8008b1f76c:      	mov	w1, #4
ffffff8008b1f770:      	str	w8, [sp]
ffffff8008b1f774:      	bl	#-175644 <iWriteRegI2C>
ffffff8008b1f778:      	ldrb	w2, [x20, #4028]
ffffff8008b1f77c:      	mov	w8, #50232
ffffff8008b1f780:      	movk	w8, #1024, lsl #16
ffffff8008b1f784:      	mov	x0, sp
ffffff8008b1f788:      	mov	w1, #4
ffffff8008b1f78c:      	str	w8, [sp]
ffffff8008b1f790:      	bl	#-175672 <iWriteRegI2C>
ffffff8008b1f794:      	ldrb	w2, [x20, #4028]
ffffff8008b1f798:      	mov	w8, #55352
ffffff8008b1f79c:      	movk	w8, #3840, lsl #16
ffffff8008b1f7a0:      	mov	x0, sp
ffffff8008b1f7a4:      	mov	w1, #4
ffffff8008b1f7a8:      	str	w8, [sp]
ffffff8008b1f7ac:      	bl	#-175700 <iWriteRegI2C>
ffffff8008b1f7b0:      	ldrb	w2, [x20, #4028]
ffffff8008b1f7b4:      	mov	w8, #55864
ffffff8008b1f7b8:      	movk	w8, #1280, lsl #16
ffffff8008b1f7bc:      	mov	x0, sp
ffffff8008b1f7c0:      	mov	w1, #4
ffffff8008b1f7c4:      	str	w8, [sp]
ffffff8008b1f7c8:      	bl	#-175728 <iWriteRegI2C>
ffffff8008b1f7cc:      	ldrb	w2, [x20, #4028]
ffffff8008b1f7d0:      	mov	w8, #56376
ffffff8008b1f7d4:      	movk	w8, #1280, lsl #16
ffffff8008b1f7d8:      	mov	x0, sp
ffffff8008b1f7dc:      	mov	w1, #4
ffffff8008b1f7e0:      	str	w8, [sp]
ffffff8008b1f7e4:      	bl	#-175756 <iWriteRegI2C>
ffffff8008b1f7e8:      	ldrb	w2, [x20, #4028]
ffffff8008b1f7ec:      	mov	w8, #49720
ffffff8008b1f7f0:      	movk	w8, #1024, lsl #16
ffffff8008b1f7f4:      	mov	x0, sp
ffffff8008b1f7f8:      	mov	w1, #4
ffffff8008b1f7fc:      	str	w8, [sp]
ffffff8008b1f800:      	bl	#-175784 <iWriteRegI2C>
ffffff8008b1f804:      	ldrb	w2, [x20, #4028]
ffffff8008b1f808:      	mov	w8, #49208
ffffff8008b1f80c:      	movk	w8, #768, lsl #16
ffffff8008b1f810:      	mov	x0, sp
ffffff8008b1f814:      	mov	w1, #4
ffffff8008b1f818:      	str	w8, [sp]
ffffff8008b1f81c:      	bl	#-175812 <iWriteRegI2C>
ffffff8008b1f820:      	ldrb	w2, [x20, #4028]
ffffff8008b1f824:      	mov	w8, #54840
ffffff8008b1f828:      	movk	w8, #1024, lsl #16
ffffff8008b1f82c:      	mov	x0, sp
ffffff8008b1f830:      	mov	w1, #4
ffffff8008b1f834:      	str	w8, [sp]
ffffff8008b1f838:      	bl	#-175840 <iWriteRegI2C>
ffffff8008b1f83c:      	ldrb	w2, [x20, #4028]
ffffff8008b1f840:      	mov	w8, #54328
ffffff8008b1f844:      	movk	w8, #768, lsl #16
ffffff8008b1f848:      	mov	x0, sp
ffffff8008b1f84c:      	mov	w1, #4
ffffff8008b1f850:      	str	w8, [sp]
ffffff8008b1f854:      	bl	#-175868 <iWriteRegI2C>
ffffff8008b1f858:      	ldrb	w2, [x20, #4028]
ffffff8008b1f85c:      	mov	w8, #45112
ffffff8008b1f860:      	movk	w8, #1536, lsl #16
ffffff8008b1f864:      	mov	x0, sp
ffffff8008b1f868:      	mov	w1, #4
ffffff8008b1f86c:      	str	w8, [sp]
ffffff8008b1f870:      	bl	#-175896 <iWriteRegI2C>
ffffff8008b1f874:      	ldrb	w2, [x20, #4028]
ffffff8008b1f878:      	mov	w8, #12857
ffffff8008b1f87c:      	movk	w8, #32, lsl #16
ffffff8008b1f880:      	mov	x0, sp
ffffff8008b1f884:      	mov	w1, #4
ffffff8008b1f888:      	str	w8, [sp]
ffffff8008b1f88c:      	bl	#-175924 <iWriteRegI2C>
ffffff8008b1f890:      	ldrb	w2, [x20, #4028]
ffffff8008b1f894:      	mov	w8, #14393
ffffff8008b1f898:      	movk	w8, #3072, lsl #16
ffffff8008b1f89c:      	mov	x0, sp
ffffff8008b1f8a0:      	mov	w1, #4
ffffff8008b1f8a4:      	str	w8, [sp]
ffffff8008b1f8a8:      	bl	#-175952 <iWriteRegI2C>
ffffff8008b1f8ac:      	ldrb	w2, [x20, #4028]
ffffff8008b1f8b0:      	mov	w8, #8200
ffffff8008b1f8b4:      	movk	w8, #2050, lsl #16
ffffff8008b1f8b8:      	mov	x0, sp
ffffff8008b1f8bc:      	mov	w1, #4
ffffff8008b1f8c0:      	str	w8, [sp]
ffffff8008b1f8c4:      	bl	#-175980 <iWriteRegI2C>
ffffff8008b1f8c8:      	ldrb	w2, [x20, #4028]
ffffff8008b1f8cc:      	mov	w8, #3128
ffffff8008b1f8d0:      	movk	w8, #18688, lsl #16
ffffff8008b1f8d4:      	mov	x0, sp
ffffff8008b1f8d8:      	mov	w1, #4
ffffff8008b1f8dc:      	str	w8, [sp]
ffffff8008b1f8e0:      	bl	#-176008 <iWriteRegI2C>
ffffff8008b1f8e4:      	ldrb	w2, [x20, #4028]
ffffff8008b1f8e8:      	mov	w8, #25648
ffffff8008b1f8ec:      	movk	w8, #53231, lsl #16
ffffff8008b1f8f0:      	mov	x0, sp
ffffff8008b1f8f4:      	mov	w1, #4
ffffff8008b1f8f8:      	str	w8, [sp]
ffffff8008b1f8fc:      	bl	#-176036 <iWriteRegI2C>
ffffff8008b1f900:      	ldrb	w2, [x20, #4028]
ffffff8008b1f904:      	mov	w8, #39984
ffffff8008b1f908:      	movk	w8, #16390, lsl #16
ffffff8008b1f90c:      	mov	x0, sp
ffffff8008b1f910:      	mov	w1, #4
ffffff8008b1f914:      	str	w8, [sp]
ffffff8008b1f918:      	bl	#-176064 <iWriteRegI2C>
ffffff8008b1f91c:      	ldrb	w2, [x20, #4028]
ffffff8008b1f920:      	mov	w8, #36912
ffffff8008b1f924:      	movk	w8, #128, lsl #16
ffffff8008b1f928:      	mov	x0, sp
ffffff8008b1f92c:      	mov	w1, #4
ffffff8008b1f930:      	str	w8, [sp]
ffffff8008b1f934:      	bl	#-176092 <iWriteRegI2C>
ffffff8008b1f938:      	ldrb	w2, [x20, #4028]
ffffff8008b1f93c:      	mov	w8, #14386
ffffff8008b1f940:      	movk	w8, #2816, lsl #16
ffffff8008b1f944:      	mov	x0, sp
ffffff8008b1f948:      	mov	w1, #4
ffffff8008b1f94c:      	str	w8, [sp]
ffffff8008b1f950:      	bl	#-176120 <iWriteRegI2C>
ffffff8008b1f954:      	ldrb	w2, [x20, #4028]
ffffff8008b1f958:      	mov	w8, #18993
ffffff8008b1f95c:      	movk	w8, #607, lsl #16
ffffff8008b1f960:      	mov	x0, sp
ffffff8008b1f964:      	mov	w1, #4
ffffff8008b1f968:      	str	w8, [sp]
ffffff8008b1f96c:      	bl	#-176148 <iWriteRegI2C>
ffffff8008b1f970:      	ldrb	w2, [x20, #4028]
ffffff8008b1f974:      	mov	w8, #45618
ffffff8008b1f978:      	movk	w8, #768, lsl #16
ffffff8008b1f97c:      	mov	x0, sp
ffffff8008b1f980:      	mov	w1, #4
ffffff8008b1f984:      	str	w8, [sp]
ffffff8008b1f988:      	bl	#-176176 <iWriteRegI2C>
ffffff8008b1f98c:      	ldrb	w2, [x20, #4028]
ffffff8008b1f990:      	mov	w8, #46130
ffffff8008b1f994:      	movk	w8, #768, lsl #16
ffffff8008b1f998:      	mov	x0, sp
ffffff8008b1f99c:      	mov	w1, #4
ffffff8008b1f9a0:      	str	w8, [sp]
ffffff8008b1f9a4:      	bl	#-176204 <iWriteRegI2C>
ffffff8008b1f9a8:      	ldrb	w2, [x20, #4028]
ffffff8008b1f9ac:      	mov	w8, #46642
ffffff8008b1f9b0:      	movk	w8, #768, lsl #16
ffffff8008b1f9b4:      	mov	x0, sp
ffffff8008b1f9b8:      	mov	w1, #4
ffffff8008b1f9bc:      	str	w8, [sp]
ffffff8008b1f9c0:      	bl	#-176232 <iWriteRegI2C>
ffffff8008b1f9c4:      	ldrb	w2, [x20, #4028]
ffffff8008b1f9c8:      	mov	w8, #47154
ffffff8008b1f9cc:      	movk	w8, #768, lsl #16
ffffff8008b1f9d0:      	mov	x0, sp
ffffff8008b1f9d4:      	mov	w1, #4
ffffff8008b1f9d8:      	str	w8, [sp]
ffffff8008b1f9dc:      	bl	#-176260 <iWriteRegI2C>
ffffff8008b1f9e0:      	ldrb	w2, [x20, #4028]
ffffff8008b1f9e4:      	mov	w8, #51
ffffff8008b1f9e8:      	mov	x0, sp
ffffff8008b1f9ec:      	mov	w1, #4
ffffff8008b1f9f0:      	str	w8, [sp]
ffffff8008b1f9f4:      	bl	#-176284 <iWriteRegI2C>
ffffff8008b1f9f8:      	ldrb	w2, [x20, #4028]
ffffff8008b1f9fc:      	mov	w8, #52
ffffff8008b1fa00:      	mov	x0, sp
ffffff8008b1fa04:      	mov	w1, #4
ffffff8008b1fa08:      	str	w8, [sp]
ffffff8008b1fa0c:      	bl	#-176308 <iWriteRegI2C>
ffffff8008b1fa10:      	ldrb	w2, [x20, #4028]
ffffff8008b1fa14:      	mov	w8, #564
ffffff8008b1fa18:      	movk	w8, #16462, lsl #16
ffffff8008b1fa1c:      	mov	x0, sp
ffffff8008b1fa20:      	mov	w1, #4
ffffff8008b1fa24:      	str	w8, [sp]
ffffff8008b1fa28:      	bl	#-176336 <iWriteRegI2C>
ffffff8008b1fa2c:      	ldrb	w2, [x20, #4028]
ffffff8008b1fa30:      	mov	w8, #45618
ffffff8008b1fa34:      	movk	w8, #2048, lsl #16
ffffff8008b1fa38:      	mov	x0, sp
ffffff8008b1fa3c:      	mov	w1, #4
ffffff8008b1fa40:      	str	w8, [sp]
ffffff8008b1fa44:      	bl	#-176364 <iWriteRegI2C>
ffffff8008b1fa48:      	ldrb	w2, [x20, #4028]
ffffff8008b1fa4c:      	mov	w8, #46130
ffffff8008b1fa50:      	movk	w8, #2048, lsl #16
ffffff8008b1fa54:      	mov	x0, sp
ffffff8008b1fa58:      	mov	w1, #4
ffffff8008b1fa5c:      	str	w8, [sp]
ffffff8008b1fa60:      	bl	#-176392 <iWriteRegI2C>
ffffff8008b1fa64:      	ldrb	w2, [x20, #4028]
ffffff8008b1fa68:      	mov	w8, #46642
ffffff8008b1fa6c:      	movk	w8, #2048, lsl #16
ffffff8008b1fa70:      	mov	x0, sp
ffffff8008b1fa74:      	mov	w1, #4
ffffff8008b1fa78:      	str	w8, [sp]
ffffff8008b1fa7c:      	bl	#-176420 <iWriteRegI2C>
ffffff8008b1fa80:      	ldrb	w2, [x20, #4028]
ffffff8008b1fa84:      	mov	w8, #47154
ffffff8008b1fa88:      	movk	w8, #2048, lsl #16
ffffff8008b1fa8c:      	mov	x0, sp
ffffff8008b1fa90:      	mov	w1, #4
ffffff8008b1fa94:      	str	w8, [sp]
ffffff8008b1fa98:      	bl	#-176448 <iWriteRegI2C>
ffffff8008b1fa9c:      	ldrb	w2, [x20, #4028]
ffffff8008b1faa0:      	mov	w8, #13372
ffffff8008b1faa4:      	movk	w8, #2048, lsl #16
ffffff8008b1faa8:      	mov	x0, sp
ffffff8008b1faac:      	mov	w1, #4
ffffff8008b1fab0:      	str	w8, [sp]
ffffff8008b1fab4:      	bl	#-176476 <iWriteRegI2C>
ffffff8008b1fab8:      	ldrb	w2, [x20, #4028]
ffffff8008b1fabc:      	mov	w8, #13884
ffffff8008b1fac0:      	mov	x0, sp
ffffff8008b1fac4:      	mov	w1, #4
ffffff8008b1fac8:      	str	w8, [sp]
ffffff8008b1facc:      	bl	#-176500 <iWriteRegI2C>
ffffff8008b1fad0:      	ldrb	w2, [x20, #4028]
ffffff8008b1fad4:      	mov	w8, #14396
ffffff8008b1fad8:      	mov	x0, sp
ffffff8008b1fadc:      	mov	w1, #4
ffffff8008b1fae0:      	str	w8, [sp]
ffffff8008b1fae4:      	bl	#-176524 <iWriteRegI2C>
ffffff8008b1fae8:      	ldrb	w2, [x20, #4028]
ffffff8008b1faec:      	mov	w8, #15929
ffffff8008b1faf0:      	movk	w8, #64, lsl #16
ffffff8008b1faf4:      	mov	x0, sp
ffffff8008b1faf8:      	mov	w1, #4
ffffff8008b1fafc:      	str	w8, [sp]
ffffff8008b1fb00:      	bl	#-176552 <iWriteRegI2C>
ffffff8008b1fb04:      	ldrb	w2, [x20, #4028]
ffffff8008b1fb08:      	mov	w8, #7740
ffffff8008b1fb0c:      	movk	w8, #1, lsl #16
ffffff8008b1fb10:      	mov	x0, sp
ffffff8008b1fb14:      	mov	w1, #4
ffffff8008b1fb18:      	str	w8, [sp]
ffffff8008b1fb1c:      	bl	#-176580 <iWriteRegI2C>
ffffff8008b1fb20:      	ldrb	w2, [x20, #4028]
ffffff8008b1fb24:      	mov	w8, #65537
ffffff8008b1fb28:      	mov	x0, sp
ffffff8008b1fb2c:      	mov	w1, #4
ffffff8008b1fb30:      	str	w8, [sp]
ffffff8008b1fb34:      	bl	#-176604 <iWriteRegI2C>
ffffff8008b1fb38:      	ldrb	w2, [x20, #4028]
ffffff8008b1fb3c:      	mov	x0, sp
ffffff8008b1fb40:      	mov	w1, #4
ffffff8008b1fb44:      	str	w19, [sp]
ffffff8008b1fb48:      	bl	#-176624 <iWriteRegI2C>
ffffff8008b1fb4c:      	adrp	x0, #13324288
ffffff8008b1fb50:      	add	x0, x0, #749
ffffff8008b1fb54:      	mov	w1, wzr
ffffff8008b1fb58:      	bl	#-8853592 <printk>
ffffff8008b1fb5c:      	adrp	x19, #28512256
ffffff8008b1fb60:      	add	x19, x19, #1572
ffffff8008b1fb64:      	mov	x0, x19
ffffff8008b1fb68:      	bl	#8561844 <_raw_spin_lock>
ffffff8008b1fb6c:      	mov	x0, x19
ffffff8008b1fb70:      	bl	#8562124 <_raw_spin_unlock>
ffffff8008b1fb74:      	ldrb	w2, [x20, #4028]
ffffff8008b1fb78:      	mov	w8, #257
ffffff8008b1fb7c:      	mov	x0, sp
ffffff8008b1fb80:      	mov	w1, #4
ffffff8008b1fb84:      	str	w8, [sp]
ffffff8008b1fb88:      	bl	#-176688 <iWriteRegI2C>
ffffff8008b1fb8c:      	mov	w0, wzr
ffffff8008b1fb90:      	adrp	x9, #22618112
ffffff8008b1fb94:      	ldr	x8, [sp, #8]
ffffff8008b1fb98:      	ldr	x9, [x9, #4088]
ffffff8008b1fb9c:      	cmp	x9, x8
ffffff8008b1fba0:      	b.ne	#28 <control$abb3d18ce96cf025cc17a76c06f66f80+0x15d0>
ffffff8008b1fba4:      	ldp	x20, x19, [sp, #64]
ffffff8008b1fba8:      	ldp	x22, x21, [sp, #48]
ffffff8008b1fbac:      	ldr	x23, [sp, #32]
ffffff8008b1fbb0:      	ldp	x29, x30, [sp, #16]
ffffff8008b1fbb4:      	add	sp, sp, #80
ffffff8008b1fbb8:      	ret
ffffff8008b1fbbc:      	bl	#-9494276 <__stack_chk_fail>
