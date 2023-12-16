#!/usr/bin/env bash

## Files and cmd
FILE="/home/mehdi/.cache/eww_launch.xyz"

## Run eww daemon if not running already
if [[ ! `pidof eww` ]]; then
	eww daemon
else
    pkill eww
fi

run ()
{
    eww open bar && rm -rf $FILE
}

if [[ ! -f $FILE ]]; then
    touch $FILE
    run
else
    run
fi
