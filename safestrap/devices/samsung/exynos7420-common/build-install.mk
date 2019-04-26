# remove fstab.samsungexynos7580 from recovery
INSTALL_SAFESTRAP_DEVICE_CMD := \
	rm -f $(TARGET_RECOVERY_ROOT_OUT)/fstab.samsungexynos7580; \
	cp $(SS_COMMON)/devices/samsung/exynos7420-common/rootfs/init $(TARGET_RECOVERY_ROOT_OUT)/;
