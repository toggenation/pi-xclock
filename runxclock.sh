#!/bin/sh

# echo Boot `date` >> /tmp/runxclock.log

export DISPLAY=:0

BACKGROUND='#414141'
FOREGROUND='#F8F8FF'
TIME_FORMAT='%H:%M:%S'
GEOMETRY='1920x880+0+120'
FONT='Archivo Narrow:style=SemiBold:size=420'
PADDING=40

/usr/bin/unclutter -display :0 -noevents -grab &

# set the background colour the same as xclock 
# so so you can move the text to the right place vertically / horizontally
xsetroot -solid $BACKGROUND

/usr/bin/xclock -digital \
-strftime $TIME_FORMAT \
-update 1 -fg "$FOREGROUND" \
-bg "$BACKGROUND" \
-geometry $GEOMETRY \
-face "$FONT" \
-padding $PADDING
