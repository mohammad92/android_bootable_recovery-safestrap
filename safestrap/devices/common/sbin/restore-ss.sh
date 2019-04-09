#!/sbin/sh
# By: Hashcode

BBX=/sbin/bbx
SS_CONFIG=/ss.config

. /sbin/ss_function.sh
readConfig

if [ -d "/tmp/safestrap" ] && [ -f "/tmp/$HIJACK_BIN" ]; then
	# clear out old safestrap
	if [ -d "/system/etc/safestrap" ]; then
		rm -R /system/etc/safestrap
	fi
	mkdir -p /system/etc/

	cp -R /tmp/safestrap /system/etc/
	chown -R 0.2000 /system/etc/safestrap
	chmod 755 /system/etc/safestrap/bbx
	chmod 755 /system/etc/safestrap/ss_function.sh
	chmod 755 /system/etc/safestrap/safestrapmenu

	if [ ! -d "/system/$HIJACK_LOC" ]; then
		mkdir -p /system/$HIJACK_LOC
		chown -R 0.2000 /system/$HIJACK_LOC
		chmod 755 /system/$HIJACK_LOC
	fi
	if [ ! -f "/system/$HIJACK_LOC/$HIJACK_BIN.bin" ]; then
		if [ -f "/system/$HIJACK_LOC/$HIJACK_BIN" ]; then
			mv /system/$HIJACK_LOC/$HIJACK_BIN /system/$HIJACK_LOC/$HIJACK_BIN.bin
		else
			cp /tmp/$HIJACK_BIN.bin /system/$HIJACK_LOC/$HIJACK_BIN.bin
		fi
		chown 0.2000 /system/$HIJACK_LOC/$HIJACK_BIN.bin
		chmod 755 /system/$HIJACK_LOC/$HIJACK_BIN.bin
	fi
	cp /tmp/$HIJACK_BIN /system/$HIJACK_LOC/$HIJACK_BIN
	chown 0.2000 /system/$HIJACK_LOC/$HIJACK_BIN
	chmod 755 /system/$HIJACK_LOC/$HIJACK_BIN
fi