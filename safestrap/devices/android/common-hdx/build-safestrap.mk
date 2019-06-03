BUILD_SAFESTRAP_CMD += && \
	cp -fr $(SS_COMMON)/devices/android/common-hdx/hijack $(PRODUCT_OUT)/install-files/etc/resize_user_data.sh && \
	cp -fr $(SS_COMMON)/devices/android/common-hdx/ss.config $(PRODUCT_OUT)/APP/ss.config && \
	cp -fr $(SS_COMMON)/devices/android/common-hdx/ss.config $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/ss.config && \
	cp -fr $(SS_COMMON)/devices/android/common-hdx/ss.config $(TARGET_RECOVERY_ROOT_OUT)/ss.config && \
	cp -fr $(SS_COMMON)/devices/android/common-hdx/twrp.fstab $(TARGET_RECOVERY_ROOT_OUT)/etc/recovery.fstab && \
	cp -fr $(SS_COMMON)/devices/android/sbin-extras/* $(TARGET_RECOVERY_ROOT_OUT)/sbin/
