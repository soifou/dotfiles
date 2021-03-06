.SILENT:
.PHONY: init install uninstall

OS := $(shell cat /etc/issue | awk -F" " '{print $$1}' | sed 's/./\L&/g')

init: .stowrc
	echo "--target=$$(echo $$HOME)" > .stowrc
	echo "--verbose" >> .stowrc

install: init
	stow @$(OS)
	stow bat
	stow bin
	stow bundler
	stow composer
	stow git
	stow lf
	stow myrepos
	stow ncmpcpp
	stow newsboat
	stow phpcs
	stow pip
	stow ripgrep
	stow rtv
	stow ssh
	stow -d sublime @linux
	stow w3m
	stow wget
	stow yamllint
	stow yarn
	stow zsh

uninstall:
	stow -D @$(OS)
	stow -D bat
	stow -D bin
	stow -D bundler
	stow -D composer
	stow -D git
	stow -D lf
	stow -D myrepos
	stow -D ncmpcpp
	stow -D newsboat
	stow -D phpcs
	stow -D pip
	stow -D ripgrep
	stow -D rtv
	stow -D ssh
	stow -D -d sublime @linux
	stow -D w3m
	stow -D wget
	stow -D yamllint
	stow -D yarn
	stow -D zsh
