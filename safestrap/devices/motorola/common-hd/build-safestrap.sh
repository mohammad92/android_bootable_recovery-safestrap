#!/usr/bin/env bash
mkdir -p $OUT/APP
mkdir -p $OUT/install-files/etc/safestrap/res/
mkdir -p $OUT/install-files/etc/safestrap/rootfs/
mkdir -p $OUT/recovery/root/etc/
cd $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/motorola
cp -fr common-hd/res/* $OUT/install-files/etc/safestrap/res/
cp -fr common-hd/hijack $OUT/install-files/etc/init.qcom.modem_links.sh
cp -fr common-hd/twrp.fstab $OUT/recovery/root/etc/recovery.fstab
cp -fr common-hd/ss.config $OUT/install-files/etc/safestrap/ss.config
cp -fr common-hd/ss.config $OUT/APP/ss.config
cp -fr common-hd/ss.config $OUT/recovery/root/ss.config
cd ../../../gui
