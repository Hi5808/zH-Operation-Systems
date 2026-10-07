#
# Copyright (C) 2026 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Halium-11.0 (Android 11) hardware adaptation for the Blackview BL6000 Pro.
#
# This file pulls in the Halium boot / GSI machinery. With Halium 11 we build
# only halium-boot.img and pair it with the prebuilt Halium-11 arm64 GSI
# (system image) and the Ubuntu Touch rootfs.

# Pull in the standard Halium device makefile
$(call inherit-product, $(SRC_TARGET_DIR)/product/halium.mk)

# --- Halium boot image layout -------------------------------------------------
# A-only device (no A/B slots), 64-bit only userspace, system-as-root.
HALIUM_BOOT_PART := boot
HALIUM_DATA_PART := userdata

# --- Required kernel pieces ---------------------------------------------------
# We build against the STOCK PREBUILT kernel (no public source for mt6873).
# BoardConfig.mk points TARGET_PREBUILT_KERNEL at Image.gz-dtb extracted from
# the dumped boot.img. Halium only needs the kernel + its modules to build
# halium-boot.img.

# --- Initramfs extras ---------------------------------------------------------
# MediaTek devices need the connectivity / charger firmware present early.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.mt6873:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6873
