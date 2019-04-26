include $(commands_TWRP_local_path)/safestrap/devices/samsung/k-common/build-safestrap.mk

BUILD_SAFESTRAP_CMD += && \
	cp -fr $(SS_COMMON)/devices/samsung/klteatt/rootfs/* $(PRODUCT_OUT)/install-files/etc/safestrap/rootfs/ && \
	cp -fr $(SS_COMMON)/devices/samsung/klteatt/ss.config $(PRODUCT_OUT)/APP/ss.config && \
	cp -fr $(SS_COMMON)/devices/samsung/klteatt/ss.config $(PRODUCT_OUT)/install-files/etc/safestrap/ss.config && \
	cp -fr $(SS_COMMON)/devices/samsung/klteatt/ss.config $(TARGET_RECOVERY_ROOT_OUT)/ss.config && \
	cp -fr $(SS_COMMON)/devices/samsung/klteatt/twrp.fstab $(TARGET_RECOVERY_ROOT_OUT)/etc/recovery.fstab
