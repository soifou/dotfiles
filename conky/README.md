# Conky

My [Conky] configuration file using the [Lua] programming language.
This version is a fork of Seajey's conkyrc which is a fork of [conkyrc_lunatico] which is itself a fork of [conkyrc_orange] =)

## Installation
Install `conky` or `conky-all` if available with your distribution
```sh
# apt-get install conky
```
Then edit `seamod/conkyrc` file. The code is pretty clear to modify and suits your needs.

Display it on your desktop
```sh
$ conky -c ~/dotfiles/conky/seamod/conkyrc
```

## Autostart
If you want to start [Conky] with your amazing config file everytime you load your desktop, add something like this in your autostart script:
```sh
#!/bin/sh
sh -c "sleep 6; conky -c ~/dotfiles/conky/seamod/conkyrc;"
```

## Credits
- [Conky](http://conky.sourceforge.net/)
- [Lua](http://www.lua.org/)
- [conkyrc_orange](http://gnome-look.org/content/show.php?content=137503&forumpage=0)
- [conkyrc_lunatico](http://gnome-look.org/content/show.php?content=142884)