#!/usr/bin/env bash
sh $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/common/build-install.sh
cd $OUT/recovery/root
# remove fstab.samsungexynos7580 from recovery
rm fstab.samsungexynos7420
cp $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/samsung/exynos7420-common/rootfs/init ./init
