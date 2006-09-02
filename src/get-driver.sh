#!/bin/sh

DEV=$1

if test -e "$1"; then
	DEVPATH=$1
else
	# find sysfs device directory for device
	DEVPATH=$(find /sys/class/ -name "$1" | head -1)
	test -z "$DEVPATH" && DEVPATH=$(find /sys/block/ -name "$1")
	test -e "$DEVPATH" || exit 1
fi

# resolve old-style "device" link as the parent device
if test -d "$DEVPATH" -a -L $DEVPATH/device ; then
	if test -e "$DEVPATH/device"; then
		DEVPATH=$(readlink -f $DEVPATH/device)
	fi
fi

echo "looking at sysfs device: $DEVPATH"

while test "$DEVPATH" != "/"; do
	DRIVERPATH=
	DRIVER=
	MODULEPATH=
	MODULE=
	if test -e $DEVPATH/driver; then
		DRIVERPATH=$(readlink -f $DEVPATH/driver)
		DRIVER=$(basename $DRIVERPATH)
		echo -n "found driver: $DRIVER"
		if test -e $DRIVERPATH/module; then
			MODULEPATH=$(readlink -f $DRIVERPATH/module)
			MODULE=$(basename $MODULEPATH)
			echo -n " from module: $MODULE"
		fi
		echo
	fi

	DEVPATH=$(dirname $DEVPATH)
done
