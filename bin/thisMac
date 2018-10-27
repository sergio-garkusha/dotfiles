#!/usr/bin/env bash
# This script displays the System Software Overview:

# There are 3 known ways to do it:

# 1. Version only
# defaults read loginwindow SystemVersionStampAsString

# 2. Sussinct
# sw_vers

# 3. Full
# system_profiler SPSoftwareDataType

if [ "$1" == "-h" ] || [ "$1" == "--help" ];
	then
		echo
		echo "This script displays the System Software Overview"
		echo
		echo "There are 3 known ways to do it:"

		echo "	1. Version only (Default, no args requred)"
		echo "	2. Sussinct (thisMac -s or thisMac --sussinct)"
		echo "	3. Full (thisMac -f or thisMac --full)"
else
	if [ -z "$1" ];
		then
			defaults read loginwindow SystemVersionStampAsString
			exit 0
	elif [ "$1" == "-s" ] || [ "$1" == "--sussinct" ];
		then
		sw_vers
		exit 0
	elif [ "$1" == "-f" ] || [ "$1" == "--full" ];
		then
		system_profiler SPSoftwareDataType
		exit 0
	else
		echo "[Error]: unsupported argument"
	fi
fi
