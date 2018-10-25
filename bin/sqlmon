#!/bin/bash

isMySQLExists="$(ps aux | grep mysql | grep -v grep)"

size=${#isMySQLExists}

if (($size > 0))
then
    echo ${isMySQLExists}
    echo $size
else
    echo "mysql isn't running!"
fi

