#!/bin/sh
#
# Find the module and driver for a given class device.

if [ $# != "1" ] ; then
	echo
	echo "Script to display the driver and module name for a specified sysfs class device"
	echo "usage: $0 <SYSFS_CLASS_DEVICE_DIRECTORY>"
	echo
	exit 1
fi


DEVICE=$1
DRIVER=no_drv
MODULE=no_mod

if test -h $DEVICE ; then
	# this is a symlink
	DIR=`readlink $DEVICE`
	cd $DEVICE/..;
	cd $DIR/..;
	if test -h driver ; then
		DRIVER=`readlink driver`
		cd driver
		if test -h module ; then
			MODULE=`readlink module`
		fi
	fi
else
	# old style of class devices
	if test -h $DEVICE/device/driver ; then
		DRIVER=`readlink $DEVICE/device/driver`
		if test -h $DEVICE/device/driver/module ; then
			MODULE=`readlink $DEVICE/device/driver/module`
		fi
	fi
fi

if [ $DRIVER = "no_drv" ] ; then
	echo "No driver found"
else
	echo "Driver = `basename $DRIVER`"

fi
if [ $MODULE = "no_mod" ] ; then
	echo "No module found"
else
	echo "Module = `basename $MODULE`"
fi
