# Autostart scripts

It does the following things at startup :
- launch Yakuake
- launch Conky with my custom configuration
- launch ssh-add to add my private ssh keys to ssh-agent

You have to symlink the `autostart` directory depending your distribution.

If you use KDE
```bash
$ rmdir ~/.kde/Autostart
$ ln -s ~/dotfiles/scripts/autostart ~/.kde/Autostart
```
Else
```bash
$ rmdir ~/.config/autostart
$ ln -s ~/dotfiles/scripts/autostart ~/.config
```
Logout/login for taking effects.