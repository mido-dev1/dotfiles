#!/usr/bin/env bash

SWWW_TRANSITION="any"
SWWW_TRANSITION_STEP=144
SWWW_TRANSITION_DURATION=.8
SWWW_TRANSITION_FPS=144
SWWW_TRANSITION_BEZIER=0.3,-0.3,0,1
dir="$HOME/Downloads/Wal/"

random()
{
    wal -q -n -t -i $dir &&
        source "/home/mehdi/.cache/wal/colors.sh" &&
        swww img $wallpaper --transition-type $SWWW_TRANSITION --transition-step $SWWW_TRANSITION_STEP --transition-duration $SWWW_TRANSITION_DURATION --transition-fps $SWWW_TRANSITION_FPS --transition-bezier $SWWW_TRANSITION_BEZIER &&
        cp /home/mehdi/.cache/wal/colors.scss /home/mehdi/.config/eww/scss/
}

init()
{
    swww kill 
    swww init 
    random
}


if [ "$1" = "init" ]; then
	init
elif [ "$1" = "random" ]; then
	random
fi
