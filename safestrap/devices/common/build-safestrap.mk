LOCAL_PATH := $(call my-dir)

SS_COMMON := $(commands_TWRP_local_path)/safestrap

# Safestrap Setup
BUILD_SAFESTRAP_CMD := \
	rm -rf $(PRODUCT_OUT)/2nd-init-files && \
	rm -rf $(PRODUCT_OUT)/APP && \
	rm -rf $(PRODUCT_OUT)/install-files && \
	mkdir -p $(PRODUCT_OUT)/2nd-init-files && \
	mkdir -p $(PRODUCT_OUT)/APP && \
	mkdir -p $(PRODUCT_OUT)/install-files/bin && \
	mkdir -p $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/flags && \
	mkdir -p $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/res && \
	mkdir -p $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/rootfs && \
	mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/sbin && \
	cp -p $(SS_COMMON)/flags/* $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/flags/ && \
	cp -p $(SS_COMMON)/bbx $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/bbx && \
	cp -p $(SS_COMMON)/devices/common/2nd-init-files/* $(PRODUCT_OUT)/2nd-init-files && \
	cp -p $(SS_COMMON)/devices/common/2nd-init-files/fixboot.sh $(TARGET_RECOVERY_ROOT_OUT)/sbin/ && \
	cp -p $(SS_COMMON)/devices/common/2nd-init-files/ss_function.sh $(TARGET_RECOVERY_ROOT_OUT)/sbin/ && \
	cp -p $(SS_COMMON)/devices/common/2nd-init-files/ss_function.sh $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/ && \
	cp -p $(SS_COMMON)/devices/common/APP/* $(PRODUCT_OUT)/APP/ && \
	cp -p $(SS_COMMON)/devices/common/sbin/* $(TARGET_RECOVERY_ROOT_OUT)/sbin/ && \
	cp -p $(SS_COMMON)/devices/common/splashscreen-res/$(DEVICE_RESOLUTION)/* $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/res/

include $(SS_COMMON)/devices/$(SS_PRODUCT_MANUFACTURER)/$(TARGET_DEVICE)/build-safestrap.mk

# Transfer in the resources for the device
include $(CLEAR_VARS)
LOCAL_MODULE := safestrap
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
LOCAL_POST_INSTALL_CMD := $(BUILD_SAFESTRAP_CMD)
include $(BUILD_PREBUILT)
