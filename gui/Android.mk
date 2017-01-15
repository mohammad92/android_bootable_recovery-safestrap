LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

ifeq ($(BUILD_SAFESTRAP), true)
  COMMON_GLOBAL_CFLAGS += -DBUILD_SAFESTRAP
  COMMON_GLOBAL_CPPFLAGS += -DBUILD_SAFESTRAP
endif

LOCAL_CFLAGS := -fno-strict-aliasing

LOCAL_SRC_FILES := \
    gui.cpp \
    resources.cpp \
    pages.cpp \
    text.cpp \
    image.cpp \
    action.cpp \
    console.cpp \
    fill.cpp \
    button.cpp \
    checkbox.cpp \
    fileselector.cpp \
    progressbar.cpp \
    animation.cpp \
    object.cpp \
    slider.cpp \
    slidervalue.cpp \
    listbox.cpp \
    keyboard.cpp \
    input.cpp \
    blanktimer.cpp \
    partitionlist.cpp \
    mousecursor.cpp \
    scrolllist.cpp \
    patternpassword.cpp \
    textbox.cpp \
    terminal.cpp \
    twmsg.cpp

ifneq ($(TWRP_CUSTOM_KEYBOARD),)
    LOCAL_SRC_FILES += $(TWRP_CUSTOM_KEYBOARD)
else
    LOCAL_SRC_FILES += hardwarekeyboard.cpp
endif

LOCAL_SHARED_LIBRARIES += libminuitwrp libc libstdc++ libminzip libaosprecovery libselinux
LOCAL_MODULE := libguitwrp

#TWRP_EVENT_LOGGING := true
ifeq ($(TWRP_EVENT_LOGGING), true)
    LOCAL_CFLAGS += -D_EVENT_LOGGING
endif
ifneq ($(TW_USE_KEY_CODE_TOUCH_SYNC),)
    LOCAL_CFLAGS += -DTW_USE_KEY_CODE_TOUCH_SYNC=$(TW_USE_KEY_CODE_TOUCH_SYNC)
endif

ifneq ($(TW_NO_SCREEN_BLANK),)
    LOCAL_CFLAGS += -DTW_NO_SCREEN_BLANK
endif
ifneq ($(TW_NO_SCREEN_TIMEOUT),)
    LOCAL_CFLAGS += -DTW_NO_SCREEN_TIMEOUT
endif
ifeq ($(HAVE_SELINUX), true)
    LOCAL_CFLAGS += -DHAVE_SELINUX
endif
ifeq ($(TW_OEM_BUILD), true)
    LOCAL_CFLAGS += -DTW_OEM_BUILD
endif
ifneq ($(TW_X_OFFSET),)
    LOCAL_CFLAGS += -DTW_X_OFFSET=$(TW_X_OFFSET)
endif
ifneq ($(TW_Y_OFFSET),)
    LOCAL_CFLAGS += -DTW_Y_OFFSET=$(TW_Y_OFFSET)
endif
ifneq ($(TW_W_OFFSET),)
    LOCAL_CFLAGS += -DTW_W_OFFSET=$(TW_W_OFFSET)
endif
ifneq ($(TW_H_OFFSET),)
    LOCAL_CFLAGS += -DTW_H_OFFSET=$(TW_H_OFFSET)
endif
ifeq ($(TW_ROUND_SCREEN), true)
    LOCAL_CFLAGS += -DTW_ROUND_SCREEN
endif

# Safestrap virtual size defaults
ifndef BOARD_DEFAULT_VIRT_SYSTEM_SIZE
    BOARD_DEFAULT_VIRT_SYSTEM_SIZE := 600
endif
ifndef BOARD_DEFAULT_VIRT_SYSTEM_MIN_SIZE
    BOARD_DEFAULT_VIRT_SYSTEM_MIN_SIZE := 600
endif
ifndef BOARD_DEFAULT_VIRT_SYSTEM_MAX_SIZE
    BOARD_DEFAULT_VIRT_SYSTEM_MAX_SIZE := 1000
endif
LOCAL_CFLAGS += -DDEFAULT_VIRT_SYSTEM_SIZE=\"$(BOARD_DEFAULT_VIRT_SYSTEM_SIZE)\"
LOCAL_CFLAGS += -DDEFAULT_VIRT_SYSTEM_MIN_SIZE=\"$(BOARD_DEFAULT_VIRT_SYSTEM_MIN_SIZE)\"
LOCAL_CFLAGS += -DDEFAULT_VIRT_SYSTEM_MAX_SIZE=\"$(BOARD_DEFAULT_VIRT_SYSTEM_MAX_SIZE)\"
ifndef BOARD_DEFAULT_VIRT_DATA_SIZE
    BOARD_DEFAULT_VIRT_DATA_SIZE := 2000
endif
ifndef BOARD_DEFAULT_VIRT_DATA_MIN_SIZE
    BOARD_DEFAULT_VIRT_DATA_MIN_SIZE := 1000
endif
ifndef BOARD_DEFAULT_VIRT_DATA_MAX_SIZE
    BOARD_DEFAULT_VIRT_DATA_MAX_SIZE := 16000
endif
LOCAL_CFLAGS += -DDEFAULT_VIRT_DATA_SIZE=\"$(BOARD_DEFAULT_VIRT_DATA_SIZE)\"
LOCAL_CFLAGS += -DDEFAULT_VIRT_DATA_MIN_SIZE=\"$(BOARD_DEFAULT_VIRT_DATA_MIN_SIZE)\"
LOCAL_CFLAGS += -DDEFAULT_VIRT_DATA_MAX_SIZE=\"$(BOARD_DEFAULT_VIRT_DATA_MAX_SIZE)\"
ifndef BOARD_DEFAULT_VIRT_CACHE_SIZE
    BOARD_DEFAULT_VIRT_CACHE_SIZE := 300
endif
ifndef BOARD_DEFAULT_VIRT_CACHE_MIN_SIZE
    BOARD_DEFAULT_VIRT_CACHE_MIN_SIZE := 300
endif
ifndef BOARD_DEFAULT_VIRT_CACHE_MAX_SIZE
    BOARD_DEFAULT_VIRT_CACHE_MAX_SIZE := 1000
endif
LOCAL_CFLAGS += -DDEFAULT_VIRT_CACHE_SIZE=\"$(BOARD_DEFAULT_VIRT_CACHE_SIZE)\"
LOCAL_CFLAGS += -DDEFAULT_VIRT_CACHE_MIN_SIZE=\"$(BOARD_DEFAULT_VIRT_CACHE_MIN_SIZE)\"
LOCAL_CFLAGS += -DDEFAULT_VIRT_CACHE_MAX_SIZE=\"$(BOARD_DEFAULT_VIRT_CACHE_MAX_SIZE)\"

LOCAL_C_INCLUDES += bionic system/core/libpixelflinger/include
ifeq ($(shell test $(PLATFORM_SDK_VERSION) -lt 23; echo $$?),0)
    LOCAL_C_INCLUDES += external/stlport/stlport
endif

LOCAL_CFLAGS += -DTWRES=\"$(TWRES_PATH)\"

include $(BUILD_STATIC_LIBRARY)

# Transfer in the resources for the device
include $(CLEAR_VARS)
LOCAL_MODULE := twrp
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)$(TWRES_PATH)
TWRP_RES := $(commands_recovery_local_path)/gui/devices/common/res/*
# enable this to use new themes:
TWRP_NEW_THEME := true

ifdef BUILD_SAFESTRAP
    ifeq ($(TW_THEME),)
        SS_COMMON := $(commands_recovery_local_path)/safestrap
        # This converts the old DEVICE_RESOLUTION flag to the new TW_THEME flag
        PORTRAIT_MDPI := 320x480 480x800 480x854 540x960
        PORTRAIT_HDPI := 720x1280 800x1280 1080x1920 1200x1920 1440x2560 1600x2560
        LANDSCAPE_MDPI := 800x480 1024x600 1024x768
        LANDSCAPE_HDPI := 1280x800 1920x1200 2560x1600
        ifneq ($(filter $(DEVICE_RESOLUTION), $(PORTRAIT_MDPI)),)
            TW_THEME := portrait_mdpi
        else ifneq ($(filter $(DEVICE_RESOLUTION), $(PORTRAIT_HDPI)),)
            TW_THEME := portrait_hdpi
        else ifneq ($(filter $(DEVICE_RESOLUTION), $(LANDSCAPE_MDPI)),)
            TW_THEME := landscape_mdpi
        else ifneq ($(filter $(DEVICE_RESOLUTION), $(LANDSCAPE_HDPI)),)
            TW_THEME := landscape_hdpi
        endif
    endif
ifeq ($(TWRP_NEW_THEME),true)
    TWRP_THEME_LOC := $(SS_COMMON)/devices/common/theme/$(TW_THEME)
    TWRP_RES := $(SS_COMMON)/devices/common/theme/common/fonts
    TWRP_RES += $(SS_COMMON)/devices/common/theme/common/languages
    TWRP_RES += $(SS_COMMON)/devices/common/theme/common/$(word 1,$(subst _, ,$(TW_THEME))).xml
ifeq ($(TW_EXTRA_LANGUAGES),true)
    TWRP_RES += $(SS_COMMON)/devices/common/theme/extra-languages/fonts
    TWRP_RES += $(SS_COMMON)/devices/common/theme/extra-languages/languages
endif
# for future copying of used include xmls and fonts:
# UI_XML := $(TWRP_THEME_LOC)/ui.xml
# TWRP_INCLUDE_XMLS := $(shell xmllint --xpath '/recovery/include/xmlfile/@name' $(UI_XML)|sed -n 's/[^\"]*\"\([^\"]*\)\"[^\"]*/\1\n/gp'|sort|uniq)
# TWRP_FONTS_TTF := $(shell xmllint --xpath '/recovery/resources/font/@filename' $(UI_XML)|sed -n 's/[^\"]*\"\([^\"]*\)\"[^\"]*/\1\n/gp'|sort|uniq)niq)
ifeq ($(wildcard $(TWRP_THEME_LOC)/ui.xml),)
    $(warning ****************************************************************************)
    $(warning * TW_THEME is not valid: '$(TW_THEME)')
    $(warning * Please choose an appropriate TW_THEME or create a new one for your device.)
    $(warning * Available themes:)
    $(warning * $(notdir $(wildcard $(SS_COMMON)/devices/common/theme/*_*)))
    $(warning ****************************************************************************)
    $(error stopping)
endif
else
    TWRP_RES += $(SS_COMMON)/devices/common/res/$(word 1,$(subst _, ,$(TW_THEME)))/res/*
    ifeq ($(TW_THEME), portrait_mdpi)
        TWRP_THEME_LOC := $(SS_COMMON)/devices/common/res/480x800/res
    else ifeq ($(TW_THEME), portrait_hdpi)
        TWRP_THEME_LOC := $(SS_COMMON)/devices/common/res/1080x1920/res
    else ifeq ($(TW_THEME), landscape_mdpi)
        TWRP_THEME_LOC := $(SS_COMMON)/devices/common/res/800x480/res
    else ifeq ($(TW_THEME), landscape_hdpi)
        TWRP_THEME_LOC := $(SS_COMMON)/devices/common/res/1920x1200/res
    else
        $(warning ****************************************************************************)
        $(warning * TW_THEME ($(TW_THEME)) is not valid.)
        $(warning * Please choose an appropriate TW_THEME or create a new one for your device.)
        $(warning * Valid options are portrait_mdpi portrait_hdpi watch_mdpi)
        $(warning *                   landscape_mdpi landscape_hdpi)
        $(warning ****************************************************************************)
        $(error stopping)
    endif
endif
else
ifeq ($(TW_CUSTOM_THEME),)
    ifeq ($(TW_THEME),)
        ifeq ($(DEVICE_RESOLUTION),)
            DEVICE_RESOLUTION := $(TARGET_SCREEN_WIDTH)x$(TARGET_SCREEN_HEIGHT)
        endif
        # This converts the old DEVICE_RESOLUTION flag to the new TW_THEME flag
        PORTRAIT_MDPI := 320x480 480x800 480x854 540x960
        PORTRAIT_HDPI := 720x1280 800x1280 1080x1920 1200x1920 1440x2560 1600x2560
        WATCH_MDPI := 240x240 280x280 320x320
        LANDSCAPE_MDPI := 800x480 1024x600 1024x768
        LANDSCAPE_HDPI := 1280x800 1920x1200 2560x1600
        ifneq ($(filter $(DEVICE_RESOLUTION), $(PORTRAIT_MDPI)),)
            TW_THEME := portrait_mdpi
        else ifneq ($(filter $(DEVICE_RESOLUTION), $(PORTRAIT_HDPI)),)
            TW_THEME := portrait_hdpi
        else ifneq ($(filter $(DEVICE_RESOLUTION), $(WATCH_MDPI)),)
            TW_THEME := watch_mdpi
        else ifneq ($(filter $(DEVICE_RESOLUTION), $(LANDSCAPE_MDPI)),)
            TW_THEME := landscape_mdpi
        else ifneq ($(filter $(DEVICE_RESOLUTION), $(LANDSCAPE_HDPI)),)
            TW_THEME := landscape_hdpi
        endif
    endif

ifeq ($(TWRP_NEW_THEME),true)
    TWRP_THEME_LOC := $(commands_recovery_local_path)/gui/theme/$(TW_THEME)
    TWRP_RES := $(commands_recovery_local_path)/gui/theme/common/fonts
    TWRP_RES += $(commands_recovery_local_path)/gui/theme/common/languages
    TWRP_RES += $(commands_recovery_local_path)/gui/theme/common/$(word 1,$(subst _, ,$(TW_THEME))).xml
ifeq ($(TW_EXTRA_LANGUAGES),true)
    TWRP_RES += $(commands_recovery_local_path)/gui/theme/extra-languages/fonts
    TWRP_RES += $(commands_recovery_local_path)/gui/theme/extra-languages/languages
endif
# for future copying of used include xmls and fonts:
# UI_XML := $(TWRP_THEME_LOC)/ui.xml
# TWRP_INCLUDE_XMLS := $(shell xmllint --xpath '/recovery/include/xmlfile/@name' $(UI_XML)|sed -n 's/[^\"]*\"\([^\"]*\)\"[^\"]*/\1\n/gp'|sort|uniq)
# TWRP_FONTS_TTF := $(shell xmllint --xpath '/recovery/resources/font/@filename' $(UI_XML)|sed -n 's/[^\"]*\"\([^\"]*\)\"[^\"]*/\1\n/gp'|sort|uniq)niq)
ifeq ($(wildcard $(TWRP_THEME_LOC)/ui.xml),)
    $(warning ****************************************************************************)
    $(warning * TW_THEME is not valid: '$(TW_THEME)')
    $(warning * Please choose an appropriate TW_THEME or create a new one for your device.)
    $(warning * Available themes:)
    $(warning * $(notdir $(wildcard $(commands_recovery_local_path)/gui/theme/*_*)))
    $(warning ****************************************************************************)
    $(error stopping)
endif
else
    TWRP_RES += $(commands_recovery_local_path)/gui/devices/$(word 1,$(subst _, ,$(TW_THEME)))/res/*
    ifeq ($(TW_THEME), portrait_mdpi)
        TWRP_THEME_LOC := $(commands_recovery_local_path)/gui/devices/480x800/res
    else ifeq ($(TW_THEME), portrait_hdpi)
        TWRP_THEME_LOC := $(commands_recovery_local_path)/gui/devices/1080x1920/res
    else ifeq ($(TW_THEME), watch_mdpi)
        TWRP_THEME_LOC := $(commands_recovery_local_path)/gui/devices/320x320/res
    else ifeq ($(TW_THEME), landscape_mdpi)
        TWRP_THEME_LOC := $(commands_recovery_local_path)/gui/devices/800x480/res
    else ifeq ($(TW_THEME), landscape_hdpi)
        TWRP_THEME_LOC := $(commands_recovery_local_path)/gui/devices/1920x1200/res
    else
        $(warning ****************************************************************************)
        $(warning * TW_THEME ($(TW_THEME)) is not valid.)
        $(warning * Please choose an appropriate TW_THEME or create a new one for your device.)
        $(warning * Valid options are portrait_mdpi portrait_hdpi watch_mdpi)
        $(warning *                   landscape_mdpi landscape_hdpi)
        $(warning ****************************************************************************)
        $(error stopping)
    endif
endif
else
    TWRP_THEME_LOC := $(TW_CUSTOM_THEME)
endif
endif

TWRP_RES_GEN := $(intermediates)/twrp
ifneq ($(TW_USE_TOOLBOX), true)
    TWRP_SH_TARGET := /sbin/busybox
else
    TWRP_SH_TARGET := /sbin/mksh
endif
TWRP_RES += $(TW_ADDITIONAL_RES)

$(TWRP_RES_GEN):
	mkdir -p $(TARGET_RECOVERY_ROOT_OUT)$(TWRES_PATH)
	cp -fr $(TWRP_RES) $(TARGET_RECOVERY_ROOT_OUT)$(TWRES_PATH)
	cp -fr $(TWRP_THEME_LOC)/* $(TARGET_RECOVERY_ROOT_OUT)$(TWRES_PATH)
	mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/sbin/
ifneq ($(TW_USE_TOOLBOX), true)
ifeq ($(shell test $(PLATFORM_SDK_VERSION) -lt 24; echo $$?),0)
	ln -sf $(TWRP_SH_TARGET) $(TARGET_RECOVERY_ROOT_OUT)/sbin/sh
endif
endif
	ln -sf /sbin/pigz $(TARGET_RECOVERY_ROOT_OUT)/sbin/gzip
	ln -sf /sbin/unpigz $(TARGET_RECOVERY_ROOT_OUT)/sbin/gunzip
ifdef BUILD_SAFESTRAP
	# Safestrap Setup
	rm -rf $(OUT)/2nd-init-files
	rm -rf $(OUT)/APP
	rm -rf $(OUT)/install-files
	mkdir -p $(OUT)/2nd-init-files
	mkdir -p $(OUT)/install-files/etc/safestrap/flags
	mkdir -p $(OUT)/install-files/etc/safestrap/res
	mkdir -p $(OUT)/APP
	cp -p $(SS_COMMON)/devices/common/2nd-init-files/* $(OUT)/2nd-init-files
	cp -p $(SS_COMMON)/devices/common/2nd-init-files/fixboot.sh $(OUT)/recovery/root/sbin/
	cp -p $(SS_COMMON)/devices/common/2nd-init-files/ss_function.sh $(OUT)/recovery/root/sbin/
	cp -p $(SS_COMMON)/devices/common/2nd-init-files/ss_function.sh $(OUT)/APP/
	cp -p $(SS_COMMON)/devices/common/2nd-init-files/ss_function.sh $(OUT)/install-files/etc/safestrap/
	cp -p $(SS_COMMON)/devices/common/APP/* $(OUT)/APP/
	cp -p $(SS_COMMON)/devices/common/sbin/* $(OUT)/recovery/root/sbin/
	cp -p $(SS_COMMON)/flags/* $(OUT)/install-files/etc/safestrap/flags/
	cp -p $(SS_COMMON)/bbx $(OUT)/install-files/etc/safestrap/bbx
	cp -p $(SS_COMMON)/busybox $(OUT)/APP/busybox
	cp -p $(SS_COMMON)/lfs $(TARGET_RECOVERY_ROOT_OUT)/sbin/lfs
	cp -p $(SS_COMMON)/devices/common/splashscreen-res/$(DEVICE_RESOLUTION)/* $(OUT)/install-files/etc/safestrap/res/
	# Call out to device-specific script
	$(SS_COMMON)/devices/$(SS_PRODUCT_MANUFACTURER)/$(TARGET_DEVICE)/build-safestrap.sh
endif


LOCAL_GENERATED_SOURCES := $(TWRP_RES_GEN)
LOCAL_SRC_FILES := twrp $(TWRP_RES_GEN)
include $(BUILD_PREBUILT)
