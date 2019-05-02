BUILD_SAFESTRAP_CMD += && \
	cp -fr $(SS_COMMON)/devices/samsung/msm8998-common/hijack $(PRODUCT_OUT)/install-files/bin/e2fsck && \
	cp -fr $(SS_COMMON)/devices/samsung/msm8998-common/res/* $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/res/ && \
	cp -fr $(SS_COMMON)/devices/samsung/msm8998-common/rootfs/* $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/rootfs/ && \
	cp -fr $(SS_COMMON)/devices/samsung/msm8998-common/ss.config $(PRODUCT_OUT)/APP/ss.config && \
	cp -fr $(SS_COMMON)/devices/samsung/msm8998-common/ss.config $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/ss.config && \
	cp -fr $(SS_COMMON)/devices/samsung/msm8998-common/ss.config $(TARGET_RECOVERY_ROOT_OUT)/ss.config && \
	cp -fr $(SS_COMMON)/devices/samsung/msm8998-common/twrp.fstab $(TARGET_RECOVERY_ROOT_OUT)/etc/recovery.fstab && \
	cp -fr $(SS_COMMON)/sbin-extras/* $(TARGET_RECOVERY_ROOT_OUT)/sbin/
