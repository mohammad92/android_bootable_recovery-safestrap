LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

ifeq ($(shell test $(PLATFORM_SDK_VERSION) -gt 22; echo $$?),0)
    LOCAL_CFLAGS += -DPLATFORM_SDK_22
endif

LOCAL_SRC_FILES:= 2nd-init.c
LOCAL_STATIC_LIBRARIES += libc libcutils liblog

LOCAL_MODULE_TAGS := eng
LOCAL_MODULE := 2nd-init

LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_OUT)/../2nd-init-files
LOCAL_FORCE_STATIC_EXECUTABLE := true
include $(BUILD_EXECUTABLE)


