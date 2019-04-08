#!/usr/bin/env bash
mkdir -p $OUT/recovery/root/etc
mkdir -p $OUT/recovery/root/sbin
mkdir -p $OUT/install-files/etc/safestrap/res/
mkdir -p $OUT/install-files/etc/safestrap/rootfs/
cd $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/android
cp -fr common-hdx/hijack $OUT/install-files/etc/resize_user_data.sh
cp -fr common-hdx/twrp.fstab $OUT/recovery/root/etc/recovery.fstab
cp -fr common-hdx/ss.config $OUT/install-files/etc/safestrap/ss.config
cp -fr common-hdx/ss.config $OUT/APP/ss.config
cp -fr common-hdx/ss.config $OUT/recovery/root/ss.config
cp -fr common-hdx/rootfs/* $OUT/install-files/etc/safestrap/rootfs/
cp -fr ../../sbin-extras/* $OUT/recovery/root/sbin/
cd ../../../gui
