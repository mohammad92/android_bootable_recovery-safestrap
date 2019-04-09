include $(ANDROID_BUILD_TOP)/bootable/recovery/safestrap/devices/common/safestrap-common.mk
include $(ANDROID_BUILD_TOP)/bootable/recovery/safestrap/devices/samsung/k-common/safestrap-k-common.mk

SS_TWRP_PRINT_SCREENINFO := true
TW_CRYPTO_REAL_BLKDEV := "/dev/block/mmcblk0p25"

# Virtual partition size default (in mb)
BOARD_DEFAULT_VIRT_SYSTEM_SIZE := 2564
BOARD_DEFAULT_VIRT_SYSTEM_MIN_SIZE := 2564
BOARD_DEFAULT_VIRT_SYSTEM_MAX_SIZE := 2564