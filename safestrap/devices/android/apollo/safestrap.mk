include $(commands_TWRP_local_path)/safestrap/devices/common/safestrap-common.mk
include $(commands_TWRP_local_path)/safestrap/devices/android/common-hdx/safestrap-hdx-common.mk

DEVICE_RESOLUTION := 2560x1600
RECOVERY_TOUCHSCREEN_SWAP_XY := true
RECOVERY_TOUCHSCREEN_FLIP_X := true
SS_DEFAULT_USB_INIT := ../safestrap/devices/android/apollo/init.recovery.usb.rc
