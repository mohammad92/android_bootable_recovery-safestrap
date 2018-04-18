#!/system/bin/sh
# By Hashcode

INSTALLPATH=$1
SS_CONFIG=$INSTALLPATH/ss.config

chmod 755 $INSTALLPATH/ss_function.sh

. $INSTALLPATH/ss_function.sh
readConfig

echo 1 > /data/$SS_RECOVERY_FILE
sync