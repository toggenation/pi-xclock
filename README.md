# Full Screen Digital Clock for Raspberry Pi
Run X not Wayland (not sure if this is needed)

Using `raspi-config` set autologin for your account

Install x11-apps to get `xclock`



Install `unclutter` to remove cursor when screen is inactive

```sh
apt-get install unclutter x11-apps
```




Download and install a font of your choice. You need something tall and skinny look for "Narrow" or "Condensed" variants.

I chose Archivo [https://fonts.google.com/specimen/Archivo](https://fonts.google.com/specimen/Archivo)

Get a list of fonts using `fc-list`

Add extra fonts to `~/.fonts` and run fc-cache -f to update.





Create a script to run `xclock`

Adjust the background (-bg) and foreground (-fg) colours using colour names or #RGB codes. Here is a list of X11 colours [https://en.wikipedia.org/wiki/X11_color_names](https://en.wikipedia.org/wiki/X11_color_names)

Set the screen geometry to match your monitor

```sh
echo Boot `date` >> /tmp/runxclock.log

/usr/bin/unclutter -display :0 -noevents -grab &

/usr/bin/xclock -digital -strftime '%H:%M:%S'  -update 1 -fg '#F8F8FF' \
-bg '#414141' -geometry '1920x1080' \
-face 'Archivo Narrow:style=SemiBold:size=420' -padding 40
```
Modify your standard Pi desktop to hide the toolbar and autostart xclock at boot

```sh
# in .config/lxsession/LXDE-pi/autostart
@lxterminal -e /home/ja/pi-xclock/runxclock.sh
```

To run `xclock` over SSH use the following command

You can edit Xresources using the -xrm arguments

```sh
DISPLAY=:0 xclock -digital -strftime '%H:%M:%S'  -update 1 \
-fg '#F8F8FF' -bg '#414141' -xrm 'xclock*width:1920' -xrm 'xclock*height:1080' \
-face 'Liberation Sans Narrow:size=380:style=Bold' -xrm 'xclock*padding:130' \
-twentyfour
```

## Pro's
- Very light resource usage


## Con's
- I found it hard to get the time vertically centred so if this is important you need another solution
- `%n` the `strftime` new-line doesn't work


This is an example screenshot

![screen shot](screenshot/2024-07-19-213320_1920x1080_scrot.png)

This is an example with Liberation Sans Narrow font and trying to embed a newline using strftime `%n%H:%M:%S`
![screen shot](screenshot/2024-07-19-214905_1920x1080_scrot.png)
