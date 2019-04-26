include $(commands_TWRP_local_path)/safestrap/devices/samsung/k-common/build-install.mk

INSTALL_SAFESTRAP_DEVICE_CMD := \
	cp $(SS_COMMON)/devices/samsung/kltevzw/rootfs/init $(TARGET_RECOVERY_ROOT_OUT)/;
