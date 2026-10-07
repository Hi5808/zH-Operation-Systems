
vmlinux.elf:	file format ELF64-aarch64-little


Disassembly of section .kernel:

ffffff8008afc480 preview:
ffffff8008afc480:      	sub	sp, sp, #80
ffffff8008afc484:      	stp	x29, x30, [sp, #16]
ffffff8008afc488:      	str	x23, [sp, #32]
ffffff8008afc48c:      	stp	x22, x21, [sp, #48]
ffffff8008afc490:      	stp	x20, x19, [sp, #64]
ffffff8008afc494:      	add	x29, sp, #16
ffffff8008afc498:      	adrp	x8, #22761472
ffffff8008afc49c:      	ldr	x8, [x8, #4088]
ffffff8008afc4a0:      	adrp	x19, #13619200
ffffff8008afc4a4:      	add	x19, x19, #3656
ffffff8008afc4a8:      	mov	x0, x19
ffffff8008afc4ac:      	str	x8, [sp, #8]
ffffff8008afc4b0:      	bl	#-8708528 <printk>
ffffff8008afc4b4:      	adrp	x20, #28655616
ffffff8008afc4b8:      	add	x20, x20, #1572
ffffff8008afc4bc:      	mov	x0, x20
ffffff8008afc4c0:      	bl	#8706908 <_raw_spin_lock>
ffffff8008afc4c4:      	adrp	x8, #28655616
ffffff8008afc4c8:      	mov	w21, #1
ffffff8008afc4cc:      	adrp	x9, #28655616
ffffff8008afc4d0:      	adrp	x10, #28655616
ffffff8008afc4d4:      	mov	w11, #3260
ffffff8008afc4d8:      	adrp	x12, #28655616
ffffff8008afc4dc:      	adrp	x13, #28655616
ffffff8008afc4e0:      	mov	x0, x20
ffffff8008afc4e4:      	strb	w21, [x8, #1608]
ffffff8008afc4e8:      	strb	w21, [x9, #1664]
ffffff8008afc4ec:      	str	w11, [x10, #1636]
ffffff8008afc4f0:      	str	w11, [x12, #1692]
ffffff8008afc4f4:      	strb	wzr, [x13, #1712]
ffffff8008afc4f8:      	bl	#8707140 <_raw_spin_unlock>
ffffff8008afc4fc:      	mov	x0, x19
ffffff8008afc500:      	bl	#-8708608 <printk>
ffffff8008afc504:      	adrp	x20, #23719936
ffffff8008afc508:      	ldrb	w2, [x20, #4028]
ffffff8008afc50c:      	mov	x0, sp
ffffff8008afc510:      	mov	w1, #4
ffffff8008afc514:      	str	w21, [sp]
ffffff8008afc518:      	bl	#-31680 <iWriteRegI2C>
ffffff8008afc51c:      	mov	w23, #8176
ffffff8008afc520:      	mov	w19, #100
ffffff8008afc524:      	mov	w21, #1280
ffffff8008afc528:      	adrp	x22, #23035904
ffffff8008afc52c:      	movk	w23, #16384, lsl #16
ffffff8008afc530:      	ldrb	w4, [x20, #4028]
ffffff8008afc534:      	add	x0, sp, #4
ffffff8008afc538:      	mov	x2, sp
ffffff8008afc53c:      	mov	w1, #2
ffffff8008afc540:      	mov	w3, #1
ffffff8008afc544:      	strh	wzr, [sp]
ffffff8008afc548:      	strh	w21, [sp, #4]
ffffff8008afc54c:      	bl	#-33232 <iReadRegI2C>
ffffff8008afc550:      	ldrh	w8, [sp]
ffffff8008afc554:      	cmp	w8, #255
ffffff8008afc558:      	b.eq	#32 <preview+0xf8>
ffffff8008afc55c:      	ldr	x8, [x22, #352]
ffffff8008afc560:      	mul	x8, x8, x23
ffffff8008afc564:      	lsr	x0, x8, #32
ffffff8008afc568:      	bl	#8573272 <__delay>
ffffff8008afc56c:      	subs	w19, w19, #1
ffffff8008afc570:      	b.ne	#-64 <preview+0xb0>
ffffff8008afc574:      	b	#16 <preview+0x104>
ffffff8008afc578:      	adrp	x0, #12095488
ffffff8008afc57c:      	add	x0, x0, #1214
ffffff8008afc580:      	bl	#-8708736 <printk>
ffffff8008afc584:      	ldrb	w2, [x20, #4028]
ffffff8008afc588:      	mov	w8, #17411
ffffff8008afc58c:      	movk	w8, #2048, lsl #16
ffffff8008afc590:      	mov	x0, sp
ffffff8008afc594:      	mov	w1, #4
ffffff8008afc598:      	str	w8, [sp]
ffffff8008afc59c:      	bl	#-31812 <iWriteRegI2C>
ffffff8008afc5a0:      	ldrb	w2, [x20, #4028]
ffffff8008afc5a4:      	mov	w8, #17923
ffffff8008afc5a8:      	movk	w8, #2048, lsl #16
ffffff8008afc5ac:      	mov	x0, sp
ffffff8008afc5b0:      	mov	w1, #4
ffffff8008afc5b4:      	str	w8, [sp]
ffffff8008afc5b8:      	bl	#-31840 <iWriteRegI2C>
ffffff8008afc5bc:      	ldrb	w2, [x20, #4028]
ffffff8008afc5c0:      	mov	w8, #18435
ffffff8008afc5c4:      	movk	w8, #30480, lsl #16
ffffff8008afc5c8:      	mov	x0, sp
ffffff8008afc5cc:      	mov	w1, #4
ffffff8008afc5d0:      	str	w8, [sp]
ffffff8008afc5d4:      	bl	#-31868 <iWriteRegI2C>
ffffff8008afc5d8:      	ldrb	w2, [x20, #4028]
ffffff8008afc5dc:      	mov	w8, #18947
ffffff8008afc5e0:      	movk	w8, #14092, lsl #16
ffffff8008afc5e4:      	mov	x0, sp
ffffff8008afc5e8:      	mov	w1, #4
ffffff8008afc5ec:      	str	w8, [sp]
ffffff8008afc5f0:      	bl	#-31896 <iWriteRegI2C>
ffffff8008afc5f4:      	ldrb	w2, [x20, #4028]
ffffff8008afc5f8:      	mov	w8, #19459
ffffff8008afc5fc:      	movk	w8, #14344, lsl #16
ffffff8008afc600:      	mov	x0, sp
ffffff8008afc604:      	mov	w1, #4
ffffff8008afc608:      	str	w8, [sp]
ffffff8008afc60c:      	bl	#-31924 <iWriteRegI2C>
ffffff8008afc610:      	ldrb	w2, [x20, #4028]
ffffff8008afc614:      	mov	w8, #19971
ffffff8008afc618:      	movk	w8, #6150, lsl #16
ffffff8008afc61c:      	mov	x0, sp
ffffff8008afc620:      	mov	w1, #4
ffffff8008afc624:      	str	w8, [sp]
ffffff8008afc628:      	bl	#-31952 <iWriteRegI2C>
ffffff8008afc62c:      	ldrb	w2, [x20, #4028]
ffffff8008afc630:      	mov	w8, #9
ffffff8008afc634:      	movk	w8, #8705, lsl #16
ffffff8008afc638:      	mov	x0, sp
ffffff8008afc63c:      	mov	w1, #4
ffffff8008afc640:      	str	w8, [sp]
ffffff8008afc644:      	bl	#-31980 <iWriteRegI2C>
ffffff8008afc648:      	ldrb	w2, [x20, #4028]
ffffff8008afc64c:      	mov	w8, #32771
ffffff8008afc650:      	movk	w8, #256, lsl #16
ffffff8008afc654:      	mov	x0, sp
ffffff8008afc658:      	mov	w1, #4
ffffff8008afc65c:      	str	w8, [sp]
ffffff8008afc660:      	bl	#-32008 <iWriteRegI2C>
ffffff8008afc664:      	ldrb	w2, [x20, #4028]
ffffff8008afc668:      	mov	w8, #33283
ffffff8008afc66c:      	movk	w8, #256, lsl #16
ffffff8008afc670:      	mov	x0, sp
ffffff8008afc674:      	mov	w1, #4
ffffff8008afc678:      	str	w8, [sp]
ffffff8008afc67c:      	bl	#-32036 <iWriteRegI2C>
ffffff8008afc680:      	ldrb	w2, [x20, #4028]
ffffff8008afc684:      	mov	w8, #33795
ffffff8008afc688:      	movk	w8, #256, lsl #16
ffffff8008afc68c:      	mov	x0, sp
ffffff8008afc690:      	mov	w1, #4
ffffff8008afc694:      	str	w8, [sp]
ffffff8008afc698:      	bl	#-32064 <iWriteRegI2C>
ffffff8008afc69c:      	ldrb	w2, [x20, #4028]
ffffff8008afc6a0:      	mov	w8, #34307
ffffff8008afc6a4:      	movk	w8, #768, lsl #16
ffffff8008afc6a8:      	mov	x0, sp
ffffff8008afc6ac:      	mov	w1, #4
ffffff8008afc6b0:      	str	w8, [sp]
ffffff8008afc6b4:      	bl	#-32092 <iWriteRegI2C>
ffffff8008afc6b8:      	ldrb	w2, [x20, #4028]
ffffff8008afc6bc:      	mov	w8, #5121
ffffff8008afc6c0:      	movk	w8, #12291, lsl #16
ffffff8008afc6c4:      	mov	x0, sp
ffffff8008afc6c8:      	mov	w1, #4
ffffff8008afc6cc:      	str	w8, [sp]
ffffff8008afc6d0:      	bl	#-32120 <iWriteRegI2C>
ffffff8008afc6d4:      	ldrb	w2, [x20, #4028]
ffffff8008afc6d8:      	mov	w8, #4097
ffffff8008afc6dc:      	movk	w8, #512, lsl #16
ffffff8008afc6e0:      	mov	x0, sp
ffffff8008afc6e4:      	mov	w1, #4
ffffff8008afc6e8:      	str	w8, [sp]
ffffff8008afc6ec:      	bl	#-32148 <iWriteRegI2C>
ffffff8008afc6f0:      	ldrb	w2, [x20, #4028]
ffffff8008afc6f4:      	mov	w8, #13825
ffffff8008afc6f8:      	movk	w8, #24, lsl #16
ffffff8008afc6fc:      	mov	x0, sp
ffffff8008afc700:      	mov	w1, #4
ffffff8008afc704:      	str	w8, [sp]
ffffff8008afc708:      	bl	#-32176 <iWriteRegI2C>
ffffff8008afc70c:      	ldrb	w2, [x20, #4028]
ffffff8008afc710:      	mov	w8, #1027
ffffff8008afc714:      	movk	w8, #1024, lsl #16
ffffff8008afc718:      	mov	x0, sp
ffffff8008afc71c:      	mov	w1, #4
ffffff8008afc720:      	str	w8, [sp]
ffffff8008afc724:      	bl	#-32204 <iWriteRegI2C>
ffffff8008afc728:      	ldrb	w2, [x20, #4028]
ffffff8008afc72c:      	mov	w8, #1539
ffffff8008afc730:      	movk	w8, #30720, lsl #16
ffffff8008afc734:      	mov	x0, sp
ffffff8008afc738:      	mov	w1, #4
ffffff8008afc73c:      	str	w8, [sp]
ffffff8008afc740:      	bl	#-32232 <iWriteRegI2C>
ffffff8008afc744:      	ldrb	w2, [x20, #4028]
ffffff8008afc748:      	mov	w19, #7740
ffffff8008afc74c:      	mov	x0, sp
ffffff8008afc750:      	mov	w1, #4
ffffff8008afc754:      	str	w19, [sp]
ffffff8008afc758:      	bl	#-32256 <iWriteRegI2C>
ffffff8008afc75c:      	ldrb	w2, [x20, #4028]
ffffff8008afc760:      	mov	w8, #3075
ffffff8008afc764:      	movk	w8, #768, lsl #16
ffffff8008afc768:      	mov	x0, sp
ffffff8008afc76c:      	mov	w1, #4
ffffff8008afc770:      	str	w8, [sp]
ffffff8008afc774:      	bl	#-32284 <iWriteRegI2C>
ffffff8008afc778:      	ldrb	w2, [x20, #4028]
ffffff8008afc77c:      	mov	w8, #3587
ffffff8008afc780:      	movk	w8, #18176, lsl #16
ffffff8008afc784:      	mov	x0, sp
ffffff8008afc788:      	mov	w1, #4
ffffff8008afc78c:      	str	w8, [sp]
ffffff8008afc790:      	bl	#-32312 <iWriteRegI2C>
ffffff8008afc794:      	ldrb	w2, [x20, #4028]
ffffff8008afc798:      	mov	w8, #5692
ffffff8008afc79c:      	movk	w8, #256, lsl #16
ffffff8008afc7a0:      	mov	x0, sp
ffffff8008afc7a4:      	mov	w1, #4
ffffff8008afc7a8:      	str	w8, [sp]
ffffff8008afc7ac:      	bl	#-32340 <iWriteRegI2C>
ffffff8008afc7b0:      	ldrb	w2, [x20, #4028]
ffffff8008afc7b4:      	mov	w8, #3
ffffff8008afc7b8:      	movk	w8, #1536, lsl #16
ffffff8008afc7bc:      	mov	x0, sp
ffffff8008afc7c0:      	mov	w1, #4
ffffff8008afc7c4:      	str	w8, [sp]
ffffff8008afc7c8:      	bl	#-32368 <iWriteRegI2C>
ffffff8008afc7cc:      	ldrb	w2, [x20, #4028]
ffffff8008afc7d0:      	mov	w8, #16899
ffffff8008afc7d4:      	movk	w8, #8211, lsl #16
ffffff8008afc7d8:      	mov	x0, sp
ffffff8008afc7dc:      	mov	w1, #4
ffffff8008afc7e0:      	str	w8, [sp]
ffffff8008afc7e4:      	bl	#-32396 <iWriteRegI2C>
ffffff8008afc7e8:      	ldrb	w2, [x20, #4028]
ffffff8008afc7ec:      	mov	w8, #16387
ffffff8008afc7f0:      	movk	w8, #48140, lsl #16
ffffff8008afc7f4:      	mov	x0, sp
ffffff8008afc7f8:      	mov	w1, #4
ffffff8008afc7fc:      	str	w8, [sp]
ffffff8008afc800:      	bl	#-32424 <iWriteRegI2C>
ffffff8008afc804:      	ldrb	w2, [x20, #4028]
ffffff8008afc808:      	mov	w8, #50232
ffffff8008afc80c:      	movk	w8, #1024, lsl #16
ffffff8008afc810:      	mov	x0, sp
ffffff8008afc814:      	mov	w1, #4
ffffff8008afc818:      	str	w8, [sp]
ffffff8008afc81c:      	bl	#-32452 <iWriteRegI2C>
ffffff8008afc820:      	ldrb	w2, [x20, #4028]
ffffff8008afc824:      	mov	w8, #55352
ffffff8008afc828:      	movk	w8, #4352, lsl #16
ffffff8008afc82c:      	mov	x0, sp
ffffff8008afc830:      	mov	w1, #4
ffffff8008afc834:      	str	w8, [sp]
ffffff8008afc838:      	bl	#-32480 <iWriteRegI2C>
ffffff8008afc83c:      	ldrb	w2, [x20, #4028]
ffffff8008afc840:      	mov	w8, #55864
ffffff8008afc844:      	movk	w8, #1280, lsl #16
ffffff8008afc848:      	mov	x0, sp
ffffff8008afc84c:      	mov	w1, #4
ffffff8008afc850:      	str	w8, [sp]
ffffff8008afc854:      	bl	#-32508 <iWriteRegI2C>
ffffff8008afc858:      	ldrb	w2, [x20, #4028]
ffffff8008afc85c:      	mov	w8, #56376
ffffff8008afc860:      	movk	w8, #1280, lsl #16
ffffff8008afc864:      	mov	x0, sp
ffffff8008afc868:      	mov	w1, #4
ffffff8008afc86c:      	str	w8, [sp]
ffffff8008afc870:      	bl	#-32536 <iWriteRegI2C>
ffffff8008afc874:      	ldrb	w2, [x20, #4028]
ffffff8008afc878:      	mov	w8, #49720
ffffff8008afc87c:      	movk	w8, #1280, lsl #16
ffffff8008afc880:      	mov	x0, sp
ffffff8008afc884:      	mov	w1, #4
ffffff8008afc888:      	str	w8, [sp]
ffffff8008afc88c:      	bl	#-32564 <iWriteRegI2C>
ffffff8008afc890:      	ldrb	w2, [x20, #4028]
ffffff8008afc894:      	mov	w8, #49208
ffffff8008afc898:      	movk	w8, #1024, lsl #16
ffffff8008afc89c:      	mov	x0, sp
ffffff8008afc8a0:      	mov	w1, #4
ffffff8008afc8a4:      	str	w8, [sp]
ffffff8008afc8a8:      	bl	#-32592 <iWriteRegI2C>
ffffff8008afc8ac:      	ldrb	w2, [x20, #4028]
ffffff8008afc8b0:      	mov	w8, #54840
ffffff8008afc8b4:      	movk	w8, #1024, lsl #16
ffffff8008afc8b8:      	mov	x0, sp
ffffff8008afc8bc:      	mov	w1, #4
ffffff8008afc8c0:      	str	w8, [sp]
ffffff8008afc8c4:      	bl	#-32620 <iWriteRegI2C>
ffffff8008afc8c8:      	ldrb	w2, [x20, #4028]
ffffff8008afc8cc:      	mov	w8, #54328
ffffff8008afc8d0:      	movk	w8, #1024, lsl #16
ffffff8008afc8d4:      	mov	x0, sp
ffffff8008afc8d8:      	mov	w1, #4
ffffff8008afc8dc:      	str	w8, [sp]
ffffff8008afc8e0:      	bl	#-32648 <iWriteRegI2C>
ffffff8008afc8e4:      	ldrb	w2, [x20, #4028]
ffffff8008afc8e8:      	mov	w8, #45112
ffffff8008afc8ec:      	movk	w8, #1792, lsl #16
ffffff8008afc8f0:      	mov	x0, sp
ffffff8008afc8f4:      	mov	w1, #4
ffffff8008afc8f8:      	str	w8, [sp]
ffffff8008afc8fc:      	bl	#-32676 <iWriteRegI2C>
ffffff8008afc900:      	ldrb	w2, [x20, #4028]
ffffff8008afc904:      	mov	w8, #12857
ffffff8008afc908:      	movk	w8, #16, lsl #16
ffffff8008afc90c:      	mov	x0, sp
ffffff8008afc910:      	mov	w1, #4
ffffff8008afc914:      	str	w8, [sp]
ffffff8008afc918:      	bl	#-32704 <iWriteRegI2C>
ffffff8008afc91c:      	ldrb	w2, [x20, #4028]
ffffff8008afc920:      	mov	w8, #14393
ffffff8008afc924:      	movk	w8, #3072, lsl #16
ffffff8008afc928:      	mov	x0, sp
ffffff8008afc92c:      	mov	w1, #4
ffffff8008afc930:      	str	w8, [sp]
ffffff8008afc934:      	bl	#-32732 <iWriteRegI2C>
ffffff8008afc938:      	ldrb	w2, [x20, #4028]
ffffff8008afc93c:      	mov	w8, #8200
ffffff8008afc940:      	movk	w8, #14338, lsl #16
ffffff8008afc944:      	mov	x0, sp
ffffff8008afc948:      	mov	w1, #4
ffffff8008afc94c:      	str	w8, [sp]
ffffff8008afc950:      	bl	#-32760 <iWriteRegI2C>
ffffff8008afc954:      	ldrb	w2, [x20, #4028]
ffffff8008afc958:      	mov	w8, #3128
ffffff8008afc95c:      	movk	w8, #18688, lsl #16
ffffff8008afc960:      	mov	x0, sp
ffffff8008afc964:      	mov	w1, #4
ffffff8008afc968:      	str	w8, [sp]
ffffff8008afc96c:      	bl	#-32788 <iWriteRegI2C>
ffffff8008afc970:      	ldrb	w2, [x20, #4028]
ffffff8008afc974:      	mov	w8, #25648
ffffff8008afc978:      	movk	w8, #53227, lsl #16
ffffff8008afc97c:      	mov	x0, sp
ffffff8008afc980:      	mov	w1, #4
ffffff8008afc984:      	str	w8, [sp]
ffffff8008afc988:      	bl	#-32816 <iWriteRegI2C>
ffffff8008afc98c:      	ldrb	w2, [x20, #4028]
ffffff8008afc990:      	mov	w8, #39984
ffffff8008afc994:      	movk	w8, #6, lsl #16
ffffff8008afc998:      	mov	x0, sp
ffffff8008afc99c:      	mov	w1, #4
ffffff8008afc9a0:      	str	w8, [sp]
ffffff8008afc9a4:      	bl	#-32844 <iWriteRegI2C>
ffffff8008afc9a8:      	ldrb	w2, [x20, #4028]
ffffff8008afc9ac:      	mov	w8, #36912
ffffff8008afc9b0:      	movk	w8, #128, lsl #16
ffffff8008afc9b4:      	mov	x0, sp
ffffff8008afc9b8:      	mov	w1, #4
ffffff8008afc9bc:      	str	w8, [sp]
ffffff8008afc9c0:      	bl	#-32872 <iWriteRegI2C>
ffffff8008afc9c4:      	ldrb	w2, [x20, #4028]
ffffff8008afc9c8:      	mov	w8, #14386
ffffff8008afc9cc:      	movk	w8, #2816, lsl #16
ffffff8008afc9d0:      	mov	x0, sp
ffffff8008afc9d4:      	mov	w1, #4
ffffff8008afc9d8:      	str	w8, [sp]
ffffff8008afc9dc:      	bl	#-32900 <iWriteRegI2C>
ffffff8008afc9e0:      	ldrb	w2, [x20, #4028]
ffffff8008afc9e4:      	mov	w8, #18993
ffffff8008afc9e8:      	movk	w8, #607, lsl #16
ffffff8008afc9ec:      	mov	x0, sp
ffffff8008afc9f0:      	mov	w1, #4
ffffff8008afc9f4:      	str	w8, [sp]
ffffff8008afc9f8:      	bl	#-32928 <iWriteRegI2C>
ffffff8008afc9fc:      	ldrb	w2, [x20, #4028]
ffffff8008afca00:      	mov	w8, #45618
ffffff8008afca04:      	movk	w8, #768, lsl #16
ffffff8008afca08:      	mov	x0, sp
ffffff8008afca0c:      	mov	w1, #4
ffffff8008afca10:      	str	w8, [sp]
ffffff8008afca14:      	bl	#-32956 <iWriteRegI2C>
ffffff8008afca18:      	ldrb	w2, [x20, #4028]
ffffff8008afca1c:      	mov	w8, #46130
ffffff8008afca20:      	movk	w8, #768, lsl #16
ffffff8008afca24:      	mov	x0, sp
ffffff8008afca28:      	mov	w1, #4
ffffff8008afca2c:      	str	w8, [sp]
ffffff8008afca30:      	bl	#-32984 <iWriteRegI2C>
ffffff8008afca34:      	ldrb	w2, [x20, #4028]
ffffff8008afca38:      	mov	w8, #46642
ffffff8008afca3c:      	movk	w8, #768, lsl #16
ffffff8008afca40:      	mov	x0, sp
ffffff8008afca44:      	mov	w1, #4
ffffff8008afca48:      	str	w8, [sp]
ffffff8008afca4c:      	bl	#-33012 <iWriteRegI2C>
ffffff8008afca50:      	ldrb	w2, [x20, #4028]
ffffff8008afca54:      	mov	w8, #47154
ffffff8008afca58:      	movk	w8, #768, lsl #16
ffffff8008afca5c:      	mov	x0, sp
ffffff8008afca60:      	mov	w1, #4
ffffff8008afca64:      	str	w8, [sp]
ffffff8008afca68:      	bl	#-33040 <iWriteRegI2C>
ffffff8008afca6c:      	ldrb	w2, [x20, #4028]
ffffff8008afca70:      	mov	w8, #51
ffffff8008afca74:      	mov	x0, sp
ffffff8008afca78:      	mov	w1, #4
ffffff8008afca7c:      	str	w8, [sp]
ffffff8008afca80:      	bl	#-33064 <iWriteRegI2C>
ffffff8008afca84:      	ldrb	w2, [x20, #4028]
ffffff8008afca88:      	mov	w8, #52
ffffff8008afca8c:      	mov	x0, sp
ffffff8008afca90:      	mov	w1, #4
ffffff8008afca94:      	str	w8, [sp]
ffffff8008afca98:      	bl	#-33088 <iWriteRegI2C>
ffffff8008afca9c:      	ldrb	w2, [x20, #4028]
ffffff8008afcaa0:      	mov	w8, #564
ffffff8008afcaa4:      	movk	w8, #16462, lsl #16
ffffff8008afcaa8:      	mov	x0, sp
ffffff8008afcaac:      	mov	w1, #4
ffffff8008afcab0:      	str	w8, [sp]
ffffff8008afcab4:      	bl	#-33116 <iWriteRegI2C>
ffffff8008afcab8:      	ldrb	w2, [x20, #4028]
ffffff8008afcabc:      	mov	w8, #45618
ffffff8008afcac0:      	movk	w8, #2048, lsl #16
ffffff8008afcac4:      	mov	x0, sp
ffffff8008afcac8:      	mov	w1, #4
ffffff8008afcacc:      	str	w8, [sp]
ffffff8008afcad0:      	bl	#-33144 <iWriteRegI2C>
ffffff8008afcad4:      	ldrb	w2, [x20, #4028]
ffffff8008afcad8:      	mov	w8, #46130
ffffff8008afcadc:      	movk	w8, #2048, lsl #16
ffffff8008afcae0:      	mov	x0, sp
ffffff8008afcae4:      	mov	w1, #4
ffffff8008afcae8:      	str	w8, [sp]
ffffff8008afcaec:      	bl	#-33172 <iWriteRegI2C>
ffffff8008afcaf0:      	ldrb	w2, [x20, #4028]
ffffff8008afcaf4:      	mov	w8, #46642
ffffff8008afcaf8:      	movk	w8, #2048, lsl #16
ffffff8008afcafc:      	mov	x0, sp
ffffff8008afcb00:      	mov	w1, #4
ffffff8008afcb04:      	str	w8, [sp]
ffffff8008afcb08:      	bl	#-33200 <iWriteRegI2C>
ffffff8008afcb0c:      	ldrb	w2, [x20, #4028]
ffffff8008afcb10:      	mov	w8, #47154
ffffff8008afcb14:      	movk	w8, #2048, lsl #16
ffffff8008afcb18:      	mov	x0, sp
ffffff8008afcb1c:      	mov	w1, #4
ffffff8008afcb20:      	str	w8, [sp]
ffffff8008afcb24:      	bl	#-33228 <iWriteRegI2C>
ffffff8008afcb28:      	ldrb	w2, [x20, #4028]
ffffff8008afcb2c:      	mov	w8, #13372
ffffff8008afcb30:      	movk	w8, #2048, lsl #16
ffffff8008afcb34:      	mov	x0, sp
ffffff8008afcb38:      	mov	w1, #4
ffffff8008afcb3c:      	str	w8, [sp]
ffffff8008afcb40:      	bl	#-33256 <iWriteRegI2C>
ffffff8008afcb44:      	ldrb	w2, [x20, #4028]
ffffff8008afcb48:      	mov	w8, #13884
ffffff8008afcb4c:      	mov	x0, sp
ffffff8008afcb50:      	mov	w1, #4
ffffff8008afcb54:      	str	w8, [sp]
ffffff8008afcb58:      	bl	#-33280 <iWriteRegI2C>
ffffff8008afcb5c:      	ldrb	w2, [x20, #4028]
ffffff8008afcb60:      	mov	w8, #14396
ffffff8008afcb64:      	mov	x0, sp
ffffff8008afcb68:      	mov	w1, #4
ffffff8008afcb6c:      	str	w8, [sp]
ffffff8008afcb70:      	bl	#-33304 <iWriteRegI2C>
ffffff8008afcb74:      	ldrb	w2, [x20, #4028]
ffffff8008afcb78:      	mov	w8, #15929
ffffff8008afcb7c:      	movk	w8, #64, lsl #16
ffffff8008afcb80:      	mov	x0, sp
ffffff8008afcb84:      	mov	w1, #4
ffffff8008afcb88:      	str	w8, [sp]
ffffff8008afcb8c:      	bl	#-33332 <iWriteRegI2C>
ffffff8008afcb90:      	ldrb	w2, [x20, #4028]
ffffff8008afcb94:      	mov	w8, #7740
ffffff8008afcb98:      	movk	w8, #1, lsl #16
ffffff8008afcb9c:      	mov	x0, sp
ffffff8008afcba0:      	mov	w1, #4
ffffff8008afcba4:      	str	w8, [sp]
ffffff8008afcba8:      	bl	#-33360 <iWriteRegI2C>
ffffff8008afcbac:      	ldrb	w2, [x20, #4028]
ffffff8008afcbb0:      	mov	w8, #65537
ffffff8008afcbb4:      	mov	x0, sp
ffffff8008afcbb8:      	mov	w1, #4
ffffff8008afcbbc:      	str	w8, [sp]
ffffff8008afcbc0:      	bl	#-33384 <iWriteRegI2C>
ffffff8008afcbc4:      	ldrb	w2, [x20, #4028]
ffffff8008afcbc8:      	mov	x0, sp
ffffff8008afcbcc:      	mov	w1, #4
ffffff8008afcbd0:      	str	w19, [sp]
ffffff8008afcbd4:      	bl	#-33404 <iWriteRegI2C>
ffffff8008afcbd8:      	adrp	x0, #13467648
ffffff8008afcbdc:      	add	x0, x0, #749
ffffff8008afcbe0:      	mov	w1, wzr
ffffff8008afcbe4:      	bl	#-8710372 <printk>
ffffff8008afcbe8:      	adrp	x19, #28655616
ffffff8008afcbec:      	add	x19, x19, #1572
ffffff8008afcbf0:      	mov	x0, x19
ffffff8008afcbf4:      	bl	#8705064 <_raw_spin_lock>
ffffff8008afcbf8:      	mov	x0, x19
ffffff8008afcbfc:      	bl	#8705344 <_raw_spin_unlock>
ffffff8008afcc00:      	ldrb	w2, [x20, #4028]
ffffff8008afcc04:      	mov	w8, #257
ffffff8008afcc08:      	mov	x0, sp
ffffff8008afcc0c:      	mov	w1, #4
ffffff8008afcc10:      	str	w8, [sp]
ffffff8008afcc14:      	bl	#-33468 <iWriteRegI2C>
ffffff8008afcc18:      	adrp	x9, #22761472
ffffff8008afcc1c:      	ldr	x8, [sp, #8]
ffffff8008afcc20:      	ldr	x9, [x9, #4088]
ffffff8008afcc24:      	cmp	x9, x8
ffffff8008afcc28:      	b.ne	#28 <preview+0x7c4>
ffffff8008afcc2c:      	ldp	x20, x19, [sp, #64]
ffffff8008afcc30:      	ldp	x22, x21, [sp, #48]
ffffff8008afcc34:      	ldr	x23, [sp, #32]
ffffff8008afcc38:      	ldp	x29, x30, [sp, #16]
ffffff8008afcc3c:      	add	sp, sp, #80
ffffff8008afcc40:      	ret
ffffff8008afcc44:      	bl	#-9351052 <__stack_chk_fail>
