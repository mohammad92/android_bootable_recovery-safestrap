include $(ANDROID_BUILD_TOP)/bootable/recovery/safestrap/devices/common/safestrap-common.mk
include $(ANDROID_BUILD_TOP)/bootable/recovery/safestrap/devices/android/common-hdx/safestrap-hdx-common.mk

DEVICE_RESOLUTION := 1200x1920
SS_DEFAULT_USB_INIT := ../safestrap/devices/android/thor/init.recovery.usb.rc