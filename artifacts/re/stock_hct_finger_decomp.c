INFO  Decomp.java> === ffffff8008d1990c=hct_finger_get_gpio_info

ulong hct_finger_get_gpio_info(undefined8 *param_1)

{
  undefined8 *puVar1;
  ulong *puVar2;
  undefined8 *puVar3;
  int iVar4;
  undefined8 uVar5;
  undefined8 *puVar6;
  ulong uVar7;
  undefined8 *puVar8;
  
  uVar5 = _raw_spin_lock_irqsave(0xffffff800abc6290);
  puVar8 = puRamffffff800abc6288;
  do {
    if ((puVar8 == (undefined8 *)0x0) ||
       (iVar4 = __of_device_is_compatible_llvm_1454772459992888323(puVar8,0xffffff8009677fd2,0,0),
       iVar4 != 0)) break;
    puVar3 = (undefined8 *)puVar8[9];
    puVar6 = puVar8;
    do {
      puVar8 = puVar3;
      if (puVar8 != (undefined8 *)0x0) break;
      puVar1 = puVar6 + 8;
      puVar8 = (undefined8 *)puVar6[10];
      puVar3 = puVar8;
      puVar6 = (undefined8 *)*puVar1;
    } while ((undefined8 *)*puVar1 != (undefined8 *)0x0);
  } while( true );
  _raw_spin_unlock_irqrestore(0xffffff800abc6290,uVar5);
  printk(0xffffff80097ff28b,*puVar8,puVar8[3]);
  __wake_up_common_lock_llvm_3673140581042821765(0xffffff800a1cb800,1,1,0,0);
  puVar8 = param_1 + 2;
  puVar6 = (undefined8 *)__kmalloc_track_caller(0x48,0x14080c0);
  if (puVar6 == (undefined8 *)0x0) {
    uVar7 = 0xfffffffffffffff4;
  }
  else {
    *puVar6 = 0;
    puVar6[1] = puVar6;
    puVar6[6] = 0;
    puVar6[7] = 0;
    puVar6[4] = 0;
    puVar6[5] = 0;
    puVar6[3] = 0;
    *puVar6 = puVar6;
    puVar6[2] = devm_pinctrl_release_1e36fd038416ff3462fb760fde14b8a3_cfi_jt;
    puVar2 = puVar6 + 8;
    uVar7 = pinctrl_get(puVar8);
    if (uVar7 < 0xfffffffffffff001) {
      *puVar2 = uVar7;
      devres_add(puVar8,puVar2);
      uRamffffff800aad0bf8 = uVar7;
      printk(0xffffff800981a136,*param_1);
      uVar7 = pinctrl_lookup_state(uRamffffff800aad0bf8,0xffffff80096ea7f4);
      uRamffffff800aad0c00 = uVar7;
      if (uVar7 < 0xfffffffffffff001) {
        uVar7 = pinctrl_lookup_state(uRamffffff800aad0bf8,0xffffff80096ed9ae);
        uRamffffff800aad0c08 = uVar7;
        if (uVar7 < 0xfffffffffffff001) {
          uVar7 = pinctrl_lookup_state(uRamffffff800aad0bf8,0xffffff8009690d9d);
          uRamffffff800aad0c10 = uVar7;
          if (uVar7 < 0xfffffffffffff001) {
            uVar7 = pinctrl_lookup_state(uRamffffff800aad0bf8,0xffffff800967eb9c);
            uRamffffff800aad0c18 = uVar7;
            if (uVar7 < 0xfffffffffffff001) {
              uVar7 = pinctrl_lookup_state(uRamffffff800aad0bf8,0xffffff800967e727);
              uRamffffff800aad0c20 = uVar7;
              if (uVar7 < 0xfffffffffffff001) {
                uVar7 = pinctrl_lookup_state(uRamffffff800aad0bf8,0xffffff800967eb5b);
                uRamffffff800aad0c28 = uVar7;
                if (uVar7 < 0xfffffffffffff001) {
                  uVar7 = pinctrl_lookup_state(uRamffffff800aad0bf8,0xffffff800968db8a);
                  uRamffffff800aad0c30 = uVar7;
                  if (uVar7 < 0xfffffffffffff001) {
                    uVar7 = pinctrl_lookup_state(uRamffffff800aad0bf8,0xffffff800967eb84);
                    uRamffffff800aad0c38 = uVar7;
                    if (uVar7 < 0xfffffffffffff001) {
                      uVar7 = pinctrl_lookup_state(uRamffffff800aad0bf8,0xffffff800966f5d4);
                      uRamffffff800aad0c40 = uVar7;
                      if (uVar7 < 0xfffffffffffff001) {
                        uVar7 = pinctrl_lookup_state(uRamffffff800aad0bf8,0xffffff800967eb44);
                        uRamffffff800aad0c48 = uVar7;
                        if (uVar7 < 0xfffffffffffff001) {
                          uVar7 = pinctrl_lookup_state(uRamffffff800aad0bf8,0xffffff8009680389);
                          uRamffffff800aad0c50 = uVar7;
                          if (uVar7 < 0xfffffffffffff001) {
                            uVar7 = pinctrl_lookup_state(uRamffffff800aad0bf8,0xffffff800967b1bf);
                            uRamffffff800aad0c58 = uVar7;
                            if (uVar7 < 0xfffffffffffff001) {
                              uVar7 = pinctrl_lookup_state(uRamffffff800aad0bf8,0xffffff800966c9fa);
                              uRamffffff800aad0c60 = uVar7;
                              if (uVar7 < 0xfffffffffffff001) {
                                printk(0xffffff8009818768);
                                uVar7 = 0;
                                goto LAB_ffffff8008d19cf0;
                              }
                              uVar5 = 0xffffff800983f974;
                            }
                            else {
                              uVar5 = 0xffffff8009840469;
                            }
                          }
                          else {
                            uVar5 = 0xffffff8009840a8b;
                          }
                        }
                        else {
                          uVar5 = 0xffffff80098408d2;
                        }
                      }
                      else {
                        uVar5 = 0xffffff800983facc;
                      }
                    }
                    else {
                      uVar5 = 0xffffff800984094c;
                    }
                  }
                  else {
                    uVar5 = 0xffffff8009841bcc;
                  }
                }
                else {
                  uVar5 = 0xffffff800984090f;
                }
              }
              else {
                uVar5 = 0xffffff8009840892;
              }
            }
            else {
              uVar5 = 0xffffff800984098a;
            }
          }
          else {
            uVar5 = 0xffffff8009841cd7;
          }
        }
        else {
          uVar5 = 0xffffff800983e89a;
        }
      }
      else {
        uVar5 = 0xffffff8009841d8f;
      }
      dev_err(puVar8,uVar5);
      goto LAB_ffffff8008d19cf0;
    }
    devres_free(puVar2);
  }
  uRamffffff800aad0bf8 = uVar7;
  dev_err(puVar8,0xffffff80098364a7,uVar7 & 0xffffffff);
LAB_ffffff8008d19cf0:
  return uVar7 & 0xffffffff;
}

 (GhidraScript)  
INFO  Decomp.java> === ffffff8008d19d1c=hct_finger_set_reset

undefined8 hct_finger_set_reset(int param_1)

{
  ulong uVar1;
  
  if ((0xfffffffffffff000 < uRamffffff800aad0c08) || (0xfffffffffffff000 < uRamffffff800aad0c00)) {
    printk(0xffffff80096fc5da);
    return 0xffffffff;
  }
  if (param_1 == 1) {
    uVar1 = uRamffffff800aad0c00;
    if (*(ulong *)(lRamffffff800aad0bf8 + 0x28) == uRamffffff800aad0c00) {
      return 0;
    }
  }
  else {
    if (param_1 != 0) {
      return 0;
    }
    uVar1 = uRamffffff800aad0c08;
    if (*(ulong *)(lRamffffff800aad0bf8 + 0x28) == uRamffffff800aad0c08) {
      return 0;
    }
  }
  pinctrl_commit_state_llvm_7460170729718701675(lRamffffff800aad0bf8,uVar1);
  return 0;
}

 (GhidraScript)  
INFO  Decomp.java> === ffffff8008d19da8=hct_finger_set_irq

undefined8 hct_finger_set_irq(int param_1)

{
  ulong uVar1;
  
  if (((0xfffffffffffff000 < uRamffffff800aad0c50) || (0xfffffffffffff000 < uRamffffff800aad0c58))
     || (0xfffffffffffff000 < uRamffffff800aad0c60)) {
    printk(0xffffff80096fc76e);
    return 0xffffffff;
  }
  if (param_1 == 2) {
    uVar1 = uRamffffff800aad0c60;
    if (*(ulong *)(lRamffffff800aad0bf8 + 0x28) == uRamffffff800aad0c60) {
      return 0;
    }
  }
  else if (param_1 == 1) {
    uVar1 = uRamffffff800aad0c58;
    if (*(ulong *)(lRamffffff800aad0bf8 + 0x28) == uRamffffff800aad0c58) {
      return 0;
    }
  }
  else {
    if (param_1 != 0) {
      return 0;
    }
    uVar1 = uRamffffff800aad0c50;
    if (*(ulong *)(lRamffffff800aad0bf8 + 0x28) == uRamffffff800aad0c50) {
      return 0;
    }
  }
  pinctrl_commit_state_llvm_7460170729718701675(lRamffffff800aad0bf8,uVar1);
  return 0;
}

 (GhidraScript)  
INFO  Decomp.java> === ffffff8008d19e68=hct_finger_get_irqnum

long * hct_finger_get_irqnum(void)

{
  long lVar1;
  long lVar2;
  int iVar3;
  undefined8 uVar4;
  long *plVar5;
  long lVar6;
  long lStack_d8;
  uint uStack_d0;
  undefined1 auStack_cc [68];
  long lStack_88;
  uint uStack_80;
  undefined1 auStack_7c [68];
  long lStack_38;
  
  lStack_38 = lRamffffff800a0b1ff8;
  uVar4 = _raw_spin_lock_irqsave(0xffffff800abc6290);
  lVar6 = lRamffffff800abc6288;
  do {
    if ((lVar6 == 0) ||
       (iVar3 = __of_device_is_compatible_llvm_1454772459992888323(lVar6,0xffffff8009677fd2,0,0),
       iVar3 != 0)) {
      _raw_spin_unlock_irqrestore(0xffffff800abc6290,uVar4);
      iVar3 = of_irq_parse_one(lVar6,0,&lStack_d8);
      plVar5 = (long *)0x0;
      if (iVar3 == 0) {
        lStack_88 = 0;
        if (lStack_d8 != 0) {
          lStack_88 = lStack_d8 + 0x20;
        }
        uStack_80 = uStack_d0;
        if (0 < (int)uStack_d0) {
          memcpy(auStack_7c,auStack_cc,(ulong)uStack_d0 << 2);
        }
        plVar5 = (long *)irq_create_fwspec_mapping(&lStack_88);
      }
      if (lRamffffff800a0b1ff8 == lStack_38) {
        return plVar5;
      }
      __stack_chk_fail(plVar5);
      uVar4 = _raw_spin_lock_irqsave(0xffffff800abc6290);
      lVar6 = lRamffffff800abc6288;
      do {
        if ((lVar6 == 0) ||
           (iVar3 = __of_device_is_compatible_llvm_1454772459992888323(lVar6,0xffffff8009677fd2,0,0)
           , iVar3 != 0)) {
          _raw_spin_unlock_irqrestore(0xffffff800abc6290,uVar4);
          plVar5 = (long *)of_get_named_gpiod_flags(lVar6,0xffffff800967ec80,0,0);
          if (plVar5 < (long *)0xfffffffffffff001) {
            plVar5 = (long *)(ulong)(uint)(*(int *)(*plVar5 + 0x360) +
                                          (int)((ulong)((long)plVar5 - *(long *)(*plVar5 + 0x358))
                                               >> 5));
          }
          return plVar5;
        }
        lVar2 = *(long *)(lVar6 + 0x48);
        lVar1 = lVar6;
        do {
          lVar6 = lVar2;
          if (lVar6 != 0) break;
          plVar5 = (long *)(lVar1 + 0x40);
          lVar6 = *(long *)(lVar1 + 0x50);
          lVar2 = lVar6;
          lVar1 = *plVar5;
        } while (*plVar5 != 0);
      } while( true );
    }
    lVar2 = *(long *)(lVar6 + 0x48);
    lVar1 = lVar6;
    do {
      lVar6 = lVar2;
      if (lVar6 != 0) break;
      plVar5 = (long *)(lVar1 + 0x40);
      lVar6 = *(long *)(lVar1 + 0x50);
      lVar2 = lVar6;
      lVar1 = *plVar5;
    } while (*plVar5 != 0);
  } while( true );
}

 (GhidraScript)  
INFO  Decomp.java> === ffffff8008d19f8c=hct_finger_get_irq_gpio

long * hct_finger_get_irq_gpio(void)

{
  long lVar1;
  long lVar2;
  int iVar3;
  undefined8 uVar4;
  long *plVar5;
  long lVar6;
  
  uVar4 = _raw_spin_lock_irqsave(0xffffff800abc6290);
  lVar6 = lRamffffff800abc6288;
  do {
    if ((lVar6 == 0) ||
       (iVar3 = __of_device_is_compatible_llvm_1454772459992888323(lVar6,0xffffff8009677fd2,0,0),
       iVar3 != 0)) {
      _raw_spin_unlock_irqrestore(0xffffff800abc6290,uVar4);
      plVar5 = (long *)of_get_named_gpiod_flags(lVar6,0xffffff800967ec80,0,0);
      if (plVar5 < (long *)0xfffffffffffff001) {
        plVar5 = (long *)(ulong)(uint)(*(int *)(*plVar5 + 0x360) +
                                      (int)((ulong)((long)plVar5 - *(long *)(*plVar5 + 0x358)) >> 5)
                                      );
      }
      return plVar5;
    }
    lVar2 = *(long *)(lVar6 + 0x48);
    lVar1 = lVar6;
    do {
      lVar6 = lVar2;
      if (lVar6 != 0) break;
      plVar5 = (long *)(lVar1 + 0x40);
      lVar6 = *(long *)(lVar1 + 0x50);
      lVar2 = lVar6;
      lVar1 = *plVar5;
    } while (*plVar5 != 0);
  } while( true );
}

 (GhidraScript)  
INFO  Decomp.java> === ffffff8008d1a05c=hct_finger_get_reset_gpio

long * hct_finger_get_reset_gpio(void)

{
  long lVar1;
  long lVar2;
  int iVar3;
  undefined8 uVar4;
  long *plVar5;
  long lVar6;
  
  uVar4 = _raw_spin_lock_irqsave(0xffffff800abc6290);
  lVar6 = lRamffffff800abc6288;
  do {
    if ((lVar6 == 0) ||
       (iVar3 = __of_device_is_compatible_llvm_1454772459992888323(lVar6,0xffffff8009677fd2,0,0),
       iVar3 != 0)) {
      _raw_spin_unlock_irqrestore(0xffffff800abc6290,uVar4);
      plVar5 = (long *)of_get_named_gpiod_flags(lVar6,0xffffff800967ec89,0,0);
      if (plVar5 < (long *)0xfffffffffffff001) {
        plVar5 = (long *)(ulong)(uint)(*(int *)(*plVar5 + 0x360) +
                                      (int)((ulong)((long)plVar5 - *(long *)(*plVar5 + 0x358)) >> 5)
                                      );
      }
      return plVar5;
    }
    lVar2 = *(long *)(lVar6 + 0x48);
    lVar1 = lVar6;
    do {
      lVar6 = lVar2;
      if (lVar6 != 0) break;
      plVar5 = (long *)(lVar1 + 0x40);
      lVar6 = *(long *)(lVar1 + 0x50);
      lVar2 = lVar6;
      lVar1 = *plVar5;
    } while (*plVar5 != 0);
  } while( true );
}

 (GhidraScript)  
INFO  Decomp.java> === ffffff8008d1a12c=hct_finger_set_spi_mode

undefined8 hct_finger_set_spi_mode(int param_1)

{
  ulong uVar1;
  ulong uVar2;
  
  if (((((0xfffffffffffff000 < uRamffffff800aad0c38) || (0xfffffffffffff000 < uRamffffff800aad0c48))
       || (0xfffffffffffff000 < uRamffffff800aad0c18)) ||
      ((0xfffffffffffff000 < uRamffffff800aad0c28 || (0xfffffffffffff000 < uRamffffff800aad0c30))))
     || ((0xfffffffffffff000 < uRamffffff800aad0c40 ||
         ((0xfffffffffffff000 < uRamffffff800aad0c10 || (0xfffffffffffff000 < uRamffffff800aad0c20))
         )))) {
    printk(0xffffff80096fc5da);
    return 0xffffffff;
  }
  if (param_1 == 1) {
    uVar1 = uRamffffff800aad0c30;
    if (*(ulong *)(lRamffffff800aad0bf8 + 0x28) != uRamffffff800aad0c30) {
      pinctrl_commit_state_llvm_7460170729718701675(lRamffffff800aad0bf8,uRamffffff800aad0c30);
      uVar1 = *(ulong *)(lRamffffff800aad0bf8 + 0x28);
    }
    if (uVar1 != uRamffffff800aad0c40) {
      pinctrl_commit_state_llvm_7460170729718701675(lRamffffff800aad0bf8,uRamffffff800aad0c40);
      uVar1 = *(ulong *)(lRamffffff800aad0bf8 + 0x28);
    }
    if (uVar1 != uRamffffff800aad0c10) {
      pinctrl_commit_state_llvm_7460170729718701675();
      uVar1 = *(ulong *)(lRamffffff800aad0bf8 + 0x28);
    }
    uVar2 = uRamffffff800aad0c20;
    if (uVar1 == uRamffffff800aad0c20) {
      return 0;
    }
  }
  else {
    if (param_1 != 0) {
      return 0;
    }
    uVar1 = uRamffffff800aad0c38;
    if (*(ulong *)(lRamffffff800aad0bf8 + 0x28) != uRamffffff800aad0c38) {
      pinctrl_commit_state_llvm_7460170729718701675();
      uVar1 = *(ulong *)(lRamffffff800aad0bf8 + 0x28);
    }
    if (uVar1 != uRamffffff800aad0c48) {
      pinctrl_commit_state_llvm_7460170729718701675(lRamffffff800aad0bf8,uRamffffff800aad0c48);
      uVar1 = *(ulong *)(lRamffffff800aad0bf8 + 0x28);
    }
    if (uVar1 != uRamffffff800aad0c18) {
      pinctrl_commit_state_llvm_7460170729718701675(lRamffffff800aad0bf8,uRamffffff800aad0c18);
      uVar1 = *(ulong *)(lRamffffff800aad0bf8 + 0x28);
    }
    uVar2 = uRamffffff800aad0c28;
    if (uVar1 == uRamffffff800aad0c28) {
      return 0;
    }
  }
  pinctrl_commit_state_llvm_7460170729718701675(lRamffffff800aad0bf8,uVar2);
  return 0;
}

 (GhidraScript)  
INFO  Decomp.java> === ffffff8008d1a2cc=hct_waite_for_finger_dts_paser

long hct_waite_for_finger_dts_paser(long param_1)

{
  long lVar1;
  undefined1 auStack_60 [40];
  long lStack_38;
  
  lStack_38 = lRamffffff800a0b1ff8;
  if (lRamffffff800aad0c68 == 0) {
    init_wait_entry(auStack_60,0);
    param_1 = prepare_to_wait_event(0xffffff800a1cb800,auStack_60,1);
    if (lRamffffff800aad0c68 == 0) {
      lVar1 = 0x2ee;
      do {
        if (param_1 != 0) goto LAB_ffffff8008d1a330;
        lVar1 = schedule_timeout(lVar1);
        param_1 = prepare_to_wait_event(0xffffff800a1cb800,auStack_60,1);
        if (lRamffffff800aad0c68 != 0 && lVar1 == 0) {
          lVar1 = 1;
        }
      } while ((lRamffffff800aad0c68 == 0) && (lVar1 != 0));
    }
    param_1 = finish_wait(0xffffff800a1cb800,auStack_60);
  }
LAB_ffffff8008d1a330:
  if (lRamffffff800a0b1ff8 == lStack_38) {
    return param_1;
  }
  __stack_chk_fail();
  return 3;
}

 (GhidraScript)  
INFO  Decomp.java> === ffffff8008d1a3a4=hct_get_max_finger_spi_cs_number

undefined8 hct_get_max_finger_spi_cs_number(void)

{
  return 3;
}

 (GhidraScript)  
INFO  Decomp.java> === ffffff8008d1a3ac=hct_finger_plat_probe

undefined8 hct_finger_plat_probe(undefined8 param_1)

{
  uRamffffff800aad0c68 = param_1;
  printk(0xffffff800970289c);
  hct_finger_get_gpio_info(param_1);
  return 0;
}

 (GhidraScript)  
INFO  Decomp.java> === ffffff8009ae09d0=hct_finger_init

undefined8 hct_finger_init(void)

{
  undefined8 uVar1;
  
  uRamffffff800a1cb848 = 0xffffff800a15eb70;
  uRamffffff800a1cb850 = 0;
  pcRamffffff800a1cb878 = platform_drv_probe_077277a5b42a13e56f4ba583b22845f5_cfi_jt;
  pcRamffffff800a1cb880 = platform_drv_remove_077277a5b42a13e56f4ba583b22845f5_cfi_jt;
  pcRamffffff800a1cb888 = platform_drv_shutdown_077277a5b42a13e56f4ba583b22845f5_cfi_jt;
  uVar1 = driver_register();
  if ((int)uVar1 != 0) {
    printk(0xffffff8009673ac4);
    uVar1 = 0xffffffed;
  }
  return uVar1;
}

 (GhidraScript)  
