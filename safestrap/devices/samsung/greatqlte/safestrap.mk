include $(ANDROID_BUILD_TOP)/bootable/recovery/safestrap/devices/common/safestrap-common.mk
include $(ANDROID_BUILD_TOP)/bootable/recovery/safestrap/devices/samsung/msm8998-common/safestrap-msm8998-common.mk

SS_TWRP_PRINT_SCREENINFO := true

# Virtual partition size default (in mb)
BOARD_DEFAULT_VIRT_SYSTEM_SIZE := 5120
BOARD_DEFAULT_VIRT_SYSTEM_MIN_SIZE := 5120
BOARD_DEFAULT_VIRT_SYSTEM_MAX_SIZE := 5120
