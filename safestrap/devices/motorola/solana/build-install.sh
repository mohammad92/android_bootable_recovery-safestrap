#!/usr/bin/env bash
#sh $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/motorola/common-omap4/build-install.sh

cd $OUT
rm $OUT/APP/install-files.zip
rm $OUT/install-files/etc/safestrap/2nd-init.zip
rm $OUT/install-files/etc/safestrap/ramdisk-recovery.img
zip -9rj install-files/etc/safestrap/2nd-init 2nd-init-files/*
cd $OUT/recovery/root

# we're using a real taskset binary
rm -rf sbin/taskset

# add common init.rc w/ battd
# copy correct bbx/fixboot.sh
cp $ANDROID_BUILD_TOP/bootable/recovery/safestrap/bbx ./sbin/bbx
cp $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/common/2nd-init-files/fixboot.sh ./sbin/fixboot.sh
cp $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/motorola/solana/init.target.rc ./

cd $OUT/recovery/root
cp $OUT/kernel $OUT/install-files/etc/safestrap/kexec/kernel
cp $ANDROID_BUILD_TOP/device/motorola/solana/kexec/* $OUT/install-files/etc/safestrap/kexec/
cp $ANDROID_BUILD_TOP/device/motorola/omap4-common/kexec/kexec $OUT/install-files/etc/safestrap/kexec/
cp $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/motorola/solana/safestrapmenu $OUT/install-files/etc/safestrap/

sh $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/common/build-install-finish.sh