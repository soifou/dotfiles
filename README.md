# Dotfiles

## About

Personal dotfiles to setup my working environments (home and work) using [GNU
stow](https://www.gnu.org/software/stow/).

## Spec

|             | Linux         | macOS        |
| ----------- | ------------- | ------------ |
| WM / hotkey | bspwm / sxhkd | yabai / skhd |
| Shell       | zsh           |              |
| Terminal    | kitty         |              |
| Bar         | polybar       | builtin      |
| Browser     | firefox       |              |
| Editor      | vim / neovim  |              |
| Launcher    | rofi          | choose-gui   |
| Notifier    | wired-notify  | builtin      |
| Themer      | wallust       |              |
| Mail        | neomutt       |              |
| Music       | mpd / rmpc    |              |
| Video       | mpv / ModernZ |              |
| Image       | nsxiv         | qview        |
| PDF         | zathura       |              |
| Filemanager | yazi          |              |
| Clipboard   | clipcat       |              |

## Init

```sh
git clone https://github.com/soifou/dotfiles ~/
cd ~/dotfiles
echo "--target=$(echo $HOME)\n--verbose" >.stowrc
```

## Examples

- Add/remove config for vim :

```sh
stow vim
stow -D vim
```

- Add/remove config for an entire env, ie. @debian:

```sh
stow @debian
stow -D @debian
```

- Add/remove config for vscode on linux:

```sh
stow -d vscodium @linux
stow -D -d vscodium @linux
```

Look at the corresponding folders for more details.
