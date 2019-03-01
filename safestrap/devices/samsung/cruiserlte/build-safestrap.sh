#!/usr/bin/env bash
sh $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung/msm8998-common/build-safestrap.sh
cd $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung
cp -fr cruiserlte/twrp.fstab $OUT/recovery/root/etc/recovery.fstab
cp -fr cruiserlte/ss.config $OUT/install-files/etc/safestrap/ss.config
cp -fr cruiserlte/ss.config $OUT/APP/ss.config
cp -fr cruiserlte/ss.config $OUT/recovery/root/ss.config
