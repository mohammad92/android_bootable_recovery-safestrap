BUILD_SAFESTRAP_CMD += && \
	cp -fr $(SS_COMMON)/devices/motorola/common-omap4/hijack $(PRODUCT_OUT)/install-files/bin/logwrapper && \
	cp -fr $(SS_COMMON)/devices/motorola/common-omap4/res/* $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/res/ && \
	cp -fr $(SS_COMMON)/devices/motorola/common-omap4/sbin-blobs/* $(TARGET_RECOVERY_ROOT_OUT)/sbin/ && \
	cp -fr $(SS_COMMON)/devices/motorola/common-omap4/ss.config $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/ss.config && \
	cp -fr $(SS_COMMON)/devices/motorola/common-omap4/ss.config $(PRODUCT_OUT)/APP/ss.config && \
	cp -fr $(SS_COMMON)/devices/motorola/common-omap4/ss.config $(TARGET_RECOVERY_ROOT_OUT)/ss.config && \
	cp -fr $(SS_COMMON)/devices/motorola/common-omap4/twrp.fstab $(TARGET_RECOVERY_ROOT_OUT)/etc/recovery.fstab
