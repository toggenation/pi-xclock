#!/bin/sh

# echo Boot `date` >> /tmp/runxclock.log

export DISPLAY=:0

BACKGROUND='#414141'

/usr/bin/unclutter -display :0 -noevents -grab &

# set the background colour the same as xclock 
# so so you can move the text to the right place vertically
xsetroot -solid $BACKGROUND

/usr/bin/xclock -digital -strftime '%H:%M:%S'  -update 1 -fg '#F8F8FF' \
-bg $BACKGROUND -geometry '1920x880+0+120' \
-face 'Archivo Narrow:style=SemiBold:size=420' -padding 40
