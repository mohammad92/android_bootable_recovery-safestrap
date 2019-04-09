#!/usr/bin/env bash
sh $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/motorola/common-omap4/build-safestrap.sh
cd $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/motorola
cp -fr edison/twrp.fstab $OUT/recovery/root/etc/recovery.fstab
cp -fr edison/ss.config $OUT/install-files/etc/safestrap/ss.config
cp -fr edison/ss.config $OUT/APP/ss.config
cp -fr edison/ss.config $OUT/recovery/root/ss.config