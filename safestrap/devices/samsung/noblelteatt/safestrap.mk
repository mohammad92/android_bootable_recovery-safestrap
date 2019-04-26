include $(commands_TWRP_local_path)/safestrap/devices/common/safestrap-common.mk
include $(commands_TWRP_local_path)/safestrap/devices/samsung/exynos7420-common/safestrap-exynos7420-common.mk

TW_CRYPTO_REAL_BLKDEV := "/dev/block/sda16"

# Virtual partition size default (in mb)
BOARD_DEFAULT_VIRT_SYSTEM_SIZE := 4200
BOARD_DEFAULT_VIRT_SYSTEM_MIN_SIZE := 4200
BOARD_DEFAULT_VIRT_SYSTEM_MAX_SIZE := 4200
