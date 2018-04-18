#!/usr/bin/env bash
mkdir -p $OUT/recovery/root/etc
mkdir -p $OUT/recovery/root/sbin
mkdir -p $OUT/install-files/bin/
mkdir -p $OUT/install-files/etc/safestrap/res/
mkdir -p $OUT/install-files/etc/safestrap/rootfs/
cd $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung
cp -fr jf-common/res/* $OUT/install-files/etc/safestrap/res/
cp -fr jf-common/sbin-libs/* $OUT/recovery/root/sbin/
cp -fr jf-common/hijack $OUT/install-files/bin/e2fsck
cp -fr jf-common/twrp.fstab $OUT/recovery/root/etc/twrp.fstab
cp -fr jf-common/ss.config $OUT/install-files/etc/safestrap/ss.config
cp -fr jf-common/ss.config $OUT/APP/ss.config
cp -fr jf-common/ss.config $OUT/recovery/root/ss.config
cp -fr jf-common/build-fs.sh $OUT/recovery/root/sbin/
cp -fr ../../sbin-extras/* $OUT/recovery/root/sbin/
cd ../../../gui
