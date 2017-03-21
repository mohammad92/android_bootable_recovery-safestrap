include $(ANDROID_BUILD_TOP)/bootable/recovery/safestrap/devices/common/safestrap-common.mk
include $(ANDROID_BUILD_TOP)/bootable/recovery/safestrap/devices/android/common-hdx/safestrap-hdx-common.mk

DEVICE_RESOLUTION := 2560x1600
RECOVERY_TOUCHSCREEN_SWAP_XY := true
RECOVERY_TOUCHSCREEN_FLIP_X := true
SS_INCLUDE_RECOVERY_USB_INIT := ../safestrap/devices/android/apollo/init.recovery.usb.rc

