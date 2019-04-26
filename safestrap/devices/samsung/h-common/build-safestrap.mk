BUILD_SAFESTRAP_CMD += && \
	cp -fr $(SS_COMMON)/devices/samsung/h-common/hijack $(PRODUCT_OUT)/install-files/bin/e2fsck && \
	cp -fr $(SS_COMMON)/devices/samsung/h-common/res/* $(PRODUCT_OUT)/install-files/etc/safestrap/res/ && \
	cp -fr $(SS_COMMON)/devices/samsung/h-common/rootfs/* $(PRODUCT_OUT)/install-files/etc/safestrap/rootfs/ && \
	cp -fr $(SS_COMMON)/devices/samsung/h-common/sbin-libs/* $(TARGET_RECOVERY_ROOT_OUT)/sbin/ && \
	cp -fr $(SS_COMMON)/devices/samsung/h-common/ss.config $(PRODUCT_OUT)/APP/ss.config && \
	cp -fr $(SS_COMMON)/devices/samsung/h-common/ss.config $(PRODUCT_OUT)/install-files/etc/safestrap/ss.config && \
	cp -fr $(SS_COMMON)/devices/samsung/h-common/ss.config $(TARGET_RECOVERY_ROOT_OUT)/ss.config && \
	cp -fr $(SS_COMMON)/devices/samsung/h-common/twrp.fstab $(TARGET_RECOVERY_ROOT_OUT)/etc/recovery.fstab && \
	cp -fr $(SS_COMMON)/sbin-extras/* $(TARGET_RECOVERY_ROOT_OUT)/sbin/
