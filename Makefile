.SILENT:
.PHONY: init install uninstall

init:
	echo "--target=$$(echo $$HOME)\n--verbose" > .stowrc
	stow stow

install: init
	stow @debian
	stow atom
	stow bin
	stow bundler
	stow composer
	stow fasd
	stow git
	stow phpcs
	stow pip
	stow ripgrep
	stow vim
	stow wget
	stow yamllint
	stow zsh
	stow -d vscode @linux
	stow -d sublime @linux

uninstall:
	stow -D @debian
	stow -D atom
	stow -D bin
	stow -D bundler
	stow -D composer
	stow -D fasd
	stow -D git
	stow -D phpcs
	stow -D pip
	stow -D ripgrep
	stow -D vim
	stow -D wget
	stow -D yamllint
	stow -D zsh
	stow -D -d vscode @linux
	stow -D -d sublime @linux
