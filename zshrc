# Explicitly configured $PATH variable
PATH=/usr/local/git/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/local/bin:/opt/local/sbin:/usr/X11/bin

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each time that oh-my-zsh is loaded.
#ZSH_THEME="random"
ZSH_THEME="lukerandall"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(ssh-agent rails git textmate ruby lighthouse)
plugins=(git debian symfony2 capistrano vagrant sublime composer zsh-syntax-highlighting repo sudo bundler web-search)

source $ZSH/oh-my-zsh.sh

# Put any proprietary or private functions/values in ~/.private, and this will source them
if [ -f $HOME/.private ]; then
  source $HOME/.private
fi

if [ -f $HOME/.profile ]; then
  source $HOME/.profile  # Read Mac .profile, if present.
fi

# enable agent forwarding support
# zstyle :omz:plugins:ssh-agent agent-forwarding on
#
# load multiple identities use the identities style
# zstyle :omz:plugins:ssh-agent identities id_dsa id_rsa
#
# set the maximum lifetime of the identities, use the lifetime style. 
# The lifetime may be specified in seconds or as described in sshd_config(5) (see TIME FORMATS)
# If left unspecified, the default lifetime is forever.
# zstyle :omz:plugins:ssh-agent lifetime 4h

# Shell Aliases
## Git Aliases
# alias gs='git status '
# alias ga='git add '
# alias gb='git branch '
# alias gc='git commit'
# alias gd='git diff'
# alias go='git checkout '
# alias gk='gitk --all&'
# alias gx='gitx --all'
# alias got='git '
# alias get='git '

## Vagrant Aliases
# alias vag='vagrant'
# alias vagup='vagrant up'
# alias vagdestroy='vagrant destroy'
# alias vagssh='vagrant ssh'
# alias vaghalt='vagrant halt'

## Miscellaneous Aliases
alias htop='sudo htop'

# Shell Functions
# qfind - used to quickly find files that contain a string in a directory
qfind () {
  find . -exec grep -l -s $1 {} \;
  return 0
}

# Custom exports
## Set EDITOR to /usr/bin/vim if Vim is installed
if [ -f /usr/bin/vim ]; then
  export EDITOR=/usr/bin/vim
fi
