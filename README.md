Dotfiles
========

This repository includes a part of my dotfiles (mainly for vim, bash and zsh), intended to backup purpose.

It was greatly inspired by Michael Malley's dotfiles repository available here https://github.com/michaeljsmalley/dotfiles, thanks go to him.


Installation
------------

``` bash
git clone git://github.com/soifou/dotfiles ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

The included setup script (install.sh) will do the following things :

1. Back up any existing dotfiles in your home directory to `~/dotfiles_old/`
2. Create symlinks to the dotfiles in `~/dotfiles/` in your home directory
3. Clone the `oh-my-zsh` repository from GitHub
4. Install zsh
5. Set zsh as the default shell.

Configuration
-------------
##### Set your zsh theme
Check the list of available here `~/dotfiles/oh-my-zsh/themes/` then edit your zshrc file and set your theme like this :
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