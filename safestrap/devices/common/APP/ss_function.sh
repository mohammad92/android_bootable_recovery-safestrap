#!/system/bin/sh
# By Hashcode

BLOCK_DIR=/dev/block
SYS2_MNT=/s2
USER2_MNT=/u2
DATAMEDIA_MNT=/datamedia
SS_MNT=/ss
SS_RECOVERY_FILE=.recovery_mode

# read ss.config
readConfig() {
	BLOCK_SYSTEM=$(fgrep "SYSTEM=" $SS_CONFIG | sed 's/SYSTEM=//')
	SYSTEM_FSTYPE=$(fgrep "SYSTEM_FSTYPE=" $SS_CONFIG | sed 's/SYSTEM_FSTYPE=//')
	BLOCK_USERDATA=$(fgrep "USERDATA=" $SS_CONFIG | sed 's/USERDATA=//')
	USERDATA_FSTYPE=$(fgrep "USERDATA_FSTYPE=" $SS_CONFIG | sed 's/USERDATA_FSTYPE=//')
	BLOCK_CACHE=$(fgrep "CACHE=" $SS_CONFIG | sed 's/CACHE=//')
	BLOCK_BOOT=$(fgrep "BOOT=" $SS_CONFIG | sed 's/BOOT=//')
	SS_PART=$(fgrep "SS_PART=" $SS_CONFIG | sed 's/SS_PART=//')
	SS_FSTYPE=$(fgrep "SS_FSTYPE=" $SS_CONFIG | sed 's/SS_FSTYPE=//')
	SS_DIR=$(fgrep "SS_DIR=" $SS_CONFIG | sed 's/SS_DIR=//')
	SS_LOC=$(fgrep "SS_LOC=" $SS_CONFIG | sed 's/SS_LOC=//')
	HIJACK_BIN=$(fgrep "HIJACK_BIN=" $SS_CONFIG | sed 's/HIJACK_BIN=//')
	HIJACK_LOC=$(fgrep "HIJACK_LOC=" $SS_CONFIG | sed 's/HIJACK_LOC=//')
	BOOTMODE=$(getprop $(fgrep "BOOTMODE_PROP=" $SS_CONFIG | sed 's/BOOTMODE_PROP=//'))
	CHECK_BOOTMODE="$(fgrep "CHECK_BOOTMODE=" $SS_CONFIG | sed 's/CHECK_BOOTMODE=//')"
	DEVICE=$(getprop $(fgrep "DEVICE_PROP=" $SS_CONFIG | sed 's/DEVICE_PROP=//'))
	CHARGER_MODE=$(cat $(fgrep "CHARGER_MODE_SYSFS=" $SS_CONFIG | sed 's/CHARGER_MODE_SYSFS=//'))
	POWERUP_REASON_TEMP="$(fgrep "CHECK_POWERUP_REASON=" $SS_CONFIG | sed 's/CHECK_POWERUP_REASON=//')"
	POWERUP_REASON=$(eval $POWERUP_REASON_TEMP 2>/dev/null)
	POWERUP_REASON_CHARGER=$(fgrep "POWERUP_REASON_CHARGER=" $SS_CONFIG | sed 's/POWERUP_REASON_CHARGER=//')
	BACKLIGHT_BRIGHTNESS_PATH=$(fgrep "BACKLIGHT_BRIGHTNESS_PATH=" $SS_CONFIG | sed 's/BACKLIGHT_BRIGHTNESS_PATH=//')
	BACKLIGHT_BRIGHTNESS_VALUE=$(fgrep "BACKLIGHT_BRIGHTNESS_VALUE=" $SS_CONFIG | sed 's/BACKLIGHT_BRIGHTNESS_VALUE=//')
	TASKSET_CPUS=$(fgrep "TASKSET_CPUS=" $SS_CONFIG | sed 's/TASKSET_CPUS=//')
	SS_USE_DATAMEDIA=$(fgrep "SS_USE_DATAMEDIA=" $SS_CONFIG | sed 's/SS_USE_DATAMEDIA=//')
	SS_COPY_SYSTEM_DATA=$(fgrep "SS_COPY_SYSTEM_DATA=" $SS_CONFIG | sed 's/SS_COPY_SYSTEM_DATA=//')
	DEBUG_MODE=$(fgrep "DEBUG_MODE=" $SS_CONFIG | sed 's/DEBUG_MODE=//')
}

# print ss.config to kmsg
dumpConfig() {
	echo "<1>DUMP ss.config" > /dev/kmsg
	echo "<1>BLOCK_SYSTEM=$BLOCK_SYSTEM" > /dev/kmsg
	echo "<1>SYSTEM_FSTYPE=$SYSTEM_FSTYPE" > /dev/kmsg
	echo "<1>BLOCK_USERDATA=$BLOCK_USERDATA" > /dev/kmsg
	echo "<1>USERDATA_FSTYPE=$USERDATA_FSTYPE" > /dev/kmsg
	echo "<1>BLOCK_CACHE=$BLOCK_CACHE" > /dev/kmsg
	echo "<1>BLOCK_BOOT=$BLOCK_BOOT" > /dev/kmsg
	echo "<1>SS_PART=$SS_PART" > /dev/kmsg
	echo "<1>SS_FSTYPE=$SS_FSTYPE" > /dev/kmsg
	echo "<1>SS_DIR=$SS_DIR" > /dev/kmsg
	echo "<1>SS_LOC=$SS_LOC" > /dev/kmsg
	echo "<1>HIJACK_BIN=$HIJACK_BIN" > /dev/kmsg
	echo "<1>BOOTMODE=$BOOTMODE" > /dev/kmsg
	echo "<1>CHECK_BOOTMODE=$CHECK_BOOTMODE" > /dev/kmsg
	echo "<1>DEVICE=$DEVICE" > /dev/kmsg
	echo "<1>CHARGER_MODE=$CHARGER_MODE" > /dev/kmsg
	echo "<1>POWERUP_REASON_TEMP=$POWERUP_REASON_TEMP" > /dev/kmsg
	echo "<1>POWERUP_REASON=$POWERUP_REASON" > /dev/kmsg
	echo "<1>POWERUP_REASON_CHARGER=$POWERUP_REASON_CHARGER" > /dev/kmsg
	echo "<1>BACKLIGHT_BRIGHTNESS_PATH=$BACKLIGHT_BRIGHTNESS_PATH" > /dev/kmsg
	echo "<1>BACKLIGHT_BRIGHTNESS_VALUE=$BACKLIGHT_BRIGHTNESS_VALUE" > /dev/kmsg
	echo "<1>TASKSET_CPUS=$TASKSET_CPUS" > /dev/kmsg
	echo "<1>SS_USE_DATAMEDIA=$SS_USE_DATAMEDIA" > /dev/kmsg
	echo "<1>SS_COPY_SYSTEM_DATA=$SS_COPY_SYSTEM_DATA" > /dev/kmsg
	echo "<1>DEBUG_MODE=$DEBUG_MODE" > /dev/kmsg
}

# unmount /sys/fs/selinux + clear out files
fixSELinux() {
	# HASH: disable for now
	if [ "1" = "0" ]; then
		echo "umount /sys/fs/selinux" > /dev/kmsg
		for i in $(seq 1 10); do
			TMP=$(mount | grep /sys/fs/selinux)
			if [[ -z "$TMP" ]] ; then
				break
			fi
			umount -l /sys/fs/selinux
			sleep 1
		done

		# make sure to erase SElinux files
		rm /file_contexts
		rm /property_contexts
		rm /seapp_contexts
		rm /sepolicy
		rm /sepolicy_version
	fi
}

logCurrentStatus() {
	echo "<1>LOG CURRENT STATUS:" > /dev/kmsg
	echo "<1>$(ls -l /init*)" > /dev/kmsg
	echo "<1>______________________" > /dev/kmsg
#	echo "<1>$(mount)" > /dev/kmsg
#	echo "<1>______________________" > /dev/kmsg
#	echo "<1>$(ps)" > /dev/kmsg
#	echo "<1>______________________" > /dev/kmsg
}
