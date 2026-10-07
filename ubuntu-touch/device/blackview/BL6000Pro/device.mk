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

# SoC: MediaTek Dimensity 800 (mt6873), board k6873v1_64
# Android base: 11 (RP1A.200720.011), shipping API 30, dynamic partitions

# Dynamic partitions / super partition (verified from the stock GPT)
PRODUCT_BUILD_SUPER_PARTITION := true
PRODUCT_USE_DYNAMIC_PARTITIONS := true
BOARD_BUILD_SUPER_IMAGE_BY_DEFAULT := true

# Virtual A/B is NOT used on this device (single `boot`, no slot suffixes)
AB_OTA_UPDATER := false

# Shipping API level (Android 11)
PRODUCT_SHIPPING_API_LEVEL := 30
PRODUCT_TARGET_VNDK_VERSION := 30

# Screen
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# MediaTek init scripts (names taken from the stock vendor ramdisk)
PRODUCT_PACKAGES += \
    init.mt6873.rc \
    init.mt6873.power.rc \
    init.mt6873.usb.rc \
    ueventd.mt6873.rc

# Flashing helpers
PRODUCT_PACKAGES += \
    fastbootd

# Health / charger (shared MediaTek HAL)
PRODUCT_PACKAGES += \
    android.hardware.health@2.0 \
    libsuspend

# Permissions
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-mediatek.xml

# Inherit the vendor blob definitions extracted from the stock firmware
$(call inherit-product, vendor/blackview/BL6000Pro/BL6000Pro-vendor.mk)
