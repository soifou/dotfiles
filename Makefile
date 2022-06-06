.SILENT:
.PHONY: init install uninstall

OS := $(shell cat /etc/issue | awk -F" " '{print $$1}' | sed 's/./\L&/g')

init: .stowrc
	echo "--target=$$(echo $$HOME)" > .stowrc
	echo "--verbose" >> .stowrc

install: init
	stow bat
	stow beets
	stow bin
	stow bundler
	stow composer
	stow feh
	stow fontconfig
	stow git
	stow gnupg
	stow kitty
	stow lf
	stow lftp
	stow mail
	stow mpd
	stow mpv
	stow myrepos
	stow ncmpcpp
	stow newsboat
	stow npm
	stow nsxiv
	stow phpcs
	stow pip
	stow pywal
	stow ripgrep
	stow rtv
	stow ssh
	stow -d sublime @linux
	stow tremc
	stow w3m
	stow weechat
	stow wezterm
	stow wget
	stow xdg
	stow yamllint
	stow yarn
	stow zsh
	stow @$(OS) --override=".*"

uninstall:
	stow -D bat
	stow -D beets
	stow -D bin
	stow -D bundler
	stow -D composer
	stow -D feh
	stow -D fontconfig
	stow -D git
	stow -D gnupg
	stow -D kitty
	stow -D lf
	stow -D lftp
	stow -D mail
	stow -D mpd
	stow -D mpv
	stow -D myrepos
	stow -D ncmpcpp
	stow -D newsboat
	stow -D npm
	stow -D nsxiv
	stow -D phpcs
	stow -D pip
	stow -D pywal
	stow -D ripgrep
	stow -D rtv
	stow -D ssh
	stow -D -d sublime @linux
	stow -D tremc
	stow -D w3m
	stow -D weechat
	stow -D wezterm
	stow -D wget
	stow -D xdg
	stow -D yamllint
	stow -D yarn
	stow -D zsh
	stow -D @$(OS)
