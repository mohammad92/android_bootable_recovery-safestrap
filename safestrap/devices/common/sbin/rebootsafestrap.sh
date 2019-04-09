#!/sbin/bbx sh
# By: Mohammad Afaneh, Afaneh92@xda
# wrapper to reboot back to Safestrap recovery
PATH=/sbin:/system/xbin:/system/bin

BBX=/sbin/bbx
SS_CONFIG=/ss.config

. /sbin/ss_function.sh
readConfig

$BBX echo 1 > /data/$SS_RECOVERY_FILE