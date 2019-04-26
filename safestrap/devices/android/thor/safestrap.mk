include $(commands_TWRP_local_path)/safestrap/devices/common/safestrap-common.mk
include $(commands_TWRP_local_path)/safestrap/devices/android/common-hdx/safestrap-hdx-common.mk

DEVICE_RESOLUTION := 1200x1920
SS_DEFAULT_USB_INIT := ../safestrap/devices/android/thor/init.recovery.usb.rc
