# Linux x64 Debian Jessie + KDE

vim /etc/apt/sources.list
# jessie
# deb http://ftp.fr.debian.org/debian/ jessie main contrib non-free
# jessie updates
# deb http://ftp.fr.debian.org/debian/ jessie-updates main contrib non-free
# jessie-backports
# deb http://ftp.fr.debian.org/debian jessie-backports main contrib non-free
# jessie security
# deb http://security.debian.org/ jessie/updates main contrib non-free
# jessie multimedia
# deb http://www.deb-multimedia.org jessie main non-free
## source list for check:
#deb http://ftp.by.debian.org/debian/ jessie main non-free
#deb http://security.debian.org/ jessie/updates main non-free
#deb http://ftp.by.debian.org/debian/ jessie-updates main non-free
#deb http://ftp.by.debian.org/debian/ jessie-backports main non-free
#deb http://manpages.ylsoftware.com/debian/ all main
#deb http://dl.google.com/linux/chrome/deb/ stable main
#deb http://www.deb-multimedia.org jessie main non-free
#deb http://download.virtualbox.org/virtualbox/debian wheezy contrib non-free
# disable src repos

# add new repos
apt-get install -y python-software-properties software-properties-common apt-transport-https
apt-add-repository 'deb http://manpages.ylsoftware.com/debian/ all main'
apt-add-repository 'deb http://dl.google.com/linux/chrome/deb/ stable main'
apt-add-repository 'deb http://download.virtualbox.org/virtualbox/debian wheezy contrib non-free'
apt-add-repository 'deb http://www.deb-multimedia.org wheezy main non-free'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
dpkg --add-architecture i386
apt-get update

# debian multimedia
wget http://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2015.6.1_all.deb
dpkg -i deb-multimedia-keyring_2015.6.1_all.deb
rm deb-multimedia-keyring_2015.6.1_all.deb

# SUDO
apt-get install -y sudo kdesu gksu
vim /etc/sudoers
## add {%user%} ALL=(ALL) ALL

# fix repos if you need
kdesudo software-properties-kde

# problem with duplicate
# http://serverfault.com/questions/376392/apt-get-duplicate-sources-list-entry-for-google-chrome-ubuntu-11-10
# >> When you installed chrome it most likely added a file in /etc/apt/sources.list.d/ named google-chrome.list.
# You should remove the line you manually added, and just keep the file that is in there, which is what the chrome package uses.

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
apt-get install -y ttf-* vlc vlc-*
apt-get install -y cpufrequtils cputool hardinfo partitionmanager firmware-linux firmware-linux-free firmware-linux-nonfree unrar
apt-get install -y audacity font-manager libreoffice libreoffice-l10n-ru shutter filezilla gimp xclip libcurl3-dev iceweasel genisoimage florence accountsservice ntp google-chrome-stable
# ADDITIONAL packages
apt-get install -y gwenview synergy quicksynergy
apt-get install -y guake
# KDE packages
apt-get install -y kdegames gtk3-engines-oxygen gtk2-engines-oxygen gtk2-engines-qtcurve kde-l10n-ru plasma-widget-smooth-tasks kde-style-oxygen kde-config-* yakuake kdeconnect ktorrent okular okular-extra-backends clementine libreoffice-kde software-properties-kde lightdm-kde-greeter krusader kruler
# VIRTUAL BOX
apt-get install -y virtualbox-4.3 virtualbox-guest-additions-iso
# add your user to "vboxusers" group
vim /etc/group

# IF YOU NEED unetbootin
# need add repository with wheezy
# 'deb http://ftp.by.debian.org/debian/ wheezy main contrib non-free'

# grub. speedup loading
vim /etc/default/grub
# set the numbers, save
update-grub
update-grub2

# Skype
## download archive from http://www.skype.com/ru/download-skype/skype-for-computer/
dpkg -i {%skype-install-file%}.deb
apt-get install -f

# change gtk styles to qtcurve and copy files after that
sudo cp ~/.gtkrc-2.0 /root/.gtkrc-2.0

# fix pulseaudio
# https://wiki.debian.org/ru/PulseAudio

# SSH
# chmod 0700 {%private-key-ssh-rsa-file-path%}


## DEV tools:
apt-get install -y httpie curl gcc git ssh gitk kdiff3 imagemagick
git config --global user.name "user"
git config --global user.email user@example.com
git config --global core.editor kate
git config --global merge.tool kdiff3
git config --global push.default simple

# python
apt-get install -y python2.7 python-pip python-setuptools python-virtualenv uild-essential autoconf libtool pkg-config python-opengl python-imaging python-pyrex python-pyside.qtopengl idle-python2.7 qt4-dev-tools qt4-designer libqtgui4 libqtcore4 libqt4-xml libqt4-test libqt4-script libqt4-network libqt4-dbus python-qt4 python-qt4-gl libgle3 python-dev
pip install --upgrade pip
pip install --upgrade virtualenv

# ruby
apt-get install -y ruby ruby-full gem
gem install sass compass hpricot premailer

# nodejs
apt-get install -y node npm
npm i -g n
n stable
npm update -g npm
npm i -g node-gyp
n latest && n stable && n --stable
node-gyp --python /usr/bin/python2.7
npm config set python /usr/bin/python2.7
npm i -g bower express grunt-cli gulp yo knex generator-generator generator-htmlemail forever static-server eslint less

# DOCKER
apt-get install docker.io

# S3 http://s3tools.org/s3cmd-howto
apt-get install s3cmd
# s3cmd --configure
# add %access key% and %secret%

# Apache + Php
# apt-get install -y apache2 apache2-mpm-prefork apache2-utils apache2.2-common libapache2-mod-php5 libapr1 libaprutil1
# NGINX + PHP
apt-get install -y nginx php5 php5-fpm

# MySQL
apt-get install -y libdbd-mysql-perl libdbi-perl libnet-daemon-perl libpq5 mysql-client mysql-common mysql-server mysql-server php5-common php5-mysql phpmyadmin
# MongoDB
# apt-get install -y mongodb mongodb-clients mongodb-server mongodb
# PostgreSQL
# apt-get install -y postgresql pgadmin3 pgadmin3-data pgadmin3-dbg
# passwd postgres
# su postgres
# createuser -sdrP pgdbuser

# ARDUINO
# apt-get install arduino-core arduino arduino-mk
# vim /etc/group
# add "dialout" user into group of your user. restart OS (or logout) !!!!

# JAVA: download from oracle
# apt-get install -y java-package
# make-jpkg ./Program/installed/jdk-8u25-linux-x64.tar.gz #for example

# SCALA SBT
# echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
# apt-get update && apt-get install sbt -y