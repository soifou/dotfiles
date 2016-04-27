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
# disable src repos

# add new repos
apt-get install -y python-software-properties software-properties-common apt-transport-https
apt-add-repository 'deb http://manpages.ylsoftware.com/debian/ all main'
apt-add-repository 'deb http://dl.google.com/linux/chrome/deb/ stable main'
apt-add-repository 'deb http://www.deb-multimedia.org wheezy main non-free'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
dpkg --add-architecture i386
apt-get update

# debian multimedia
wget http://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2015.6.1_all.deb
dpkg -i deb-multimedia-keyring_2015.6.1_all.deb
rm deb-multimedia-keyring_2015.6.1_all.deb

# create user
useradd -s /bin/bash -m -d /home/user -g sudo user -p XXXXXXXX

# SUDO
apt-get install -y sudo kdesu gksu
vim /etc/sudoers
# at EOF
# user ALL=(ALL) NOPASSWD: ALL

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
apt-get install -y audacity font-manager libreoffice libreoffice-l10n-ru shutter filezilla gimp xclip libcurl3-dev iceweasel genisoimage florence accountsservice ntp
# ADDITIONAL packages
apt-get install -y gwenview synergy quicksynergy
apt-get install -y guake
# KDE packages
apt-get install -y kdegames gtk3-engines-oxygen gtk2-engines-oxygen gtk2-engines-qtcurve kde-l10n-ru plasma-widget-smooth-tasks kde-style-oxygen kde-config-* yakuake kdeconnect ktorrent okular okular-extra-backends clementine libreoffice-kde software-properties-kde lightdm-kde-greeter krusader kruler

# virtualbox 5
# https://www.virtualbox.org/wiki/Linux_Downloads#Debian-basedLinuxdistributions
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian `lsb_release -c | awk '"'"'{print $2}'"'"'` contrib" > /etc/apt/sources.list.d/virtualbox.list'
apt-get update
apt-get install dkms virtualbox-5.0
# add your user to "vboxusers" group
usermod -aG vboxusers user

# IF YOU NEED unetbootin
# need add repository with wheezy
# 'deb http://ftp.by.debian.org/debian/ wheezy main contrib non-free'

# grub. speedup loading
vim /etc/default/grub
# set the numbers, save
update-grub
update-grub2


# change gtk styles to qtcurve and copy files after that
#sudo cp ~/.gtkrc-2.0 /root/.gtkrc-2.0

# SSH
# chmod 0700 {%private-key-ssh-rsa-file-path%}

# DEV TOOLS
apt-get install -y build-essential curl git ssh kdiff3-qt ack-grep

# PYTHON
apt-get install -y python-pip
pip install --upgrade pip
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
# source $HOME/.zshrc
pyenv install 2.7.9
pyenv local 2.7.9
# pip install [package1]

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

# NODEJS
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
apt-get purge lxc-docker* docker.io*
apt-get update
apt-get install -y apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo deb https://apt.dockerproject.org/repo debian-jessie main >> /etc/apt/source.list.d/docker.list
apt-get install docker-engine
usermod -aG docker <your_username>
service docker start

# HIPCHAT
echo "deb http://downloads.hipchat.com/linux/apt stable main" > \
    /etc/apt/sources.list.d/atlassian-hipchat.list
wget -O - https://www.hipchat.com/keys/hipchat-linux.key | apt-key add -
apt-get update
apt-get -y install hipchat

# CHROMIUM
sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
apt-get update
apt-get install -y google-chrome-stable

# FLUX
add-apt-repository ppa:kilian/f.lux
apt-get update
apt-get -y install fluxgui
# TODO: Add flux to list of startup applications