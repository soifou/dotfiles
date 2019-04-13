.SILENT:
.PHONY: init install uninstall

init:
	echo "--target=$$(echo $$HOME)\n--verbose" > stow/.stowrc
	stow stow

install: init
	stow @linux
	stow atom
	stow bin
	stow bundler
	stow composer
	stow git
	stow phpcs
	stow pip
	stow ripgrep
	stow vim
	stow yamllint
	stow zsh
	stow -d vscode @linux
	stow -d sublime @linux

uninstall:
	stow -D @linux
	stow -D atom
	stow -D bin
	stow -D bundler
	stow -D composer
	stow -D phpcs
	stow -D pip
	stow -D ripgrep
	stow -D vim
	stow -D yamllint
	stow -D zsh
	stow -D -d vscode @linux
	stow -D -d sublime @linux
