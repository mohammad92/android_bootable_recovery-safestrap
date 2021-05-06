# Copyright 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := $(call my-dir)

ifeq ($(BUILD_SAFESTRAP), true)
  LOCAL_CFLAGS += -DBUILD_SAFESTRAP
  LOCAL_CPPFLAGS += -DBUILD_SAFESTRAP
endif

ifneq ($(wildcard external/e2fsprogs/misc/tune2fs.h),)
    tune2fs_static_libraries := \
        libext2_com_err \
        libext2_blkid \
        libext2_quota \
        libext2_uuid \
        libext2_e2p \
        libext2fs
    LOCAL_CFLAGS += -DHAVE_LIBTUNE2FS
else
    tune2fs_static_libraries :=
endif

updater_common_static_libraries := \
    libapplypatch \
    libbootloader_message \
    libbspatch \
    libedify \
    libotautil \
    libext4_utils \
    libdm \
    libfec \
    libfec_rs \
    libverity_tree \
    libfs_mgr \
    libgtest_prod \
    liblog \
    liblp \
    libselinux \
    libsparse \
    libsquashfs_utils \
    libbrotli \
    libbz \
    libziparchive \
    libz \
    libbase \
    libcrypto \
    libcrypto_utils \
    libcutils \
    libutils \
    libtune2fs \
    $(tune2fs_static_libraries)

<<<<<<< HEAD
# libupdater (static library)
# ===============================
include $(CLEAR_VARS)

LOCAL_MODULE := libupdater

LOCAL_SRC_FILES := \
    install.cpp \
    blockimg.cpp

ifeq ($(BUILD_SAFESTRAP), true)
LOCAL_SRC_FILES += \
    ../safestrap-functions.c
endif

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/.. \
    $(LOCAL_PATH)/include \
    external/e2fsprogs/misc

LOCAL_CFLAGS := \
    -Wall \
    -Werror

ifeq ($(BOARD_SUPPRESS_EMMC_WIPE),true)
    LOCAL_CFLAGS += -DSUPPRESS_EMMC_WIPE
endif

LOCAL_EXPORT_C_INCLUDE_DIRS := \
    $(LOCAL_PATH)/include

LOCAL_STATIC_LIBRARIES := \
    $(updater_common_static_libraries)

include $(BUILD_STATIC_LIBRARY)

=======
>>>>>>> android-10.0.0_r25
# updater (static executable)
# ===============================
include $(CLEAR_VARS)

ifeq ($(BUILD_SAFESTRAP), true)
LOCAL_MODULE := update-binary
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_PACK_MODULE_RELOCATIONS := false 
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_UNSTRIPPED_PATH := $(TARGET_RECOVERY_ROOT_OUT)/../../symbols/sbin
else
LOCAL_MODULE := updater
endif

LOCAL_SRC_FILES := \
    updater.cpp

ifeq ($(BUILD_SAFESTRAP), true)
LOCAL_SRC_FILES += \
    ../safestrap-functions.c
endif

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/include

LOCAL_CFLAGS := \
    -Wall \
    -Werror

LOCAL_STATIC_LIBRARIES := \
    libupdater \
    $(TARGET_RECOVERY_UPDATER_LIBS) \
    $(TARGET_RECOVERY_UPDATER_EXTRA_LIBS) \
    $(updater_common_static_libraries)

# Each library in TARGET_RECOVERY_UPDATER_LIBS should have a function
# named "Register_<libname>()".  Here we emit a little C function that
# gets #included by updater.c.  It calls all those registration
# functions.

# Devices can also add libraries to TARGET_RECOVERY_UPDATER_EXTRA_LIBS.
# These libs are also linked in with updater, but we don't try to call
# any sort of registration function for these.  Use this variable for
# any subsidiary static libraries required for your registered
# extension libs.

ifneq ($(BUILD_SAFESTRAP), true)
LOCAL_MODULE_CLASS := EXECUTABLES
inc := $(call local-generated-sources-dir)/register.inc
endif

$(inc) : libs := $(TARGET_RECOVERY_UPDATER_LIBS)
$(inc) :
	$(hide) mkdir -p $(dir $@)
	$(hide) echo "" > $@
	$(hide) $(foreach lib,$(libs),echo "extern void Register_$(lib)(void);" >> $@;)
	$(hide) echo "void RegisterDeviceExtensions() {" >> $@
	$(hide) $(foreach lib,$(libs),echo "  Register_$(lib)();" >> $@;)
	$(hide) echo "}" >> $@

LOCAL_GENERATED_SOURCES := $(inc)

inc :=

LOCAL_FORCE_STATIC_EXECUTABLE := true

include $(BUILD_EXECUTABLE)
