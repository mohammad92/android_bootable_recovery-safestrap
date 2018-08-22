#!/usr/bin/env bash
mkdir -p $OUT/recovery/root/etc
mkdir -p $OUT/recovery/root/sbin
mkdir -p $OUT/install-files/bin/
mkdir -p $OUT/install-files/etc/safestrap/res/
mkdir -p $OUT/install-files/etc/safestrap/rootfs/
cd $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung
cp -fr h-common/res/* $OUT/install-files/etc/safestrap/res/
cp -fr h-common/sbin-libs/* $OUT/recovery/root/sbin/
cp -fr h-common/hijack $OUT/install-files/bin/e2fsck
cp -fr h-common/twrp.fstab $OUT/recovery/root/etc/recovery.fstab
cp -fr h-common/ss.config $OUT/install-files/etc/safestrap/ss.config
cp -fr h-common/ss.config $OUT/APP/ss.config
cp -fr h-common/ss.config $OUT/recovery/root/ss.config
cp -fr h-common/rootfs/* $OUT/install-files/etc/safestrap/rootfs/
cp -fr h-common/build-fs.sh $OUT/recovery/root/sbin/
cp -fr ../../sbin-extras/* $OUT/recovery/root/sbin/
cd ../../../gui
