#!/system/bin/sh
# By Hashcode

INSTALLPATH=$1
SS_CONFIG=$INSTALLPATH/ss.config

chmod 755 $INSTALLPATH/ss_function.sh

. $INSTALLPATH/ss_function.sh
readConfig

RECOVERY_DIR=$SS_LOC/safestrap
CURRENTSYS=`readlink $BLOCK_DIR/$BLOCK_SYSTEM`
# check for older symlink style fixboot
if [ "$?" -ne 0 ]; then
	CURRENTSYS=`readlink $BLOCK_DIR/system`
fi
echo "CURRENTSYS = $CURRENTSYS" $LOGFILE

if [ -d $INSTALLPATH/install-files ]; then
	rm -rf $INSTALLPATH/install-files $LOGFILE
fi
sync
unzip $INSTALLPATH/install-files.zip -d $INSTALLPATH $LOGFILE
if [ ! -d $INSTALLPATH/install-files ]; then
	echo 'ERR: Zip file didnt extract correctly.  Installation aborted.' $LOGFILE
	exit 1
fi
chmod -R 755 $INSTALLPATH/install-files

# determine our active system, and mount/remount accordingly
if [ "$CURRENTSYS" = "$BLOCK_DIR/loop-system" ]; then
	# alt-system, needs to mount original /system
	DESTMOUNT=$INSTALLPATH/system
	if [ ! -d "$DESTMOUNT" ]; then
		mkdir $DESTMOUNT
		chmod 755 $DESTMOUNT
	fi
	mount -t $SYSTEM_FSTYPE $BLOCK_DIR/$BLOCK_SYSTEM-orig $DESTMOUNT $LOGFILE
	if [ "$?" -ne 0 ]; then
		mount -t $SYSTEM_FSTYPE $BLOCK_DIR/systemorig $DESTMOUNT
	fi
else
	DESTMOUNT=/system
	sync
	mount -o remount,rw $DESTMOUNT $LOGFILE
fi

# check for a $HIJACK_LOC/$HIJACK_BIN.bin file and its not there, make a copy
if [ ! -f "$DESTMOUNT/$HIJACK_LOC/$HIJACK_BIN.bin" ]; then
	cp $DESTMOUNT/$HIJACK_LOC/$HIJACK_BIN $DESTMOUNT/$HIJACK_LOC/$HIJACK_BIN.bin $LOGFILE
	chown 0.2000 $DESTMOUNT/$HIJACK_LOC/$HIJACK_BIN.bin $LOGFILE
	chmod 755 $DESTMOUNT/$HIJACK_LOC/$HIJACK_BIN.bin $LOGFILE
fi
rm $DESTMOUNT/$HIJACK_LOC/$HIJACK_BIN $LOGFILE
cp -f $INSTALLPATH/install-files/$HIJACK_LOC/$HIJACK_BIN $DESTMOUNT/$HIJACK_LOC/$HIJACK_BIN $LOGFILE
chown 0.2000 $DESTMOUNT/$HIJACK_LOC/$HIJACK_BIN $LOGFILE
chmod 755 $DESTMOUNT/$HIJACK_LOC/$HIJACK_BIN $LOGFILE

# delete any existing /system/$SS_LOC/safestrap dir
if [ -d "$DESTMOUNT/$RECOVERY_DIR" ]; then
	rm -rf $DESTMOUNT/$RECOVERY_DIR $LOGFILE
fi
# extract the new dirs to /system
cp -R $INSTALLPATH/install-files/$RECOVERY_DIR $DESTMOUNT/$SS_LOC $LOGFILE
chown 0.2000 $DESTMOUNT/$RECOVERY_DIR/* $LOGFILE
chmod 755 $DESTMOUNT/$RECOVERY_DIR/* $LOGFILE

sync

# determine our active system, and umount/remount accordingly
if [ "$CURRENTSYS" = "$BLOCK_DIR/loop-system" ]; then
	# if we're in 2nd-system then re-enable safe boot
	touch $DESTMOUNT/$RECOVERY_DIR/flags/alt_system_mode $LOGFILE

	umount $DESTMOUNT $LOGFILE
	rmdir $DESTMOUNT $LOGFILE
else
	mount -o ro,remount $DESTMOUNT $LOGFILE
fi
