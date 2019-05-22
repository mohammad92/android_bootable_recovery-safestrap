#!/sbin/bbx sh
# By: Hashcode
PATH=/sbin:/system/xbin:/system/bin

# system/userdata/cache
LOOP_DEV=${1}
BBX=/sbin/bbx
SS_CONFIG=/ss.config

. /sbin/ss_function.sh
readConfig

if [ "$USERDATA_FSTYPE" = "f2fs" ] && [ "$LOOP_DEV" = "-userdata" ]; then
	fsck.f2fs $BLOCK_DIR/loop$LOOP_DEV
else
	e2fsck -pfv $BLOCK_DIR/loop$LOOP_DEV
fi
