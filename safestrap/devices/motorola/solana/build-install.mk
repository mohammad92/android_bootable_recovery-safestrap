#include $(commands_TWRP_local_path)/safestrap/devices/motorola/common-omap4/build-install.mk

# add common init.rc w/ battd
# copy correct bbx/fixboot.sh
INSTALL_SAFESTRAP_DEVICE_CMD := \
	cp $(SS_COMMON)/bbx $(TARGET_RECOVERY_ROOT_OUT)/sbin/bbx; \
	cp $(SS_COMMON)/devices/common/2nd-init-files/fixboot.sh $(TARGET_RECOVERY_ROOT_OUT)/sbin/fixboot.sh; \
	cp $(SS_COMMON)/devices/motorola/solana/init.target.rc $(TARGET_RECOVERY_ROOT_OUT)/; \
	mkdir -p $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/kexec; \
	cp $(PRODUCT_OUT)/kernel $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/kexec/kernel; \
	cp device/motorola/solana/kexec/* $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/kexec/; \
	cp device/motorola/omap4-common/kexec/kexec $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/kexec/; \
	cp $(SS_COMMON)/devices/motorola/solana/safestrapmenu $(PRODUCT_OUT)/install-files/$(SS_LOC)/safestrap/;
