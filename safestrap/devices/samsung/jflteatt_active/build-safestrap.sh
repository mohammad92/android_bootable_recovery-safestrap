#!/usr/bin/env bash
sh $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung/jf-common/build-safestrap.sh
cd $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung
cp -fr jflteatt_active/twrp.fstab $OUT/recovery/root/etc/recovery.fstab
cp -fr jflteatt_active/ss.config $OUT/install-files/etc/safestrap/ss.config
cp -fr jflteatt_active/ss.config $OUT/APP/ss.config
cp -fr jflteatt_active/ss.config $OUT/recovery/root/ss.config
