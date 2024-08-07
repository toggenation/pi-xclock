# Full Screen Digital Clock for Raspberry Pi

Using `raspi-config`
Set to run X not Wayland
Set autologin for your account

Install: 
- x11-apps to get `xclock`
- `unclutter` to remove cursor when screen is inactive
- `ntpsec` to sync Pi local machine clock with internet time

```sh
apt-get install unclutter x11-apps ntpsec
```
Download and install a font of your choice. You need something tall and skinny look for "Narrow" or "Condensed" variants. 

Get a list of installed fonts using `fc-list`

I chose to install Archivo [https://fonts.google.com/specimen/Archivo](https://fonts.google.com/specimen/Archivo)

Add extra fonts to `~/.fonts` and run fc-cache -f to update.

Create a script to run `xclock`

```sh
echo Boot `date` >> /tmp/runxclock.log

/usr/bin/unclutter -display :0 -noevents -grab &

/usr/bin/xclock -digital -strftime '%H:%M:%S'  -update 1 -fg '#F8F8FF' \
-bg '#414141' -geometry '1920x1080+0+100' \
-face 'Archivo Narrow:style=SemiBold:size=420' -padding 40
```
Adjust the background (-bg) and foreground (-fg) colours using colour names or #RGB codes. Here is a list of X11 colours [https://en.wikipedia.org/wiki/X11_color_names](https://en.wikipedia.org/wiki/X11_color_names)

Set the screen geometry to match your monitor

Modify your standard Pi desktop to hide the toolbar and autostart xclock at boot

```sh
# in .config/lxsession/LXDE-pi/autostart
# the next commented line left the terminal on top of xclock
# @lxterminal -e /home/ja/pi-xclock/runxclock.sh

# this works
/home/ja/pi-xclock/runxclock.sh
```

## Run xlock from an SSH terminal
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
- `%n` the `strftime` new-line doesn't work

## Change boot splash

Remove the multi-colour boot splash

```
# in /boot/firmware/config.txt add

disable_splash=1
```
Create an image smaller than the resolution use `fbset` to find your screen resolution

```sh
fbset
# output
mode "1920x1080"
    geometry 1920 1080 1920 1080 16
    timings 0 0 0 0 0 0 0
    rgba 5/11,6/5,5/0,0/0
endmode

```

I wanted a splash screen that uses approximately 80% of the vertical height 
so 1080 * 0.8 = 864 so resized the square PNG splash image I had with Gimp 
to 800x800 and upload to the Pi

800 allows some room so the service start messages on the boot don't look like 
they are colliding with the splash image


```sh
sudo cp splash.png /usr/share/plymouth/themes/pix/splash.png 
sudo plymouth-set-default-theme -R pix
```

Modify `/usr/share/plymouth/themes/pix/pix.script` if you want to remove the systemd loading text sprite:

```sh
# message_sprite = Sprite();
# message_sprite.SetPosition(screen_width * 0.1, screen_height * 0.9, 10000);

fun message_callback (text) {
#	my_image = Image.Text(text, 1, 1, 1);
#	message_sprite.SetImage(my_image);
	sprite.SetImage (resized_image);
}

```

Remember to re-run the following to compile it into the initrd's

```sh
sudo plymouth-set-default-theme -R pix
```

## Screenshots

This is an example screenshot (I took them on the Pi logged in via SSH using `DISPLAY=:0 scrot`

The font used here is Archivo Narrow

![screen shot](screenshot/2024-07-20-130404_1920x1080_scrot.png)

This is an example with Liberation Sans Narrow font and trying to embed a newline using strftime `%n%H:%M:%S` which doesn't work (so you can't have date and time on two lines with xclock)
![screen shot](screenshot/2024-07-19-214905_1920x1080_scrot.png)


Two lines of xclock output
![screen shot](screenshot/2024-07-20-141413_1920x1080_scrot.png)

### Version of Pi
```
cat /etc/debian_version
12.6

lsb_release -a
No LSB modules are available.
Distributor ID: Raspbian
Description:    Raspbian GNU/Linux 12 (bookworm)
Release:        12
Codename:       bookworm
```


