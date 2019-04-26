BUILD_SAFESTRAP_CMD += && \
	cp -fr $(SS_COMMON)/devices/motorola/common-ghost/APP/* $(PRODUCT_OUT)/APP/ && \
	cp -fr $(SS_COMMON)/devices/motorola/common-ghost/changeslot.sh $(TARGET_RECOVERY_ROOT_OUT)/sbin/ && \
	cp -fr $(SS_COMMON)/devices/motorola/common-ghost/hijack $(PRODUCT_OUT)/install-files/bin/resize2fs && \
	cp -fr $(SS_COMMON)/devices/motorola/common-ghost/res/* $(PRODUCT_OUT)/install-files/etc/safestrap/res/ && \
	cp -fr $(SS_COMMON)/devices/motorola/common-ghost/ss.config $(PRODUCT_OUT)/APP/ss.config && \
	cp -fr $(SS_COMMON)/devices/motorola/common-ghost/ss.config $(PRODUCT_OUT)/install-files/etc/safestrap/ss.config && \
	cp -fr $(SS_COMMON)/devices/motorola/common-ghost/ss.config $(TARGET_RECOVERY_ROOT_OUT)/ss.config && \
	cp -fr $(SS_COMMON)/devices/motorola/common-ghost/twrp.fstab $(TARGET_RECOVERY_ROOT_OUT)/etc/recovery.fstab
