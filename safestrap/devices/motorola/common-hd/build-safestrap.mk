BUILD_SAFESTRAP_CMD += && \
	cp -fr $(SS_COMMON)/devices/motorola/common-hd/hijack $(PRODUCT_OUT)/install-files/etc/init.qcom.modem_links.sh && \
	cp -fr $(SS_COMMON)/devices/motorola/common-hd/res/* $(PRODUCT_OUT)/install-files/etc/safestrap/res/ && \
	cp -fr $(SS_COMMON)/devices/motorola/common-hd/ss.config $(PRODUCT_OUT)/APP/ss.config && \
	cp -fr $(SS_COMMON)/devices/motorola/common-hd/ss.config $(PRODUCT_OUT)/install-files/etc/safestrap/ss.config && \
	cp -fr $(SS_COMMON)/devices/motorola/common-hd/ss.config $(TARGET_RECOVERY_ROOT_OUT)/ss.config && \
	cp -fr $(SS_COMMON)/devices/motorola/common-hd/twrp.fstab $(TARGET_RECOVERY_ROOT_OUT)/etc/recovery.fstab
