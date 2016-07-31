# Autostart scripts

You have to symlink the `autostart` directory depending your distribution.

If you use KDE 4  
```bash
$ rmdir ~/.kde/Autostart
$ ln -s ~/dotfiles/scripts/autostart ~/.kde/Autostart
```
If you use KDE 5
```bash
$ rmdir ~/.config/autostart-scripts
$ ln -s ~/dotfiles/scripts/autostart ~/.config/autostart-scripts
```
Else
```bash
$ rmdir ~/.config/autostart
$ ln -s ~/dotfiles/scripts/autostart ~/.config
```
Logout/login for taking effects.