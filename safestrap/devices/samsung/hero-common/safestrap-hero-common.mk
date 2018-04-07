#TWRP
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
DEVICE_RESOLUTION := 1440x2960
RECOVERY_GRAPHICS_FORCE_USE_LINELENGTH := true

RECOVERY_SDCARD_ON_DATA := true
TW_INTERNAL_STORAGE_PATH := "/datamedia/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "datamedia"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
TW_NO_REBOOT_BOOTLOADER := true
TW_HAS_DOWNLOAD_MODE := true

TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_SAMSUNG := true
TW_CRYPTO_FS_TYPE := "ext4"
TW_CRYPTO_MNT_POINT := "/data"
TW_CRYPTO_FS_OPTIONS := "nosuid,nodev,noatime,noauto_da_alloc,discard,journal_async_commit,errors=panic wait,check,encryptable=footer"
TW_CRYPTO_FS_FLAGS := "0x00000406"
TW_CRYPTO_KEY_LOC := "footer"
TW_CRYPTO_REAL_BLKDEV := "/dev/block/sda23"

SPLASH_RECOVERY_KEY := KEY_MENU
SPLASH_CONTINUE_KEY := KEY_BACK
SPLASH_DISABLE_KEY := KEY_HOMEPAGE
SPLASH_DELAY := 6

TARGET_USERIMAGES_USE_EXT4 := true
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"

TW_INPUT_BLACKLIST := "hbtp_vm\x0asec_e-pen-pad\x0asec_e-pen" 

# Virtual partition size default (in mb)
BOARD_DEFAULT_VIRT_SYSTEM_SIZE := 4700
BOARD_DEFAULT_VIRT_SYSTEM_MIN_SIZE := 4700
BOARD_DEFAULT_VIRT_SYSTEM_MAX_SIZE := 4700
BOARD_DEFAULT_VIRT_DATA_SIZE := 4000
BOARD_DEFAULT_VIRT_DATA_MIN_SIZE := 2000
BOARD_DEFAULT_VIRT_DATA_MAX_SIZE := 64000
BOARD_DEFAULT_VIRT_CACHE_SIZE := 300
BOARD_DEFAULT_VIRT_CACHE_MIN_SIZE := 300
BOARD_DEFAULT_VIRT_CACHE_MAX_SIZE := 1000

HAVE_SELINUX := true
