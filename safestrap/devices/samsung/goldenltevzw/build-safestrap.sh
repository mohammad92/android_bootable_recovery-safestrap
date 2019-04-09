#!/usr/bin/env bash
sh $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung/golden-common/build-safestrap.sh
cd $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung
cp -fr goldenltevzw/twrp.fstab $OUT/recovery/root/etc/recovery.fstab
cp -fr goldenltevzw/ss.config $OUT/install-files/etc/safestrap/ss.config
cp -fr goldenltevzw/ss.config $OUT/APP/ss.config
cp -fr goldenltevzw/ss.config $OUT/recovery/root/ss.config