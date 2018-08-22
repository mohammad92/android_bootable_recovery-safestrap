#!/usr/bin/env bash
sh $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/motorola/common-omap4/build-safestrap.sh
cd $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/motorola
cp -fr targa/twrp.fstab $OUT/recovery/root/etc/recovery.fstab
cp -fr targa/ss.config $OUT/install-files/etc/safestrap/ss.config
cp -fr targa/ss.config $OUT/APP/ss.config
cp -fr targa/ss.config $OUT/recovery/root/ss.config
