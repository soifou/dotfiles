#!/usr/bin/env sh

# XDG official
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"
# XDG non-official
export XDG_LOCAL_HOME="$HOME/.local"
[ -f "$XDG_CONFIG_HOME"/user-dirs.dirs ] && \
    eval "$(sed 's/^[^#].*/export &/g;t' "$XDG_CONFIG_HOME"/user-dirs.dirs)"

## Runtime
[ -z $XDG_RUNTIME_DIR ] && export XDG_RUNTIME_DIR=/tmp
export RXVT_SOCKET="$XDG_RUNTIME_DIR"/urxvtd
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
## Config
export BUNDLE_USER_HOME="$XDG_CONFIG_HOME"/bundle
export COMPOSER_HOME="$XDG_CONFIG_HOME"/composer
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc-2.0
export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/brew/Brewfile"
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME"/httpie
export LESSKEYIN="$XDG_CONFIG_HOME"/less/lesskey
export MEDNAFEN_HOME="$XDG_CONFIG_HOME"/mednafen
export MR_CONFIG="$XDG_CONFIG_HOME/myrepos/config"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PACKER_CONFIG_DIR="$XDG_CONFIG_HOME"/packer
export RAINFROG_CONFIG="$XDG_CONFIG_HOME"/rainfrog
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/ripgrep/rc
export WAKATIME_HOME="$XDG_CONFIG_HOME"/wakatime
export WGETRC="$XDG_CONFIG_HOME"/wget/wgetrc
export XINITRC="$XDG_CONFIG_HOME"/x/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/x/xserverrc
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
## Cache
export ANSIBLE_CACHE_PLUGINS="$XDG_CACHE_HOME"/ansible/plugins
export ANSIBLE_LOCAL_TEMP="$XDG_CACHE_HOME"/ansible/tmp
export ANSIBLE_REMOTE_TEMP=/var/tmp/ansible
export ANSIBLE_SSH_CONTROL_PATH_DIR="$XDG_CACHE_HOME"/ansible/cp
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export COMPOSER_CACHE_DIR="$XDG_CACHE_HOME"/composer
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export NOVACLIENT_UUID_CACHE_DIR="$XDG_CACHE_HOME"/novaclient
export PACKER_CACHE_DIR="$XDG_CACHE_HOME"/packer
export RANDFILE="$XDG_CACHE_HOME"/rnd
export YARN_CACHE_FOLDER="$XDG_CACHE_HOME"/yarn
## Data
export ANSIBLE_HOME="$XDG_DATA_HOME"/ansible
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export GEM_HOME="$XDG_DATA_HOME"/gem
export KODI_DATA="$XDG_DATA_HOME"/kodi
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/password-store
export PASSWORD_STORE_ENABLE_EXTENSIONS=true
export VAGRANT_HOME="$XDG_DATA_HOME"/vagrant
export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode
export XCURSOR_PATH=${XCURSOR_PATH}:$XDG_DATA_HOME/icons
## State
export LESSHISTFILE="$XDG_STATE_HOME"/less/history
export MPD_HOST="$XDG_STATE_HOME"/mpd/socket

## Default programs
export BROWSER=firefox
export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=kitty
export URLVIEWER=urlpicker

# Use nvim while navigating into manpages
# `gO` opens the TOC
# `K` or `C-]` navigate to corresponding man under cursor
export MANPAGER="nvim --noplugin -i $XDG_STATE_HOME/nvim/shada/man.shada -c 'unlet! g:loaded_man' -c 'runtime! plugin/man.lua' +Man!"
export MANWIDTH=80

export GREP_COLORS="mt=30;43"
export BC_ENV_ARGS="-q"
export GIT_PAGER=delta

export FZF_DEFAULT_OPTS="
    --prompt 'λ ' --marker │ --pointer ▌ --separator ─ --scrollbar │
    --preview-window=border-thinblock
    --info=inline-right
    --no-mouse
    --layout=reverse
    --cycle
    --bind ctrl-q:abort,ctrl-z:ignore
    --bind ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up
    --bind ctrl-f:half-page-down,ctrl-b:half-page-up
    --bind ctrl-h:backward-char,ctrl-l:forward-char
    --bind ctrl-e:change-preview-window\(down\|hidden\|\)
    --bind ctrl-a:toggle-all
    --color fg:8,fg+:7,bg:-1,bg+:-1,hl:4,hl+:4
    --color info:8,prompt:7,spinner:1,pointer:1,marker:1,border:4,gutter:-1
"

case $OSTYPE in
    darwin*)
        export HOMEBREW_PREFIX=/opt/homebrew
        export FONTCONFIG_PATH=$HOMEBREW_PREFIX/etc/fonts
    ;;
    *) export HOMEBREW_PREFIX="$XDG_DATA_HOME"/brew ;;
esac

export LS_COLORS="
rs=0:di=1;34:ln=0;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:
"
export JQ_COLORS='1;4;31:1;31:1;37:0;35:1;36:0;33:0;34:0;34'
export GCC_COLORS="error=31:warning=38;5;208:note=34:caret=32:locus=37:quote=36"

export XCURSOR_THEME=capitaine-cursors

export VAGRANT_DEFAULT_PROVIDER=libvirt
export LIBVIRT_DEFAULT_URI='qemu:///system'

export DOCKER_BUILDKIT=1
export BUILDKIT_PROGRESS=auto

export ANSIBLE_CONFIG=$XDG_DEVELOP_DIR/$USER/ansible/sandbox/ansible.cfg
export ANSIBLE_VAULT_PASSWORD_FILE=$XDG_LOCAL_HOME/bin/ansible-vault-pass
export ANSIBLE_VAULT_IDENTITY_LIST=soifou@$ANSIBLE_VAULT_PASSWORD_FILE
export ANSIBLE_HOST_KEY_CHECKING=False

export WALLPAPER_PATH=$XDG_PICTURES_DIR/wallpapers
export SCREENSHOT_PATH=$XDG_PICTURES_DIR/screenshots

# For OS specific environment variables, see ~/.config/zsh/profile.d/private.zsh
