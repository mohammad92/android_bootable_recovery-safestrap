#!/sbin/bbx sh
# By: Hashcode
PATH=/sbin:/system/xbin:/system/bin

# system/userdata/cache
IMAGE_NAME=`echo '${1}' | tr '[a-z]' '[A-Z]'`
LOOP_DEV=${2}
ROMSLOT_NAME=${3}
BBX=/sbin/bbx
SS_CONFIG=/ss.config
DISABLE_JOURNAL=


. /sbin/ss_function.sh
readConfig

eval CURRENT_BLOCK=\$BLOCK_${IMAGE_NAME}

$BBX rm $BLOCK_DIR/$CURRENT_BLOCK
$BBX ln -s $BLOCK_DIR/loop$LOOP_DEV $BLOCK_DIR/$CURRENT_BLOCK

if [ "$SS_USE_DATAMEDIA" = "1" ]; then
	DISABLE_JOURNAL="-O ^has_journal"
fi

# Samsung devices need to have data copied from stock system after rom-slot creation
if [ "$LOOP_DEV" = "-system" ]; then
	lfs dd if=$BLOCK_DIR/$BLOCK_SYSTEM-orig of=$BLOCK_DIR/loop$LOOP_DEV bs=4096
	e2fsck -p -v $BLOCK_DIR/loop$LOOP_DEV
	mount -t $SYSTEM_FSTYPE $BLOCK_DIR/loop$LOOP_DEV /system
	rm -rf /system/*
	umount /system
else
	if [ "$USERDATA_FSTYPE" = "f2fs" ] && [ "$LOOP_DEV" = "-userdata" ]; then
		mkfs.f2fs $BLOCK_DIR/loop$LOOP_DEV
	else
		if [ "$LOOP_DEV" = "-userdata" ]; then
			mke2fs $DISABLE_JOURNAL -T $USERDATA_FSTYPE $BLOCK_DIR/loop$LOOP_DEV
		else
			mke2fs $DISABLE_JOURNAL -T $SYSTEM_FSTYPE $BLOCK_DIR/loop$LOOP_DEV
		fi
	fi
fi

