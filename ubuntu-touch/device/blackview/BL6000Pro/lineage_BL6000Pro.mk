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

# Inherit from the 64-bit, telephony base and the Halium config
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, device/blackview/BL6000Pro/device.mk)
$(call inherit-product, device/blackview/BL6000Pro/halium.mk)

# Overlay / configs
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay

# Product identity
PRODUCT_NAME := lineage_BL6000Pro
PRODUCT_DEVICE := BL6000Pro
PRODUCT_BRAND := Blackview
PRODUCT_MODEL := BL6000 Pro
PRODUCT_MANUFACTURER := Blackview

PRODUCT_GMS_CLIENTID_BASE := android-blackview
