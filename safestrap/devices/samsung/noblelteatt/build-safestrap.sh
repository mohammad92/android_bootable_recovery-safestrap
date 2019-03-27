#!/usr/bin/env bash
sh $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung/exynos7420-common/build-safestrap.sh
cd $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung
cp -fr noblelteatt/twrp.fstab $OUT/recovery/root/etc/recovery.fstab
cp -fr noblelteatt/ss.config $OUT/install-files/etc/safestrap/ss.config
cp -fr noblelteatt/ss.config $OUT/APP/ss.config
cp -fr noblelteatt/ss.config $OUT/recovery/root/ss.config
