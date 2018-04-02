#!/usr/bin/env bash
sh $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung/msm8998-common/build-safestrap.sh
cd $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung
cp -fr greatqlte/twrp.fstab $OUT/recovery/root/etc/recovery.fstab
cp -fr greatqlte/ss.config $OUT/install-files/etc/safestrap/ss.config
cp -fr greatqlte/ss.config $OUT/APP/ss.config
cp -fr greatqlte/ss.config $OUT/recovery/root/ss.config

