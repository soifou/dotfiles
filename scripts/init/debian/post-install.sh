#!/bin/sh
###############################################################
# Linux x64 Debian Jessie + KDE
# This is a more a walkthrough than a real post-install script
###############################################################

# https://wiki.debian.org/SourcesList
vim /etc/apt/sources.list
# main
#deb http://ftp.fr.debian.org/debian/ jessie main
# security
#deb http://security.debian.org/ jessie/updates main
# jessie-updates, previously known as 'volatile'
#deb http://ftp.fr.debian.org/debian/ jessie-updates main
# contrib
#deb http://httpredir.debian.org/debian jessie main contrib non-free
# backports
#deb http://httpredir.debian.org/debian jessie-backports main contrib non-free
# disable src repos

# add new repos
apt-get install -y software-properties-common apt-transport-https
apt-add-repository 'deb http://httpredir.debian.org/debian jessie-backports main contrib non-free'
dpkg --add-architecture i386
apt-get update

# debian multimedia
# grab the GnuPG archive key of the deb-multimedia repository
apt-add-repository 'deb http://www.deb-multimedia.org jessie main non-free'
wget http://deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.3.6_all.deb
dpkg -i deb-multimedia-keyring_2016.3.6_all.deb
rm deb-multimedia-keyring_2016.3.6_all.deb
apt-get update

# create user
useradd -s /bin/bash -m -d /home/$USER -g sudo $USER -p XXXXXXXX

# SUDO
apt-get install -y sudo kdesu gksu
vim /etc/sudoers
# at EOF
# user ALL=(ALL) NOPASSWD: ALL

# NVIDIA
apt-get install -y linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,')
apt-get install -y -t jessie-backports nvidia-driver

# fix repos if you need
kdesudo software-properties-kde

# configure locales
dpkg-reconfigure locales
# check only UTF-8 needed locals

# full upgrade
apt-get install -f && apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get autoclean -y && apt-get autoremove -y

# install packages from file
# see: https://wiki.debian.org/ListInstalledPackages
# apt-get install dselect
# dpkg --set-selections < package-selections
# apt-get dselect-upgrade
# or in one shot
# aptitude install $(cat package-selections | awk '{print $1}')

# BASE packages
apt-get install -y partitionmanager ffmpegthumbs
# set video previews in Dolphin: Settings > General > Previews > Video Files (ffmpegthumbs)
apt-get install -y audacity libreoffice libreoffice-style-sifr gimp firefox-esr vlc vlc-*
# set LibreOffice icons set: Tools > Options... > View
# KDE packages
apt-get install -y yakuake ksshaskpass okular libreoffice-kde software-properties-kde transmission-qt
# Style
apt-get install -y gtk3-engines-oxygen gtk2-engines-oxygen gtk2-engines-qtcurve kde-style-oxygen
apt-get install -y kde-config-gtk-style
# set Widget Style QtCurves in Settings > Application Appearance > GTK
# change gtk styles to qtcurve and copy files after that
#sudo cp ~/.gtkrc-2.0 /root/.gtkrc-2.0

# grub. speedup loading
vim /etc/default/grub
# set the numbers, save
update-grub
update-grub2

# SSH
# chmod 0700 {%private-key-ssh-rsa-file-path%}

# DEV TOOLS
apt-get install -y build-essential curl git ssh kdiff3-qt ack-grep

# Install a nice KDE icons set
mkdir -p /home/$USER/.icons
git clone --depth=1 --branch=master https://github.com/PapirusDevelopmentTeam/papirus-icon-theme /home/$USER/.icons
ln -s /home/$USER/.icons/Papirus /home/$USER/.kde/share/icons/Papirus

# Keybase.io
curl -O https://prerelease.keybase.io/keybase_amd64.deb
dpkg -i keybase_amd64.deb
apt-get install -f
#run_keybase

# PYTHON
apt-get install -y python-pip libncurses5 libncurses5-dev libncursesw5
pip install --upgrade pip
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)
# source $HOME/.zshrc
pyenv install 2.7.10
pyenv global 2.7.10
# pip install something cool

# FONTS POWERLINE (via PIP)
# @see: https://levlaz.org/installing-powerline-in-debian/
pip install git+git://github.com/Lokaltog/powerline
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
mv PowerlineSymbols.otf /usr/share/fonts/
fc-cache -vf
mv 10-powerline-symbols.conf /etc/fonts/conf.d/

# RUBY
apt-get install -y libreadline-dev
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
# export PATH="$HOME/.rbenv/bin:$PATH" >> $HOME/.zshrc
# source $HOME/.zshrc
rbenv install 2.2.4
rbenv global 2.2.4
apt-get install -y gem
gem install bundler
# gem env home

# VIM (with ruby, python and powerline support)
# @see: http://juniway.blogspot.fr/2015/12/install-vim-with-python-support.html
# @see: https://gist.github.com/jmcantrell/156438bfacaa7111bf0f
apt-get install libncurses5-dev libreadline6-dev
git clone --depth=1 https://github.com/vim/vim.git $HOME/vimsrc
cd $HOME/vimsrc
# make distclean
./configure --with-features=huge --enable-gui=no --enable-python --enable-multibyte --enable-rubyinterp --enable-pythoninterp --with-python-config-dir=$(pyenv prefix)/lib/python2.7/config --enable-perlinterp --enable-luainterp --enable-cscope --prefix=/usr
make # VIMRUNTIMEDIR=/usr/share/vim/vim74
make install
rm -rf $HOME/vimsrc


# NODEJS
apt-get install -y node npm
npm i -g n
n stable
npm update -g npm
npm i -g node-gyp
n latest && n stable && n --stable
#node-gyp --python /home/user/.pyenv/shims/python
npm config set python /home/<user>/.pyenv/shims/python
npm i -g bower express grunt-cli gulp yo knex generator-generator generator-htmlemail forever static-server eslint less

# DOCKER
apt-get remove --purge lxc-docker* docker.io*
apt-get update
apt-get install -y apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sh -c "echo 'deb https://apt.dockerproject.org/repo debian-jessie main' > /etc/apt/sources.list.d/docker.list"
apt-get install docker-engine
usermod -aG docker $USER
service docker start
# systemctl start docker.service
# DOCKER-COMPOSE
curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# VIRTUALBOX 5
# https://www.virtualbox.org/wiki/Linux_Downloads#Debian-basedLinuxdistributions
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian '$(lsb_release -cs)' contrib non-free' > /etc/apt/sources.list.d/virtualbox.list"
apt-get update
apt-get install dkms virtualbox-5.1
# add your user to "vboxusers" group
usermod -aG vboxusers $USER

# CHROMIUM
apt-get install -y chromium

# FLUX
# see: https://github.com/xflux-gui/xflux-gui
apt-get install -y python-appindicator python-xdg python-pexpect python-gconf python-gtk2 python-glade2 libxxf86vm1
cd /tmp
git clone https://github.com/xflux-gui/xflux-gui.git
cd xflux-gui
python ./setup.py install
# TODO: Add flux to list of startup applications

# SLACK
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-2.1.0-amd64.deb
apt-get install -y gvfs-bin libappindicator1
dpkg -i slack-desktop-2.1.0-amd64.deb
rm slack-desktop-2.1.0-amd64.deb