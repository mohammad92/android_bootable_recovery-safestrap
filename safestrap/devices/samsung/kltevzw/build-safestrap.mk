include $(commands_TWRP_local_path)/safestrap/devices/samsung/k-common/build-safestrap.mk

BUILD_SAFESTRAP_CMD += && \
	cp -fr $(SS_COMMON)/devices/samsung/kltevzw/rootfs/* $(PRODUCT_OUT)/install-files/etc/safestrap/rootfs/
