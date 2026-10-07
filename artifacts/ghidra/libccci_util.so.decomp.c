/* Decompiled from libccci_util.so by Ghidra (BL6000 Pro port) */

/* __on_dlclose @ 00107000 */

void __on_dlclose(void)

{
  __cxa_finalize(&PTR_LOOP_0010b000);
  return;
}



/* __emutls_unregister_key @ 0010700c */

void __emutls_unregister_key(void)

{
  return;
}



/* __on_dlclose_late @ 00107010 */

void __on_dlclose_late(void)

{
  return;
}



/* find_image_from_pt_internal @ 00107014 */

ulong find_image_from_pt_internal(int param_1,char *param_2,int *param_3,int *param_4)

{
  int iVar1;
  int iVar2;
  int iVar3;
  int *__buf;
  ulong uVar4;
  ssize_t sVar5;
  undefined4 *puVar6;
  char *pcVar7;
  uint uVar8;
  
  __buf = malloc(0x200);
  if (__buf == (int *)0x0) {
    __android_log_print(6,"ccci_lib","alloc memory for hdr fail\n");
    uVar4 = 0xfffffffc;
  }
  else {
    iVar3 = 0;
    __buf[0x7a] = 0;
    __buf[0x7b] = 0;
    __buf[0x78] = 0;
    __buf[0x79] = 0;
    __buf[0x7e] = 0;
    __buf[0x7f] = 0;
    __buf[0x7c] = 0;
    __buf[0x7d] = 0;
    __buf[0x72] = 0;
    __buf[0x73] = 0;
    __buf[0x70] = 0;
    __buf[0x71] = 0;
    __buf[0x76] = 0;
    __buf[0x77] = 0;
    __buf[0x74] = 0;
    __buf[0x75] = 0;
    __buf[0x6a] = 0;
    __buf[0x6b] = 0;
    __buf[0x68] = 0;
    __buf[0x69] = 0;
    __buf[0x6e] = 0;
    __buf[0x6f] = 0;
    __buf[0x6c] = 0;
    __buf[0x6d] = 0;
    __buf[0x62] = 0;
    __buf[99] = 0;
    __buf[0x60] = 0;
    __buf[0x61] = 0;
    __buf[0x66] = 0;
    __buf[0x67] = 0;
    __buf[100] = 0;
    __buf[0x65] = 0;
    __buf[0x5a] = 0;
    __buf[0x5b] = 0;
    __buf[0x58] = 0;
    __buf[0x59] = 0;
    __buf[0x5e] = 0;
    __buf[0x5f] = 0;
    __buf[0x5c] = 0;
    __buf[0x5d] = 0;
    __buf[0x52] = 0;
    __buf[0x53] = 0;
    __buf[0x50] = 0;
    __buf[0x51] = 0;
    __buf[0x56] = 0;
    __buf[0x57] = 0;
    __buf[0x54] = 0;
    __buf[0x55] = 0;
    __buf[0x4a] = 0;
    __buf[0x4b] = 0;
    __buf[0x48] = 0;
    __buf[0x49] = 0;
    __buf[0x4e] = 0;
    __buf[0x4f] = 0;
    __buf[0x4c] = 0;
    __buf[0x4d] = 0;
    __buf[0x42] = 0;
    __buf[0x43] = 0;
    __buf[0x40] = 0;
    __buf[0x41] = 0;
    __buf[0x46] = 0;
    __buf[0x47] = 0;
    __buf[0x44] = 0;
    __buf[0x45] = 0;
    __buf[0x3a] = 0;
    __buf[0x3b] = 0;
    __buf[0x38] = 0;
    __buf[0x39] = 0;
    __buf[0x3e] = 0;
    __buf[0x3f] = 0;
    __buf[0x3c] = 0;
    __buf[0x3d] = 0;
    __buf[0x32] = 0;
    __buf[0x33] = 0;
    __buf[0x30] = 0;
    __buf[0x31] = 0;
    __buf[0x36] = 0;
    __buf[0x37] = 0;
    __buf[0x34] = 0;
    __buf[0x35] = 0;
    __buf[0x2a] = 0;
    __buf[0x2b] = 0;
    __buf[0x28] = 0;
    __buf[0x29] = 0;
    __buf[0x2e] = 0;
    __buf[0x2f] = 0;
    __buf[0x2c] = 0;
    __buf[0x2d] = 0;
    __buf[0x22] = 0;
    __buf[0x23] = 0;
    __buf[0x20] = 0;
    __buf[0x21] = 0;
    __buf[0x26] = 0;
    __buf[0x27] = 0;
    __buf[0x24] = 0;
    __buf[0x25] = 0;
    __buf[0x1a] = 0;
    __buf[0x1b] = 0;
    __buf[0x18] = 0;
    __buf[0x19] = 0;
    __buf[0x1e] = 0;
    __buf[0x1f] = 0;
    __buf[0x1c] = 0;
    __buf[0x1d] = 0;
    __buf[0x12] = 0;
    __buf[0x13] = 0;
    __buf[0x10] = 0;
    __buf[0x11] = 0;
    __buf[0x16] = 0;
    __buf[0x17] = 0;
    __buf[0x14] = 0;
    __buf[0x15] = 0;
    __buf[10] = 0;
    __buf[0xb] = 0;
    __buf[8] = 0;
    __buf[9] = 0;
    __buf[0xe] = 0;
    __buf[0xf] = 0;
    __buf[0xc] = 0;
    __buf[0xd] = 0;
    __buf[2] = 0;
    __buf[3] = 0;
    __buf[0] = 0;
    __buf[1] = 0;
    __buf[6] = 0;
    __buf[7] = 0;
    __buf[4] = 0;
    __buf[5] = 0;
    *param_3 = 0;
    do {
      sVar5 = read(param_1,__buf,0x200);
      *(undefined1 *)((long)__buf + 0x27) = 0;
      if ((int)sVar5 != 0x200) {
        pcVar7 = "load hdr fail(%d)\n";
LAB_00107294:
        __android_log_print(6,"ccci_lib",pcVar7);
        uVar4 = 0xfffffffb;
        goto LAB_001072cc;
      }
      if (*__buf != 0x58881688) {
        iVar2 = *param_3;
        *param_3 = (int)((long)iVar2 + (long)iVar3);
        lseek(param_1,(long)iVar2 + (long)iVar3,0);
        sVar5 = read(param_1,__buf,0x200);
        if ((int)sVar5 != 0x200) {
          pcVar7 = "load hdr fail again(%d)\n";
          goto LAB_00107294;
        }
        if (*__buf != 0x58881688) {
          __android_log_print(6,"ccci_lib","invalid magic(%x) at 0x%x, ref(%x)\n",*__buf,*param_3,
                              0x58881688);
          uVar4 = 0xfffffffa;
          goto LAB_001072cc;
        }
      }
      iVar3 = strcmp(param_2,(char *)(__buf + 2));
      if (iVar3 == 0) {
        *param_3 = *param_3 + 0x200;
        *param_4 = __buf[1];
        __android_log_print(4,"ccci_lib","find image %s, offset 0x%x, size 0x%x\n",param_2,*param_3)
        ;
        uVar4 = 0;
        goto LAB_001072cc;
      }
      if (__buf[0x10] != 0) {
        uVar4 = 0xfffffff9;
        goto LAB_001072cc;
      }
      iVar3 = __buf[0x11];
      uVar8 = __buf[1];
      if (iVar3 == 0) {
        __android_log_print(4,"ccci_lib","image %s align size is 0!\n",param_2);
      }
      else {
        uVar8 = (iVar3 + uVar8) - 1 & -iVar3;
      }
      iVar2 = 0x200;
      if (__buf[0xd] != 0) {
        iVar2 = __buf[0xd];
      }
      iVar1 = *param_3;
      iVar2 = iVar2 + uVar8;
      iVar3 = ((iVar2 + 0xfffU & 0xfffff000) - iVar2) + 0x100;
      *param_3 = iVar2 + iVar1;
      __android_log_print(4,"ccci_lib","next image offset is 0x%x, sec_padding 0x%x\n",iVar2 + iVar1
                          ,iVar3);
      uVar4 = lseek(param_1,(long)*param_3,0);
    } while (-1 < (int)uVar4);
    iVar3 = *param_3;
    puVar6 = (undefined4 *)__errno();
    __android_log_print(6,"ccci_lib","lseek err! offset 0x%x, errno %d",iVar3,*puVar6);
LAB_001072cc:
    free(__buf);
  }
  return uVar4 & 0xffffffff;
}



/* find_image_from_pt @ 001072f8 */

int find_image_from_pt(undefined8 param_1,undefined8 param_2,undefined8 param_3)

{
  long lVar1;
  int iVar2;
  uint uVar3;
  undefined8 uVar4;
  ulong uVar5;
  undefined4 *puVar6;
  undefined8 local_160;
  undefined8 uStack_158;
  undefined8 uStack_150;
  undefined8 uStack_148;
  undefined8 local_140;
  undefined8 uStack_138;
  undefined8 uStack_130;
  undefined8 uStack_128;
  undefined8 local_120;
  undefined8 uStack_118;
  undefined8 uStack_110;
  undefined8 uStack_108;
  undefined8 local_100;
  undefined8 uStack_f8;
  undefined8 uStack_f0;
  undefined8 uStack_e8;
  char local_e0 [136];
  long local_58;
  
  lVar1 = tpidr_el0;
  local_58 = *(long *)(lVar1 + 0x28);
  local_e0[0x68] = '\0';
  local_e0[0x69] = '\0';
  local_e0[0x6a] = '\0';
  local_e0[0x6b] = '\0';
  local_e0[0x6c] = '\0';
  local_e0[0x6d] = '\0';
  local_e0[0x6e] = '\0';
  local_e0[0x6f] = '\0';
  local_e0[0x60] = '\0';
  local_e0[0x61] = '\0';
  local_e0[0x62] = '\0';
  local_e0[99] = '\0';
  local_e0[100] = '\0';
  local_e0[0x65] = '\0';
  local_e0[0x66] = '\0';
  local_e0[0x67] = '\0';
  local_e0[0x78] = '\0';
  local_e0[0x79] = '\0';
  local_e0[0x7a] = '\0';
  local_e0[0x7b] = '\0';
  local_e0[0x7c] = '\0';
  local_e0[0x7d] = '\0';
  local_e0[0x7e] = '\0';
  local_e0[0x7f] = '\0';
  local_e0[0x70] = '\0';
  local_e0[0x71] = '\0';
  local_e0[0x72] = '\0';
  local_e0[0x73] = '\0';
  local_e0[0x74] = '\0';
  local_e0[0x75] = '\0';
  local_e0[0x76] = '\0';
  local_e0[0x77] = '\0';
  local_e0[0x48] = '\0';
  local_e0[0x49] = '\0';
  local_e0[0x4a] = '\0';
  local_e0[0x4b] = '\0';
  local_e0[0x4c] = '\0';
  local_e0[0x4d] = '\0';
  local_e0[0x4e] = '\0';
  local_e0[0x4f] = '\0';
  local_e0[0x40] = '\0';
  local_e0[0x41] = '\0';
  local_e0[0x42] = '\0';
  local_e0[0x43] = '\0';
  local_e0[0x44] = '\0';
  local_e0[0x45] = '\0';
  local_e0[0x46] = '\0';
  local_e0[0x47] = '\0';
  local_e0[0x58] = '\0';
  local_e0[0x59] = '\0';
  local_e0[0x5a] = '\0';
  local_e0[0x5b] = '\0';
  local_e0[0x5c] = '\0';
  local_e0[0x5d] = '\0';
  local_e0[0x5e] = '\0';
  local_e0[0x5f] = '\0';
  local_e0[0x50] = '\0';
  local_e0[0x51] = '\0';
  local_e0[0x52] = '\0';
  local_e0[0x53] = '\0';
  local_e0[0x54] = '\0';
  local_e0[0x55] = '\0';
  local_e0[0x56] = '\0';
  local_e0[0x57] = '\0';
  local_e0[0x28] = '\0';
  local_e0[0x29] = '\0';
  local_e0[0x2a] = '\0';
  local_e0[0x2b] = '\0';
  local_e0[0x2c] = '\0';
  local_e0[0x2d] = '\0';
  local_e0[0x2e] = '\0';
  local_e0[0x2f] = '\0';
  local_e0[0x20] = '\0';
  local_e0[0x21] = '\0';
  local_e0[0x22] = '\0';
  local_e0[0x23] = '\0';
  local_e0[0x24] = '\0';
  local_e0[0x25] = '\0';
  local_e0[0x26] = '\0';
  local_e0[0x27] = '\0';
  local_e0[0x38] = '\0';
  local_e0[0x39] = '\0';
  local_e0[0x3a] = '\0';
  local_e0[0x3b] = '\0';
  local_e0[0x3c] = '\0';
  local_e0[0x3d] = '\0';
  local_e0[0x3e] = '\0';
  local_e0[0x3f] = '\0';
  local_e0[0x30] = '\0';
  local_e0[0x31] = '\0';
  local_e0[0x32] = '\0';
  local_e0[0x33] = '\0';
  local_e0[0x34] = '\0';
  local_e0[0x35] = '\0';
  local_e0[0x36] = '\0';
  local_e0[0x37] = '\0';
  local_e0[8] = '\0';
  local_e0[9] = '\0';
  local_e0[10] = '\0';
  local_e0[0xb] = '\0';
  local_e0[0xc] = '\0';
  local_e0[0xd] = '\0';
  local_e0[0xe] = '\0';
  local_e0[0xf] = '\0';
  local_e0[0] = '\0';
  local_e0[1] = '\0';
  local_e0[2] = '\0';
  local_e0[3] = '\0';
  local_e0[4] = '\0';
  local_e0[5] = '\0';
  local_e0[6] = '\0';
  local_e0[7] = '\0';
  local_e0[0x18] = '\0';
  local_e0[0x19] = '\0';
  local_e0[0x1a] = '\0';
  local_e0[0x1b] = '\0';
  local_e0[0x1c] = '\0';
  local_e0[0x1d] = '\0';
  local_e0[0x1e] = '\0';
  local_e0[0x1f] = '\0';
  local_e0[0x10] = '\0';
  local_e0[0x11] = '\0';
  local_e0[0x12] = '\0';
  local_e0[0x13] = '\0';
  local_e0[0x14] = '\0';
  local_e0[0x15] = '\0';
  local_e0[0x16] = '\0';
  local_e0[0x17] = '\0';
  uStack_f8 = 0;
  local_100 = 0;
  uStack_e8 = 0;
  uStack_f0 = 0;
  uStack_118 = 0;
  local_120 = 0;
  uStack_108 = 0;
  uStack_110 = 0;
  uStack_138 = 0;
  local_140 = 0;
  uStack_128 = 0;
  uStack_130 = 0;
  uStack_158 = 0;
  local_160 = 0;
  uStack_148 = 0;
  uStack_150 = 0;
  AB_image_get(&local_160);
  snprintf(local_e0,0x80,(char *)0x80,&DAT_00101cd5,"/dev/block/by-name/md1img",&local_160);
  uVar4 = __open_2(local_e0,0);
  if ((int)uVar4 < 0) {
    puVar6 = (undefined4 *)__errno();
    __android_log_print(6,"ccci_lib","open md1img node %s fail! errno = %d\n",local_e0,*puVar6);
    iVar2 = -1;
  }
  else {
    iVar2 = find_image_from_pt_internal(uVar4,param_1,param_2,param_3);
    uVar3 = close((int)uVar4);
    uVar5 = (ulong)uVar3;
    if (iVar2 == 0) goto LAB_001074a4;
    __android_log_print(6,"ccci_lib","not found img:%s in the %s image\n",param_1,local_e0);
  }
  snprintf(local_e0,0x80,(char *)0x80,&DAT_00101cd5,"/dev/block/by-name/md3img",&local_160);
  uVar4 = __open_2(local_e0,0);
  if ((int)uVar4 < 0) {
    puVar6 = (undefined4 *)__errno();
    uVar5 = __android_log_print(6,"ccci_lib","open md1img node %s fail! errno = %d\n",local_e0,
                                *puVar6);
  }
  else {
    iVar2 = find_image_from_pt_internal(uVar4,param_1,param_2,param_3);
    uVar3 = close((int)uVar4);
    uVar5 = (ulong)uVar3;
    if (iVar2 == 0) {
      iVar2 = 1;
    }
    else {
      uVar5 = __android_log_print(6,"ccci_lib","not found img:%s in the %s image\n",param_1,local_e0
                                 );
    }
  }
LAB_001074a4:
  if (*(long *)(lVar1 + 0x28) == local_58) {
    return iVar2;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(uVar5);
}



/* snprintf @ 001074d8 */

/* snprintf(char*, unsigned long pass_object_size1, char const*, ...) */

void snprintf(char *param_1,ulong param_2,char *param_3,...)

{
  long lVar1;
  undefined8 in_x3;
  undefined8 in_x4;
  undefined8 in_x5;
  undefined8 in_x6;
  undefined8 in_x7;
  long lVar2;
  undefined8 in_d0;
  undefined8 local_90;
  undefined8 uStack_88;
  undefined8 local_80;
  undefined8 uStack_78;
  undefined1 *local_70;
  undefined1 **ppuStack_68;
  undefined8 *puStack_60;
  undefined8 uStack_58;
  
  lVar1 = tpidr_el0;
  lVar2 = *(long *)(lVar1 + 0x28);
  ppuStack_68 = &local_70;
  puStack_60 = &local_90;
  uStack_58 = 0xffffff80ffffffe0;
  local_90 = in_x4;
  uStack_88 = in_x5;
  local_80 = in_x6;
  uStack_78 = in_x7;
  local_70 = (undefined1 *)register0x00000008;
  __vsnprintf_chk(param_1,param_3,0,param_2,in_x3,&local_70,in_x6,in_x7,in_d0);
  if (*(long *)(lVar1 + 0x28) == lVar2) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}



/* restore_image_from_pt @ 00107580 */

int restore_image_from_pt(long param_1,char *param_2)

{
  undefined4 uVar1;
  long lVar2;
  uint uVar3;
  int iVar4;
  uint uVar5;
  int __fd;
  int __fd_00;
  int iVar6;
  ulong uVar7;
  __off_t _Var8;
  undefined4 *puVar9;
  char *pcVar10;
  int iVar11;
  undefined8 local_1188;
  undefined8 local_1180;
  undefined8 uStack_1178;
  undefined8 uStack_1170;
  undefined8 uStack_1168;
  undefined8 local_1160;
  undefined8 uStack_1158;
  undefined8 uStack_1150;
  undefined8 uStack_1148;
  undefined8 local_1140;
  undefined8 uStack_1138;
  undefined8 uStack_1130;
  undefined8 uStack_1128;
  undefined8 local_1120;
  undefined8 uStack_1118;
  undefined8 uStack_1110;
  undefined8 uStack_1108;
  char local_1100 [136];
  undefined1 auStack_1078 [4096];
  long local_78;
  
  lVar2 = tpidr_el0;
  local_78 = *(long *)(lVar2 + 0x28);
  local_1188 = 0;
  memset(auStack_1078,0,0x1000);
  local_1100[0x68] = '\0';
  local_1100[0x69] = '\0';
  local_1100[0x6a] = '\0';
  local_1100[0x6b] = '\0';
  local_1100[0x6c] = '\0';
  local_1100[0x6d] = '\0';
  local_1100[0x6e] = '\0';
  local_1100[0x6f] = '\0';
  local_1100[0x60] = '\0';
  local_1100[0x61] = '\0';
  local_1100[0x62] = '\0';
  local_1100[99] = '\0';
  local_1100[100] = '\0';
  local_1100[0x65] = '\0';
  local_1100[0x66] = '\0';
  local_1100[0x67] = '\0';
  local_1100[0x78] = '\0';
  local_1100[0x79] = '\0';
  local_1100[0x7a] = '\0';
  local_1100[0x7b] = '\0';
  local_1100[0x7c] = '\0';
  local_1100[0x7d] = '\0';
  local_1100[0x7e] = '\0';
  local_1100[0x7f] = '\0';
  local_1100[0x70] = '\0';
  local_1100[0x71] = '\0';
  local_1100[0x72] = '\0';
  local_1100[0x73] = '\0';
  local_1100[0x74] = '\0';
  local_1100[0x75] = '\0';
  local_1100[0x76] = '\0';
  local_1100[0x77] = '\0';
  local_1100[0x48] = '\0';
  local_1100[0x49] = '\0';
  local_1100[0x4a] = '\0';
  local_1100[0x4b] = '\0';
  local_1100[0x4c] = '\0';
  local_1100[0x4d] = '\0';
  local_1100[0x4e] = '\0';
  local_1100[0x4f] = '\0';
  local_1100[0x40] = '\0';
  local_1100[0x41] = '\0';
  local_1100[0x42] = '\0';
  local_1100[0x43] = '\0';
  local_1100[0x44] = '\0';
  local_1100[0x45] = '\0';
  local_1100[0x46] = '\0';
  local_1100[0x47] = '\0';
  local_1100[0x58] = '\0';
  local_1100[0x59] = '\0';
  local_1100[0x5a] = '\0';
  local_1100[0x5b] = '\0';
  local_1100[0x5c] = '\0';
  local_1100[0x5d] = '\0';
  local_1100[0x5e] = '\0';
  local_1100[0x5f] = '\0';
  local_1100[0x50] = '\0';
  local_1100[0x51] = '\0';
  local_1100[0x52] = '\0';
  local_1100[0x53] = '\0';
  local_1100[0x54] = '\0';
  local_1100[0x55] = '\0';
  local_1100[0x56] = '\0';
  local_1100[0x57] = '\0';
  local_1100[0x28] = '\0';
  local_1100[0x29] = '\0';
  local_1100[0x2a] = '\0';
  local_1100[0x2b] = '\0';
  local_1100[0x2c] = '\0';
  local_1100[0x2d] = '\0';
  local_1100[0x2e] = '\0';
  local_1100[0x2f] = '\0';
  local_1100[0x20] = '\0';
  local_1100[0x21] = '\0';
  local_1100[0x22] = '\0';
  local_1100[0x23] = '\0';
  local_1100[0x24] = '\0';
  local_1100[0x25] = '\0';
  local_1100[0x26] = '\0';
  local_1100[0x27] = '\0';
  local_1100[0x38] = '\0';
  local_1100[0x39] = '\0';
  local_1100[0x3a] = '\0';
  local_1100[0x3b] = '\0';
  local_1100[0x3c] = '\0';
  local_1100[0x3d] = '\0';
  local_1100[0x3e] = '\0';
  local_1100[0x3f] = '\0';
  local_1100[0x30] = '\0';
  local_1100[0x31] = '\0';
  local_1100[0x32] = '\0';
  local_1100[0x33] = '\0';
  local_1100[0x34] = '\0';
  local_1100[0x35] = '\0';
  local_1100[0x36] = '\0';
  local_1100[0x37] = '\0';
  local_1100[8] = '\0';
  local_1100[9] = '\0';
  local_1100[10] = '\0';
  local_1100[0xb] = '\0';
  local_1100[0xc] = '\0';
  local_1100[0xd] = '\0';
  local_1100[0xe] = '\0';
  local_1100[0xf] = '\0';
  local_1100[0] = '\0';
  local_1100[1] = '\0';
  local_1100[2] = '\0';
  local_1100[3] = '\0';
  local_1100[4] = '\0';
  local_1100[5] = '\0';
  local_1100[6] = '\0';
  local_1100[7] = '\0';
  local_1100[0x18] = '\0';
  local_1100[0x19] = '\0';
  local_1100[0x1a] = '\0';
  local_1100[0x1b] = '\0';
  local_1100[0x1c] = '\0';
  local_1100[0x1d] = '\0';
  local_1100[0x1e] = '\0';
  local_1100[0x1f] = '\0';
  local_1100[0x10] = '\0';
  local_1100[0x11] = '\0';
  local_1100[0x12] = '\0';
  local_1100[0x13] = '\0';
  local_1100[0x14] = '\0';
  local_1100[0x15] = '\0';
  local_1100[0x16] = '\0';
  local_1100[0x17] = '\0';
  uStack_1118 = 0;
  local_1120 = 0;
  uStack_1108 = 0;
  uStack_1110 = 0;
  uStack_1138 = 0;
  local_1140 = 0;
  uStack_1128 = 0;
  uStack_1130 = 0;
  uStack_1158 = 0;
  local_1160 = 0;
  uStack_1148 = 0;
  uStack_1150 = 0;
  uStack_1178 = 0;
  local_1180 = 0;
  uStack_1168 = 0;
  uStack_1170 = 0;
  if ((param_1 == 0) || (param_2 == (char *)0x0)) {
    uVar7 = __android_log_print(6,"ccci_lib","invalid arg for restore_image_from_pt\n");
    iVar11 = -1;
  }
  else {
    uVar5 = find_image_from_pt(param_1,(long)&local_1188 + 4,&local_1188);
    if ((int)uVar5 < 0) {
      uVar7 = __android_log_print(6,"ccci_lib","not find %s in partition\n",param_1);
      iVar11 = -1;
    }
    else {
      uVar3 = (uint)local_1188;
      if ((uint)local_1188 < 0x20000001) {
        iVar4 = local_1188._4_4_;
        __android_log_print(4,"ccci_lib","img %s (size 0x%x) is at 0x%x in partition\n",param_1,
                            local_1188 & 0xffffffff,local_1188._4_4_);
        __fd = creat(param_2,0x1b4);
        if (__fd < 0) {
          puVar9 = (undefined4 *)__errno();
          uVar1 = *puVar9;
          pcVar10 = "create %s fail, errno %d\n";
        }
        else {
          AB_image_get(&local_1180);
          snprintf(local_1100,0x80,(char *)0x80,&DAT_00101cd5,
                   (&PTR_s__dev_block_by_name_md1img_0010b008)[uVar5],&local_1180);
          __fd_00 = __open_2(local_1100,0);
          if (-1 < __fd_00) {
            __android_log_print(4,"ccci_lib","md %s (md id:%d)\n",local_1100,(ulong)uVar5);
            if ((int)uVar3 < 1) {
              iVar11 = 0;
            }
            else {
              iVar11 = 0;
              do {
                _Var8 = lseek(__fd_00,(long)(iVar11 + iVar4),0);
                if ((int)_Var8 < 0) {
                  puVar9 = (undefined4 *)__errno();
                  __android_log_print(6,"ccci_lib","lseek mdimg fail! offset = %d, errno = %d\n",
                                      iVar11 + iVar4,*puVar9);
                  iVar11 = (int)_Var8;
LAB_00107870:
                  __android_log_print(6,"ccci_lib","read image %s ret %d, errno %d\n",param_1,iVar11
                                      ,*puVar9);
                  break;
                }
                iVar6 = uVar3 - iVar11;
                if (0xfff < iVar6) {
                  iVar6 = 0x1000;
                }
                iVar6 = __read_chk(__fd_00,auStack_1078,(long)iVar6,0x1000);
                if (iVar6 < 0) {
                  puVar9 = (undefined4 *)__errno();
                  __android_log_print(6,"ccci_lib","read img %s return %d, errno = %d\n",param_1,
                                      iVar6,*puVar9);
                  iVar11 = iVar6;
                  goto LAB_00107870;
                }
                if (iVar6 == 0) {
                  __android_log_print(5,"ccci_lib","read image %s done, w_count = %d\n",param_1,
                                      iVar11);
                  break;
                }
                iVar6 = __write_chk(__fd,auStack_1078,iVar6,0x1000);
                if (iVar6 < 1) {
                  puVar9 = (undefined4 *)__errno();
                  __android_log_print(6,"ccci_lib","write image %s to %s ret %d, errno %d\n",param_1
                                      ,param_2,iVar6,*puVar9);
                  iVar11 = iVar6;
                  break;
                }
                iVar11 = iVar11 + iVar6;
              } while (iVar11 < (int)uVar3);
            }
            __android_log_print(4,"ccci_lib","restore %s to %s done, return %d\n",param_1,param_2,
                                iVar11);
            close(__fd);
            uVar5 = close(__fd_00);
            uVar7 = (ulong)uVar5;
            goto LAB_00107920;
          }
          puVar9 = (undefined4 *)__errno();
          uVar1 = *puVar9;
          pcVar10 = "open md1img node %s fail! errno = %d\n";
          param_2 = local_1100;
        }
        uVar7 = __android_log_print(6,"ccci_lib",pcVar10,param_2,uVar1);
        iVar11 = -2;
      }
      else {
        uVar7 = __android_log_print(6,"ccci_lib","MD image size abnormal %d(>512MB or <0MB)\n",
                                    local_1188 & 0xffffffff);
        iVar11 = -1;
      }
    }
  }
LAB_00107920:
  if (*(long *)(lVar2 + 0x28) != local_78) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar7);
  }
  return iVar11;
}



/* query_kcfg_setting @ 0010795c */

/* WARNING: Removing unreachable block (ram,0x00107a4c) */
/* WARNING: Removing unreachable block (ram,0x00107bb8) */
/* WARNING: Removing unreachable block (ram,0x00107bd4) */

undefined8 query_kcfg_setting(undefined8 param_1)

{
  long lVar1;
  int __fd;
  uint uVar2;
  void *__buf;
  ulong uVar3;
  undefined8 uVar4;
  undefined4 *puVar5;
  long lVar6;
  
  lVar1 = tpidr_el0;
  lVar6 = *(long *)(lVar1 + 0x28);
  __fd = __open_2("/sys/kernel/ccci/kcfg_setting",0);
  if (__fd < 0) {
    puVar5 = (undefined4 *)__errno();
    uVar3 = __android_log_print(6,"ccci_lib","open sys file fail(%d)",*puVar5);
    uVar4 = 0xffffffff;
  }
  else {
    __buf = malloc(0x1000);
    if (__buf == (void *)0x0) {
      __android_log_print(6,"ccci_lib","allock memory fail");
      uVar2 = close(__fd);
      uVar3 = (ulong)uVar2;
      uVar4 = 0xfffffffe;
    }
    else {
      uVar3 = read(__fd,__buf,0xfff);
      if (0 < (int)uVar3) {
        *(undefined1 *)((long)__buf + (long)(int)uVar3) = 0;
        __android_log_print(3,"ccci_lib","read info:%s",__buf);
        __android_log_print(3,"ccci_lib","parse_info name:%s",param_1);
                    /* WARNING: Could not recover jumptable at 0x00107a7c. Too many branches */
                    /* WARNING: Treating indirect jump as call */
        uVar4 = (*(code *)((ulong)switchD_00107a7c::switchdataD_00101198 * 4 + 0x107a3c))();
        return uVar4;
      }
      puVar5 = (undefined4 *)__errno();
      __android_log_print(6,"ccci_lib","read info fail ret%d(%d)",uVar3 & 0xffffffff,*puVar5);
      uVar4 = 0xfffffffd;
      free(__buf);
      uVar2 = close(__fd);
      uVar3 = (ulong)uVar2;
    }
  }
  if (*(long *)(lVar1 + 0x28) != lVar6) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar3);
  }
  return uVar4;
}



/* query_prj_cfg_setting @ 00107c7c */

void query_prj_cfg_setting(void)

{
  (*(code *)PTR_query_prj_cfg_setting_platform_0010b2b0)();
  return;
}



/* ccci_smem_get @ 00107c80 */

ulong ccci_smem_get(undefined4 param_1,uint param_2,long *param_3,uint *param_4)

{
  undefined4 uVar1;
  long lVar2;
  int iVar3;
  uint uVar4;
  uint uVar5;
  ssize_t sVar6;
  undefined4 *puVar7;
  void *pvVar8;
  char *pcVar9;
  char *__s1;
  ulong uVar10;
  uint local_8c;
  undefined4 uStack_88;
  undefined2 local_84 [2];
  char local_80 [40];
  long local_58;
  
  lVar2 = tpidr_el0;
  local_58 = *(long *)(lVar2 + 0x28);
  local_8c = 0;
  uStack_88 = 0;
  local_80[8] = '\0';
  local_80[9] = '\0';
  local_80[10] = '\0';
  local_80[0xb] = '\0';
  local_80[0xc] = '\0';
  local_80[0xd] = '\0';
  local_80[0xe] = '\0';
  local_80[0xf] = '\0';
  local_80[0] = '\0';
  local_80[1] = '\0';
  local_80[2] = '\0';
  local_80[3] = '\0';
  local_80[4] = '\0';
  local_80[5] = '\0';
  local_80[6] = '\0';
  local_80[7] = '\0';
  local_80[0x18] = '\0';
  local_80[0x19] = '\0';
  local_80[0x1a] = '\0';
  local_80[0x1b] = '\0';
  local_80[0x1c] = '\0';
  local_80[0x1d] = '\0';
  local_80[0x1e] = '\0';
  local_80[0x1f] = '\0';
  local_80[0x10] = '\0';
  local_80[0x11] = '\0';
  local_80[0x12] = '\0';
  local_80[0x13] = '\0';
  local_80[0x14] = '\0';
  local_80[0x15] = '\0';
  local_80[0x16] = '\0';
  local_80[0x17] = '\0';
  pcVar9 = (char *)0x0;
  switch(param_1) {
  case 0:
    local_84[0] = 0;
    iVar3 = __open_2("/sys/kernel/ccci/version",0,param_3,param_4,0);
    if (iVar3 < 0) {
      __s1 = &UNK_00101e94 + (ulong)param_2 * 0xe4;
      break;
    }
    sVar6 = read(iVar3,local_84,2);
    iVar3 = close(iVar3);
    if ((int)sVar6 < 1) {
      pcVar9 = (char *)0x0;
    }
    else {
      pcVar9 = (char *)0x0;
      if ((byte)local_84[0] - 0x31 < 6) {
                    /* WARNING: Could not recover jumptable at 0x00107d50. Too many branches */
                    /* WARNING: Treating indirect jump as call */
        uVar10 = (*(code *)((ulong)(byte)(&DAT_001011a2)[(byte)local_84[0] - 0x31] * 4 + 0x107d54))
                           (iVar3);
        return uVar10;
      }
    }
    goto switchD_00107ce8_caseD_3;
  case 1:
    __s1 = &UNK_00101eb4 + (ulong)param_2 * 0xe4;
    break;
  case 2:
    __s1 = "/dev/null" + (ulong)param_2 * 0xe4;
    break;
  default:
    goto switchD_00107ce8_caseD_3;
  case 4:
    local_84[0] = 0;
    iVar3 = __open_2("/sys/kernel/ccci/version",0,param_3,param_4,0);
    if (-1 < iVar3) {
      sVar6 = read(iVar3,local_84,2);
      close(iVar3);
      if (0 < (int)sVar6) {
        if ((byte)local_84[0] == '5') {
          __s1 = "/dev/emd_cfifo1" + (ulong)param_2 * 0xe4;
          break;
        }
      }
    }
    __s1 = "/dev/eemcs_mux" + (ulong)param_2 * 0xe4;
  }
  iVar3 = strcmp(__s1,"/dev/null");
  pcVar9 = (char *)0x0;
  if (iVar3 != 0) {
    pcVar9 = __s1;
  }
switchD_00107ce8_caseD_3:
  snprintf(local_80,0x20,(char *)0x20,&DAT_0010139d,pcVar9);
  uVar4 = __open_2(local_80,2);
  if ((int)uVar4 < 0) {
    puVar7 = (undefined4 *)__errno();
    pvVar8 = (void *)__android_log_print(6,"ccci_lib","open %s failed, errno=%d, user%d, md%d",
                                         local_80,*puVar7,param_2,param_1);
    uVar10 = 0xffffffed;
  }
  else {
    uVar10 = (ulong)uVar4;
    uVar5 = ioctl(uVar4,0x80044330,&uStack_88);
    if (uVar5 == 0) {
      uVar5 = ioctl(uVar4,0x80044331,&local_8c);
      if (uVar5 == 0) {
        __android_log_print(3,"ccci_lib","mmap on %s(%d) for addr=0x%x, len=%d\n",local_80,uVar10,
                            uStack_88,local_8c);
        pvVar8 = mmap((void *)0x0,(ulong)local_8c,3,1,uVar4,0);
        *param_3 = (long)pvVar8;
        *param_4 = local_8c;
        if (*param_3 == -1) {
          puVar7 = (undefined4 *)__errno();
          __android_log_print(6,"ccci_lib","mmap on %s failed, %d\n",local_80,*puVar7);
          uVar4 = close(uVar4);
          pvVar8 = (void *)(ulong)uVar4;
          uVar10 = 0xfffffff2;
        }
        goto LAB_00107f14;
      }
      puVar7 = (undefined4 *)__errno();
      uVar1 = *puVar7;
      pcVar9 = "CCCI_IOC_SMEM_LEN fail on %s, err=%d\n";
    }
    else {
      puVar7 = (undefined4 *)__errno();
      uVar1 = *puVar7;
      pcVar9 = "CCCI_IOC_SMEM_BASE fail on %s, err=%d\n";
    }
    __android_log_print(6,"ccci_lib",pcVar9,local_80,uVar1);
    uVar4 = close(uVar4);
    pvVar8 = (void *)(ulong)uVar4;
    uVar10 = (ulong)uVar5;
  }
LAB_00107f14:
  if (*(long *)(lVar2 + 0x28) == local_58) {
    return uVar10;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(pvVar8);
}



/* ccci_ccb_ctrl_put @ 0010800c */

int ccci_ccb_ctrl_put(int param_1,void *param_2,uint param_3)

{
  int iVar1;
  
  if (-1 < param_1) {
    close(param_1);
    __android_log_print(3,"ccci_lib","munmap on (%d) for addr=%p, len=%d\n",param_1,param_2,param_3)
    ;
    iVar1 = munmap(param_2,(ulong)param_3);
    return iVar1;
  }
  return -0x16;
}



/* ccci_smem_put @ 00108074 */

int ccci_smem_put(int param_1,void *param_2,uint param_3)

{
  int iVar1;
  
  if (-1 < param_1) {
    close(param_1);
    __android_log_print(3,"ccci_lib","munmap on (%d) for addr=%p, len=%d\n",param_1,param_2,param_3)
    ;
    iVar1 = munmap(param_2,(ulong)param_3);
    return iVar1;
  }
  return -0x16;
}



/* ccci_ccb_get_config @ 001080dc */

undefined8 ccci_ccb_get_config(int param_1,int param_2,int param_3,undefined4 *param_4)

{
  undefined8 uVar1;
  int iVar2;
  undefined4 *puVar3;
  ulong uVar4;
  
  uVar1 = 0xffffffea;
  if ((param_1 == 0) && (param_4 != (undefined4 *)0x0)) {
    if (*(uint *)PTR_ccb_info_len_0010b1f8 != 0) {
      uVar4 = 0;
      iVar2 = 0;
      puVar3 = (undefined4 *)(DAT_0010c338 + 0xc);
      do {
        if (puVar3[-3] == param_2 + -0x39) {
          if (iVar2 == param_3) {
            *param_4 = 8;
            param_4[1] = puVar3[-1];
            param_4[2] = *puVar3;
            param_4[3] = puVar3[1];
            param_4[4] = puVar3[2];
            return 0;
          }
          iVar2 = iVar2 + 1;
        }
        uVar4 = uVar4 + 1;
        puVar3 = puVar3 + 6;
      } while (uVar4 < *(uint *)PTR_ccb_info_len_0010b1f8);
    }
    __android_log_print(6,"ccci_lib",
                        "get_config failed, md_id=%d, user_id=%d, buffer_id=%d, ccb_info_len=%d, count=%d\n"
                        ,0);
    uVar1 = 0xfffffff2;
  }
  return uVar1;
}



/* ccci_ccb_init_users @ 001081b4 */

undefined8 ccci_ccb_init_users(ulong param_1)

{
  ccci_ccb_init_user(param_1,0x39);
  ccci_ccb_init_user(param_1 & 0xffffffff,0x3a);
  ccci_ccb_init_user(param_1 & 0xffffffff,0x3b);
  return 0;
}



/* ccci_ccb_init_user @ 001081f4 */

void ccci_ccb_init_user(int param_1,int param_2)

{
  long lVar1;
  undefined4 *puVar2;
  long lVar3;
  void *__addr;
  int __fd;
  undefined8 uVar4;
  ulong uVar5;
  long lVar6;
  ulong uVar7;
  undefined8 *puVar8;
  long lVar9;
  ulong local_80;
  ulong uStack_78;
  void *local_70;
  long local_68;
  
  lVar3 = tpidr_el0;
  local_68 = *(long *)(lVar3 + 0x28);
  local_70 = (void *)0x0;
  local_80 = 0;
  uStack_78 = 0;
  if (param_1 == 0) {
    uStack_78 = 0;
    local_80 = (ulong)(param_2 - 0x39U);
    __fd = ccci_ccb_ctrl_get(&local_80,&local_70);
    __addr = local_70;
    if (__fd < 0) {
      __android_log_print(6,"ccci_lib","ctrl_fd error. fd=%d\n");
      uVar4 = 0xffffffed;
    }
    else {
      uVar5 = (ulong)*(uint *)PTR_ccb_info_len_0010b1f8;
      if (*(uint *)PTR_ccb_info_len_0010b1f8 != 0) {
        uVar7 = 0;
        lVar9 = 0xc;
        puVar8 = (undefined8 *)((long)local_70 + (local_80 >> 0x20) * 0x40);
        lVar6 = DAT_0010c338;
        do {
          lVar1 = lVar6 + lVar9;
          if (*(uint *)(lVar1 + -0xc) == param_2 - 0x39U) {
            __android_log_print(3,"ccci_lib","user %d DL, slot %d, address=%p (%d, %d)\n",param_2,
                                uVar7 & 0xffffffff,puVar8,*(undefined4 *)(lVar1 + -4),
                                *(undefined4 *)(lVar1 + 4));
            puVar8[1] = 0;
            *puVar8 = 0;
            puVar8[3] = 0;
            puVar8[2] = 0;
            puVar2 = (undefined4 *)(DAT_0010c338 + lVar9);
            *(undefined4 *)((long)puVar8 + 0x14) = puVar2[-1];
            *(undefined4 *)(puVar8 + 3) = puVar2[1];
            *(undefined4 *)((long)puVar8 + 0x1c) = 0xeeff0011;
            __android_log_print(3,"ccci_lib","user %d UL, slot %d, address=%p (%d, %d)\n",param_2,
                                uVar7 & 0xffffffff,puVar8 + 4,*puVar2,puVar2[2]);
            puVar8[5] = 0;
            puVar8[4] = 0;
            puVar8[7] = 0;
            puVar8[6] = 0;
            lVar6 = DAT_0010c338;
            puVar2 = (undefined4 *)(DAT_0010c338 + lVar9);
            *(undefined4 *)((long)puVar8 + 0x34) = *puVar2;
            *(undefined4 *)(puVar8 + 7) = puVar2[2];
            *(undefined4 *)((long)puVar8 + 0x3c) = 0xeeff0011;
            uVar5 = (ulong)*(uint *)PTR_ccb_info_len_0010b1f8;
            puVar8 = puVar8 + 8;
          }
          uVar7 = uVar7 + 1;
          lVar9 = lVar9 + 0x18;
        } while (uVar7 < uVar5);
      }
      uVar5 = uStack_78 >> 0x20;
      close(__fd);
      __android_log_print(3,"ccci_lib","munmap on (%d) for addr=%p, len=%d\n",__fd,__addr,uVar5);
      munmap(__addr,uVar5);
      uVar4 = 0;
    }
    __android_log_print(3,"ccci_lib","init user%d md%d ret=%d",param_2,0,uVar4);
  }
  if (*(long *)(lVar3 + 0x28) == local_68) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}



/* ccci_ccb_check_users @ 00108420 */

undefined8 ccci_ccb_check_users(void)

{
  return 0;
}



/* ccci_ccb_get_fd @ 00108428 */

undefined4 ccci_ccb_get_fd(void)

{
  if (DAT_0010c340 != 0) {
    return *(undefined4 *)(DAT_0010c340 + 0x34);
  }
  return 0xffffffff;
}



/* ccci_ccb_register @ 00108444 */

void ccci_ccb_register(int param_1,int param_2)

{
  long lVar1;
  uint *puVar2;
  uint uVar3;
  uint uVar4;
  long lVar5;
  int iVar6;
  ulong uVar7;
  int *piVar8;
  void *__s;
  char *pcVar9;
  int *piVar10;
  long lVar11;
  undefined4 uVar12;
  long lVar13;
  long lVar14;
  ulong uVar15;
  long lVar16;
  long lVar17;
  long lVar18;
  int local_6c;
  long local_68;
  
  lVar5 = tpidr_el0;
  local_68 = *(long *)(lVar5 + 0x28);
  local_6c = 0xff;
  if (param_1 != 0) {
    uVar7 = 0xffffffea;
    goto LAB_001084bc;
  }
  ccci_ccb_unregister();
  if (DAT_0010c340 == (int *)0x0) {
    piVar8 = malloc(0x48);
    DAT_0010c340 = piVar8;
    if (piVar8 != (int *)0x0) {
      piVar8[0x10] = 0;
      piVar8[0x11] = 0;
      piVar8[6] = 0;
      piVar8[7] = 0;
      piVar8[4] = 0;
      piVar8[5] = 0;
      piVar8[10] = 0;
      piVar8[0xb] = 0;
      piVar8[8] = 0;
      piVar8[9] = 0;
      piVar8[0xe] = 0;
      piVar8[0xf] = 0;
      piVar8[0xc] = 0;
      piVar8[0xd] = 0;
      piVar8[2] = 0;
      piVar8[3] = 0;
      piVar8[0] = 0;
      piVar8[1] = 0;
      piVar8[0xd] = -1;
      piVar8[0xe] = -1;
      iVar6 = ccci_smem_get(0,param_2,piVar8 + 10);
      piVar8 = DAT_0010c340;
      DAT_0010c340[0xd] = iVar6;
      if (iVar6 < 0) {
        free(piVar8);
        uVar7 = 0xffffffed;
        DAT_0010c340 = (int *)0x0;
        goto LAB_001084bc;
      }
      iVar6 = ioctl(iVar6,0x80044335,&local_6c);
      piVar8 = DAT_0010c340;
      if (local_6c == 1) {
        piVar10 = DAT_0010c340 + 1;
        *piVar10 = param_2 + -0x39;
        iVar6 = ccci_ccb_ctrl_get(piVar10,piVar8 + 6);
        piVar8 = DAT_0010c340;
        DAT_0010c340[0xe] = iVar6;
        if (iVar6 < 0) {
          ccci_ccb_unregister();
          uVar7 = 0xffffffed;
          goto LAB_001084bc;
        }
        __android_log_print(3,"ccci_lib",
                            "register user%d md%d: base=%p, len=%d, ctrl_base=%p, ctrl_offset=%d\n",
                            param_2,0,*(undefined8 *)(piVar8 + 10),piVar8[0xc],
                            *(undefined8 *)(piVar8 + 6),piVar8[2]);
        piVar8 = DAT_0010c340;
        uVar3 = *(uint *)PTR_ccb_info_len_0010b1f8;
        if (uVar3 != 0) {
          uVar7 = 0;
          piVar10 = DAT_0010c338;
          do {
            if (*piVar10 == param_2 + -0x39) {
              piVar8[8] = piVar8[8] + 1;
            }
            uVar7 = uVar7 + 1;
            piVar10 = piVar10 + 6;
          } while (uVar7 < uVar3);
        }
        if (piVar8[8] != 0) {
          __s = malloc((ulong)(uint)piVar8[8] * 0x28);
          *(void **)(piVar8 + 0x10) = __s;
          if (__s != (void *)0x0) {
            memset(__s,0,(ulong)(uint)piVar8[8] * 0x28);
            piVar10 = DAT_0010c340;
            piVar8 = DAT_0010c340 + 8;
            *DAT_0010c340 = param_2;
            if (*piVar8 == 0) {
              uVar7 = 0;
            }
            else {
              lVar16 = 0;
              uVar15 = 0;
              lVar18 = *(long *)(piVar10 + 10);
              lVar17 = *(long *)(piVar10 + 6) + (ulong)(uint)piVar10[2] * 0x40;
              do {
                lVar13 = *(long *)(piVar10 + 0x10);
                lVar1 = lVar13 + lVar16;
                *(long *)(lVar1 + 8) = lVar17;
                *(undefined8 *)(lVar1 + 0x10) = 0;
                lVar11 = *(long *)(piVar10 + 0x10);
                lVar14 = *(long *)(lVar11 + lVar16 + 8);
                *(undefined4 *)(lVar14 + 0xc) = *(undefined4 *)(lVar14 + 0x10);
                lVar11 = *(long *)(lVar11 + lVar16 + 8);
                *(undefined4 *)(lVar11 + 8) = *(undefined4 *)(lVar11 + 0xc);
                lVar11 = *(long *)(lVar1 + 8);
                if (*(int *)(lVar11 + 0xc) == 0) {
                  uVar12 = 0;
                }
                else {
                  __android_log_print(3,"ccci_lib",
                                      "dl index: read = %d, free = %d, write = %d, alloc = %d\n",
                                      *(int *)(lVar11 + 0xc),*(undefined4 *)(lVar11 + 8),
                                      *(undefined4 *)(lVar11 + 0x10),*(undefined4 *)(lVar11 + 4));
                  lVar11 = *(long *)(lVar1 + 8);
                  uVar12 = *(undefined4 *)(lVar11 + 0xc);
                }
                *(undefined4 *)(lVar11 + 8) = uVar12;
                piVar8 = *(int **)(lVar1 + 8);
                if (*piVar8 == 0) {
                  pcVar9 = "register: DL buffer %d pattern wrong\n";
LAB_001088c8:
                  __android_log_print(6,"ccci_lib",pcVar9,uVar15 & 0xffffffff);
                  ccci_ccb_unregister();
                  goto LAB_001084b8;
                }
                uVar3 = 0;
                if (piVar8[5] != 0) {
                  uVar3 = (uint)piVar8[6] / (uint)piVar8[5];
                }
                puVar2 = (uint *)(lVar13 + lVar16);
                *puVar2 = uVar3;
                piVar8[7] = 0x1100ffee;
                *(long *)(puVar2 + 6) = lVar18;
                __android_log_print(3,"ccci_lib",
                                    "register user%d md%d DL%d, pattern=%x, dl_page=%p\n",param_2,0,
                                    uVar15 & 0xffffffff,**(undefined4 **)(lVar1 + 8),lVar18);
                uVar3 = *(uint *)(*(long *)(lVar1 + 8) + 0x18);
                *(long *)(puVar2 + 4) = lVar17 + 0x20;
                *(undefined4 *)(lVar17 + 0x24) = *(undefined4 *)(lVar17 + 0x30);
                piVar8 = *(int **)(lVar1 + 0x10);
                if (piVar8[4] != 0) {
                  __android_log_print(3,"ccci_lib",
                                      "ul index: read = %d, free = %d, write = %d, alloc = %d\n",
                                      piVar8[3],piVar8[2],piVar8[4],piVar8[1]);
                  piVar8 = *(int **)(lVar1 + 0x10);
                }
                if (*piVar8 == 0) {
                  pcVar9 = "register: UL buffer %d pattern wrong\n";
                  goto LAB_001088c8;
                }
                uVar4 = 0;
                if (piVar8[5] != 0) {
                  uVar4 = (uint)piVar8[6] / (uint)piVar8[5];
                }
                lVar18 = lVar18 + (ulong)uVar3;
                *(uint *)(lVar13 + lVar16 + 4) = uVar4;
                piVar8[7] = 0x1100ffee;
                *(long *)(lVar13 + lVar16 + 0x20) = lVar18;
                __android_log_print(3,"ccci_lib",
                                    "register user%d md%d UL%d, pattern=%x, ul_page=%p\n",param_2,0,
                                    uVar15 & 0xffffffff,**(undefined4 **)(lVar1 + 0x10),lVar18);
                uVar7 = (ulong)(uint)DAT_0010c340[8];
                uVar15 = uVar15 + 1;
                lVar18 = lVar18 + (ulong)*(uint *)(*(long *)(lVar1 + 0x10) + 0x18);
                lVar16 = lVar16 + 0x28;
                lVar17 = lVar17 + 0x40;
                piVar10 = DAT_0010c340;
              } while (uVar15 < uVar7);
            }
            goto LAB_001084bc;
          }
          ccci_ccb_unregister();
          pcVar9 = "alloc user%d md%d buffer struct fail\n";
          goto LAB_001084a8;
        }
        ccci_ccb_unregister();
        pcVar9 = "user %d of MD %d has no smem info\n";
        iVar6 = 0;
      }
      else {
        ccci_ccb_unregister(iVar6);
        pcVar9 = "register user %d state wrong %d\n";
        iVar6 = local_6c;
      }
      __android_log_print(6,"ccci_lib",pcVar9,param_2,iVar6);
      uVar7 = 0xffffffea;
      goto LAB_001084bc;
    }
    pcVar9 = "alloc user%d md%d struct fail\n";
  }
  else {
    pcVar9 = "user%d md%d already registered\n";
  }
LAB_001084a8:
  __android_log_print(6,"ccci_lib",pcVar9,param_2,0);
LAB_001084b8:
  uVar7 = 0xfffffff2;
LAB_001084bc:
  if (*(long *)(lVar5 + 0x28) != local_68) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar7);
  }
  return;
}



/* ccci_ccb_ctrl_get @ 001088e0 */

int ccci_ccb_ctrl_get(undefined4 *param_1,undefined8 *param_2)

{
  int iVar1;
  long lVar2;
  undefined *puVar3;
  uint uVar4;
  int __fd;
  int iVar5;
  void *pvVar6;
  undefined4 *puVar7;
  ulong uVar8;
  long lVar9;
  char local_80 [40];
  long local_58;
  
  lVar2 = tpidr_el0;
  local_58 = *(long *)(lVar2 + 0x28);
  local_80[8] = '\0';
  local_80[9] = '\0';
  local_80[10] = '\0';
  local_80[0xb] = '\0';
  local_80[0xc] = '\0';
  local_80[0xd] = '\0';
  local_80[0xe] = '\0';
  local_80[0xf] = '\0';
  local_80[0] = '\0';
  local_80[1] = '\0';
  local_80[2] = '\0';
  local_80[3] = '\0';
  local_80[4] = '\0';
  local_80[5] = '\0';
  local_80[6] = '\0';
  local_80[7] = '\0';
  local_80[0x18] = '\0';
  local_80[0x19] = '\0';
  local_80[0x1a] = '\0';
  local_80[0x1b] = '\0';
  local_80[0x1c] = '\0';
  local_80[0x1d] = '\0';
  local_80[0x1e] = '\0';
  local_80[0x1f] = '\0';
  local_80[0x10] = '\0';
  local_80[0x11] = '\0';
  local_80[0x12] = '\0';
  local_80[0x13] = '\0';
  local_80[0x14] = '\0';
  local_80[0x15] = '\0';
  local_80[0x16] = '\0';
  local_80[0x17] = '\0';
  uVar4 = snprintf(local_80,0x20,(char *)0x20,&DAT_0010139d,"/dev/ccci_ccb_ctrl");
  if (uVar4 < 0x20) {
    __fd = __open_2(local_80,2);
    puVar3 = PTR_ccb_info_len_0010b1f8;
    if (__fd < 0) {
      puVar7 = (undefined4 *)__errno();
      pvVar6 = (void *)__android_log_print(6,"ccci_lib","open %s failed, errno=%d, user%d",local_80,
                                           *puVar7,*param_1);
      iVar5 = -0x13;
      goto LAB_00108af8;
    }
    iVar5 = ioctl(__fd,0x8004433f,PTR_ccb_info_len_0010b1f8);
    iVar1 = *(int *)puVar3;
    if ((iVar5 != 0) || (iVar1 == 0)) {
      puVar7 = (undefined4 *)__errno();
      __android_log_print(6,"ccci_lib",
                          "CCCI_IOC_GET_CCB_CONFIG_LENGTH fail on %s, err=%d, len = %d\n",local_80,
                          *puVar7,iVar1);
      uVar4 = close(__fd);
      pvVar6 = (void *)(ulong)uVar4;
      goto LAB_00108af8;
    }
    __android_log_print(3,"ccci_lib","ccb_info_len=%d\n",iVar1);
    uVar4 = *(uint *)puVar3;
    puVar7 = malloc((ulong)uVar4 * 0x18);
    DAT_0010c338 = puVar7;
    if (puVar7 == (undefined4 *)0x0) {
      __android_log_print(3,"ccci_lib","%s:malloc fail\n","ccci_ccb_ctrl_get");
    }
    else {
      if (uVar4 != 0) {
        *puVar7 = 0;
        ioctl(__fd,0xc0184340,puVar7);
        if (1 < *(uint *)puVar3) {
          uVar8 = 1;
          lVar9 = 0x18;
          do {
            *(int *)((long)DAT_0010c338 + lVar9) = (int)uVar8;
            ioctl(__fd,0xc0184340);
            uVar8 = uVar8 + 1;
            lVar9 = lVar9 + 0x18;
          } while (uVar8 < *(uint *)puVar3);
        }
      }
      iVar5 = ioctl(__fd,0xc0104347,param_1);
      if (iVar5 != 0) {
        puVar7 = (undefined4 *)__errno();
        __android_log_print(6,"ccci_lib","CCCI_IOC_CCB_CTRL_INFO fail on %s, err=%d\n",local_80,
                            *puVar7);
        uVar4 = close(__fd);
        pvVar6 = (void *)(ulong)uVar4;
        goto LAB_00108af8;
      }
      __android_log_print(3,"ccci_lib","new ccb_ctrl mmap on %s(%d) for addr=0x%x, len=%d\n",
                          local_80,__fd,param_1[2],param_1[3]);
      pvVar6 = mmap((void *)0x0,(ulong)(uint)param_1[3],3,1,__fd,0);
      *param_2 = pvVar6;
      iVar5 = __fd;
      if (pvVar6 != (void *)0xffffffffffffffff) goto LAB_00108af8;
      if (param_1[3] != 0) {
        puVar7 = (undefined4 *)__errno();
        __android_log_print(6,"ccci_lib","mmap on %s failed, %d\n",local_80,*puVar7);
      }
    }
    uVar4 = close(__fd);
    pvVar6 = (void *)(ulong)uVar4;
  }
  else {
    pvVar6 = (void *)__android_log_print(6,"ccci_lib","%s-%d:snprintf fail,ret = %d\n",
                                         "ccci_ccb_ctrl_get",0x1c7,uVar4);
  }
  iVar5 = -0xe;
LAB_00108af8:
  if (*(long *)(lVar2 + 0x28) == local_58) {
    return iVar5;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(pvVar6);
}



/* ccci_ccb_read_flush @ 00108bd4 */

undefined8 ccci_ccb_read_flush(ulong param_1)

{
  long lVar1;
  long lVar2;
  
  lVar1 = *(long *)(DAT_0010c340 + 0x40) + (param_1 & 0xffffffff) * 0x28;
  lVar2 = *(long *)(lVar1 + 8);
  *(undefined4 *)(lVar2 + 0xc) = *(undefined4 *)(lVar2 + 0x10);
  lVar1 = *(long *)(lVar1 + 8);
  *(undefined4 *)(lVar1 + 8) = *(undefined4 *)(lVar1 + 0xc);
  return 0;
}



/* ccci_ccb_unregister @ 00108c08 */

int ccci_ccb_unregister(void)

{
  uint uVar1;
  int __fd;
  int iVar2;
  long lVar3;
  void *__ptr;
  long lVar4;
  ulong uVar5;
  long lVar6;
  void *pvVar7;
  
  __ptr = DAT_0010c340;
  if (DAT_0010c340 == (void *)0x0) {
    iVar2 = -0xe;
  }
  else {
    lVar4 = *(long *)((long)DAT_0010c340 + 0x40);
    if ((lVar4 != 0) && (*(int *)((long)DAT_0010c340 + 0x20) != 0)) {
      lVar3 = *(long *)(lVar4 + 8);
      if (lVar3 == 0) {
        uVar5 = 0;
      }
      else {
        lVar6 = 0;
        uVar5 = 0;
        do {
          if (*(long *)(lVar4 + lVar6 + 0x10) == 0) break;
          *(undefined4 *)(lVar3 + 0x1c) = 0xeeff0011;
          *(undefined4 *)(*(long *)(lVar4 + lVar6 + 0x10) + 0x1c) = 0xeeff0011;
          uVar5 = uVar5 + 1;
          if (*(uint *)((long)__ptr + 0x20) <= uVar5) goto LAB_00108cc8;
          lVar4 = *(long *)((long)__ptr + 0x40);
          lVar3 = *(long *)(lVar4 + lVar6 + 0x30);
          lVar6 = lVar6 + 0x28;
        } while (lVar3 != 0);
      }
      __android_log_print(6,"ccci_lib","unregister: invalid header DL %p, UL %p\n",lVar3,
                          *(undefined8 *)(lVar4 + (uVar5 & 0xffffffff) * 0x28 + 0x10));
      __ptr = DAT_0010c340;
    }
LAB_00108cc8:
    iVar2 = *(int *)((long)__ptr + 0x34);
    if (iVar2 < 0) {
      iVar2 = 0;
      __fd = *(int *)((long)__ptr + 0x38);
    }
    else {
      pvVar7 = *(void **)((long)__ptr + 0x28);
      uVar1 = *(uint *)((long)__ptr + 0x30);
      close(iVar2);
      __android_log_print(3,"ccci_lib","munmap on (%d) for addr=%p, len=%d\n",iVar2,pvVar7,
                          (ulong)uVar1);
      iVar2 = munmap(pvVar7,(ulong)uVar1);
      __fd = *(int *)((long)DAT_0010c340 + 0x38);
      __ptr = DAT_0010c340;
    }
    if (-1 < __fd) {
      pvVar7 = *(void **)((long)__ptr + 0x18);
      uVar1 = *(uint *)((long)__ptr + 0x10);
      close(__fd);
      __android_log_print(3,"ccci_lib","munmap on (%d) for addr=%p, len=%d\n",__fd,pvVar7,
                          (ulong)uVar1);
      munmap(pvVar7,(ulong)uVar1);
      __ptr = DAT_0010c340;
    }
    if (*(void **)((long)__ptr + 0x40) != (void *)0x0) {
      free(*(void **)((long)__ptr + 0x40));
      __ptr = DAT_0010c340;
      *(undefined8 *)((long)DAT_0010c340 + 0x40) = 0;
    }
    free(__ptr);
    DAT_0010c340 = (void *)0x0;
  }
  return iVar2;
}



/* ccci_ccb_query_status @ 00108dac */

undefined8 ccci_ccb_query_status(void)

{
  undefined4 uVar1;
  char *pcVar2;
  ulong uVar3;
  undefined8 *puVar4;
  
  if (DAT_0010c340 == (undefined4 *)0x0) {
    return 0xfffffff2;
  }
  if (DAT_0010c340[8] != 0) {
    uVar3 = 0;
    puVar4 = (undefined8 *)(*(long *)(DAT_0010c340 + 0x10) + 0x10);
    do {
      if (*(int *)puVar4[-1] != -0x22443356) {
        uVar1 = *DAT_0010c340;
        pcVar2 = "user%d DL %d not ready, %x\n";
LAB_00108e50:
        __android_log_print(3,"ccci_lib",pcVar2,uVar1);
        return 0xfffffff5;
      }
      if (*(int *)*puVar4 != -0x22443356) {
        uVar1 = *DAT_0010c340;
        pcVar2 = "user%d UL %d not ready, %x\n";
        goto LAB_00108e50;
      }
      uVar3 = uVar3 + 1;
      puVar4 = puVar4 + 5;
    } while (uVar3 < (uint)DAT_0010c340[8]);
  }
  return 0;
}



/* ccci_ccb_write_alloc @ 00108e64 */

undefined4 * ccci_ccb_write_alloc(uint param_1)

{
  undefined4 *puVar1;
  int iVar2;
  uint uVar3;
  uint uVar4;
  uint uVar5;
  int iVar6;
  uint uVar7;
  ulong uVar8;
  long *plVar9;
  long lVar10;
  undefined4 *puVar11;
  int *piVar12;
  
  if ((DAT_0010c340 == (undefined4 *)0x0) ||
     (uVar8 = (ulong)param_1, (uint)DAT_0010c340[8] < param_1)) {
    return (undefined4 *)0x0;
  }
  lVar10 = *(long *)(DAT_0010c340 + 0x10);
  plVar9 = (long *)(lVar10 + uVar8 * 0x28 + 0x10);
  piVar12 = (int *)*plVar9;
  if (*piVar12 != -0x22443356 || piVar12[7] != 0x1100ffee) {
    __android_log_print(6,"ccci_lib",
                        "write_alloc of user%d buffer%d: MD not ready on UL, pattern=0x%0x, pattern_e=0x%x\n"
                        ,*DAT_0010c340);
    return (undefined4 *)0x0;
  }
  uVar3 = piVar12[1];
  uVar4 = piVar12[2];
  uVar5 = *(uint *)(lVar10 + uVar8 * 0x28 + 4);
  if (uVar4 == uVar3) {
    if (uVar5 != 1) {
LAB_00108f20:
      puVar11 = (undefined4 *)
                (*(long *)(lVar10 + uVar8 * 0x28 + 0x20) + (ulong)(piVar12[5] * uVar3));
      *puVar11 = 0x11111111;
      lVar10 = *plVar9;
      iVar6 = *(int *)(lVar10 + 4);
      iVar2 = 0;
      if (iVar6 + 1U < uVar5) {
        iVar2 = iVar6 + 1;
      }
      *(int *)(lVar10 + 4) = iVar2;
      goto LAB_00108f68;
    }
  }
  else {
    uVar7 = ~uVar3;
    if (uVar4 < uVar3) {
      uVar7 = uVar5 + uVar7;
    }
    if (uVar4 + uVar7 != 0) goto LAB_00108f20;
  }
  puVar11 = (undefined4 *)0x0;
LAB_00108f68:
  puVar1 = (undefined4 *)0x0;
  if (puVar11 != (undefined4 *)0x0) {
    puVar1 = puVar11 + 2;
  }
  return puVar1;
}



/* ccci_ccb_write_done @ 00108f7c */

void ccci_ccb_write_done(uint param_1,int *param_2,uint param_3)

{
  int *piVar1;
  int iVar2;
  long lVar3;
  uint uVar4;
  int iVar5;
  ulong uVar6;
  int iVar7;
  int iVar8;
  long lVar9;
  uint uVar10;
  long *plVar11;
  int *piVar12;
  uint *puVar13;
  byte *pbVar14;
  long lVar15;
  int iVar16;
  ulong uVar17;
  uint local_3c;
  long local_38;
  
  lVar3 = tpidr_el0;
  local_38 = *(long *)(lVar3 + 0x28);
  local_3c = 0;
  if (DAT_0010c340 == (int *)0x0) {
    iVar5 = -0xe;
    goto LAB_001090d0;
  }
  if (param_1 <= (uint)DAT_0010c340[8]) {
    lVar15 = *(long *)(DAT_0010c340 + 0x10);
    plVar11 = (long *)(lVar15 + (ulong)param_1 * 0x28 + 0x10);
    piVar12 = (int *)*plVar11;
    if (*piVar12 == -0x22443356 && piVar12[7] == 0x1100ffee) {
      if ((uint)piVar12[5] < param_3) {
        __android_log_print(6,"ccci_lib","write_done of user%d buffer%d: invalid length=%d\n",
                            *DAT_0010c340,param_1,param_3);
      }
      else {
        uVar17 = (ulong)param_1;
        puVar13 = (uint *)(lVar15 + uVar17 * 0x28 + 4);
        uVar10 = *puVar13;
        if (uVar10 != 0) {
          uVar4 = 0;
          uVar6 = 0;
          do {
            piVar1 = (int *)(*(long *)(lVar15 + uVar17 * 0x28 + 0x20) + (ulong)uVar4);
            if (piVar1 + 2 == param_2) break;
            uVar6 = uVar6 + 1;
            uVar4 = uVar4 + piVar12[5];
          } while (uVar6 < uVar10);
          if (uVar10 != (uint)uVar6) {
            if (*piVar1 == 0x11111111) {
              *piVar1 = 0x22222222;
              piVar1[1] = param_3;
              DataMemoryBarrier(2,3);
              lVar9 = *plVar11;
              iVar7 = *(int *)(lVar9 + 0x10);
              iVar2 = *(int *)(lVar9 + 4);
              iVar5 = iVar7;
              iVar8 = iVar7;
              if (iVar7 != iVar2) {
                iVar16 = *(int *)(lVar9 + 0x14);
                while (iVar5 = iVar2, iVar8 = iVar7,
                      *(int *)(*(long *)(lVar15 + uVar17 * 0x28 + 0x20) +
                              (ulong)(uint)(iVar16 * iVar7)) == 0x22222222) {
                  iVar5 = 0;
                  if (*(int *)(lVar9 + 0x10) + 1U < *puVar13) {
                    iVar5 = *(int *)(lVar9 + 0x10) + 1;
                  }
                  *(int *)(lVar9 + 0x10) = iVar5;
                  lVar9 = *plVar11;
                  iVar2 = *(int *)(lVar9 + 4);
                  iVar5 = 0;
                  if (iVar7 + 1U < *puVar13) {
                    iVar5 = iVar7 + 1;
                  }
                  iVar8 = iVar5;
                  if (iVar5 == iVar2) break;
                  iVar16 = *(int *)(lVar9 + 0x14);
                  iVar7 = iVar5;
                }
                iVar7 = *(int *)(lVar9 + 0x10);
              }
              __android_log_print(3,"ccci_lib",
                                  "write done of user%d buffer%d: OK, i=%d write=%d, alloc=%d, free=%d, len=%d\n"
                                  ,*DAT_0010c340,param_1,iVar8,iVar7,iVar5,
                                  *(undefined4 *)(lVar9 + 8),param_3);
              uVar17 = (ulong)*(uint *)PTR_ccb_info_len_0010b1f8;
              if (*(uint *)PTR_ccb_info_len_0010b1f8 != 0) {
                uVar10 = 0;
                pbVar14 = (byte *)(DAT_0010c338 + 4);
                do {
                  if (*(int *)(pbVar14 + -4) == *DAT_0010c340 + -0x39) {
                    if (uVar10 == param_1) {
                      local_3c = (uint)*pbVar14;
                      iVar5 = ioctl(DAT_0010c340[0xd],0x40044332,&local_3c);
                      goto LAB_001090d0;
                    }
                    uVar10 = uVar10 + 1;
                  }
                  pbVar14 = pbVar14 + 0x18;
                  uVar17 = uVar17 - 1;
                } while (uVar17 != 0);
              }
              __android_log_print(3,"ccci_lib","%s-%d:invalid config\n","ccci_ccb_write_done",0x407)
              ;
              iVar5 = -0xe;
              goto LAB_001090d0;
            }
            __android_log_print(6,"ccci_lib",
                                "write done of user%d buffer%d: invalid page%d, address=%p, status=%d\n"
                                ,*DAT_0010c340,param_1,uVar6,param_2);
            goto LAB_001090cc;
          }
        }
        __android_log_print(6,"ccci_lib","write done of user%d buffer%d: invalid address=%p\n",
                            *DAT_0010c340,param_1,param_2);
      }
    }
    else {
      __android_log_print(6,"ccci_lib",
                          "write_done of user%d buffer%d: MD not ready on UL, pattern=0x%0x, pattern=0x%x\n"
                          ,*DAT_0010c340,param_1);
    }
  }
LAB_001090cc:
  iVar5 = -0x16;
LAB_001090d0:
  if (*(long *)(lVar3 + 0x28) == local_38) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(iVar5);
}



/* ccci_ccb_poll @ 0010929c */

uint ccci_ccb_poll(uint param_1,undefined8 param_2,uint *param_3,ulong param_4,ulong param_5,
                  ulong param_6,ulong param_7,ulong param_8)

{
  uint uVar1;
  uint uVar2;
  uint uVar3;
  uint uVar4;
  uint uVar5;
  uint uVar6;
  uint uVar7;
  uint uVar8;
  uint uVar9;
  long lVar10;
  uint uVar11;
  int *piVar12;
  int iVar13;
  int iVar14;
  ulong uVar15;
  ulong uVar16;
  long lVar17;
  uint uVar18;
  long lVar19;
  ulong uVar20;
  uint unaff_w19;
  uint local_3c;
  long local_38;
  
  lVar10 = tpidr_el0;
  local_38 = *(long *)(lVar10 + 0x28);
  local_3c = param_1;
  do {
    if (DAT_0010c340 == 0) {
      uVar11 = 0xfffffff2;
      goto LAB_001094ac;
    }
    uVar11 = *(uint *)(DAT_0010c340 + 0x20);
    uVar15 = (ulong)uVar11;
    if (uVar11 != 0) {
      if (uVar11 == 1) {
        uVar16 = 0;
        unaff_w19 = 0;
LAB_00109418:
        lVar17 = uVar16 * 0x28;
        do {
          uVar11 = 1 << (ulong)((uint)uVar16 & 0x1f);
          if ((local_3c & uVar11) != 0) {
            lVar19 = *(long *)(*(long *)(DAT_0010c340 + 0x40) + lVar17 + 8);
            iVar14 = *(int *)(lVar19 + 0x10) - *(int *)(lVar19 + 0xc);
            if (iVar14 < 0) {
              iVar14 = *(int *)(*(long *)(DAT_0010c340 + 0x40) + lVar17) + iVar14;
            }
            uVar18 = 0;
            if (iVar14 != 0) {
              uVar18 = uVar11;
            }
            unaff_w19 = uVar18 | unaff_w19;
          }
          uVar16 = uVar16 + 1;
          lVar17 = lVar17 + 0x28;
        } while (uVar16 < uVar15);
      }
      else {
        lVar17 = 0;
        uVar20 = 0;
        uVar11 = 0;
        uVar18 = 0;
        uVar16 = uVar15 & 0xfffffffe;
        do {
          iVar14 = (int)param_8;
          uVar6 = 1 << (ulong)((uint)uVar20 & 0x1f);
          uVar7 = 1 << (ulong)((uint)uVar20 + 1 & 0x1f);
          uVar3 = local_3c & uVar6;
          uVar1 = local_3c & uVar7;
          if (uVar3 != 0) {
            param_3 = *(uint **)(DAT_0010c340 + 0x40);
          }
          if (uVar1 != 0) {
            param_4 = *(ulong *)(DAT_0010c340 + 0x40);
          }
          if (uVar3 != 0) {
            param_5 = *(ulong *)((long)param_3 + lVar17 + 8);
          }
          if (uVar1 != 0) {
            param_6 = param_4 + lVar17;
            param_7 = *(ulong *)(param_6 + 0x30);
          }
          iVar13 = (int)param_6;
          if (uVar3 != 0) {
            iVar13 = *(int *)(param_5 + 0x10);
          }
          if (uVar1 != 0) {
            iVar14 = *(int *)(param_7 + 0x10);
          }
          if (uVar3 != 0) {
            unaff_w19 = *(uint *)(param_5 + 0xc);
          }
          if (uVar1 != 0) {
            param_5 = (ulong)*(uint *)(param_7 + 0xc);
          }
          uVar8 = iVar14 - (int)param_5;
          param_5 = (ulong)uVar8;
          param_7 = (ulong)(uVar1 != 0);
          uVar9 = iVar13 - unaff_w19;
          param_6 = (ulong)uVar9;
          uVar2 = (uint)((int)uVar8 < 0 && uVar1 != 0);
          param_8 = (ulong)uVar2;
          if (((int)uVar9 < 0) && (uVar3 != 0)) {
            param_7 = (ulong)*(uint *)((long)param_3 + lVar17);
          }
          if (uVar2 != 0) {
            param_3 = (uint *)(ulong)*(uint *)(param_4 + lVar17 + 0x28);
          }
          uVar2 = 0;
          if (0x7fffffff < uVar9 || uVar3 == 0) {
            uVar2 = -(int)param_7;
          }
          param_4 = (ulong)uVar2;
          uVar5 = 0;
          if (0x7fffffff < uVar8 || uVar1 == 0) {
            uVar5 = -(int)param_3;
          }
          param_3 = (uint *)(ulong)uVar5;
          uVar4 = 0;
          if (uVar9 != uVar2) {
            uVar4 = uVar6;
          }
          uVar6 = 0;
          if (uVar8 != uVar5) {
            uVar6 = uVar7;
          }
          if (uVar3 == 0) {
            uVar4 = 0;
          }
          if (uVar1 == 0) {
            uVar6 = 0;
          }
          uVar11 = uVar11 | uVar4;
          uVar18 = uVar18 | uVar6;
          uVar20 = uVar20 + 2;
          lVar17 = lVar17 + 0x50;
        } while (uVar16 != uVar20);
        unaff_w19 = uVar18 | uVar11;
        if (uVar16 != uVar15) goto LAB_00109418;
      }
      uVar11 = unaff_w19;
      if (unaff_w19 != 0) goto LAB_001094ac;
    }
    param_3 = &local_3c;
    uVar11 = ioctl(*(int *)(DAT_0010c340 + 0x34),0x80044333);
  } while (-1 < (int)uVar11);
  piVar12 = (int *)__errno();
  if (*piVar12 == 0x13) {
    __android_log_print(6,"ccci_lib","ccb poll fail, ret=%d, md is not ready\n",uVar11);
    uVar11 = 0xfffffffe;
  }
LAB_001094ac:
  if (*(long *)(lVar10 + 0x28) == local_38) {
    return uVar11;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}



/* ccci_ccb_read_get @ 001094d8 */

undefined8 ccci_ccb_read_get(uint param_1,long *param_2,int *param_3)

{
  int *piVar1;
  int iVar2;
  int iVar3;
  ulong uVar4;
  long lVar5;
  uint *puVar6;
  undefined4 *puVar7;
  
  if (DAT_0010c340 == (undefined4 *)0x0) {
    return 0xfffffff2;
  }
  uVar4 = (ulong)param_1;
  if (param_1 <= (uint)DAT_0010c340[8]) {
    puVar6 = (uint *)(*(long *)(DAT_0010c340 + 0x10) + uVar4 * 0x28);
    puVar7 = *(undefined4 **)(puVar6 + 2);
    if (puVar7[7] == 0x1100ffee) {
      iVar3 = puVar7[4] - puVar7[3];
      if (iVar3 < 0) {
        iVar3 = *puVar6 + iVar3;
      }
      if (iVar3 != 0) {
        piVar1 = (int *)(*(long *)(*(long *)(DAT_0010c340 + 0x10) + uVar4 * 0x28 + 0x18) +
                        (ulong)(uint)(puVar7[5] * puVar7[3]));
        if (*piVar1 != 0x22222222) {
          __android_log_print(6,"ccci_lib",
                              "read get of user%d buffer%d: invalid status=%d, read=%d\n",
                              *DAT_0010c340);
          return 0xfffffff2;
        }
        *param_2 = (long)(piVar1 + 2);
        *param_3 = piVar1[1];
        lVar5 = *(long *)(puVar6 + 2);
        iVar2 = *(int *)(lVar5 + 0xc);
        iVar3 = 0;
        if (iVar2 + 1U < *puVar6) {
          iVar3 = iVar2 + 1;
        }
        *(int *)(lVar5 + 0xc) = iVar3;
        return 0;
      }
      *param_2 = 0;
      *param_3 = 0;
      return 0xfffffff5;
    }
    __android_log_print(6,"ccci_lib",
                        "read get of user%d buffer%d: MD not ready on DL, pattern=0x%0x, pattern_e=0x%x\n"
                        ,*DAT_0010c340,uVar4,*puVar7);
  }
  return 0xffffffea;
}



/* ccci_ccb_read_done @ 0010960c */

undefined8 ccci_ccb_read_done(uint param_1)

{
  int iVar1;
  ulong uVar2;
  undefined4 *puVar3;
  
  if (DAT_0010c340 == (undefined4 *)0x0) {
    return 0xfffffff2;
  }
  uVar2 = (ulong)param_1;
  if (param_1 <= (uint)DAT_0010c340[8]) {
    puVar3 = *(undefined4 **)(*(long *)(DAT_0010c340 + 0x10) + uVar2 * 0x28 + 8);
    if (puVar3[7] == 0x1100ffee) {
      iVar1 = 0;
      if (puVar3[2] + 1 < *(uint *)(*(long *)(DAT_0010c340 + 0x10) + uVar2 * 0x28)) {
        iVar1 = puVar3[2] + 1;
      }
      if (puVar3[3] != iVar1) {
        __android_log_print(6,"ccci_lib",
                            "read done of user%d buffer%d: invalid index, read=%d, free=%d\n",
                            *DAT_0010c340);
        return 0xfffffff2;
      }
      puVar3[2] = iVar1;
      return 0;
    }
    __android_log_print(6,"ccci_lib",
                        "read done of user%d buffer%d: MD not ready on DL, pattern=0x%0x, pattern_e=0x%x\n"
                        ,*DAT_0010c340,uVar2,*puVar3);
  }
  return 0xffffffea;
}



/* ccci_get_ccb_support @ 001096e0 */

void ccci_get_ccb_support(uint param_1,int param_2)

{
  long lVar1;
  int iVar2;
  undefined8 uVar3;
  ssize_t sVar4;
  char *pcVar5;
  stat local_f0;
  char local_60 [40];
  long local_38;
  
  lVar1 = tpidr_el0;
  local_38 = *(long *)(lVar1 + 0x28);
  local_f0.st_ctim.tv_sec = 0;
  local_f0.st_mtim.tv_nsec = 0;
  local_f0.__unused[0] = 0;
  local_f0.st_ctim.tv_nsec = 0;
  local_f0.st_atim.tv_sec = 0;
  local_f0.st_blocks = 0;
  local_f0.st_mtim.tv_sec = 0;
  local_f0.st_atim.tv_nsec = 0;
  local_f0.st_rdev = 0;
  local_f0.st_gid = 0;
  local_f0.__pad0 = 0;
  local_f0.st_blksize = 0;
  local_f0.st_size = 0;
  local_f0.st_ino = 0;
  local_f0.st_dev = 0;
  local_f0.st_mode = 0;
  local_f0.st_uid = 0;
  local_f0.st_nlink = 0;
  local_60[8] = '\0';
  local_60[9] = '\0';
  local_60[10] = '\0';
  local_60[0xb] = '\0';
  local_60[0xc] = '\0';
  local_60[0xd] = '\0';
  local_60[0xe] = '\0';
  local_60[0xf] = '\0';
  local_60[0] = '\0';
  local_60[1] = '\0';
  local_60[2] = '\0';
  local_60[3] = '\0';
  local_60[4] = '\0';
  local_60[5] = '\0';
  local_60[6] = '\0';
  local_60[7] = '\0';
  local_60[0x18] = '\0';
  local_60[0x19] = '\0';
  local_60[0x1a] = '\0';
  local_60[0x1b] = '\0';
  local_60[0x1c] = '\0';
  local_60[0x1d] = '\0';
  local_60[0x1e] = '\0';
  local_60[0x1f] = '\0';
  local_60[0x10] = '\0';
  local_60[0x11] = '\0';
  local_60[0x12] = '\0';
  local_60[0x13] = '\0';
  local_60[0x14] = '\0';
  local_60[0x15] = '\0';
  local_60[0x16] = '\0';
  local_60[0x17] = '\0';
  if (param_2 == 0) {
    local_f0.__unused[2]._4_2_ = 0;
    iVar2 = __open_2("/sys/kernel/ccci/version");
    if (iVar2 < 0) {
      iVar2 = strcmp(&UNK_00101e94 + (ulong)param_1 * 0xe4,"/dev/null");
      pcVar5 = (char *)0x0;
      if (iVar2 != 0) {
        pcVar5 = &UNK_00101e94 + (ulong)param_1 * 0xe4;
      }
    }
    else {
      sVar4 = read(iVar2,(void *)((long)local_f0.__unused + 0x14),2);
      iVar2 = close(iVar2);
      if ((int)sVar4 < 1) {
        pcVar5 = (char *)0x0;
      }
      else {
        pcVar5 = (char *)0x0;
        if (local_f0.__unused[2]._4_1_ - 0x31 < 6) {
                    /* WARNING: Could not recover jumptable at 0x001097a8. Too many branches */
                    /* WARNING: Treating indirect jump as call */
          (*(code *)((ulong)(byte)(&DAT_001011a8)[local_f0.__unused[2]._4_1_ - 0x31] * 4 + 0x1097ac)
          )(iVar2);
          return;
        }
      }
    }
    snprintf(local_60,0x20,(char *)0x20,&DAT_0010139d,pcVar5);
    if (param_1 == 0x3b) {
      iVar2 = stat(local_60,&local_f0);
      if (-1 < iVar2) {
        uVar3 = 3;
        goto LAB_00109720;
      }
      pcVar5 = "not support ccb meta\n";
    }
    else if (param_1 == 0x3a) {
      iVar2 = stat(local_60,&local_f0);
      if (-1 < iVar2) {
        uVar3 = 2;
        goto LAB_00109720;
      }
      pcVar5 = "not support ccb md monitor\n";
    }
    else {
      if (param_1 != 0x39) goto LAB_0010971c;
      iVar2 = stat(local_60,&local_f0);
      if (-1 < iVar2) {
        uVar3 = 1;
        goto LAB_00109720;
      }
      pcVar5 = "not support ccb emdlogger\n";
    }
    __android_log_print(6,"ccci_lib",pcVar5);
  }
LAB_0010971c:
  uVar3 = 0;
LAB_00109720:
  if (*(long *)(lVar1 + 0x28) != local_38) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar3);
  }
  return;
}



/* AB_image_get @ 001098d0 */

void AB_image_get(undefined1 *param_1)

{
  int iVar1;
  
  iVar1 = property_get("ro.boot.slot_suffix",param_1,0);
  if (iVar1 == 0) {
    *param_1 = 0;
  }
  return;
}



/* query_prj_cfg_setting_platform @ 00109908 */

int query_prj_cfg_setting_platform(char *param_1,char *param_2,int param_3)

{
  int iVar1;
  
  iVar1 = strcmp(param_1,"MTK_ECCCI_C2K");
  if (iVar1 == 0) {
    iVar1 = snprintf(param_2,0xffffffffffffffff,(char *)(long)param_3);
    iVar1 = -(uint)(iVar1 < 0 || param_3 <= iVar1);
  }
  else {
    iVar1 = -1;
  }
  return iVar1;
}



/* snprintf @ 00109968 */

/* snprintf(char*, unsigned long pass_object_size1, char const*, ...) */

void snprintf(char *param_1,ulong param_2,char *param_3,...)

{
  long lVar1;
  undefined8 in_x4;
  undefined8 in_x5;
  undefined8 in_x6;
  undefined8 in_x7;
  long lVar2;
  undefined8 in_d0;
  undefined8 local_90;
  undefined8 local_88;
  undefined8 uStack_80;
  undefined8 local_78;
  undefined1 *local_70;
  undefined1 **ppuStack_68;
  undefined8 *puStack_60;
  undefined8 uStack_58;
  
  lVar1 = tpidr_el0;
  lVar2 = *(long *)(lVar1 + 0x28);
  ppuStack_68 = &local_70;
  puStack_60 = &local_90;
  uStack_58 = 0xffffff80ffffffe0;
  local_90 = in_x4;
  local_88 = in_x5;
  uStack_80 = in_x6;
  local_78 = in_x7;
  local_70 = (undefined1 *)register0x00000008;
  __vsnprintf_chk(param_1,param_3,0,param_2,&DAT_00101ae9,&local_70,in_x6,in_x7,in_d0);
  if (*(long *)(lVar1 + 0x28) == lVar2) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}



/* property_get_bool @ 00109a14 */

undefined4 property_get_bool(long param_1,undefined4 param_2)

{
  long lVar1;
  short sVar2;
  char cVar3;
  ulong uVar4;
  undefined4 uVar5;
  size_t sVar6;
  undefined4 local_a0;
  short sStack_9c;
  undefined8 uStack_98;
  undefined8 local_90;
  undefined8 uStack_88;
  undefined8 uStack_80;
  undefined8 uStack_78;
  undefined8 local_70;
  undefined8 uStack_68;
  undefined8 uStack_60;
  undefined4 uStack_58;
  undefined4 local_54;
  undefined4 uStack_50;
  undefined8 uStack_4c;
  long local_38;
  
  lVar1 = tpidr_el0;
  local_38 = *(long *)(lVar1 + 0x28);
  uVar5 = param_2;
  if (param_1 == 0) goto LAB_00109bb0;
  uStack_4c = 0;
  uStack_50 = 0;
  uStack_68 = 0;
  local_70 = 0;
  uStack_58 = 0;
  local_54 = 0;
  uStack_60 = 0;
  uStack_88 = 0;
  local_90 = 0;
  uStack_78 = 0;
  uStack_80 = 0;
  uStack_98 = 0;
  _local_a0 = 0;
  uVar4 = __system_property_get(param_1,&local_a0);
  sVar6 = uVar4 & 0xffffffff;
  if ((int)uVar4 < 1) {
    sVar6 = strnlen("",0x5b);
    if (sVar6 != (long)(int)sVar6) {
                    /* WARNING: Subroutine does not return */
      abort();
    }
    __memcpy_chk(&local_a0,&DAT_00101cd4,sVar6,0x5c);
    *(undefined1 *)((long)&local_a0 + sVar6) = 0;
    if ((int)sVar6 == 1) goto LAB_00109a6c;
LAB_00109ad8:
    if ((int)sVar6 < 2) goto LAB_00109bb0;
    sVar2 = (short)local_a0;
    cVar3 = local_a0._2_1_;
    if ((short)local_a0 != 0x6f6e || local_a0._2_1_ != '\0') {
      uVar5 = 0;
      if (local_a0 == 0x736c6166 && sStack_9c == 0x65) goto LAB_00109bb0;
      if (local_a0 != 0x66666f) {
        if (((local_a0 != 0x736579) && (local_a0 != 0x65757274 || (char)sStack_9c != '\0')) &&
           (uVar5 = param_2, sVar2 != 0x6e6f || cVar3 != '\0')) goto LAB_00109bb0;
        goto LAB_00109b98;
      }
    }
    uVar5 = 0;
  }
  else {
    if ((int)uVar4 != 1) goto LAB_00109ad8;
LAB_00109a6c:
    uVar5 = 0;
    if ((byte)local_a0 < 0x6e) {
      if (((byte)local_a0 == 0x30) || (uVar5 = param_2, (byte)local_a0 != 0x31)) goto LAB_00109bb0;
    }
    else if (((byte)local_a0 == 0x6e) || (uVar5 = param_2, (byte)local_a0 != 0x79))
    goto LAB_00109bb0;
LAB_00109b98:
    uVar5 = 1;
  }
LAB_00109bb0:
  if (*(long *)(lVar1 + 0x28) != local_38) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return uVar5;
}



/* property_get @ 00109be0 */

ulong property_get(undefined8 param_1,void *param_2,char *param_3)

{
  ulong uVar1;
  size_t __n;
  
  uVar1 = __system_property_get();
  __n = uVar1 & 0xffffffff;
  if ((param_3 != (char *)0x0) && ((int)uVar1 < 1)) {
    __n = strnlen(param_3,0x5b);
    if (__n != (long)(int)__n) {
                    /* WARNING: Subroutine does not return */
      abort();
    }
    memcpy(param_2,param_3,__n);
    *(undefined1 *)((long)param_2 + __n) = 0;
  }
  return __n & 0xffffffff;
}



/* property_get_int64 @ 00109c50 */

intmax_t property_get_int64(long param_1,intmax_t param_2)

{
  long lVar1;
  int iVar2;
  size_t sVar3;
  int *piVar4;
  intmax_t iVar5;
  char *local_b8;
  char local_b0 [104];
  long local_48;
  
  lVar1 = tpidr_el0;
  local_48 = *(long *)(lVar1 + 0x28);
  if (param_1 != 0) {
    local_b0[0x54] = '\0';
    local_b0[0x55] = '\0';
    local_b0[0x56] = '\0';
    local_b0[0x57] = '\0';
    local_b0[0x58] = '\0';
    local_b0[0x59] = '\0';
    local_b0[0x5a] = '\0';
    local_b0[0x5b] = '\0';
    local_b0[0x50] = '\0';
    local_b0[0x51] = '\0';
    local_b0[0x52] = '\0';
    local_b0[0x53] = '\0';
    local_b0[0x38] = '\0';
    local_b0[0x39] = '\0';
    local_b0[0x3a] = '\0';
    local_b0[0x3b] = '\0';
    local_b0[0x3c] = '\0';
    local_b0[0x3d] = '\0';
    local_b0[0x3e] = '\0';
    local_b0[0x3f] = '\0';
    local_b0[0x30] = '\0';
    local_b0[0x31] = '\0';
    local_b0[0x32] = '\0';
    local_b0[0x33] = '\0';
    local_b0[0x34] = '\0';
    local_b0[0x35] = '\0';
    local_b0[0x36] = '\0';
    local_b0[0x37] = '\0';
    local_b0[0x48] = '\0';
    local_b0[0x49] = '\0';
    local_b0[0x4a] = '\0';
    local_b0[0x4b] = '\0';
    local_b0[0x4c] = '\0';
    local_b0[0x4d] = '\0';
    local_b0[0x4e] = '\0';
    local_b0[0x4f] = '\0';
    local_b0[0x40] = '\0';
    local_b0[0x41] = '\0';
    local_b0[0x42] = '\0';
    local_b0[0x43] = '\0';
    local_b0[0x44] = '\0';
    local_b0[0x45] = '\0';
    local_b0[0x46] = '\0';
    local_b0[0x47] = '\0';
    local_b0[0x18] = '\0';
    local_b0[0x19] = '\0';
    local_b0[0x1a] = '\0';
    local_b0[0x1b] = '\0';
    local_b0[0x1c] = '\0';
    local_b0[0x1d] = '\0';
    local_b0[0x1e] = '\0';
    local_b0[0x1f] = '\0';
    local_b0[0x10] = '\0';
    local_b0[0x11] = '\0';
    local_b0[0x12] = '\0';
    local_b0[0x13] = '\0';
    local_b0[0x14] = '\0';
    local_b0[0x15] = '\0';
    local_b0[0x16] = '\0';
    local_b0[0x17] = '\0';
    local_b0[0x28] = '\0';
    local_b0[0x29] = '\0';
    local_b0[0x2a] = '\0';
    local_b0[0x2b] = '\0';
    local_b0[0x2c] = '\0';
    local_b0[0x2d] = '\0';
    local_b0[0x2e] = '\0';
    local_b0[0x2f] = '\0';
    local_b0[0x20] = '\0';
    local_b0[0x21] = '\0';
    local_b0[0x22] = '\0';
    local_b0[0x23] = '\0';
    local_b0[0x24] = '\0';
    local_b0[0x25] = '\0';
    local_b0[0x26] = '\0';
    local_b0[0x27] = '\0';
    local_b0[8] = '\0';
    local_b0[9] = '\0';
    local_b0[10] = '\0';
    local_b0[0xb] = '\0';
    local_b0[0xc] = '\0';
    local_b0[0xd] = '\0';
    local_b0[0xe] = '\0';
    local_b0[0xf] = '\0';
    local_b0[0] = '\0';
    local_b0[1] = '\0';
    local_b0[2] = '\0';
    local_b0[3] = '\0';
    local_b0[4] = '\0';
    local_b0[5] = '\0';
    local_b0[6] = '\0';
    local_b0[7] = '\0';
    local_b8 = (char *)0x0;
    iVar2 = __system_property_get(param_1,local_b0);
    if (iVar2 < 1) {
      sVar3 = strnlen("",0x5b);
      if (sVar3 != (long)(int)sVar3) {
                    /* WARNING: Subroutine does not return */
        abort();
      }
      __memcpy_chk(local_b0,&DAT_00101cd4,sVar3,0x5c);
      local_b0[sVar3] = '\0';
      if ((int)sVar3 < 1) goto LAB_00109d38;
    }
    piVar4 = (int *)__errno();
    iVar2 = *piVar4;
    *piVar4 = 0;
    iVar5 = strtoimax(local_b0,&local_b8,0);
    if (((1 < iVar5 + 0x8000000000000001U) || (*piVar4 != 0x22)) && (local_b8 != local_b0)) {
      param_2 = iVar5;
    }
    *piVar4 = iVar2;
  }
LAB_00109d38:
  if (*(long *)(lVar1 + 0x28) != local_48) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return param_2;
}



/* property_get_int32 @ 00109d6c */

ulong property_get_int32(long param_1,int param_2)

{
  undefined4 uVar1;
  long lVar2;
  int iVar3;
  size_t sVar4;
  undefined4 *puVar5;
  ulong uVar6;
  ulong uVar7;
  char *local_b8;
  char local_b0 [104];
  long local_48;
  
  lVar2 = tpidr_el0;
  local_48 = *(long *)(lVar2 + 0x28);
  uVar7 = (ulong)param_2;
  if (param_1 != 0) {
    local_b0[0x54] = '\0';
    local_b0[0x55] = '\0';
    local_b0[0x56] = '\0';
    local_b0[0x57] = '\0';
    local_b0[0x58] = '\0';
    local_b0[0x59] = '\0';
    local_b0[0x5a] = '\0';
    local_b0[0x5b] = '\0';
    local_b0[0x50] = '\0';
    local_b0[0x51] = '\0';
    local_b0[0x52] = '\0';
    local_b0[0x53] = '\0';
    local_b0[0x38] = '\0';
    local_b0[0x39] = '\0';
    local_b0[0x3a] = '\0';
    local_b0[0x3b] = '\0';
    local_b0[0x3c] = '\0';
    local_b0[0x3d] = '\0';
    local_b0[0x3e] = '\0';
    local_b0[0x3f] = '\0';
    local_b0[0x30] = '\0';
    local_b0[0x31] = '\0';
    local_b0[0x32] = '\0';
    local_b0[0x33] = '\0';
    local_b0[0x34] = '\0';
    local_b0[0x35] = '\0';
    local_b0[0x36] = '\0';
    local_b0[0x37] = '\0';
    local_b0[0x48] = '\0';
    local_b0[0x49] = '\0';
    local_b0[0x4a] = '\0';
    local_b0[0x4b] = '\0';
    local_b0[0x4c] = '\0';
    local_b0[0x4d] = '\0';
    local_b0[0x4e] = '\0';
    local_b0[0x4f] = '\0';
    local_b0[0x40] = '\0';
    local_b0[0x41] = '\0';
    local_b0[0x42] = '\0';
    local_b0[0x43] = '\0';
    local_b0[0x44] = '\0';
    local_b0[0x45] = '\0';
    local_b0[0x46] = '\0';
    local_b0[0x47] = '\0';
    local_b0[0x18] = '\0';
    local_b0[0x19] = '\0';
    local_b0[0x1a] = '\0';
    local_b0[0x1b] = '\0';
    local_b0[0x1c] = '\0';
    local_b0[0x1d] = '\0';
    local_b0[0x1e] = '\0';
    local_b0[0x1f] = '\0';
    local_b0[0x10] = '\0';
    local_b0[0x11] = '\0';
    local_b0[0x12] = '\0';
    local_b0[0x13] = '\0';
    local_b0[0x14] = '\0';
    local_b0[0x15] = '\0';
    local_b0[0x16] = '\0';
    local_b0[0x17] = '\0';
    local_b0[0x28] = '\0';
    local_b0[0x29] = '\0';
    local_b0[0x2a] = '\0';
    local_b0[0x2b] = '\0';
    local_b0[0x2c] = '\0';
    local_b0[0x2d] = '\0';
    local_b0[0x2e] = '\0';
    local_b0[0x2f] = '\0';
    local_b0[0x20] = '\0';
    local_b0[0x21] = '\0';
    local_b0[0x22] = '\0';
    local_b0[0x23] = '\0';
    local_b0[0x24] = '\0';
    local_b0[0x25] = '\0';
    local_b0[0x26] = '\0';
    local_b0[0x27] = '\0';
    local_b0[8] = '\0';
    local_b0[9] = '\0';
    local_b0[10] = '\0';
    local_b0[0xb] = '\0';
    local_b0[0xc] = '\0';
    local_b0[0xd] = '\0';
    local_b0[0xe] = '\0';
    local_b0[0xf] = '\0';
    local_b0[0] = '\0';
    local_b0[1] = '\0';
    local_b0[2] = '\0';
    local_b0[3] = '\0';
    local_b0[4] = '\0';
    local_b0[5] = '\0';
    local_b0[6] = '\0';
    local_b0[7] = '\0';
    local_b8 = (char *)0x0;
    iVar3 = __system_property_get(param_1,local_b0);
    if (iVar3 < 1) {
      sVar4 = strnlen("",0x5b);
      if (sVar4 != (long)(int)sVar4) {
                    /* WARNING: Subroutine does not return */
        abort();
      }
      __memcpy_chk(local_b0,&DAT_00101cd4,sVar4,0x5c);
      local_b0[sVar4] = '\0';
      if ((int)sVar4 < 1) goto LAB_00109e4c;
    }
    puVar5 = (undefined4 *)__errno();
    uVar1 = *puVar5;
    *puVar5 = 0;
    uVar6 = strtoimax(local_b0,&local_b8,0);
    if ((local_b8 != local_b0 && (long)(int)uVar6 == uVar6) && 1 < uVar6 + 0x8000000000000001) {
      uVar7 = uVar6;
    }
    *puVar5 = uVar1;
  }
LAB_00109e4c:
  if (*(long *)(lVar2 + 0x28) == local_48) {
    return uVar7 & 0xffffffff;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}



/* property_set @ 00109e80 */

void property_set(void)

{
  (*(code *)PTR___system_property_set_0010b320)();
  return;
}



/* property_list @ 00109e84 */

void property_list(undefined8 param_1,undefined8 param_2)

{
  long lVar1;
  undefined8 local_38;
  undefined8 uStack_30;
  long local_28;
  
  lVar1 = tpidr_el0;
  local_28 = *(long *)(lVar1 + 0x28);
  local_38 = param_1;
  uStack_30 = param_2;
  __system_property_foreach(property_list_callback,&local_38);
  if (*(long *)(lVar1 + 0x28) == local_28) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}



/* property_list_callback @ 00109ed8 */

/* property_list_callback(prop_info const*, void*) */

void property_list_callback(prop_info *param_1,void *param_2)

{
  __system_property_read_callback(param_1,trampoline,param_2);
  return;
}



/* trampoline @ 00109ee8 */

/* trampoline(void*, char const*, char const*, unsigned int) */

void trampoline(void *param_1,char *param_2,char *param_3,uint param_4)

{
                    /* WARNING: Could not recover jumptable at 0x00109ef8. Too many branches */
                    /* WARNING: Treating indirect jump as call */
  (**(code **)param_1)(param_2,param_3,*(undefined8 *)((long)param_1 + 8));
  return;
}



/* FUN_00109f00 @ 00109f00 */

void FUN_00109f00(void)

{
  (*(code *)PTR_0010b210)();
  return;
}



/* __cxa_finalize @ 00109f20 */

void __cxa_finalize(void)

{
  (*(code *)PTR___cxa_finalize_0010b218)();
  return;
}



/* malloc @ 00109f30 */

/* WARNING: Unknown calling convention -- yet parameter storage is locked */

void * malloc(size_t __size)

{
  void *pvVar1;
  
  pvVar1 = (void *)(*(code *)PTR_malloc_0010b220)();
  return pvVar1;
}



/* __android_log_print @ 00109f40 */

void __android_log_print(void)

{
  (*(code *)PTR___android_log_print_0010b228)();
  return;
}



/* lseek @ 00109f50 */

/* WARNING: Unknown calling convention -- yet parameter storage is locked */

__off_t lseek(int __fd,__off_t __offset,int __whence)

{
  __off_t _Var1;
  
  _Var1 = (*(code *)PTR_lseek_0010b230)(__fd,__offset,__whence);
  return _Var1;
}



/* read @ 00109f60 */

/* WARNING: Unknown calling convention -- yet parameter storage is locked */

ssize_t read(int __fd,void *__buf,size_t __nbytes)

{
  ssize_t sVar1;
  
  sVar1 = (*(code *)PTR_read_0010b238)(__fd);
  return sVar1;
}



/* strcmp @ 00109f70 */

/* WARNING: Unknown calling convention -- yet parameter storage is locked */

int strcmp(char *__s1,char *__s2)

{
  int iVar1;
  
  iVar1 = (*(code *)PTR_strcmp_0010b240)((int)__s1);
  return iVar1;
}



/* __errno @ 00109f80 */

void __errno(void)

{
  (*(code *)PTR___errno_0010b248)();
  return;
}



/* free @ 00109f90 */

/* WARNING: Unknown calling convention -- yet parameter storage is locked */

void free(void *__ptr)

{
  (*(code *)PTR_free_0010b250)();
  return;
}



/* AB_image_get @ 00109fa0 */

void AB_image_get(void)

{
  (*(code *)PTR_AB_image_get_0010b258)();
  return;
}



/* __open_2 @ 00109fb0 */

void __open_2(void)

{
  (*(code *)PTR___open_2_0010b260)();
  return;
}



/* find_image_from_pt_internal @ 00109fc0 */

void find_image_from_pt_internal(void)

{
  (*(code *)PTR_find_image_from_pt_internal_0010b268)();
  return;
}



/* close @ 00109fd0 */

/* WARNING: Unknown calling convention -- yet parameter storage is locked */

int close(int __fd)

{
  int iVar1;
  
  iVar1 = (*(code *)PTR_close_0010b270)(__fd);
  return iVar1;
}



/* __stack_chk_fail @ 00109fe0 */

void __stack_chk_fail(void)

{
  (*(code *)PTR___stack_chk_fail_0010b278)();
  return;
}



/* __vsnprintf_chk @ 00109ff0 */

void __vsnprintf_chk(void)

{
  (*(code *)PTR___vsnprintf_chk_0010b280)();
  return;
}



/* memset @ 0010a000 */

/* WARNING: Unknown calling convention -- yet parameter storage is locked */

void * memset(void *__s,int __c,size_t __n)

{
  void *pvVar1;
  
  pvVar1 = (void *)(*(code *)PTR_memset_0010b288)(__s,__c);
  return pvVar1;
}



/* find_image_from_pt @ 0010a010 */

void find_image_from_pt(void)

{
  (*(code *)PTR_find_image_from_pt_0010b290)();
  return;
}



/* creat @ 0010a020 */

/* WARNING: Unknown calling convention -- yet parameter storage is locked */

int creat(char *__file,__mode_t __mode)

{
  int iVar1;
  
  iVar1 = (*(code *)PTR_creat_0010b298)((int)__file,__mode);
  return iVar1;
}



/* __read_chk @ 0010a030 */

void __read_chk(void)

{
  (*(code *)PTR___read_chk_0010b2a0)();
  return;
}



/* __write_chk @ 0010a040 */

void __write_chk(void)

{
  (*(code *)PTR___write_chk_0010b2a8)();
  return;
}



/* query_prj_cfg_setting_platform @ 0010a050 */

void query_prj_cfg_setting_platform(void)

{
  (*(code *)PTR_query_prj_cfg_setting_platform_0010b2b0)();
  return;
}



/* ioctl @ 0010a060 */

/* WARNING: Unknown calling convention -- yet parameter storage is locked */

int ioctl(int __fd,ulong __request,...)

{
  int iVar1;
  
  iVar1 = (*(code *)PTR_ioctl_0010b2b8)(__fd);
  return iVar1;
}



/* mmap @ 0010a070 */

/* WARNING: Unknown calling convention -- yet parameter storage is locked */

void * mmap(void *__addr,size_t __len,int __prot,int __flags,int __fd,__off_t __offset)

{
  void *pvVar1;
  
  pvVar1 = (void *)(*(code *)PTR_mmap_0010b2c0)(__addr,__len,__prot,__flags,__fd);
  return pvVar1;
}



/* munmap @ 0010a080 */

/* WARNING: Unknown calling convention -- yet parameter storage is locked */

int munmap(void *__addr,size_t __len)

{
  int iVar1;
  
  iVar1 = (*(code *)PTR_munmap_0010b2c8)((int)__addr);
  return iVar1;
}



/* ccci_ccb_unregister @ 0010a090 */

void ccci_ccb_unregister(void)

{
  (*(code *)PTR_ccci_ccb_unregister_0010b2d0)();
  return;
}



/* ccci_smem_get @ 0010a0a0 */

void ccci_smem_get(void)

{
  (*(code *)PTR_ccci_smem_get_0010b2d8)();
  return;
}



/* stat @ 0010a0b0 */

/* WARNING: Unknown calling convention -- yet parameter storage is locked */

int stat(char *__file,stat *__buf)

{
  int iVar1;
  
  iVar1 = (*(code *)PTR_stat_0010b2e0)((int)__file);
  return iVar1;
}



/* property_get @ 0010a0c0 */

void property_get(void)

{
  (*(code *)PTR_property_get_0010b2e8)();
  return;
}



/* __system_property_get @ 0010a0d0 */

void __system_property_get(void)

{
  (*(code *)PTR___system_property_get_0010b2f0)();
  return;
}



/* strnlen @ 0010a0e0 */

/* WARNING: Unknown calling convention -- yet parameter storage is locked */

size_t strnlen(char *__string,size_t __maxlen)

{
  size_t sVar1;
  
  sVar1 = (*(code *)PTR_strnlen_0010b2f8)();
  return sVar1;
}



/* __memcpy_chk @ 0010a0f0 */

void __memcpy_chk(void)

{
  (*(code *)PTR___memcpy_chk_0010b300)();
  return;
}



/* abort @ 0010a100 */

/* WARNING: Unknown calling convention -- yet parameter storage is locked */

void abort(void)

{
  (*(code *)PTR_abort_0010b308)();
  return;
}



/* memcpy @ 0010a110 */

/* WARNING: Unknown calling convention -- yet parameter storage is locked */

void * memcpy(void *__dest,void *__src,size_t __n)

{
  void *pvVar1;
  
  pvVar1 = (void *)(*(code *)PTR_memcpy_0010b310)();
  return pvVar1;
}



/* strtoimax @ 0010a120 */

/* WARNING: Unknown calling convention -- yet parameter storage is locked */

intmax_t strtoimax(char *__nptr,char **__endptr,int __base)

{
  intmax_t iVar1;
  
  iVar1 = (*(code *)PTR_strtoimax_0010b318)(__nptr,__endptr,__base);
  return iVar1;
}



/* __system_property_set @ 0010a130 */

void __system_property_set(void)

{
  (*(code *)PTR___system_property_set_0010b320)();
  return;
}



/* __system_property_foreach @ 0010a140 */

void __system_property_foreach(void)

{
  (*(code *)PTR___system_property_foreach_0010b328)();
  return;
}



/* __system_property_read_callback @ 0010a150 */

void __system_property_read_callback(void)

{
  (*(code *)PTR___system_property_read_callback_0010b330)();
  return;
}



/* __cxa_finalize @ 0010d000 */

/* WARNING: Control flow encountered bad instruction data */

void __cxa_finalize(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* __android_log_print @ 0010d008 */

/* WARNING: Control flow encountered bad instruction data */

void __android_log_print(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* __errno @ 0010d010 */

/* WARNING: Control flow encountered bad instruction data */

void __errno(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* __open_2 @ 0010d018 */

/* WARNING: Control flow encountered bad instruction data */

void __open_2(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* __read_chk @ 0010d020 */

/* WARNING: Control flow encountered bad instruction data */

void __read_chk(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* __stack_chk_fail @ 0010d028 */

/* WARNING: Control flow encountered bad instruction data */

void __stack_chk_fail(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* __vsnprintf_chk @ 0010d030 */

/* WARNING: Control flow encountered bad instruction data */

void __vsnprintf_chk(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* __write_chk @ 0010d038 */

/* WARNING: Control flow encountered bad instruction data */

void __write_chk(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* close @ 0010d040 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Unknown calling convention -- yet parameter storage is locked */

int close(int __fd)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* creat @ 0010d048 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Unknown calling convention -- yet parameter storage is locked */

int creat(char *__file,__mode_t __mode)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* free @ 0010d050 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Unknown calling convention -- yet parameter storage is locked */

void free(void *__ptr)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* ioctl @ 0010d058 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Unknown calling convention -- yet parameter storage is locked */

int ioctl(int __fd,ulong __request,...)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* lseek @ 0010d060 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Unknown calling convention -- yet parameter storage is locked */

__off_t lseek(int __fd,__off_t __offset,int __whence)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* malloc @ 0010d068 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Unknown calling convention -- yet parameter storage is locked */

void * malloc(size_t __size)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* memset @ 0010d070 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Unknown calling convention -- yet parameter storage is locked */

void * memset(void *__s,int __c,size_t __n)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* mmap @ 0010d078 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Unknown calling convention -- yet parameter storage is locked */

void * mmap(void *__addr,size_t __len,int __prot,int __flags,int __fd,__off_t __offset)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* munmap @ 0010d080 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Unknown calling convention -- yet parameter storage is locked */

int munmap(void *__addr,size_t __len)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* read @ 0010d088 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Unknown calling convention -- yet parameter storage is locked */

ssize_t read(int __fd,void *__buf,size_t __nbytes)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* stat @ 0010d090 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Unknown calling convention -- yet parameter storage is locked */

int stat(char *__file,stat *__buf)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* strcmp @ 0010d098 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Unknown calling convention -- yet parameter storage is locked */

int strcmp(char *__s1,char *__s2)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* __memcpy_chk @ 0010d0a0 */

/* WARNING: Control flow encountered bad instruction data */

void __memcpy_chk(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* __system_property_foreach @ 0010d0a8 */

/* WARNING: Control flow encountered bad instruction data */

void __system_property_foreach(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* __system_property_get @ 0010d0b0 */

/* WARNING: Control flow encountered bad instruction data */

void __system_property_get(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* __system_property_read_callback @ 0010d0b8 */

/* WARNING: Control flow encountered bad instruction data */

void __system_property_read_callback(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* __system_property_set @ 0010d0c0 */

/* WARNING: Control flow encountered bad instruction data */

void __system_property_set(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* abort @ 0010d0c8 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Unknown calling convention -- yet parameter storage is locked */

void abort(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* memcpy @ 0010d0d0 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Unknown calling convention -- yet parameter storage is locked */

void * memcpy(void *__dest,void *__src,size_t __n)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* strnlen @ 0010d0d8 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Unknown calling convention -- yet parameter storage is locked */

size_t strnlen(char *__string,size_t __maxlen)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* strtoimax @ 0010d0e0 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Unknown calling convention -- yet parameter storage is locked */

intmax_t strtoimax(char *__nptr,char **__endptr,int __base)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}


