#!/bin/sh

# because you can't embed a new line in the strftime format
# and you might want to spread things across multiple lines
# you might need to run two instances of xclock

# echo Boot `date` >> /tmp/runxclock.log

export DISPLAY=:0

BACKGROUND='#414141'
FOREGROUND='#F8F8FF'


/usr/bin/unclutter -display :0 -noevents -grab &

# set the background colour the same as xclock 
# so so you can move the text to the right place vertically / horizontally
xsetroot -solid $BACKGROUND

killall xclock

TIME_FORMAT='%A'
GEOMETRY='1920x640+130+440'
FONT='Archivo Narrow:style=SemiBold:size=350'
PADDING=0
/usr/bin/xclock -digital \
-strftime $TIME_FORMAT \
-fg "$FOREGROUND" \
-update 60 \
-bg "$BACKGROUND" \
-geometry $GEOMETRY \
-face "$FONT" \
-padding $PADDING & 

sleep 1
TIME_FORMAT='%H:%M:%S'
GEOMETRY='1920x640+0+-160'
FONT='Archivo Narrow:style=SemiBold:size=420'
PADDING=40
/usr/bin/xclock -digital \
-strftime $TIME_FORMAT \
-update 1 -fg "$FOREGROUND" \
-bg "$BACKGROUND" \
-geometry $GEOMETRY \
-face "$FONT" \
-padding $PADDING & 

