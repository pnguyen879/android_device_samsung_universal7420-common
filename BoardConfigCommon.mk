#
# Copyright (C) 2020 The LineageOS Project
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

COMMON_PATH := device/samsung/universal7420-common

BUILD_BROKEN_DUP_RULES := true
BUILD_TOP := $(shell pwd)

# Include path
TARGET_SPECIFIC_HEADER_PATH := $(COMMON_PATH)/include

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a57

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53
TARGET_NR_CPUS := 8

# Audio
TARGET_AUDIOHAL_VARIANT := samsung
AUDIOSERVER_MULTILIB := 32

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_CUSTOM_BT_CONFIG := $(COMMON_PATH)/bluetooth/libbt_vndcfg.txt

# Bootloader
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Display
TARGET_SCREEN_DENSITY := 560

# Dexpreopt
ifeq ($(HOST_OS),linux)
  ifneq ($(TARGET_BUILD_VARIANT),eng)
    WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY ?= false
    WITH_DEXPREOPT := true
  endif
endif

# Filesystem
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4

# Fingerprint
TARGET_SEC_FP_CALL_NOTIFY_ON_CANCEL := true
TARGET_SEC_FP_CALL_CANCEL_ON_ENROLL_COMPLETION := true
TARGET_SEC_FP_USES_PERCENTAGE_SAMPLES := true

# HIDL
PRODUCT_ENFORCE_VINTF_MANIFEST_OVERRIDE := true

# Kernel
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
KERNEL_TOOLCHAIN := $(BUILD_TOP)/prebuilts/gcc/$(HOST_OS)-x86/aarch64/aarch64-linux-android-4.9/bin
TARGET_KERNEL_ADDITIONAL_FLAGS := \
    HOSTCFLAGS="-fuse-ld=lld -Wno-unused-command-line-argument"
BOARD_KERNEL_BASE := 0x10000000
# BOARD_KERNEL_CMDLINE := commandline from boot.img by bootloader
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x01000000 --tags_offset 0x00000100
TARGET_KERNEL_SOURCE := kernel/samsung/universal7420
TARGET_LINUX_KERNEL_VERSION := 3.10
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_CUSTOM_BOOTIMG := true
BOARD_CUSTOM_BOOTIMG_MK := hardware/samsung/mkbootimg.mk
BOARD_KERNEL_SEPARATED_DT := true
BOARD_RAMDISK_USE_XZ := true
TARGET_CUSTOM_DTBTOOL := dtbhtoolExynos
BOARD_RAMDISK_USE_XZ := true    

# MEMFD
TARGET_HAS_MEMFD_BACKPORT := true

# Manifest
DEVICE_MANIFEST_FILE += $(COMMON_PATH)/manifest.xml

# Compatibility Matrix
DEVICE_MATRIX_FILE += $(COMMON_PATH)/compatibility_matrix.xml

# LED
RED_LED_PATH := "/sys/class/leds/led_r/brightness"
GREEN_LED_PATH := "/sys/class/leds/led_g/brightness"
BLUE_LED_PATH := "/sys/class/leds/led_b/brightness"
BACKLIGHT_PATH := "/sys/class/backlight/panel/brightness"

# LMKD stats logging
TARGET_LMKD_STATS_LOG := true

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 29360128
BOARD_CACHEIMAGE_PARTITION_SIZE := 209715200
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 35651584
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3124019200
BOARD_ROOT_EXTRA_FOLDERS += efs cpefs
TARGET_FS_CONFIG_GEN := $(COMMON_PATH)/config.fs

# Platform
BOARD_VENDOR := samsung
TARGET_BOARD_PLATFORM := exynos5
TARGET_SOC := exynos7420
TARGET_BOOTLOADER_BOARD_NAME := universal7420
include hardware/samsung_slsi-linaro/config/BoardConfig7420.mk

# Radio
BOARD_MODEM_TYPE := ss333
ENABLE_VENDOR_RIL_SERVICE := true
TARGET_USES_VND_SECRIL := true

# Recovery
ifneq ($(filter noblelte nobleltecan nobleltedd nobleltedv nobleltejv nobleltektt nobleltelgt noblelteskt nobleltespr nobleltetmo nobleltextc nobleltezt zenlte zenltecan zenltedd zenltedv zenltejv zenltektt zenltelgt zenlteskt zenltetmo zenltexx zenltezt,$(TARGET_DEVICE)),)
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/ramdisk/etc/fstab.samsungexynos7420.noble
else
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/ramdisk/etc/fstab.samsungexynos7420.zero
endif

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := $(COMMON_PATH)/releasetools

# SECComp filters
BOARD_SECCOMP_POLICY += $(COMMON_PATH)/seccomp

# SEPolicy
include device/lineage/sepolicy/exynos/sepolicy.mk
BOARD_SEPOLICY_TEE_FLAVOR := mobicore
include device/samsung_slsi/sepolicy/sepolicy.mk
BOARD_VENDOR_SEPOLICY_DIRS += $(COMMON_PATH)/sepolicy/vendor
SELINUX_IGNORE_NEVERALLOWS := true

# Shims
TARGET_LD_SHIM_LIBS += \
    /vendor/lib64/libexynoscamera.so|/vendor/lib64/libexynoscamera_shim.so \
    /vendor/lib/libexynoscamera.so|/vendor/lib/libexynoscamera_shim.so

# System prop
TARGET_SYSTEM_PROP += $(COMMON_PATH)/system.prop

# Vendor separation
TARGET_COPY_OUT_VENDOR := system/vendor

# Vendor security patch level
VENDOR_SECURITY_PATCH := 2018-06-01

# WFD
BOARD_USES_WFD := true

# Wifi
TARGET_USES_64_BIT_BCMDHD        := true
BOARD_HAVE_SAMSUNG_WIFI          := true
BOARD_WLAN_DEVICE                := bcmdhd
WPA_SUPPLICANT_USE_HIDL          := true
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_bcmdhd
WIFI_DRIVER_FW_PATH_PARAM        := "/sys/module/dhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA          := "/system/vendor/etc/wifi/bcmdhd_sta.bin"
WIFI_DRIVER_FW_PATH_AP           := "/system/vendor/etc/wifi/bcmdhd_apsta.bin"
WIFI_BAND                        := 802_11_ABG
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true

# Inherit from the proprietary version
include vendor/samsung/universal7420-common/BoardConfigVendor.mk
