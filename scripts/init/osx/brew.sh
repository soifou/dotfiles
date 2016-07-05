#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


# Install Xcode tools
xcode-select --install
# Note: MacVim (and possibly smlnj I'm not quite sure) require a full-blown
# Xcode installation to work

# Install and set up Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum
# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install newest bash and zsh and make zsh the login shell
brew install bash
brew install bash-completion
echo "`brew --prefix`/bin/bash" | sudo tee -a /etc/shells
brew install zsh
echo "`brew --prefix`/bin/zsh" | sudo tee -a /etc/shells
chsh -s "`brew --prefix`/bin/zsh"


brew tap homebrew/versions

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
# brew install homebrew/php/php55 --with-gmp

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
# brew install aircrack-ng
# brew install bfg
# brew install binutils
# brew install binwalk
# brew install cifer
# brew install dex2jar
# brew install dns2tcp
# brew install fcrackzip
# brew install foremost
# brew install hashpump
# brew install hydra
# brew install john
# brew install knock
# brew install netpbm
# brew install nmap
# brew install pngcheck
# brew install socat
# brew install sqlmap
# brew install tcpflow
# brew install tcpreplay
# brew install tcptrace
# brew install ucspi-tcp # `tcpserver` etc.
# brew install xpdf
# brew install xz

# Install other useful binaries.
brew install ack
# brew install dark-mode
brew install fabric
brew install git
brew install diff-so-fancy
brew install gws
# brew install git-lfs
brew install httpie
brew install imagemagick --with-webp
# brew install lua
# brew install lynx
brew install p7zip
# brew install pigz
# brew install pv
brew install rename
# brew install rhino
brew install speedtest_cli
brew install ssh-copy-id
brew install tree
# brew install webkit2png
# brew install zopfli

# Docker stuff
brew install docker
brew install docker-clean
brew install docker-compose
brew install docker-machine
brew install docker-machine-nfs

# Ruby stuff
brew install rbenv ruby-build
eval "$(rbenv init -)"
rbenv install 2.3.1
rbenv global 2.3.1
gem install bundler

# Install Homebrew cask : http://caskroom.io/
brew install caskroom/cask/brew-cask
# Get alternate versions of Casks (e.g. betas, nightly releases, old versions)
brew tap caskroom/versions

# Get Casks that install fonts
brew tap caskroom/fonts
# Install some dev fonts patched in use with powerline
brew cask install font-inconsolata-for-powerline
brew cask install font-source-code-pro font-sauce-code-powerline
brew cask install font-anonymous-pro-for-powerline
brew cask install font-roboto-mono-for-powerline
brew cask install font-ubuntu-mono-powerline

# Install graphical utilities
brew cask install alfred
brew cask install clipmenu
brew cask install flux
brew cask install iterm2

brew cask install sublime-text
brew cask install chromium
brew cask install gimp
brew cask install libreoffice
brew cask install clementine

brew cask install virtualbox

brew cask install transmission
brew cask install slack
brew cask install imagemagick
brew cask install vlc
brew cask install handbrake

# brew cask install google-chrome
# brew cask install google-drive
# brew cask install dropbox
# brew cask install spotify
# brew cask install amethyst
# brew cask install inskape
# brew cask install calibre
# brew cask install fitbit-connect
# brew cask install rcdefaultapp


# Remove outdated versions from the cellar.
brew cleanup