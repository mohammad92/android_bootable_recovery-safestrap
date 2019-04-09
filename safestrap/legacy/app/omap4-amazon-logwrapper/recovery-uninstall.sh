#!/system/bin/sh
# By Hashcode
# Last Editted: 10/27/2012
PATH=/system/bin:/system/xbin
BLOCKNAME_DIR=/dev/block/platform/omap/omap_hsmmc.1/by-name
SYS_BLOCK=$BLOCKNAME_DIR/systemorig
SYS_BLOCK_FSTYPE=ext4
HIJACK_BIN=logwrapper

INSTALLPATH=$1
RECOVERY_DIR=/etc/safestrap
LOGFILE=$INSTALLPATH/action-uninstall.log

chmod 755 $INSTALLPATH/busybox

if [ -f $SYS_BLOCK ]; then
	PRIMARYSYS=`$INSTALLPATH/busybox ls -l $BLOCKNAME_DIR/ | $INSTALLPATH/busybox grep systemorig | $INSTALLPATH/busybox tail -c 22`
else
	PRIMARYSYS=`$INSTALLPATH/busybox ls -l $BLOCKNAME_DIR/ | $INSTALLPATH/busybox grep system | $INSTALLPATH/busybox tail -c 22`
fi
CURRENTSYS=`$INSTALLPATH/busybox ls -l /dev/block/system | $INSTALLPATH/busybox tail -c 22`

echo '' > $LOGFILE

# determine our active system, and mount/remount accordingly
if [ ! "$CURRENTSYS" = "$PRIMARYSYS" ]; then
	# alt-system, needs to mount original /system
	DESTMOUNT=$INSTALLPATH/system
	if [ ! -d "$DESTMOUNT" ]; then
		$INSTALLPATH/busybox mkdir $DESTMOUNT
		$INSTALLPATH/busybox chmod 755 $DESTMOUNT
	fi
	$INSTALLPATH/busybox mount -t $SYS_BLOCK_FSTYPE $PRIMARYSYS $DESTMOUNT >> $LOGFILE
else
	DESTMOUNT=/system
	sync
	$INSTALLPATH/busybox mount -o remount,rw $DESTMOUNT >> $LOGFILE
fi

if [ -f "$DESTMOUNT/bin/$HIJACK_BIN.bin" ]; then
	$INSTALLPATH/busybox cp -f $DESTMOUNT/bin/$HIJACK_BIN.bin $DESTMOUNT/bin/$HIJACK_BIN >> $LOGFILE
	$INSTALLPATH/busybox chown 0.2000 $DESTMOUNT/bin/$HIJACK_BIN >> $LOGFILE
	$INSTALLPATH/busybox chmod 755 $DESTMOUNT/bin/$HIJACK_BIN >> $LOGFILE
fi

if [ -d "$DESTMOUNT$RECOVERY_DIR" ]; then
	$INSTALLPATH/busybox rm -r $DESTMOUNT$RECOVERY_DIR >> $LOGFILE
fi

sync

# determine our active system, and umount/remount accordingly
if [ ! "$CURRENTSYS" = "$PRIMARYSYS" ]; then
	$INSTALLPATH/busybox umount $DESTMOUNT >> $LOGFILE
	$INSTALLPATH/busybox rmdir $DESTMOUNT
else
	$INSTALLPATH/busybox mount -o ro,remount $DESTMOUNT >> $LOGFILE
fi