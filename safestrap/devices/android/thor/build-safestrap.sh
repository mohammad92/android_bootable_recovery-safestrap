#!/usr/bin/env bash
sh $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/android/common-hdx/build-safestrap.sh

cd $ANDROID_BUILD_TOP/bootable/recovery/safestrap/devices/android
cp -fr thor/res/* $OUT/install-files/etc/safestrap/res/