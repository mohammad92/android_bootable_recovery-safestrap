#!/sbin/bbx sh
# By: Hashcode
BBX=/sbin/bbx
SS_CONFIG=/ss.config
echo "<1>Starting Safestrap fixboot.sh" > /dev/kmsg

. /sbin/ss_function.sh

readConfig

# If SS_PART uses DATAMEDIA we need to use the -orig partition in recovery
if [ "$SS_USE_DATAMEDIA" = "1" ]; then
	SS_PART=$SS_PART-orig
fi

# Double-check that these partitions are unmounted here
$BBX umount /system 2>/dev/null
$BBX umount /data 2>/dev/null
$BBX umount /cache 2>/dev/null

# check for SS loopdevs
if [ ! -e "$BLOCK_DIR/loop-system" ]; then
	# create SS loopdevs
	$BBX mknod -m600 /dev/block/loop-system b 7 99
	$BBX mknod -m600 /dev/block/loop-userdata b 7 98
	$BBX mknod -m600 /dev/block/loop-cache b 7 97
	$BBX mknod -m600 /dev/block/loop-boot b 7 96
fi

# check for systemorig partition alias so we don't run this twice
if [ ! -e "$BLOCK_DIR/$BLOCK_SYSTEM-orig" ]; then
	# move real partitions out of the way
	$BBX mv $BLOCK_DIR/$BLOCK_SYSTEM $BLOCK_DIR/$BLOCK_SYSTEM-orig
	$BBX mv $BLOCK_DIR/$BLOCK_USERDATA $BLOCK_DIR/$BLOCK_USERDATA-orig
	$BBX mv $BLOCK_DIR/$BLOCK_CACHE $BLOCK_DIR/$BLOCK_CACHE-orig
	$BBX mv $BLOCK_DIR/$BLOCK_BOOT $BLOCK_DIR/$BLOCK_BOOT-orig

	# remount root as rw
	echo "<1>$($BBX mount -o remount,rw rootfs)" > /dev/kmsg

	if [ ! -d "$SS_MNT" ]; then
		$BBX mkdir $SS_MNT
		$BBX chmod 777 $SS_MNT
	fi
	# mount safestrap partition
	if [ "$SS_USE_DATAMEDIA" = "1" ]; then
		if [ ! -d "$DATAMEDIA_MNT" ]; then
			$BBX mkdir $DATAMEDIA_MNT
			$BBX chown 0.0 $DATAMEDIA_MNT
			$BBX chmod 777 $DATAMEDIA_MNT
		fi
		$BBX mount -t $SS_FSTYPE $BLOCK_DIR/$SS_PART $DATAMEDIA_MNT
		$BBX mount $DATAMEDIA_MNT/media $SS_MNT
	else
		$BBX mount -t $SS_FSTYPE $BLOCK_DIR/$SS_PART $SS_MNT
	fi
	SLOT_LOC=$($BBX cat $SS_DIR/active_slot)

	if [ -f "$SS_DIR/$SLOT_LOC/system.img" ] && [ -f "$SS_DIR/$SLOT_LOC/userdata.img" ] && [ -f "$SS_DIR/$SLOT_LOC/cache.img" ]; then
		# setup loopbacks
		$BBX losetup $BLOCK_DIR/loop-system $SS_DIR/$SLOT_LOC/system.img
		$BBX losetup $BLOCK_DIR/loop-userdata $SS_DIR/$SLOT_LOC/userdata.img
		$BBX losetup $BLOCK_DIR/loop-cache $SS_DIR/$SLOT_LOC/cache.img
#		$BBX losetup $BLOCK_DIR/loop-boot $SS_DIR/$SLOT_LOC/boot.img

		# change symlinks
		$BBX ln -s $BLOCK_DIR/loop-system $BLOCK_DIR/$BLOCK_SYSTEM
		$BBX ln -s $BLOCK_DIR/loop-userdata $BLOCK_DIR/$BLOCK_USERDATA
		$BBX ln -s $BLOCK_DIR/loop-cache $BLOCK_DIR/$BLOCK_CACHE
#		$BBX ln -s $BLOCK_DIR/loop-boot $BLOCK_DIR/$BLOCK_BOOT
		$BBX ln -s /dev/null $BLOCK_DIR/$BLOCK_BOOT
	else
		echo "stock" > $SS_DIR/active_slot
		$BBX ln -s $BLOCK_DIR/$BLOCK_SYSTEM-orig $BLOCK_DIR/$BLOCK_SYSTEM
		$BBX ln -s $BLOCK_DIR/$BLOCK_USERDATA-orig $BLOCK_DIR/$BLOCK_USERDATA
		$BBX ln -s $BLOCK_DIR/$BLOCK_CACHE-orig $BLOCK_DIR/$BLOCK_CACHE
#		$BBX ln -s $BLOCK_DIR/$BLOCK_BOOT-orig $BLOCK_DIR/$BLOCK_BOOT
		$BBX ln -s /dev/null $BLOCK_DIR/$BLOCK_BOOT
	fi
fi

echo "<1>$($BBX mount | $BBX grep rootfs)" > /dev/kmsg
echo "<1>$($BBX ls -l /dev/block/loop-*)" > /dev/kmsg
echo "<1>$($BBX ls -l /dev/block/*-orig)" > /dev/kmsg

/sbin/taskset -p -c $TASKSET_CPUS 1