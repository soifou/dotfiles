.SILENT:
.PHONY: init install uninstall

OS := $(shell cat /etc/issue | awk -F" " '{print $$1}' | sed 's/./\L&/g')

init:
	echo "--target=$$(echo $$HOME)" > .stowrc
	echo "--verbose" >> .stowrc

install: init
	stow bat
	stow beets
	stow bin
	stow brew
	stow bundler
	stow composer
	stow fontconfig
	stow git
	stow gnupg
	stow greenclip
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
	stow php-cs-fixer
	stow pip
	stow polybar
	stow ripgrep
	stow rofi
	stow rtv
	stow mise
	stow ssh
	stow tremc
	stow tridactyl
	stow w3m
	stow weechat
	stow wezterm
	stow wget
	stow xdg
	stow yamllint
	stow yarn
	stow zathura
	stow zsh
	stow @$(OS) --override=".*"

uninstall:
	stow -D bat
	stow -D beets
	stow -D bin
	stow -D brew
	stow -D bundler
	stow -D composer
	stow -D fontconfig
	stow -D git
	stow -D gnupg
	stow -D greenclip
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
	stow -D php-cs-fixer
	stow -D pip
	stow -D polybar
	stow -D ripgrep
	stow -D rofi
	stow -D rtv
	stow -D mise
	stow -D ssh
	stow -D tremc
	stow -D tridactyl
	stow -D w3m
	stow -D weechat
	stow -D wezterm
	stow -D wget
	stow -D xdg
	stow -D yamllint
	stow -D yarn
	stow -D zathura
	stow -D zsh
	stow -D @$(OS)
