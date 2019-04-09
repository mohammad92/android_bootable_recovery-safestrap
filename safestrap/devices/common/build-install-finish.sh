#!/usr/bin/env bash
mkbootfs $OUT/recovery/root | minigzip > $OUT/install-files/etc/safestrap/ramdisk-recovery.img
cd $OUT
zip -9r APP/install-files install-files