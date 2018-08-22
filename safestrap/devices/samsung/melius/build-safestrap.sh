#!/usr/bin/env bash
mkdir -p $OUT/recovery/root/etc
mkdir -p $OUT/recovery/root/sbin
mkdir -p $OUT/install-files/bin/
mkdir -p $OUT/install-files/etc/safestrap/res/
mkdir -p $OUT/install-files/etc/safestrap/rootfs/
cd $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung
cp -fr melius/res/* $OUT/install-files/etc/safestrap/res/
cp -fr melius/sbin-libs/* $OUT/recovery/root/sbin/
cp -fr melius/hijack $OUT/install-files/bin/e2fsck
cp -fr melius/twrp.fstab $OUT/recovery/root/etc/recovery.fstab
cp -fr melius/ss.config $OUT/install-files/etc/safestrap/ss.config
cp -fr melius/ss.config $OUT/APP/ss.config
cp -fr melius/ss.config $OUT/recovery/root/ss.config
cp -fr melius/rootfs/* $OUT/install-files/etc/safestrap/rootfs/
cp -fr ../../sbin-extras/* $OUT/recovery/root/sbin/
cd ../../../gui
