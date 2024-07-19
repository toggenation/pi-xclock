# Full Screen Digital Clock for Raspberry Pi


Install `unclutter` to remove cursor when screen is inactive

Run X not Wayland (not sure if this is needed)

Install x11-apps to get `xclock`

Using `raspi-config` set autologin for your account


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

Get a list of fonts using `fc-list`

Add extra fonts to `~/.fonts` and run fc-cache -f to update.

Auto start it at boot

```sh
# .config/lxsession/LXDE-pi/autostart
@lxterminal -e /home/ja/pi-xclock/runxclock.sh
```

Modify your standard Pi desktop to hide the toolbar



