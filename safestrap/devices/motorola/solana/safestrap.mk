#include $(commands_TWRP_local_path)/safestrap/devices/common/safestrap-common.mk
SS_INCLUDE_2NDINIT := true
SS_INCLUDE_SPLASHMENU := true
#BOARD_USE_NO_DEVFS_SETUP := true
BOARD_SUPPRESS_EMMC_WIPE := true

# Logging
#TWRP_EVENT_LOGGING := true

# Use prebuilt kernel for kexec
TARGET_KERNEL_SOURCE := 
TARGET_KERNEL_CONFIG := 
TARGET_PREBUILT_KERNEL := $(commands_TWRP_local_path)/safestrap/devices/motorola/solana/recovery-kernel

include $(commands_TWRP_local_path)/safestrap/devices/motorola/common-omap4/safestrap-common-omap4.mk

DEVICE_RESOLUTION := 540x960
TW_MAX_BRIGHTNESS := 254
TW_BRIGHTNESS_PATH := /sys/class/backlight/lm3532_bl/brightness
