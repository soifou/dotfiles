Dotfiles
========

This repository includes a part of my dotfiles, intended to backup purpose. It was greatly inspired by [Michael Malley's dotfiles] and [Alan Christopher Thomas's dotfiles] repositories, thanks go to them.

Theses dotfiles are custom config for :
- Bash
- Conky
- Git
- SublimeText
- Vim
- Zsh

Installation
------------
``` bash
git clone git://github.com/soifou/dotfiles ~/dotfiles
cd ~/dotfiles
chmod +x bootstrap
./bootstrap -h
```

Configuration
-------------
##### Set your zsh theme
Check the list of themes available here `~/dotfiles/oh-my-zsh/themes/` then edit your zshrc file and set your theme like this :
``` bash
ZSH_THEME="theme_name"
```
##### Set your zsh plugins (for auto-completion)
Check the list of available plugins here `~/dotfiles/oh-my-zsh/plugins/` then edit your zshrc file and load plugins you want :
``` bash
plugins=(git debian symfony2 composer)
```
##### Choose the shell you want
If you want revert bash as default shell just do :
``` bash
chsh
*** your password ***
/usr/bin/bash
```
If you want to switch from bash to zsh in order to compare them, just type its name on prompt
``` bash
zsh
** switch to zsh **
bash
** switch to bash **
```

[zsh themes]:http://zshthem.es/
[Michael Malley's dotfiles]:https://github.com/michaeljsmalley/dotfiles
[Alan Christopher Thomas's dotfiles]:https://github.com/alanctkc/dotfiles