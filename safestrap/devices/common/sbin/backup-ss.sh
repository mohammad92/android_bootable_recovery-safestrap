#!/sbin/sh
# By: Hashcode

BBX=/sbin/bbx
SS_CONFIG=/ss.config

. /sbin/ss_function.sh
readConfig

if [ -d "/tmp/safestrap" ]; then
	rm -rf /tmp/safestrap
fi
if [ -f "/tmp/$HIJACK_BIN" ]; then
	rm /tmp/$HIJACK_BIN
fi
if [ -f "/tmp/$HIJACK_BIN.bin" ]; then
	rm /tmp/$HIJACK_BIN.bin
fi
cp -R /system/$SS_LOC/safestrap /tmp/
cp /system/$HIJACK_LOC/$HIJACK_BIN /tmp/
cp /system/$HIJACK_LOC/$HIJACK_BIN.bin /tmp/
