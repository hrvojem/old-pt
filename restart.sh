#!/bin/bash

timer=$(/usr/bin/time --format="%e" service mysql restart 2>&1 | cut -d . -f 1)

echo ${timer}

if [ ${timer} -gt 20 ]; then

	echo "WARNING restart takes more than 20s"
	exit 1
else 
	echo "Restarting in timely manner"
fi
