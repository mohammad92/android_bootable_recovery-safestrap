BUILD_SAFESTRAP_CMD += && \
	cp -fr $(SS_COMMON)/devices/android/otter/hijack $(PRODUCT_OUT)/install-files/bin/e2fsck && \
	cp -fr $(SS_COMMON)/devices/android/otter/res/* $(PRODUCT_OUT)/install-files/etc/safestrap/res/ && \
	cp -fr $(SS_COMMON)/devices/android/otter/ss.config $(PRODUCT_OUT)/APP/ss.config && \
	cp -fr $(SS_COMMON)/devices/android/otter/ss.config $(PRODUCT_OUT)/install-files/etc/safestrap/ss.config && \
	cp -fr $(SS_COMMON)/devices/android/otter/ss.config $(TARGET_RECOVERY_ROOT_OUT)/ss.config && \
	cp -fr $(SS_COMMON)/devices/android/otter/twrp.fstab $(TARGET_RECOVERY_ROOT_OUT)/etc/recovery.fstab
