.SILENT:
.PHONY: init install uninstall

OS := $(shell cat /etc/issue | awk -F" " '{print $$1}' | sed 's/./\L&/g')

init: .stowrc
	echo "--target=$$(echo $$HOME)" > .stowrc
	echo "--verbose" >> .stowrc

install: init
	stow @$(OS)
	stow bat
	stow beets
	stow bin
	stow bundler
	stow composer
	stow feh
	stow git
	stow gnupg
	stow kitty
	stow lf
	stow lftp
	stow mpv
	stow mpd
	stow myrepos
	stow npm
	stow nsxiv
	stow ncmpcpp
	stow newsboat
	stow phpcs
	stow pip
	stow ripgrep
	stow rtv
	stow ssh
	stow -d sublime @linux
	stow tremc
	stow w3m
	stow wezterm
	stow wget
	stow yamllint
	stow yarn
	stow zsh

uninstall:
	stow -D @$(OS)
	stow -D bat
	stow -D beets
	stow -D bin
	stow -D bundler
	stow -D composer
	stow -D feh
	stow -D git
	stow -D gnupg
	stow -D kitty
	stow -D lf
	stow -D lftp
	stow -D mpv
	stow -D mpd
	stow -D myrepos
	stow -D npm
	stow -D nsxiv
	stow -D ncmpcpp
	stow -D newsboat
	stow -D phpcs
	stow -D pip
	stow -D ripgrep
	stow -D rtv
	stow -D ssh
	stow -D -d sublime @linux
	stow -D tremc
	stow -D w3m
	stow -D wget
	stow -D wezterm
	stow -D yamllint
	stow -D yarn
	stow -D zsh
