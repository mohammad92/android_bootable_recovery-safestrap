include $(SS_COMMON)/devices/$(SS_PRODUCT_MANUFACTURER)/$(TARGET_DEVICE)/build-install.mk

INSTALL_SAFESTRAP_CMD := $(PRODUCT_OUT)/safestrap_installer
$(INSTALL_SAFESTRAP_CMD):
	rm -f $(PRODUCT_OUT)/APP/install-files.zip;
	rm -f $(PRODUCT_OUT)/install-files/etc/safestrap/2nd-init.zip;
	rm -f $(PRODUCT_OUT)/install-files/etc/safestrap/ramdisk-recovery.img;
	zip -9rj $(PRODUCT_OUT)/install-files/etc/safestrap/2nd-init $(PRODUCT_OUT)/2nd-init-files/*;
	# clean up for 2nd-init"
	rm -rf $(TARGET_RECOVERY_ROOT_OUT)/data;
	rm -rf $(TARGET_RECOVERY_ROOT_OUT)/dev;
	rm -rf $(TARGET_RECOVERY_ROOT_OUT)/proc;
	rm -rf $(TARGET_RECOVERY_ROOT_OUT)/sys;
	rm -rf $(TARGET_RECOVERY_ROOT_OUT)/system;
	rm -rf $(TARGET_RECOVERY_ROOT_OUT)/tmp;
	# we're using a real taskset binary"
	rm -f $(TARGET_RECOVERY_ROOT_OUT)/sbin/taskset;
	$(INSTALL_SAFESTRAP_DEVICE_CMD) 
	$(MKBOOTFS) $(TARGET_RECOVERY_ROOT_OUT) | $(MINIGZIP) > $(PRODUCT_OUT)/install-files/etc/safestrap/ramdisk-recovery.img; \
	cd $(PRODUCT_OUT) && zip -9r $(PRODUCT_OUT)/APP/install-files install-files;

.PHONY: safestrap_installer
safestrap_installer: $(INSTALL_SAFESTRAP_CMD)
