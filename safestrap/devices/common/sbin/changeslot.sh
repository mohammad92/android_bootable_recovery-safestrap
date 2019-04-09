#!/sbin/bbx sh
# By: Hashcode
PATH=/sbin:/system/xbin:/system/bin

SS_SLOT=${1}
BBX=/sbin/bbx
SS_CONFIG=/ss.config

. /sbin/ss_function.sh
readConfig

$BBX umount /system
$BBX umount /data
$BBX umount /cache
$BBX umount /boot

$BBX rm $BLOCK_DIR/$BLOCK_SYSTEM
$BBX rm $BLOCK_DIR/$BLOCK_USERDATA
$BBX rm $BLOCK_DIR/$BLOCK_CACHE
$BBX rm $BLOCK_DIR/$BLOCK_BOOT
$BBX losetup -d $BLOCK_DIR/loop-system
$BBX losetup -d $BLOCK_DIR/loop-userdata
$BBX losetup -d $BLOCK_DIR/loop-cache
$BBX losetup -d $BLOCK_DIR/loop-boot

if [ "$SS_SLOT" = "stock" ]; then
	$BBX ln -s $BLOCK_DIR/$BLOCK_SYSTEM-orig $BLOCK_DIR/$BLOCK_SYSTEM
	$BBX ln -s $BLOCK_DIR/$BLOCK_USERDATA-orig $BLOCK_DIR/$BLOCK_USERDATA
	$BBX ln -s $BLOCK_DIR/$BLOCK_CACHE-orig $BLOCK_DIR/$BLOCK_CACHE
#	$BBX ln -s $BLOCK_DIR/$BLOCK_BOOT-orig $BLOCK_DIR/$BLOCK_BOOT
	$BBX ln -s /dev/null $BLOCK_DIR/$BLOCK_BOOT
else
	$BBX losetup $BLOCK_DIR/loop-system $SS_DIR/$SS_SLOT/system.img
	$BBX losetup $BLOCK_DIR/loop-userdata $SS_DIR/$SS_SLOT/userdata.img
	$BBX losetup $BLOCK_DIR/loop-cache $SS_DIR/$SS_SLOT/cache.img
#	$BBX losetup $BLOCK_DIR/loop-boot $SS_DIR/$SS_SLOT/boot.img
	$BBX ln -s $BLOCK_DIR/loop-system $BLOCK_DIR/$BLOCK_SYSTEM
	$BBX ln -s $BLOCK_DIR/loop-userdata $BLOCK_DIR/$BLOCK_USERDATA
	$BBX ln -s $BLOCK_DIR/loop-cache $BLOCK_DIR/$BLOCK_CACHE
#	$BBX ln -s $BLOCK_DIR/loop-boot $BLOCK_DIR/$BLOCK_BOOT
	$BBX ln -s /dev/null $BLOCK_DIR/$BLOCK_BOOT
fi
$BBX echo "$SS_SLOT" > $SS_DIR/active_slot