#!/usr/bin/env bash
mkdir -p $OUT/APP
mkdir -p $OUT/install-files/bin/
mkdir -p $OUT/install-files/etc/safestrap/res/
mkdir -p $OUT/install-files/etc/safestrap/rootfs/
mkdir -p $OUT/recovery/root/etc
mkdir -p $OUT/recovery/root/sbin
cd $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/android
cp -fr otter/res/* $OUT/install-files/etc/safestrap/res/
cp -fr otter/hijack $OUT/install-files/bin/e2fsck
cp -fr otter/twrp.fstab $OUT/recovery/root/etc/recovery.fstab
cp -fr otter/ss.config $OUT/install-files/etc/safestrap/ss.config
cp -fr otter/ss.config $OUT/APP/ss.config
cp -fr otter/ss.config $OUT/recovery/root/ss.config
cd ../../../gui
