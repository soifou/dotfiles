# Dotfiles

## About

Personal dotfiles to setup my working environments (home and work).

I'm using [GNU stow](https://www.gnu.org/software/stow/) following conventions by [F-dotfiles](https://github.com/Kraymer/F-dotfiles) and it works pretty damn good.

Dig in through the repo you might find some inspiration.


## Init

1 - Install stow.

2 - Clone this repo:

```sh
$ git clone https://github.com/soifou/dotfiles ~/
$ cd ~/dotfiles
```

3 - Init stow:

```sh
$ echo "--target=$(echo $HOME)\n--verbose" > stow/.stowrc
$ stow stow
```

## Examples


- Add/remove config for vim :

```sh
$ stow vim
$ stow -D vim
```

- Add/remove config for an entire env, ie. @debian:

```sh
$ stow @debian
$ stow -D @debian
```

- Add/remove config for vscode on linux:

```sh
$ stow -d vscode @linux
$ stow -D -d vscode @linux
```

Look at the corresponding folder for more details