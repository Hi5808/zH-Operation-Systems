
vmlinux.elf:	file format ELF64-aarch64-little


Disassembly of section .kernel:

ffffff8008b1fdcc capture_setting:
ffffff8008b1fdcc:      	sub	sp, sp, #80
ffffff8008b1fdd0:      	stp	x29, x30, [sp, #16]
ffffff8008b1fdd4:      	str	x23, [sp, #32]
ffffff8008b1fdd8:      	stp	x22, x21, [sp, #48]
ffffff8008b1fddc:      	stp	x20, x19, [sp, #64]
ffffff8008b1fde0:      	add	x29, sp, #16
ffffff8008b1fde4:      	adrp	x8, #22618112
ffffff8008b1fde8:      	ldr	x8, [x8, #4088]
ffffff8008b1fdec:      	and	w19, w0, #0xffff
ffffff8008b1fdf0:      	adrp	x0, #13193216
ffffff8008b1fdf4:      	add	x0, x0, #181
ffffff8008b1fdf8:      	mov	w1, w19
ffffff8008b1fdfc:      	str	x8, [sp, #8]
ffffff8008b1fe00:      	bl	#-8854272 <printk>
ffffff8008b1fe04:      	cmp	w19, #150
ffffff8008b1fe08:      	adrp	x20, #23576576
ffffff8008b1fe0c:      	b.eq	#136 <capture_setting+0xc8>
ffffff8008b1fe10:      	cmp	w19, #240
ffffff8008b1fe14:      	b.eq	#256 <capture_setting+0x148>
ffffff8008b1fe18:      	cmp	w19, #300
ffffff8008b1fe1c:      	b.ne	#376 <capture_setting+0x1c8>
ffffff8008b1fe20:      	ldrb	w2, [x20, #4028]
ffffff8008b1fe24:      	mov	w19, #8176
ffffff8008b1fe28:      	mov	w8, #1
ffffff8008b1fe2c:      	mov	x0, sp
ffffff8008b1fe30:      	mov	w1, #4
ffffff8008b1fe34:      	movk	w19, #16384, lsl #16
ffffff8008b1fe38:      	str	w8, [sp]
ffffff8008b1fe3c:      	bl	#-177380 <iWriteRegI2C>
ffffff8008b1fe40:      	mov	w21, #100
ffffff8008b1fe44:      	mov	w22, #1280
ffffff8008b1fe48:      	adrp	x23, #22892544
ffffff8008b1fe4c:      	ldrb	w4, [x20, #4028]
ffffff8008b1fe50:      	add	x0, sp, #4
ffffff8008b1fe54:      	mov	x2, sp
ffffff8008b1fe58:      	mov	w1, #2
ffffff8008b1fe5c:      	mov	w3, #1
ffffff8008b1fe60:      	strh	wzr, [sp]
ffffff8008b1fe64:      	strh	w22, [sp, #4]
ffffff8008b1fe68:      	bl	#-178924 <iReadRegI2C>
ffffff8008b1fe6c:      	ldrh	w8, [sp]
ffffff8008b1fe70:      	cmp	w8, #255
ffffff8008b1fe74:      	b.eq	#1048 <capture_setting+0x4c0>
ffffff8008b1fe78:      	ldr	x8, [x23, #352]
ffffff8008b1fe7c:      	mul	x8, x8, x19
ffffff8008b1fe80:      	lsr	x0, x8, #32
ffffff8008b1fe84:      	bl	#8427580 <__delay>
ffffff8008b1fe88:      	subs	w21, w21, #1
ffffff8008b1fe8c:      	b.ne	#-64 <capture_setting+0x80>
ffffff8008b1fe90:      	b	#1032 <capture_setting+0x4cc>
ffffff8008b1fe94:      	adrp	x0, #13742080
ffffff8008b1fe98:      	mov	w19, #8176
ffffff8008b1fe9c:      	add	x0, x0, #518
ffffff8008b1fea0:      	movk	w19, #16384, lsl #16
ffffff8008b1fea4:      	bl	#-8854436 <printk>
ffffff8008b1fea8:      	ldrb	w2, [x20, #4028]
ffffff8008b1feac:      	mov	w8, #1
ffffff8008b1feb0:      	mov	x0, sp
ffffff8008b1feb4:      	mov	w1, #4
ffffff8008b1feb8:      	str	w8, [sp]
ffffff8008b1febc:      	bl	#-177508 <iWriteRegI2C>
ffffff8008b1fec0:      	mov	w21, #100
ffffff8008b1fec4:      	mov	w22, #1280
ffffff8008b1fec8:      	adrp	x23, #22892544
ffffff8008b1fecc:      	ldrb	w4, [x20, #4028]
ffffff8008b1fed0:      	add	x0, sp, #4
ffffff8008b1fed4:      	mov	x2, sp
ffffff8008b1fed8:      	mov	w1, #2
ffffff8008b1fedc:      	mov	w3, #1
ffffff8008b1fee0:      	strh	wzr, [sp]
ffffff8008b1fee4:      	strh	w22, [sp, #4]
ffffff8008b1fee8:      	bl	#-179052 <iReadRegI2C>
ffffff8008b1feec:      	ldrh	w8, [sp]
ffffff8008b1fef0:      	cmp	w8, #255
ffffff8008b1fef4:      	b.eq	#288 <capture_setting+0x248>
ffffff8008b1fef8:      	ldr	x8, [x23, #352]
ffffff8008b1fefc:      	mul	x8, x8, x19
ffffff8008b1ff00:      	lsr	x0, x8, #32
ffffff8008b1ff04:      	bl	#8427452 <__delay>
ffffff8008b1ff08:      	subs	w21, w21, #1
ffffff8008b1ff0c:      	b.ne	#-64 <capture_setting+0x100>
ffffff8008b1ff10:      	b	#272 <capture_setting+0x254>
ffffff8008b1ff14:      	adrp	x0, #13742080
ffffff8008b1ff18:      	mov	w19, #8176
ffffff8008b1ff1c:      	add	x0, x0, #545
ffffff8008b1ff20:      	movk	w19, #16384, lsl #16
ffffff8008b1ff24:      	bl	#-8854564 <printk>
ffffff8008b1ff28:      	ldrb	w2, [x20, #4028]
ffffff8008b1ff2c:      	mov	w8, #1
ffffff8008b1ff30:      	mov	x0, sp
ffffff8008b1ff34:      	mov	w1, #4
ffffff8008b1ff38:      	str	w8, [sp]
ffffff8008b1ff3c:      	bl	#-177636 <iWriteRegI2C>
ffffff8008b1ff40:      	mov	w21, #100
ffffff8008b1ff44:      	mov	w22, #1280
ffffff8008b1ff48:      	adrp	x23, #22892544
ffffff8008b1ff4c:      	ldrb	w4, [x20, #4028]
ffffff8008b1ff50:      	add	x0, sp, #4
ffffff8008b1ff54:      	mov	x2, sp
ffffff8008b1ff58:      	mov	w1, #2
ffffff8008b1ff5c:      	mov	w3, #1
ffffff8008b1ff60:      	strh	wzr, [sp]
ffffff8008b1ff64:      	strh	w22, [sp, #4]
ffffff8008b1ff68:      	bl	#-179180 <iReadRegI2C>
ffffff8008b1ff6c:      	ldrh	w8, [sp]
ffffff8008b1ff70:      	cmp	w8, #255
ffffff8008b1ff74:      	b.eq	#1424 <capture_setting+0x738>
ffffff8008b1ff78:      	ldr	x8, [x23, #352]
ffffff8008b1ff7c:      	mul	x8, x8, x19
ffffff8008b1ff80:      	lsr	x0, x8, #32
ffffff8008b1ff84:      	bl	#8427324 <__delay>
ffffff8008b1ff88:      	subs	w21, w21, #1
ffffff8008b1ff8c:      	b.ne	#-64 <capture_setting+0x180>
ffffff8008b1ff90:      	b	#1408 <capture_setting+0x744>
ffffff8008b1ff94:      	adrp	x0, #12759040
ffffff8008b1ff98:      	mov	w19, #8176
ffffff8008b1ff9c:      	add	x0, x0, #1254
ffffff8008b1ffa0:      	movk	w19, #16384, lsl #16
ffffff8008b1ffa4:      	bl	#-8854692 <printk>
ffffff8008b1ffa8:      	ldrb	w2, [x20, #4028]
ffffff8008b1ffac:      	mov	w8, #1
ffffff8008b1ffb0:      	mov	x0, sp
ffffff8008b1ffb4:      	mov	w1, #4
ffffff8008b1ffb8:      	str	w8, [sp]
ffffff8008b1ffbc:      	bl	#-177764 <iWriteRegI2C>
ffffff8008b1ffc0:      	mov	w21, #100
ffffff8008b1ffc4:      	mov	w22, #1280
ffffff8008b1ffc8:      	adrp	x23, #22892544
ffffff8008b1ffcc:      	ldrb	w4, [x20, #4028]
ffffff8008b1ffd0:      	add	x0, sp, #4
ffffff8008b1ffd4:      	mov	x2, sp
ffffff8008b1ffd8:      	mov	w1, #2
ffffff8008b1ffdc:      	mov	w3, #1
ffffff8008b1ffe0:      	strh	wzr, [sp]
ffffff8008b1ffe4:      	strh	w22, [sp, #4]
ffffff8008b1ffe8:      	bl	#-179308 <iReadRegI2C>
ffffff8008b1ffec:      	ldrh	w8, [sp]
ffffff8008b1fff0:      	cmp	w8, #255
ffffff8008b1fff4:      	b.eq	#32 <capture_setting+0x248>
ffffff8008b1fff8:      	ldr	x8, [x23, #352]
ffffff8008b1fffc:      	mul	x8, x8, x19
ffffff8008b20000:      	lsr	x0, x8, #32
ffffff8008b20004:      	bl	#8427196 <__delay>
ffffff8008b20008:      	subs	w21, w21, #1
ffffff8008b2000c:      	b.ne	#-64 <capture_setting+0x200>
ffffff8008b20010:      	b	#16 <capture_setting+0x254>
ffffff8008b20014:      	adrp	x0, #11948032
ffffff8008b20018:      	add	x0, x0, #1214
ffffff8008b2001c:      	bl	#-8854812 <printk>
ffffff8008b20020:      	ldrb	w2, [x20, #4028]
ffffff8008b20024:      	mov	w8, #17411
ffffff8008b20028:      	movk	w8, #2048, lsl #16
ffffff8008b2002c:      	mov	x0, sp
ffffff8008b20030:      	mov	w1, #4
ffffff8008b20034:      	str	w8, [sp]
ffffff8008b20038:      	bl	#-177888 <iWriteRegI2C>
ffffff8008b2003c:      	ldrb	w2, [x20, #4028]
ffffff8008b20040:      	mov	w8, #17923
ffffff8008b20044:      	movk	w8, #2048, lsl #16
ffffff8008b20048:      	mov	x0, sp
ffffff8008b2004c:      	mov	w1, #4
ffffff8008b20050:      	str	w8, [sp]
ffffff8008b20054:      	bl	#-177916 <iWriteRegI2C>
ffffff8008b20058:      	ldrb	w2, [x20, #4028]
ffffff8008b2005c:      	mov	w8, #18435
ffffff8008b20060:      	movk	w8, #30480, lsl #16
ffffff8008b20064:      	mov	x0, sp
ffffff8008b20068:      	mov	w1, #4
ffffff8008b2006c:      	str	w8, [sp]
ffffff8008b20070:      	bl	#-177944 <iWriteRegI2C>
ffffff8008b20074:      	ldrb	w2, [x20, #4028]
ffffff8008b20078:      	mov	w8, #18947
ffffff8008b2007c:      	movk	w8, #14092, lsl #16
ffffff8008b20080:      	mov	x0, sp
ffffff8008b20084:      	mov	w1, #4
ffffff8008b20088:      	str	w8, [sp]
ffffff8008b2008c:      	bl	#-177972 <iWriteRegI2C>
ffffff8008b20090:      	ldrb	w2, [x20, #4028]
ffffff8008b20094:      	mov	w8, #19459
ffffff8008b20098:      	movk	w8, #28688, lsl #16
ffffff8008b2009c:      	mov	x0, sp
ffffff8008b200a0:      	mov	w1, #4
ffffff8008b200a4:      	str	w8, [sp]
ffffff8008b200a8:      	bl	#-178000 <iWriteRegI2C>
ffffff8008b200ac:      	ldrb	w2, [x20, #4028]
ffffff8008b200b0:      	mov	w8, #19971
ffffff8008b200b4:      	movk	w8, #12300, lsl #16
ffffff8008b200b8:      	mov	x0, sp
ffffff8008b200bc:      	mov	w1, #4
ffffff8008b200c0:      	str	w8, [sp]
ffffff8008b200c4:      	bl	#-178028 <iWriteRegI2C>
ffffff8008b200c8:      	ldrb	w2, [x20, #4028]
ffffff8008b200cc:      	mov	w8, #9
ffffff8008b200d0:      	mov	x0, sp
ffffff8008b200d4:      	mov	w1, #4
ffffff8008b200d8:      	str	w8, [sp]
ffffff8008b200dc:      	bl	#-178052 <iWriteRegI2C>
ffffff8008b200e0:      	ldrb	w2, [x20, #4028]
ffffff8008b200e4:      	mov	w8, #32771
ffffff8008b200e8:      	movk	w8, #256, lsl #16
ffffff8008b200ec:      	mov	x0, sp
ffffff8008b200f0:      	mov	w1, #4
ffffff8008b200f4:      	str	w8, [sp]
ffffff8008b200f8:      	bl	#-178080 <iWriteRegI2C>
ffffff8008b200fc:      	ldrb	w2, [x20, #4028]
ffffff8008b20100:      	mov	w8, #33283
ffffff8008b20104:      	movk	w8, #256, lsl #16
ffffff8008b20108:      	mov	x0, sp
ffffff8008b2010c:      	mov	w1, #4
ffffff8008b20110:      	str	w8, [sp]
ffffff8008b20114:      	bl	#-178108 <iWriteRegI2C>
ffffff8008b20118:      	ldrb	w2, [x20, #4028]
ffffff8008b2011c:      	mov	w8, #33795
ffffff8008b20120:      	movk	w8, #256, lsl #16
ffffff8008b20124:      	mov	x0, sp
ffffff8008b20128:      	mov	w1, #4
ffffff8008b2012c:      	str	w8, [sp]
ffffff8008b20130:      	bl	#-178136 <iWriteRegI2C>
ffffff8008b20134:      	ldrb	w2, [x20, #4028]
ffffff8008b20138:      	mov	w8, #34307
ffffff8008b2013c:      	movk	w8, #256, lsl #16
ffffff8008b20140:      	mov	x0, sp
ffffff8008b20144:      	mov	w1, #4
ffffff8008b20148:      	str	w8, [sp]
ffffff8008b2014c:      	bl	#-178164 <iWriteRegI2C>
ffffff8008b20150:      	ldrb	w2, [x20, #4028]
ffffff8008b20154:      	mov	w8, #5121
ffffff8008b20158:      	movk	w8, #12291, lsl #16
ffffff8008b2015c:      	mov	x0, sp
ffffff8008b20160:      	mov	w1, #4
ffffff8008b20164:      	str	w8, [sp]
ffffff8008b20168:      	bl	#-178192 <iWriteRegI2C>
ffffff8008b2016c:      	ldrb	w2, [x20, #4028]
ffffff8008b20170:      	mov	w8, #4097
ffffff8008b20174:      	movk	w8, #512, lsl #16
ffffff8008b20178:      	mov	x0, sp
ffffff8008b2017c:      	mov	w1, #4
ffffff8008b20180:      	str	w8, [sp]
ffffff8008b20184:      	bl	#-178220 <iWriteRegI2C>
ffffff8008b20188:      	ldrb	w2, [x20, #4028]
ffffff8008b2018c:      	mov	w8, #13825
ffffff8008b20190:      	movk	w8, #24, lsl #16
ffffff8008b20194:      	mov	x0, sp
ffffff8008b20198:      	mov	w1, #4
ffffff8008b2019c:      	str	w8, [sp]
ffffff8008b201a0:      	bl	#-178248 <iWriteRegI2C>
ffffff8008b201a4:      	ldrb	w2, [x20, #4028]
ffffff8008b201a8:      	mov	w8, #1027
ffffff8008b201ac:      	movk	w8, #1024, lsl #16
ffffff8008b201b0:      	mov	x0, sp
ffffff8008b201b4:      	mov	w1, #4
ffffff8008b201b8:      	str	w8, [sp]
ffffff8008b201bc:      	bl	#-178276 <iWriteRegI2C>
ffffff8008b201c0:      	ldrb	w2, [x20, #4028]
ffffff8008b201c4:      	mov	w8, #1539
ffffff8008b201c8:      	movk	w8, #30720, lsl #16
ffffff8008b201cc:      	mov	x0, sp
ffffff8008b201d0:      	mov	w1, #4
ffffff8008b201d4:      	str	w8, [sp]
ffffff8008b201d8:      	bl	#-178304 <iWriteRegI2C>
ffffff8008b201dc:      	ldrb	w2, [x20, #4028]
ffffff8008b201e0:      	mov	w19, #7740
ffffff8008b201e4:      	mov	x0, sp
ffffff8008b201e8:      	mov	w1, #4
ffffff8008b201ec:      	str	w19, [sp]
ffffff8008b201f0:      	bl	#-178328 <iWriteRegI2C>
ffffff8008b201f4:      	ldrb	w2, [x20, #4028]
ffffff8008b201f8:      	mov	w8, #3075
ffffff8008b201fc:      	movk	w8, #1024, lsl #16
ffffff8008b20200:      	mov	x0, sp
ffffff8008b20204:      	mov	w1, #4
ffffff8008b20208:      	str	w8, [sp]
ffffff8008b2020c:      	bl	#-178356 <iWriteRegI2C>
ffffff8008b20210:      	ldrb	w2, [x20, #4028]
ffffff8008b20214:      	mov	w8, #3587
ffffff8008b20218:      	movk	w8, #25600, lsl #16
ffffff8008b2021c:      	mov	x0, sp
ffffff8008b20220:      	mov	w1, #4
ffffff8008b20224:      	str	w8, [sp]
ffffff8008b20228:      	bl	#-178384 <iWriteRegI2C>
ffffff8008b2022c:      	ldrb	w2, [x20, #4028]
ffffff8008b20230:      	mov	w8, #5692
ffffff8008b20234:      	mov	x0, sp
ffffff8008b20238:      	mov	w1, #4
ffffff8008b2023c:      	str	w8, [sp]
ffffff8008b20240:      	bl	#-178408 <iWriteRegI2C>
ffffff8008b20244:      	ldrb	w2, [x20, #4028]
ffffff8008b20248:      	mov	w8, #3
ffffff8008b2024c:      	movk	w8, #1536, lsl #16
ffffff8008b20250:      	mov	x0, sp
ffffff8008b20254:      	mov	w1, #4
ffffff8008b20258:      	str	w8, [sp]
ffffff8008b2025c:      	bl	#-178436 <iWriteRegI2C>
ffffff8008b20260:      	ldrb	w2, [x20, #4028]
ffffff8008b20264:      	mov	w8, #16899
ffffff8008b20268:      	movk	w8, #8211, lsl #16
ffffff8008b2026c:      	mov	x0, sp
ffffff8008b20270:      	mov	w1, #4
ffffff8008b20274:      	str	w8, [sp]
ffffff8008b20278:      	bl	#-178464 <iWriteRegI2C>
ffffff8008b2027c:      	ldrb	w2, [x20, #4028]
ffffff8008b20280:      	mov	w8, #16387
ffffff8008b20284:      	movk	w8, #35353, lsl #16
ffffff8008b20288:      	b	#1264 <capture_setting+0x9ac>
ffffff8008b2028c:      	adrp	x0, #11948032
ffffff8008b20290:      	add	x0, x0, #1214
ffffff8008b20294:      	bl	#-8855444 <printk>
ffffff8008b20298:      	ldrb	w2, [x20, #4028]
ffffff8008b2029c:      	mov	w8, #17411
ffffff8008b202a0:      	movk	w8, #2048, lsl #16
ffffff8008b202a4:      	mov	x0, sp
ffffff8008b202a8:      	mov	w1, #4
ffffff8008b202ac:      	str	w8, [sp]
ffffff8008b202b0:      	bl	#-178520 <iWriteRegI2C>
ffffff8008b202b4:      	ldrb	w2, [x20, #4028]
ffffff8008b202b8:      	mov	w8, #17923
ffffff8008b202bc:      	movk	w8, #2048, lsl #16
ffffff8008b202c0:      	mov	x0, sp
ffffff8008b202c4:      	mov	w1, #4
ffffff8008b202c8:      	str	w8, [sp]
ffffff8008b202cc:      	bl	#-178548 <iWriteRegI2C>
ffffff8008b202d0:      	ldrb	w2, [x20, #4028]
ffffff8008b202d4:      	mov	w8, #18435
ffffff8008b202d8:      	movk	w8, #30480, lsl #16
ffffff8008b202dc:      	mov	x0, sp
ffffff8008b202e0:      	mov	w1, #4
ffffff8008b202e4:      	str	w8, [sp]
ffffff8008b202e8:      	bl	#-178576 <iWriteRegI2C>
ffffff8008b202ec:      	ldrb	w2, [x20, #4028]
ffffff8008b202f0:      	mov	w8, #18947
ffffff8008b202f4:      	movk	w8, #14092, lsl #16
ffffff8008b202f8:      	mov	x0, sp
ffffff8008b202fc:      	mov	w1, #4
ffffff8008b20300:      	str	w8, [sp]
ffffff8008b20304:      	bl	#-178604 <iWriteRegI2C>
ffffff8008b20308:      	ldrb	w2, [x20, #4028]
ffffff8008b2030c:      	mov	w8, #19459
ffffff8008b20310:      	movk	w8, #28688, lsl #16
ffffff8008b20314:      	mov	x0, sp
ffffff8008b20318:      	mov	w1, #4
ffffff8008b2031c:      	str	w8, [sp]
ffffff8008b20320:      	bl	#-178632 <iWriteRegI2C>
ffffff8008b20324:      	ldrb	w2, [x20, #4028]
ffffff8008b20328:      	mov	w8, #19971
ffffff8008b2032c:      	movk	w8, #12300, lsl #16
ffffff8008b20330:      	mov	x0, sp
ffffff8008b20334:      	mov	w1, #4
ffffff8008b20338:      	str	w8, [sp]
ffffff8008b2033c:      	bl	#-178660 <iWriteRegI2C>
ffffff8008b20340:      	ldrb	w2, [x20, #4028]
ffffff8008b20344:      	mov	w8, #9
ffffff8008b20348:      	mov	x0, sp
ffffff8008b2034c:      	mov	w1, #4
ffffff8008b20350:      	str	w8, [sp]
ffffff8008b20354:      	bl	#-178684 <iWriteRegI2C>
ffffff8008b20358:      	ldrb	w2, [x20, #4028]
ffffff8008b2035c:      	mov	w8, #32771
ffffff8008b20360:      	movk	w8, #256, lsl #16
ffffff8008b20364:      	mov	x0, sp
ffffff8008b20368:      	mov	w1, #4
ffffff8008b2036c:      	str	w8, [sp]
ffffff8008b20370:      	bl	#-178712 <iWriteRegI2C>
ffffff8008b20374:      	ldrb	w2, [x20, #4028]
ffffff8008b20378:      	mov	w8, #33283
ffffff8008b2037c:      	movk	w8, #256, lsl #16
ffffff8008b20380:      	mov	x0, sp
ffffff8008b20384:      	mov	w1, #4
ffffff8008b20388:      	str	w8, [sp]
ffffff8008b2038c:      	bl	#-178740 <iWriteRegI2C>
ffffff8008b20390:      	ldrb	w2, [x20, #4028]
ffffff8008b20394:      	mov	w8, #33795
ffffff8008b20398:      	movk	w8, #256, lsl #16
ffffff8008b2039c:      	mov	x0, sp
ffffff8008b203a0:      	mov	w1, #4
ffffff8008b203a4:      	str	w8, [sp]
ffffff8008b203a8:      	bl	#-178768 <iWriteRegI2C>
ffffff8008b203ac:      	ldrb	w2, [x20, #4028]
ffffff8008b203b0:      	mov	w8, #34307
ffffff8008b203b4:      	movk	w8, #256, lsl #16
ffffff8008b203b8:      	mov	x0, sp
ffffff8008b203bc:      	mov	w1, #4
ffffff8008b203c0:      	str	w8, [sp]
ffffff8008b203c4:      	bl	#-178796 <iWriteRegI2C>
ffffff8008b203c8:      	ldrb	w2, [x20, #4028]
ffffff8008b203cc:      	mov	w8, #5121
ffffff8008b203d0:      	movk	w8, #12291, lsl #16
ffffff8008b203d4:      	mov	x0, sp
ffffff8008b203d8:      	mov	w1, #4
ffffff8008b203dc:      	str	w8, [sp]
ffffff8008b203e0:      	bl	#-178824 <iWriteRegI2C>
ffffff8008b203e4:      	ldrb	w2, [x20, #4028]
ffffff8008b203e8:      	mov	w8, #4097
ffffff8008b203ec:      	movk	w8, #512, lsl #16
ffffff8008b203f0:      	mov	x0, sp
ffffff8008b203f4:      	mov	w1, #4
ffffff8008b203f8:      	str	w8, [sp]
ffffff8008b203fc:      	bl	#-178852 <iWriteRegI2C>
ffffff8008b20400:      	ldrb	w2, [x20, #4028]
ffffff8008b20404:      	mov	w8, #13825
ffffff8008b20408:      	movk	w8, #24, lsl #16
ffffff8008b2040c:      	mov	x0, sp
ffffff8008b20410:      	mov	w1, #4
ffffff8008b20414:      	str	w8, [sp]
ffffff8008b20418:      	bl	#-178880 <iWriteRegI2C>
ffffff8008b2041c:      	ldrb	w2, [x20, #4028]
ffffff8008b20420:      	mov	w8, #1027
ffffff8008b20424:      	movk	w8, #1024, lsl #16
ffffff8008b20428:      	mov	x0, sp
ffffff8008b2042c:      	mov	w1, #4
ffffff8008b20430:      	str	w8, [sp]
ffffff8008b20434:      	bl	#-178908 <iWriteRegI2C>
ffffff8008b20438:      	ldrb	w2, [x20, #4028]
ffffff8008b2043c:      	mov	w8, #1539
ffffff8008b20440:      	movk	w8, #30720, lsl #16
ffffff8008b20444:      	mov	x0, sp
ffffff8008b20448:      	mov	w1, #4
ffffff8008b2044c:      	str	w8, [sp]
ffffff8008b20450:      	bl	#-178936 <iWriteRegI2C>
ffffff8008b20454:      	ldrb	w2, [x20, #4028]
ffffff8008b20458:      	mov	w19, #7740
ffffff8008b2045c:      	mov	x0, sp
ffffff8008b20460:      	mov	w1, #4
ffffff8008b20464:      	str	w19, [sp]
ffffff8008b20468:      	bl	#-178960 <iWriteRegI2C>
ffffff8008b2046c:      	ldrb	w2, [x20, #4028]
ffffff8008b20470:      	mov	w8, #3075
ffffff8008b20474:      	movk	w8, #1024, lsl #16
ffffff8008b20478:      	mov	x0, sp
ffffff8008b2047c:      	mov	w1, #4
ffffff8008b20480:      	str	w8, [sp]
ffffff8008b20484:      	bl	#-178988 <iWriteRegI2C>
ffffff8008b20488:      	ldrb	w2, [x20, #4028]
ffffff8008b2048c:      	mov	w8, #3587
ffffff8008b20490:      	movk	w8, #25600, lsl #16
ffffff8008b20494:      	mov	x0, sp
ffffff8008b20498:      	mov	w1, #4
ffffff8008b2049c:      	str	w8, [sp]
ffffff8008b204a0:      	bl	#-179016 <iWriteRegI2C>
ffffff8008b204a4:      	ldrb	w2, [x20, #4028]
ffffff8008b204a8:      	mov	w8, #5692
ffffff8008b204ac:      	mov	x0, sp
ffffff8008b204b0:      	mov	w1, #4
ffffff8008b204b4:      	str	w8, [sp]
ffffff8008b204b8:      	bl	#-179040 <iWriteRegI2C>
ffffff8008b204bc:      	ldrb	w2, [x20, #4028]
ffffff8008b204c0:      	mov	w8, #3
ffffff8008b204c4:      	movk	w8, #1536, lsl #16
ffffff8008b204c8:      	mov	x0, sp
ffffff8008b204cc:      	mov	w1, #4
ffffff8008b204d0:      	str	w8, [sp]
ffffff8008b204d4:      	bl	#-179068 <iWriteRegI2C>
ffffff8008b204d8:      	ldrb	w2, [x20, #4028]
ffffff8008b204dc:      	mov	w8, #16899
ffffff8008b204e0:      	movk	w8, #8211, lsl #16
ffffff8008b204e4:      	mov	x0, sp
ffffff8008b204e8:      	mov	w1, #4
ffffff8008b204ec:      	str	w8, [sp]
ffffff8008b204f0:      	bl	#-179096 <iWriteRegI2C>
ffffff8008b204f4:      	ldrb	w2, [x20, #4028]
ffffff8008b204f8:      	mov	w8, #16387
ffffff8008b204fc:      	movk	w8, #48140, lsl #16
ffffff8008b20500:      	b	#632 <capture_setting+0x9ac>
ffffff8008b20504:      	adrp	x0, #11948032
ffffff8008b20508:      	add	x0, x0, #1214
ffffff8008b2050c:      	bl	#-8856076 <printk>
ffffff8008b20510:      	ldrb	w2, [x20, #4028]
ffffff8008b20514:      	mov	w8, #17411
ffffff8008b20518:      	movk	w8, #2048, lsl #16
ffffff8008b2051c:      	mov	x0, sp
ffffff8008b20520:      	mov	w1, #4
ffffff8008b20524:      	str	w8, [sp]
ffffff8008b20528:      	bl	#-179152 <iWriteRegI2C>
ffffff8008b2052c:      	ldrb	w2, [x20, #4028]
ffffff8008b20530:      	mov	w8, #17923
ffffff8008b20534:      	movk	w8, #2048, lsl #16
ffffff8008b20538:      	mov	x0, sp
ffffff8008b2053c:      	mov	w1, #4
ffffff8008b20540:      	str	w8, [sp]
ffffff8008b20544:      	bl	#-179180 <iWriteRegI2C>
ffffff8008b20548:      	ldrb	w2, [x20, #4028]
ffffff8008b2054c:      	mov	w8, #18435
ffffff8008b20550:      	movk	w8, #30480, lsl #16
ffffff8008b20554:      	mov	x0, sp
ffffff8008b20558:      	mov	w1, #4
ffffff8008b2055c:      	str	w8, [sp]
ffffff8008b20560:      	bl	#-179208 <iWriteRegI2C>
ffffff8008b20564:      	ldrb	w2, [x20, #4028]
ffffff8008b20568:      	mov	w8, #18947
ffffff8008b2056c:      	movk	w8, #14092, lsl #16
ffffff8008b20570:      	mov	x0, sp
ffffff8008b20574:      	mov	w1, #4
ffffff8008b20578:      	str	w8, [sp]
ffffff8008b2057c:      	bl	#-179236 <iWriteRegI2C>
ffffff8008b20580:      	ldrb	w2, [x20, #4028]
ffffff8008b20584:      	mov	w8, #19459
ffffff8008b20588:      	movk	w8, #28688, lsl #16
ffffff8008b2058c:      	mov	x0, sp
ffffff8008b20590:      	mov	w1, #4
ffffff8008b20594:      	str	w8, [sp]
ffffff8008b20598:      	bl	#-179264 <iWriteRegI2C>
ffffff8008b2059c:      	ldrb	w2, [x20, #4028]
ffffff8008b205a0:      	mov	w8, #19971
ffffff8008b205a4:      	movk	w8, #12300, lsl #16
ffffff8008b205a8:      	mov	x0, sp
ffffff8008b205ac:      	mov	w1, #4
ffffff8008b205b0:      	str	w8, [sp]
ffffff8008b205b4:      	bl	#-179292 <iWriteRegI2C>
ffffff8008b205b8:      	ldrb	w2, [x20, #4028]
ffffff8008b205bc:      	mov	w8, #9
ffffff8008b205c0:      	mov	x0, sp
ffffff8008b205c4:      	mov	w1, #4
ffffff8008b205c8:      	str	w8, [sp]
ffffff8008b205cc:      	bl	#-179316 <iWriteRegI2C>
ffffff8008b205d0:      	ldrb	w2, [x20, #4028]
ffffff8008b205d4:      	mov	w8, #32771
ffffff8008b205d8:      	movk	w8, #256, lsl #16
ffffff8008b205dc:      	mov	x0, sp
ffffff8008b205e0:      	mov	w1, #4
ffffff8008b205e4:      	str	w8, [sp]
ffffff8008b205e8:      	bl	#-179344 <iWriteRegI2C>
ffffff8008b205ec:      	ldrb	w2, [x20, #4028]
ffffff8008b205f0:      	mov	w8, #33283
ffffff8008b205f4:      	movk	w8, #256, lsl #16
ffffff8008b205f8:      	mov	x0, sp
ffffff8008b205fc:      	mov	w1, #4
ffffff8008b20600:      	str	w8, [sp]
ffffff8008b20604:      	bl	#-179372 <iWriteRegI2C>
ffffff8008b20608:      	ldrb	w2, [x20, #4028]
ffffff8008b2060c:      	mov	w8, #33795
ffffff8008b20610:      	movk	w8, #256, lsl #16
ffffff8008b20614:      	mov	x0, sp
ffffff8008b20618:      	mov	w1, #4
ffffff8008b2061c:      	str	w8, [sp]
ffffff8008b20620:      	bl	#-179400 <iWriteRegI2C>
ffffff8008b20624:      	ldrb	w2, [x20, #4028]
ffffff8008b20628:      	mov	w8, #34307
ffffff8008b2062c:      	movk	w8, #256, lsl #16
ffffff8008b20630:      	mov	x0, sp
ffffff8008b20634:      	mov	w1, #4
ffffff8008b20638:      	str	w8, [sp]
ffffff8008b2063c:      	bl	#-179428 <iWriteRegI2C>
ffffff8008b20640:      	ldrb	w2, [x20, #4028]
ffffff8008b20644:      	mov	w8, #5121
ffffff8008b20648:      	movk	w8, #12291, lsl #16
ffffff8008b2064c:      	mov	x0, sp
ffffff8008b20650:      	mov	w1, #4
ffffff8008b20654:      	str	w8, [sp]
ffffff8008b20658:      	bl	#-179456 <iWriteRegI2C>
ffffff8008b2065c:      	ldrb	w2, [x20, #4028]
ffffff8008b20660:      	mov	w8, #4097
ffffff8008b20664:      	movk	w8, #512, lsl #16
ffffff8008b20668:      	mov	x0, sp
ffffff8008b2066c:      	mov	w1, #4
ffffff8008b20670:      	str	w8, [sp]
ffffff8008b20674:      	bl	#-179484 <iWriteRegI2C>
ffffff8008b20678:      	ldrb	w2, [x20, #4028]
ffffff8008b2067c:      	mov	w8, #13825
ffffff8008b20680:      	movk	w8, #24, lsl #16
ffffff8008b20684:      	mov	x0, sp
ffffff8008b20688:      	mov	w1, #4
ffffff8008b2068c:      	str	w8, [sp]
ffffff8008b20690:      	bl	#-179512 <iWriteRegI2C>
ffffff8008b20694:      	ldrb	w2, [x20, #4028]
ffffff8008b20698:      	mov	w8, #1027
ffffff8008b2069c:      	movk	w8, #1024, lsl #16
ffffff8008b206a0:      	mov	x0, sp
ffffff8008b206a4:      	mov	w1, #4
ffffff8008b206a8:      	str	w8, [sp]
ffffff8008b206ac:      	bl	#-179540 <iWriteRegI2C>
ffffff8008b206b0:      	ldrb	w2, [x20, #4028]
ffffff8008b206b4:      	mov	w8, #1539
ffffff8008b206b8:      	movk	w8, #30720, lsl #16
ffffff8008b206bc:      	mov	x0, sp
ffffff8008b206c0:      	mov	w1, #4
ffffff8008b206c4:      	str	w8, [sp]
ffffff8008b206c8:      	bl	#-179568 <iWriteRegI2C>
ffffff8008b206cc:      	ldrb	w2, [x20, #4028]
ffffff8008b206d0:      	mov	w19, #7740
ffffff8008b206d4:      	mov	x0, sp
ffffff8008b206d8:      	mov	w1, #4
ffffff8008b206dc:      	str	w19, [sp]
ffffff8008b206e0:      	bl	#-179592 <iWriteRegI2C>
ffffff8008b206e4:      	ldrb	w2, [x20, #4028]
ffffff8008b206e8:      	mov	w8, #3075
ffffff8008b206ec:      	movk	w8, #1024, lsl #16
ffffff8008b206f0:      	mov	x0, sp
ffffff8008b206f4:      	mov	w1, #4
ffffff8008b206f8:      	str	w8, [sp]
ffffff8008b206fc:      	bl	#-179620 <iWriteRegI2C>
ffffff8008b20700:      	ldrb	w2, [x20, #4028]
ffffff8008b20704:      	mov	w8, #3587
ffffff8008b20708:      	movk	w8, #25600, lsl #16
ffffff8008b2070c:      	mov	x0, sp
ffffff8008b20710:      	mov	w1, #4
ffffff8008b20714:      	str	w8, [sp]
ffffff8008b20718:      	bl	#-179648 <iWriteRegI2C>
ffffff8008b2071c:      	ldrb	w2, [x20, #4028]
ffffff8008b20720:      	mov	w8, #5692
ffffff8008b20724:      	mov	x0, sp
ffffff8008b20728:      	mov	w1, #4
ffffff8008b2072c:      	str	w8, [sp]
ffffff8008b20730:      	bl	#-179672 <iWriteRegI2C>
ffffff8008b20734:      	ldrb	w2, [x20, #4028]
ffffff8008b20738:      	mov	w8, #3
ffffff8008b2073c:      	movk	w8, #1536, lsl #16
ffffff8008b20740:      	mov	x0, sp
ffffff8008b20744:      	mov	w1, #4
ffffff8008b20748:      	str	w8, [sp]
ffffff8008b2074c:      	bl	#-179700 <iWriteRegI2C>
ffffff8008b20750:      	ldrb	w2, [x20, #4028]
ffffff8008b20754:      	mov	w8, #16899
ffffff8008b20758:      	movk	w8, #8211, lsl #16
ffffff8008b2075c:      	mov	x0, sp
ffffff8008b20760:      	mov	w1, #4
ffffff8008b20764:      	str	w8, [sp]
ffffff8008b20768:      	bl	#-179728 <iWriteRegI2C>
ffffff8008b2076c:      	ldrb	w2, [x20, #4028]
ffffff8008b20770:      	mov	w8, #16387
ffffff8008b20774:      	movk	w8, #62735, lsl #16
ffffff8008b20778:      	mov	x0, sp
ffffff8008b2077c:      	mov	w1, #4
ffffff8008b20780:      	str	w8, [sp]
ffffff8008b20784:      	bl	#-179756 <iWriteRegI2C>
ffffff8008b20788:      	ldrb	w2, [x20, #4028]
ffffff8008b2078c:      	mov	w8, #50232
ffffff8008b20790:      	movk	w8, #2304, lsl #16
ffffff8008b20794:      	mov	x0, sp
ffffff8008b20798:      	mov	w1, #4
ffffff8008b2079c:      	str	w8, [sp]
ffffff8008b207a0:      	bl	#-179784 <iWriteRegI2C>
ffffff8008b207a4:      	ldrb	w2, [x20, #4028]
ffffff8008b207a8:      	mov	w8, #55352
ffffff8008b207ac:      	movk	w8, #10752, lsl #16
ffffff8008b207b0:      	mov	x0, sp
ffffff8008b207b4:      	mov	w1, #4
ffffff8008b207b8:      	str	w8, [sp]
ffffff8008b207bc:      	bl	#-179812 <iWriteRegI2C>
ffffff8008b207c0:      	ldrb	w2, [x20, #4028]
ffffff8008b207c4:      	mov	w8, #55864
ffffff8008b207c8:      	movk	w8, #2560, lsl #16
ffffff8008b207cc:      	mov	x0, sp
ffffff8008b207d0:      	mov	w1, #4
ffffff8008b207d4:      	str	w8, [sp]
ffffff8008b207d8:      	bl	#-179840 <iWriteRegI2C>
ffffff8008b207dc:      	ldrb	w2, [x20, #4028]
ffffff8008b207e0:      	mov	w8, #56376
ffffff8008b207e4:      	movk	w8, #2816, lsl #16
ffffff8008b207e8:      	mov	x0, sp
ffffff8008b207ec:      	mov	w1, #4
ffffff8008b207f0:      	str	w8, [sp]
ffffff8008b207f4:      	bl	#-179868 <iWriteRegI2C>
ffffff8008b207f8:      	ldrb	w2, [x20, #4028]
ffffff8008b207fc:      	mov	w8, #49720
ffffff8008b20800:      	movk	w8, #2560, lsl #16
ffffff8008b20804:      	mov	x0, sp
ffffff8008b20808:      	mov	w1, #4
ffffff8008b2080c:      	str	w8, [sp]
ffffff8008b20810:      	bl	#-179896 <iWriteRegI2C>
ffffff8008b20814:      	ldrb	w2, [x20, #4028]
ffffff8008b20818:      	mov	w8, #49208
ffffff8008b2081c:      	movk	w8, #3840, lsl #16
ffffff8008b20820:      	mov	x0, sp
ffffff8008b20824:      	mov	w1, #4
ffffff8008b20828:      	str	w8, [sp]
ffffff8008b2082c:      	bl	#-179924 <iWriteRegI2C>
ffffff8008b20830:      	ldrb	w2, [x20, #4028]
ffffff8008b20834:      	mov	w8, #54840
ffffff8008b20838:      	movk	w8, #2560, lsl #16
ffffff8008b2083c:      	mov	x0, sp
ffffff8008b20840:      	mov	w1, #4
ffffff8008b20844:      	str	w8, [sp]
ffffff8008b20848:      	bl	#-179952 <iWriteRegI2C>
ffffff8008b2084c:      	ldrb	w2, [x20, #4028]
ffffff8008b20850:      	mov	w8, #54328
ffffff8008b20854:      	movk	w8, #2304, lsl #16
ffffff8008b20858:      	mov	x0, sp
ffffff8008b2085c:      	mov	w1, #4
ffffff8008b20860:      	str	w8, [sp]
ffffff8008b20864:      	bl	#-179980 <iWriteRegI2C>
ffffff8008b20868:      	ldrb	w2, [x20, #4028]
ffffff8008b2086c:      	mov	w8, #45112
ffffff8008b20870:      	movk	w8, #3840, lsl #16
ffffff8008b20874:      	mov	x0, sp
ffffff8008b20878:      	mov	w1, #4
ffffff8008b2087c:      	str	w8, [sp]
ffffff8008b20880:      	bl	#-180008 <iWriteRegI2C>
ffffff8008b20884:      	ldrb	w2, [x20, #4028]
ffffff8008b20888:      	mov	w8, #12857
ffffff8008b2088c:      	movk	w8, #24, lsl #16
ffffff8008b20890:      	mov	x0, sp
ffffff8008b20894:      	mov	w1, #4
ffffff8008b20898:      	str	w8, [sp]
ffffff8008b2089c:      	bl	#-180036 <iWriteRegI2C>
ffffff8008b208a0:      	ldrb	w2, [x20, #4028]
ffffff8008b208a4:      	mov	w8, #14393
ffffff8008b208a8:      	movk	w8, #3072, lsl #16
ffffff8008b208ac:      	mov	x0, sp
ffffff8008b208b0:      	mov	w1, #4
ffffff8008b208b4:      	str	w8, [sp]
ffffff8008b208b8:      	bl	#-180064 <iWriteRegI2C>
ffffff8008b208bc:      	ldrb	w2, [x20, #4028]
ffffff8008b208c0:      	mov	w8, #8200
ffffff8008b208c4:      	movk	w8, #45060, lsl #16
ffffff8008b208c8:      	mov	x0, sp
ffffff8008b208cc:      	mov	w1, #4
ffffff8008b208d0:      	str	w8, [sp]
ffffff8008b208d4:      	bl	#-180092 <iWriteRegI2C>
ffffff8008b208d8:      	ldrb	w2, [x20, #4028]
ffffff8008b208dc:      	mov	w8, #3128
ffffff8008b208e0:      	movk	w8, #36864, lsl #16
ffffff8008b208e4:      	mov	x0, sp
ffffff8008b208e8:      	mov	w1, #4
ffffff8008b208ec:      	str	w8, [sp]
ffffff8008b208f0:      	bl	#-180120 <iWriteRegI2C>
ffffff8008b208f4:      	ldrb	w2, [x20, #4028]
ffffff8008b208f8:      	mov	w8, #25648
ffffff8008b208fc:      	movk	w8, #53231, lsl #16
ffffff8008b20900:      	mov	x0, sp
ffffff8008b20904:      	mov	w1, #4
ffffff8008b20908:      	str	w8, [sp]
ffffff8008b2090c:      	bl	#-180148 <iWriteRegI2C>
ffffff8008b20910:      	ldrb	w2, [x20, #4028]
ffffff8008b20914:      	mov	w8, #39984
ffffff8008b20918:      	movk	w8, #16390, lsl #16
ffffff8008b2091c:      	mov	x0, sp
ffffff8008b20920:      	mov	w1, #4
ffffff8008b20924:      	str	w8, [sp]
ffffff8008b20928:      	bl	#-180176 <iWriteRegI2C>
ffffff8008b2092c:      	ldrb	w2, [x20, #4028]
ffffff8008b20930:      	mov	w8, #36912
ffffff8008b20934:      	movk	w8, #136, lsl #16
ffffff8008b20938:      	mov	x0, sp
ffffff8008b2093c:      	mov	w1, #4
ffffff8008b20940:      	str	w8, [sp]
ffffff8008b20944:      	bl	#-180204 <iWriteRegI2C>
ffffff8008b20948:      	ldrb	w2, [x20, #4028]
ffffff8008b2094c:      	mov	w8, #14386
ffffff8008b20950:      	movk	w8, #3072, lsl #16
ffffff8008b20954:      	mov	x0, sp
ffffff8008b20958:      	mov	w1, #4
ffffff8008b2095c:      	str	w8, [sp]
ffffff8008b20960:      	bl	#-180232 <iWriteRegI2C>
ffffff8008b20964:      	ldrb	w2, [x20, #4028]
ffffff8008b20968:      	mov	w8, #18993
ffffff8008b2096c:      	movk	w8, #95, lsl #16
ffffff8008b20970:      	mov	x0, sp
ffffff8008b20974:      	mov	w1, #4
ffffff8008b20978:      	str	w8, [sp]
ffffff8008b2097c:      	bl	#-180260 <iWriteRegI2C>
ffffff8008b20980:      	ldrb	w2, [x20, #4028]
ffffff8008b20984:      	mov	w8, #45618
ffffff8008b20988:      	mov	x0, sp
ffffff8008b2098c:      	mov	w1, #4
ffffff8008b20990:      	str	w8, [sp]
ffffff8008b20994:      	bl	#-180284 <iWriteRegI2C>
ffffff8008b20998:      	ldrb	w2, [x20, #4028]
ffffff8008b2099c:      	mov	w8, #46130
ffffff8008b209a0:      	mov	x0, sp
ffffff8008b209a4:      	mov	w1, #4
ffffff8008b209a8:      	str	w8, [sp]
ffffff8008b209ac:      	bl	#-180308 <iWriteRegI2C>
ffffff8008b209b0:      	ldrb	w2, [x20, #4028]
ffffff8008b209b4:      	mov	w8, #46642
ffffff8008b209b8:      	mov	x0, sp
ffffff8008b209bc:      	mov	w1, #4
ffffff8008b209c0:      	str	w8, [sp]
ffffff8008b209c4:      	bl	#-180332 <iWriteRegI2C>
ffffff8008b209c8:      	ldrb	w2, [x20, #4028]
ffffff8008b209cc:      	mov	w8, #47154
ffffff8008b209d0:      	mov	x0, sp
ffffff8008b209d4:      	mov	w1, #4
ffffff8008b209d8:      	str	w8, [sp]
ffffff8008b209dc:      	bl	#-180356 <iWriteRegI2C>
ffffff8008b209e0:      	ldrb	w2, [x20, #4028]
ffffff8008b209e4:      	mov	w8, #51
ffffff8008b209e8:      	mov	x0, sp
ffffff8008b209ec:      	mov	w1, #4
ffffff8008b209f0:      	str	w8, [sp]
ffffff8008b209f4:      	bl	#-180380 <iWriteRegI2C>
ffffff8008b209f8:      	ldrb	w2, [x20, #4028]
ffffff8008b209fc:      	mov	w8, #52
ffffff8008b20a00:      	mov	x0, sp
ffffff8008b20a04:      	mov	w1, #4
ffffff8008b20a08:      	str	w8, [sp]
ffffff8008b20a0c:      	bl	#-180404 <iWriteRegI2C>
ffffff8008b20a10:      	ldrb	w2, [x20, #4028]
ffffff8008b20a14:      	mov	w8, #564
ffffff8008b20a18:      	movk	w8, #16974, lsl #16
ffffff8008b20a1c:      	mov	x0, sp
ffffff8008b20a20:      	mov	w1, #4
ffffff8008b20a24:      	str	w8, [sp]
ffffff8008b20a28:      	bl	#-180432 <iWriteRegI2C>
ffffff8008b20a2c:      	ldrb	w2, [x20, #4028]
ffffff8008b20a30:      	mov	w8, #45618
ffffff8008b20a34:      	movk	w8, #1536, lsl #16
ffffff8008b20a38:      	mov	x0, sp
ffffff8008b20a3c:      	mov	w1, #4
ffffff8008b20a40:      	str	w8, [sp]
ffffff8008b20a44:      	bl	#-180460 <iWriteRegI2C>
ffffff8008b20a48:      	ldrb	w2, [x20, #4028]
ffffff8008b20a4c:      	mov	w8, #46130
ffffff8008b20a50:      	movk	w8, #1536, lsl #16
ffffff8008b20a54:      	mov	x0, sp
ffffff8008b20a58:      	mov	w1, #4
ffffff8008b20a5c:      	str	w8, [sp]
ffffff8008b20a60:      	bl	#-180488 <iWriteRegI2C>
ffffff8008b20a64:      	ldrb	w2, [x20, #4028]
ffffff8008b20a68:      	mov	w8, #46642
ffffff8008b20a6c:      	movk	w8, #1536, lsl #16
ffffff8008b20a70:      	mov	x0, sp
ffffff8008b20a74:      	mov	w1, #4
ffffff8008b20a78:      	str	w8, [sp]
ffffff8008b20a7c:      	bl	#-180516 <iWriteRegI2C>
ffffff8008b20a80:      	ldrb	w2, [x20, #4028]
ffffff8008b20a84:      	mov	w8, #47154
ffffff8008b20a88:      	movk	w8, #1536, lsl #16
ffffff8008b20a8c:      	mov	x0, sp
ffffff8008b20a90:      	mov	w1, #4
ffffff8008b20a94:      	str	w8, [sp]
ffffff8008b20a98:      	bl	#-180544 <iWriteRegI2C>
ffffff8008b20a9c:      	ldrb	w2, [x20, #4028]
ffffff8008b20aa0:      	mov	w8, #13372
ffffff8008b20aa4:      	movk	w8, #2048, lsl #16
ffffff8008b20aa8:      	mov	x0, sp
ffffff8008b20aac:      	mov	w1, #4
ffffff8008b20ab0:      	str	w8, [sp]
ffffff8008b20ab4:      	bl	#-180572 <iWriteRegI2C>
ffffff8008b20ab8:      	ldrb	w2, [x20, #4028]
ffffff8008b20abc:      	mov	w8, #13884
ffffff8008b20ac0:      	mov	x0, sp
ffffff8008b20ac4:      	mov	w1, #4
ffffff8008b20ac8:      	str	w8, [sp]
ffffff8008b20acc:      	bl	#-180596 <iWriteRegI2C>
ffffff8008b20ad0:      	ldrb	w2, [x20, #4028]
ffffff8008b20ad4:      	mov	w8, #14396
ffffff8008b20ad8:      	mov	x0, sp
ffffff8008b20adc:      	mov	w1, #4
ffffff8008b20ae0:      	str	w8, [sp]
ffffff8008b20ae4:      	bl	#-180620 <iWriteRegI2C>
ffffff8008b20ae8:      	ldrb	w2, [x20, #4028]
ffffff8008b20aec:      	mov	w8, #15929
ffffff8008b20af0:      	movk	w8, #64, lsl #16
ffffff8008b20af4:      	mov	x0, sp
ffffff8008b20af8:      	mov	w1, #4
ffffff8008b20afc:      	str	w8, [sp]
ffffff8008b20b00:      	bl	#-180648 <iWriteRegI2C>
ffffff8008b20b04:      	ldrb	w2, [x20, #4028]
ffffff8008b20b08:      	mov	w8, #7740
ffffff8008b20b0c:      	movk	w8, #1, lsl #16
ffffff8008b20b10:      	mov	x0, sp
ffffff8008b20b14:      	mov	w1, #4
ffffff8008b20b18:      	str	w8, [sp]
ffffff8008b20b1c:      	bl	#-180676 <iWriteRegI2C>
ffffff8008b20b20:      	ldrb	w2, [x20, #4028]
ffffff8008b20b24:      	mov	w8, #65537
ffffff8008b20b28:      	mov	x0, sp
ffffff8008b20b2c:      	mov	w1, #4
ffffff8008b20b30:      	str	w8, [sp]
ffffff8008b20b34:      	bl	#-180700 <iWriteRegI2C>
ffffff8008b20b38:      	ldrb	w2, [x20, #4028]
ffffff8008b20b3c:      	mov	x0, sp
ffffff8008b20b40:      	mov	w1, #4
ffffff8008b20b44:      	str	w19, [sp]
ffffff8008b20b48:      	bl	#-180720 <iWriteRegI2C>
ffffff8008b20b4c:      	ldrb	w2, [x20, #4028]
ffffff8008b20b50:      	mov	w8, #26428
ffffff8008b20b54:      	strh	w8, [sp]
ffffff8008b20b58:      	mov	w8, #16
ffffff8008b20b5c:      	mov	x0, sp
ffffff8008b20b60:      	mov	w1, #3
ffffff8008b20b64:      	strb	w8, [sp, #2]
ffffff8008b20b68:      	bl	#-180752 <iWriteRegI2C>
ffffff8008b20b6c:      	adrp	x9, #22614016
ffffff8008b20b70:      	ldr	x8, [sp, #8]
ffffff8008b20b74:      	ldr	x9, [x9, #4088]
ffffff8008b20b78:      	cmp	x9, x8
ffffff8008b20b7c:      	b.ne	#28 <capture_setting+0xdcc>
ffffff8008b20b80:      	ldp	x20, x19, [sp, #64]
ffffff8008b20b84:      	ldp	x22, x21, [sp, #48]
ffffff8008b20b88:      	ldr	x23, [sp, #32]
ffffff8008b20b8c:      	ldp	x29, x30, [sp, #16]
ffffff8008b20b90:      	add	sp, sp, #80
ffffff8008b20b94:      	ret
ffffff8008b20b98:      	bl	#-9498336 <__stack_chk_fail>
