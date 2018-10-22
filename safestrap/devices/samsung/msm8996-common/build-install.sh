#!/usr/bin/env bash
sh $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/common/build-install.sh
cd $OUT/recovery/root
# remove fstab.qcom from recovery
rm fstab.qcom
cp $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung/msm8996-common/rootfs/init ./init
