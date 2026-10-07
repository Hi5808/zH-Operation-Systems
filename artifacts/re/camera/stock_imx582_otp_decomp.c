INFO  Decomp.java> === ffffff8008b2bba4=imx582_selective_read_region

undefined4
imx582_selective_read_region(undefined8 param_1,uint param_2,undefined1 *param_3,undefined4 param_4)

{
  long lVar1;
  
  lVar1 = -0x7ff59af93b;
  if (param_2 != 0x800) {
    lVar1 = (ulong)param_2 - 0x7ff59aee58;
  }
  memcpy(param_3,lVar1,param_4);
  printk(0xffffff800971d339,param_2,param_4,*param_3);
  return param_4;
}

 (GhidraScript)  
INFO  Decomp.java> === ffffff8008afd404=imx582_get_otp_data

undefined8 imx582_get_otp_data(void)

{
  uint uVar1;
  long lVar2;
  undefined1 uVar3;
  uint uVar4;
  undefined1 uVar5;
  ushort uVar6;
  ushort uVar7;
  ushort uVar8;
  ushort uVar9;
  ushort uVar10;
  undefined8 uVar11;
  undefined8 *puVar12;
  undefined8 uVar13;
  undefined8 uVar14;
  uint uVar15;
  uint uVar16;
  int iVar17;
  uint uVar18;
  uint uVar19;
  ushort uVar20;
  long lVar21;
  undefined2 uStack_9c;
  undefined1 uStack_9a;
  long lStack_98;
  undefined1 *puStack_90;
  code *pcStack_88;
  ushort auStack_50 [2];
  ushort auStack_4c [2];
  long lStack_48;
  
  lStack_48 = lRamffffff800a0b1ff8;
  auStack_50[0] = 0;
  auStack_4c[0] = 0;
  uVar11 = iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
  if (auStack_50[0] == 1) {
    auStack_50[0] = 0;
    uRamffffff800a6511a8 = 0x10b00ff;
    bRamffffff800a6511ac = 10;
    auStack_4c[0] = 0x2100;
    iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
    uVar6 = auStack_50[0];
    auStack_50[0] = 0;
    uRamffffff800a6511ae = (undefined1)uVar6;
    auStack_4c[0] = 0x2200;
    iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
    uVar7 = auStack_50[0];
    uVar20 = auStack_50[0] & 0xff;
    auStack_50[0] = 0;
    uRamffffff800a6511af = (undefined1)uVar7;
    auStack_4c[0] = 0x2300;
    iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
    uVar7 = auStack_50[0];
    auStack_50[0] = 0;
    uRamffffff800a6511b0 = (undefined1)uVar7;
    auStack_4c[0] = 0x2400;
    iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
    uVar8 = auStack_50[0];
    auStack_50[0] = 0;
    uRamffffff800a6511b1 = (undefined1)uVar8;
    auStack_4c[0] = 0x2500;
    iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
    uVar9 = auStack_50[0];
    auStack_50[0] = 0;
    uRamffffff800a6511b2 = (undefined1)uVar9;
    auStack_4c[0] = 0x2600;
    iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
    uVar10 = auStack_50[0];
    auStack_50[0] = 0;
    uRamffffff800a6511b3 = (undefined1)uVar10;
    auStack_4c[0] = 0x2700;
    iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
    if (auStack_50[0] == (uVar20 + (uVar6 & 0xff) + uVar7 + uVar8 + uVar9 + uVar10 & 0xff)) {
      if ((bRamffffff800a262f72 >> 2 & 1) != 0) {
        __dynamic_pr_debug(0xffffff800a262f50,0xffffff80097f7f65,0xffffff80096cb754);
      }
      uVar5 = uRamffffff800a6511af;
      uVar3 = uRamffffff800a6511ae;
      uRamffffff800a6511b0 = uRamffffff800a6511af;
      uRamffffff800a6511b1 = uRamffffff800a6511ae;
      uRamffffff800a6511ae = uRamffffff800a6511b3;
      uRamffffff800a6511af = uRamffffff800a6511b2;
      if ((bRamffffff800a262f9a >> 2 & 1) != 0) {
        __dynamic_pr_debug(0xffffff800a262f78,0xffffff80097d4f3f,0xffffff80096cb754,
                           CONCAT11(uRamffffff800a6511b2,uRamffffff800a6511b3),CONCAT11(uVar3,uVar5)
                          );
      }
    }
    else {
      if ((bRamffffff800a262fc2 >> 2 & 1) != 0) {
        __dynamic_pr_debug(0xffffff800a262fa0,0xffffff800984a9ce,0xffffff80096cb754);
      }
      bRamffffff800a6511ac = bRamffffff800a6511ac & 0xfd;
    }
    lVar21 = 0;
    uVar20 = 0;
    do {
      uVar1 = (int)lVar21 + 0xc;
      auStack_4c[0] = (ushort)(uVar1 >> 8) & 0xff | (ushort)((uVar1 & 0xff00ff) << 8);
      auStack_50[0] = 0;
      iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
      *(char *)(lVar21 + -0x7ff59ae658) = (char)auStack_50[0];
      lVar21 = lVar21 + 1;
      uVar20 = uVar20 + (auStack_50[0] & 0xff);
    } while (lVar21 != 0xc);
    auStack_50[0] = 0;
    auStack_4c[0] = 0x1d00;
    iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
    if (auStack_50[0] == (uVar20 & 0xff)) {
      if ((bRamffffff800a262fea >> 2 & 1) != 0) {
        uVar11 = 0xffffff800a262fc8;
        uVar13 = 0xffffff80097f7ff1;
LAB_ffffff8008afdb38:
        __dynamic_pr_debug(uVar11,uVar13,0xffffff80096cb754);
      }
    }
    else if ((bRamffffff800a263012 >> 2 & 1) != 0) {
      uVar11 = 0xffffff800a262ff0;
      uVar13 = 0xffffff800984aa76;
      goto LAB_ffffff8008afdb38;
    }
    uVar20 = 0;
    lVar21 = 0;
    do {
      uVar1 = (int)lVar21 + 0x31;
      auStack_4c[0] = (ushort)(uVar1 >> 8) & 0xff | (ushort)((uVar1 & 0xff00ff) << 8);
      auStack_50[0] = 0;
      iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
      lVar2 = lVar21 + 1;
      uVar20 = uVar20 + (auStack_50[0] & 0xff);
      *(char *)(lVar21 + -0x7ff59aee44) = (char)auStack_50[0];
      lVar21 = lVar2;
    } while (lVar2 != 0x74c);
    auStack_50[0] = 0;
    auStack_4c[0] = 0x7d07;
    iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
    if (auStack_50[0] == (uVar20 & 0xff)) {
      if ((bRamffffff800a26303a >> 2 & 1) != 0) {
        __dynamic_pr_debug(0xffffff800a263018,0xffffff80097f7fa7,0xffffff80096cb754);
      }
    }
    else {
      if ((bRamffffff800a263062 >> 2 & 1) != 0) {
        __dynamic_pr_debug(0xffffff800a263040,0xffffff800984aa1e,0xffffff80096cb754);
      }
      bRamffffff800a6511ac = bRamffffff800a6511ac & 0xf7;
    }
    if ((bRamffffff800a263102 >> 2 & 1) != 0) {
      __dynamic_pr_debug(0xffffff800a2630e0,0xffffff80097d6aab,0xffffff80096e01e2,0x60);
    }
    lVar21 = 0;
    iVar17 = 0;
    do {
      uVar1 = (int)lVar21 + 0x903;
      auStack_4c[0] = (ushort)(uVar1 >> 8) & 0xff | (ushort)((uVar1 & 0xff00ff) << 8);
      auStack_50[0] = 0;
      iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
      *(byte *)(lVar21 + -0x7ff59af93b) = (byte)auStack_50[0];
      lVar21 = lVar21 + 1;
      iVar17 = iVar17 + (uint)(byte)auStack_50[0];
    } while (lVar21 != 0x60);
    auStack_50[0] = 0;
    auStack_4c[0] = 0x6309;
    iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
    if (iVar17 % 0x100 == (uint)auStack_50[0]) {
      if ((bRamffffff800a26312a >> 2 & 1) != 0) {
        uVar11 = 0xffffff800a263108;
        uVar13 = 0xffffff8009669adc;
LAB_ffffff8008afdb78:
        __dynamic_pr_debug(uVar11,uVar13,0xffffff80096e01e2);
      }
    }
    else if ((bRamffffff800a263152 >> 2 & 1) != 0) {
      uVar11 = 0xffffff800a263130;
      uVar13 = 0xffffff80096fc73d;
      goto LAB_ffffff8008afdb78;
    }
    if ((bRamffffff800a26317a >> 2 & 1) != 0) {
      __dynamic_pr_debug(0xffffff800a263158,0xffffff80097d69f3,0xffffff80096df916,0x900);
    }
    lVar21 = 0;
    iVar17 = 0;
    do {
      uVar1 = (int)lVar21 + 0x965;
      auStack_4c[0] = (ushort)(uVar1 >> 8) & 0xff | (ushort)((uVar1 & 0xff00ff) << 8);
      auStack_50[0] = 0;
      iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
      *(byte *)(lVar21 + -0x7ff59af75b) = (byte)auStack_50[0];
      lVar21 = lVar21 + 1;
      iVar17 = iVar17 + (uint)(byte)auStack_50[0];
    } while (lVar21 != 0x900);
    auStack_50[0] = 0;
    auStack_4c[0] = 0x6512;
    iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
    if (iVar17 % 0x100 == (uint)auStack_50[0]) {
      if ((bRamffffff800a2631a2 >> 2 & 1) != 0) {
        uVar11 = 0xffffff800a263180;
        uVar13 = 0xffffff8009669a46;
LAB_ffffff8008afdb98:
        __dynamic_pr_debug(uVar11,uVar13,0xffffff80096df916);
      }
    }
    else if ((bRamffffff800a2631ca >> 2 & 1) != 0) {
      uVar11 = 0xffffff800a2631a8;
      uVar13 = 0xffffff80096fc69f;
      goto LAB_ffffff8008afdb98;
    }
    if ((bRamffffff800a2631f2 >> 2 & 1) != 0) {
      __dynamic_pr_debug(0xffffff800a2631d0,0xffffff80097d6a4f,0xffffff80096dfaf4,0x180);
    }
    lVar21 = 0;
    iVar17 = 0;
    do {
      uVar1 = (int)lVar21 + 0x781;
      auStack_4c[0] = (ushort)(uVar1 >> 8) & 0xff | (ushort)((uVar1 & 0xff00ff) << 8);
      auStack_50[0] = 0;
      iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
      *(byte *)(lVar21 + -0x7ff59af8db) = (byte)auStack_50[0];
      lVar21 = lVar21 + 1;
      iVar17 = iVar17 + (uint)(byte)auStack_50[0];
    } while (lVar21 != 0x180);
    auStack_50[0] = 0;
    auStack_4c[0] = 0x109;
    uVar11 = iReadRegI2C(auStack_4c,2,auStack_50,1,0xa0);
    if (iVar17 % 0x100 == (uint)auStack_50[0]) {
      if ((bRamffffff800a26321a >> 2 & 1) != 0) {
        uVar11 = 0xffffff800a2631f8;
        uVar13 = 0xffffff8009669a91;
LAB_ffffff8008afdbb8:
        uVar14 = 0xffffff80096dfaf4;
        goto LAB_ffffff8008afdbc0;
      }
    }
    else if ((bRamffffff800a263242 >> 2 & 1) != 0) {
      uVar11 = 0xffffff800a263220;
      uVar13 = 0xffffff80096fc6ee;
      goto LAB_ffffff8008afdbb8;
    }
  }
  else {
    if ((bRamffffff800a262f4a >> 2 & 1) == 0) goto LAB_ffffff8008afda50;
    uVar11 = 0xffffff800a262f28;
    uVar13 = 0xffffff800984a86f;
    uVar14 = 0xffffff80096cb754;
LAB_ffffff8008afdbc0:
    uVar11 = __dynamic_pr_debug(uVar11,uVar13,uVar14);
  }
LAB_ffffff8008afda50:
  if (lRamffffff800a0b1ff8 == lStack_48) {
    return uVar11;
  }
  __stack_chk_fail();
  uVar20 = uRamffffff800a6519b2;
  pcStack_88 = load_imx582_awb;
  lStack_98 = lRamffffff800a0b1ff8;
  uVar15 = (uint)uRamffffff800a6519ae;
  uVar1 = ((uRamffffff800a6519a8 & 0xff00) << 8 | (uint)uRamffffff800a6519a8 << 0x18) >> 0x10;
  uVar19 = ((uRamffffff800a6519aa & 0xff00) << 8 | (uint)uRamffffff800a6519aa << 0x18) >> 0x10;
  uVar16 = (uint)uRamffffff800a6519b0;
  puStack_90 = &stack0xffffffffffffffc0;
  if ((bRamffffff800a26308a >> 2 & 1) != 0) {
    __dynamic_pr_debug(0xffffff800a263068,0xffffff800971ef5f,0xffffff80096c8ca9,uVar1,uVar19,
                       ((uRamffffff800a6519ac & 0xff00) << 8 | (uint)uRamffffff800a6519ac << 0x18)
                       >> 0x10);
  }
  uVar15 = ((uVar15 & 0xff00) << 8 | uVar15 << 0x18) >> 0x10;
  uVar16 = ((uVar16 & 0xff00) << 8 | uVar16 << 0x18) >> 0x10;
  if ((bRamffffff800a2630b2 >> 2 & 1) != 0) {
    __dynamic_pr_debug(0xffffff800a263090,0xffffff800971efe6,0xffffff80096c8ca9,uVar15,uVar16,
                       ((uVar20 & 0xff00) << 8 | (uint)uVar20 << 0x18) >> 0x10);
  }
  uVar4 = 0;
  if (uVar1 != 0) {
    uVar4 = (uVar15 << 10) / uVar1;
  }
  uVar1 = 0;
  if (uVar19 != 0) {
    uVar1 = (uVar16 << 10) / uVar19;
  }
  if (uVar4 < 0x400) {
    uVar19 = 0;
    if (uVar4 != 0) {
      uVar19 = 0x40000 / uVar4;
    }
    if (uVar1 < 0x400) {
      uVar15 = 0;
      if (uVar1 != 0) {
        uVar15 = 0x40000 / uVar1;
      }
      if (uVar19 < uVar15) {
        uVar16 = 0;
        if (uVar1 != 0) {
          uVar16 = (uVar4 << 8) / uVar1;
        }
        uVar18 = 0x100;
        uVar19 = uVar15;
        goto LAB_ffffff8008afdcc8;
      }
    }
    uVar18 = 0;
    if (uVar4 != 0) {
      uVar18 = (uVar1 << 8) / uVar4;
    }
    uVar16 = 0x100;
  }
  else if (uVar1 < 0x400) {
    uVar16 = 0;
    if (uVar1 != 0) {
      uVar16 = (uVar4 << 8) / uVar1;
    }
    uVar19 = 0;
    if (uVar1 != 0) {
      uVar19 = 0x40000 / uVar1;
    }
    uVar18 = 0x100;
  }
  else {
    uVar16 = uVar4 >> 2 & 0x3fffff;
    uVar18 = uVar1 >> 2 & 0x3fffff;
    uVar19 = 0x100;
  }
LAB_ffffff8008afdcc8:
  if ((bRamffffff800a2630da >> 2 & 1) != 0) {
    __dynamic_pr_debug(0xffffff800a2630b8,0xffffff80097143fb,0xffffff80096c8ca9,uVar16,uVar18,uVar19
                      );
  }
  uStack_9c = 0x3031;
  uStack_9a = 1;
  uVar11 = iWriteRegI2C(&uStack_9c,3,0x34);
  if (0x100 < uVar16) {
    uStack_9c = 0x1002;
    uStack_9a = (undefined1)(uVar16 >> 8);
    iWriteRegI2C(&uStack_9c,3,0x34);
    uStack_9c = 0x1102;
    uStack_9a = (undefined1)uVar16;
    uVar11 = iWriteRegI2C(&uStack_9c,3,0x34);
  }
  if (0x100 < uVar19) {
    uStack_9c = 0xe02;
    uVar3 = (undefined1)(uVar19 >> 8);
    uStack_9a = uVar3;
    iWriteRegI2C(&uStack_9c,3,0x34);
    uStack_9c = 0xf02;
    uStack_9a = (char)uVar19;
    iWriteRegI2C(&uStack_9c,3,0x34);
    uStack_9c = 0x1402;
    uStack_9a = uVar3;
    iWriteRegI2C(&uStack_9c,3,0x34);
    uStack_9c = 0x1502;
    uStack_9a = (char)uVar19;
    uVar11 = iWriteRegI2C(&uStack_9c,3,0x34);
  }
  if (0x100 < uVar18) {
    uStack_9c = 0x1202;
    uStack_9a = (undefined1)(uVar18 >> 8);
    iWriteRegI2C(&uStack_9c,3,0x34);
    uStack_9c = 0x1302;
    uStack_9a = (undefined1)uVar18;
    uVar11 = iWriteRegI2C(&uStack_9c,3,0x34);
  }
  if (lRamffffff800a0b1ff8 == lStack_98) {
    return uVar11;
  }
  puVar12 = (undefined8 *)__stack_chk_fail();
  if (puVar12 != (undefined8 *)0x0) {
    *puVar12 = 0xffffff800a19a9b8;
  }
  return 0;
}

 (GhidraScript)  
