# remove bbx and copy correct fixboot.sh
INSTALL_SAFESTRAP_DEVICE_CMD := \
	rm -f $(TARGET_RECOVERY_ROOT_OUT)/sbin/bbx; \
	cp $(SS_COMMON)/devices/common/2nd-init-files/fixboot.sh $(TARGET_RECOVERY_ROOT_OUT)/sbin/;
