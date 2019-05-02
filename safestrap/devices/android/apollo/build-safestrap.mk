include $(commands_TWRP_local_path)/safestrap/devices/android/common-hdx/build-safestrap.mk

BUILD_SAFESTRAP_CMD += && \
	cp -fr $(SS_COMMON)/devices/android/apollo/res/* $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/res/
