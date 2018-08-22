#!/usr/bin/env bash
sh $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung/k-common/build-safestrap.sh
cd $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung
cp -fr klteatt/rootfs/* $OUT/install-files/etc/safestrap/rootfs/
cp -fr klteatt/twrp.fstab $OUT/recovery/root/etc/recovery.fstab
cp -fr klteatt/ss.config $OUT/install-files/etc/safestrap/ss.config
cp -fr klteatt/ss.config $OUT/APP/ss.config
cp -fr klteatt/ss.config $OUT/recovery/root/ss.config

