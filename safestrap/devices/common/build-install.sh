#!/usr/bin/env bash
cd $OUT
rm $OUT/APP/install-files.zip
rm $OUT/install-files/etc/safestrap/2nd-init.zip
rm $OUT/install-files/etc/safestrap/ramdisk-recovery.img
zip -9rj install-files/etc/safestrap/2nd-init 2nd-init-files/*
cd $OUT/recovery/root
# clean up for 2nd-init
rm -rf data
rm -rf dev
rm -rf proc
rm -rf sys
rm -rf system
rm -rf supersu
rm -rf tmp
# we're using a real taskset binary
rm -rf sbin/taskset