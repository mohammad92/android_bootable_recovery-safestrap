include $(ANDROID_BUILD_TOP)/bootable/recovery/safestrap/devices/common/safestrap-common.mk
include $(ANDROID_BUILD_TOP)/bootable/recovery/safestrap/devices/samsung/msm8998-common/safestrap-msm8998-common.mk

SS_TWRP_PRINT_SCREENINFO := true

TW_CRYPTO_REAL_BLKDEV := "/dev/block/sda24"

# Virtual partition size default (in mb)
BOARD_DEFAULT_VIRT_SYSTEM_SIZE := 4600
BOARD_DEFAULT_VIRT_SYSTEM_MIN_SIZE := 4600
BOARD_DEFAULT_VIRT_SYSTEM_MAX_SIZE := 4600
