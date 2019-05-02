#!/system/bin/sh
# By Hashcode

INSTALLPATH=$1
#LOGFILE=">> $INSTALLPATH/action-uninstall.log"
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
if [ "$CURRENTSYS" = "$BLOCK_DIR/loop-system" ]; then
	# alt-system, needs to mount original /system
	DESTMOUNT=$INSTALLPATH/system
	if [ ! -d "$DESTMOUNT" ]; then
		mkdir $DESTMOUNT
		chmod 755 $DESTMOUNT
	fi
	mount -t $SYSTEM_FSTYPE $BLOCK_DIR/$BLOCK_SYSTEM-orig $DESTMOUNT
	if [ "$?" -ne 0 ]; then
		mount -t $SYSTEM_FSTYPE $BLOCK_DIR/systemorig $DESTMOUNT
	fi
else
	DESTMOUNT=/system
	sync
	mount -o remount,rw $DESTMOUNT
fi

if [ -f "$DESTMOUNT/$HIJACK_LOC/$HIJACK_BIN.bin" ]; then
	mv -f $DESTMOUNT/$HIJACK_LOC/$HIJACK_BIN.bin $DESTMOUNT/$HIJACK_LOC/$HIJACK_BIN $LOGFILE
	chown 0.2000 $DESTMOUNT/$HIJACK_LOC/$HIJACK_BIN $LOGFILE
	chmod 755 $DESTMOUNT/$HIJACK_LOC/$HIJACK_BIN $LOGFILE
fi

if [ -d "$DESTMOUNT/$RECOVERY_DIR" ]; then
	rm -r $DESTMOUNT/$RECOVERY_DIR $LOGFILE
fi

sync

# determine our active system, and umount/remount accordingly
if [ "$CURRENTSYS" = "$BLOCK_DIR/loop-system" ]; then
	umount $DESTMOUNT $LOGFILE
	rmdir $DESTMOUNT
else
	mount -o ro,remount $DESTMOUNT $LOGFILE
fi
