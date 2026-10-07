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

DEVICE_PATH := device/blackview/BL6000Pro

# -----------------------------------------------------------------------------
# Platform / SoC
# -----------------------------------------------------------------------------
# MediaTek Dimensity 800 (mt6873), Mali-G57 MC3 ("mali valhall r25p0" in the
# stock kernel config). Board name read from the stock bootloader.
TARGET_BOARD_PLATFORM := mt6873
TARGET_BOARD_PLATFORM_GPU := mali-g57
TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_BOARD_NAME := k6873v1_64

# -----------------------------------------------------------------------------
# Architecture (big.LITTLE: 4x Cortex-A76 + 4x Cortex-A55)
# -----------------------------------------------------------------------------
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# -----------------------------------------------------------------------------
# Kernel
# -----------------------------------------------------------------------------
# No public kernel source exists for the BL6000 Pro (mt6873), so Halium builds
# halium-boot.img against the STOCK PREBUILT kernel. Generate the prebuilt with
#   ./extract-kernel.sh
# which unpacks Image.gz-dtb from the dumped images/partitions/boot.img.
#
# All address/offset values below were read directly from the stock boot image
# header (artifacts/kernel-analysis/bootimg.cfg):
#   kerneladdr=0x40080000  ramdiskaddr=0x47c80000  tagsaddr=0x4bc80000
#   secondaddr=0x0  pagesize=0x800
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel/Image.gz-dtb
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x07c08000
BOARD_TAGS_OFFSET := 0x0bc08000
BOARD_SECOND_OFFSET := 0x00000000
# cmdline taken verbatim from the stock header (bootopt = memory layout hint).
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2
BOARD_MKBOOTIMG_ARGS := \
    --base $(BOARD_KERNEL_BASE) \
    --kernel_offset $(BOARD_KERNEL_OFFSET) \
    --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
    --tags_offset $(BOARD_TAGS_OFFSET) \
    --second_offset $(BOARD_SECOND_OFFSET) \
    --pagesize $(BOARD_KERNEL_PAGESIZE)

# -----------------------------------------------------------------------------
# Fixed partitions (byte sizes taken from the stock GPT / dumped images)
# -----------------------------------------------------------------------------
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432       # 32 MB
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 41943040   # 40 MB
BOARD_DTBOIMG_PARTITION_SIZE := 8388608          # 8 MB
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_FLASH_BLOCK_MIN_SIZE := 131072

# -----------------------------------------------------------------------------
# Dynamic partitions (super, 5120 MB)
# -----------------------------------------------------------------------------
# Verified logical sizes from the stock super image:
#   system  = 2066964480 (~1971 MB)
#   vendor  =  620785664 (~592 MB)
#   product = 1976287232 (~1885 MB)
# The group is sized to (super - 4 MB metadata) to leave room for LP metadata.
BOARD_SUPER_PARTITION_SIZE := 5368709120
BOARD_SUPER_PARTITION_GROUPS := blackview_dynamic_partitions
BOARD_BLACKVIEW_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product
BOARD_BLACKVIEW_DYNAMIC_PARTITIONS_SIZE := 5364514816

# Filesystem types (stock uses ext4 on system/vendor/product)
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product

# -----------------------------------------------------------------------------
# Halium boot / recovery layout
# -----------------------------------------------------------------------------
# A-only device (single `boot`, no slot suffixes), system-as-root.
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false
BOARD_USES_RECOVERY_AS_BOOT := false
TARGET_NO_RECOVERY := false
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

# -----------------------------------------------------------------------------
# Verified boot — disabled for the port (bootloader is already unlocked)
# -----------------------------------------------------------------------------
BOARD_AVB_ENABLE := false
BOARD_BUILD_DISABLED_VBMETA_IMAGE := true

# -----------------------------------------------------------------------------
# SELinux
# -----------------------------------------------------------------------------
BOARD_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# Vendor-specific board config (blob-related knobs)
-include vendor/blackview/BL6000Pro/BoardConfigVendor.mk
