#!/usr/bin/env bash
sh $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung/k-common/build-install.sh
cp $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung/kltevzw/rootfs/init $OUT/recovery/root/init
sh $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/common/build-install-finish.sh