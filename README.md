# Full Screen Digital Clock for Raspberry Pi


Install Unclutter to remove cursor when screen is inactive

Run X not wayland (not sure if this is needed)

Install x1-apps to get `xclock`



```sh

apt-get install unclutter x11-apps
```


Create a script to run `xclock`


```sh
echo Boot `date` >> /tmp/runxclock.log

/usr/bin/unclutter -display :0 -noevents -grab &

/usr/bin/xclock -digital -strftime '%H:%M:%S'  -update 1 -fg '#F8F8FF' \
-bg '#414141' -geometry '1920x1080' \
-face 'Archivo Narrow:style=SemiBold:size=420' -padding 40
```


Auto start it at boot
```sh
# .config/lxsession/LXDE-pi/autostart
@lxterminal -e /home/ja/pi-xclock/runxclock.sh
```

Modify your standard Pi desktop to hide the toolbar



