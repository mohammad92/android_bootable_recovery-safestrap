#!/usr/bin/env bash
#sh $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/motorola/common-omap4/build-safestrap.sh
mkdir -p $OUT/recovery/root/sbin
mkdir -p $OUT/APP
mkdir -p $OUT/2nd-init-files
mkdir -p $OUT/install-files/bin/
mkdir -p $OUT/install-files/etc/safestrap/kexec/
mkdir -p $OUT/install-files/etc/safestrap/res/
cd $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/motorola
cp -fr common-omap4/res/* $OUT/install-files/etc/safestrap/res/
cp -fr solana/res/* $OUT/install-files/etc/safestrap/res/
cp -fr common-omap4/sbin-blobs/* $OUT/recovery/root/sbin/
cp -fr solana/hijack $OUT/install-files/bin/logwrapper
cp -fr solana/twrp.fstab $OUT/recovery/root/etc/recovery.fstab
cp -fr solana/ss.config $OUT/install-files/etc/safestrap/ss.config
cp -fr solana/ss.config $OUT/APP/ss.config
cp -fr solana/ss.config $OUT/recovery/root/ss.config
cd ../../../gui