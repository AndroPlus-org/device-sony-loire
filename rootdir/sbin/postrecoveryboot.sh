#!/sbin/sh
bb=/sbin/busybox
if [ "$($BB mount | $BB grep system | $BB grep -c ro)" -eq "1" ]; then
	$BB mount -o remount,rw /system;
fi;

if [ -e /system/lib/modules/core_ctl.ko ]; then
    insmod /system/lib/modules/core_ctl.ko
    insmod /system/lib/modules/ecryptfs.ko
    insmod /system/lib/modules/kscl.ko
    insmod /system/lib/modules/texfat.ko
else
    insmod /sbin/core_ctl.ko
    insmod /sbin/ecryptfs.ko
    insmod /sbin/kscl.ko
    insmod /sbin/texfat.ko
fi

stop sbinqseecomd

if [ "$($BB mount | $BB grep system | $BB grep -c rw)" -eq "1" ]; then
	$BB mount -o remount,ro /system;
fi;
