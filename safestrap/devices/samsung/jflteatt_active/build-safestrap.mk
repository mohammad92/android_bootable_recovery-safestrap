include $(commands_TWRP_local_path)/safestrap/devices/samsung/jf-common/build-safestrap.mk

BUILD_SAFESTRAP_CMD += && \
	cp -fr $(SS_COMMON)/devices/samsung/jflteatt_active/ss.config $(PRODUCT_OUT)/APP/ss.config && \
	cp -fr $(SS_COMMON)/devices/samsung/jflteatt_active/ss.config $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/ss.config && \
	cp -fr $(SS_COMMON)/devices/samsung/jflteatt_active/ss.config $(TARGET_RECOVERY_ROOT_OUT)/ss.config && \
	cp -fr $(SS_COMMON)/devices/samsung/jflteatt_active/twrp.fstab $(TARGET_RECOVERY_ROOT_OUT)/etc/recovery.fstab
