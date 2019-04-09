#!/usr/bin/env bash
sh $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/common/build-install.sh
cd $OUT/recovery/root
# remove bbx and copy correct fixboot.sh
rm ./sbin/bbx
cp $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/common/2nd-init-files/fixboot.sh ./sbin/fixboot.sh