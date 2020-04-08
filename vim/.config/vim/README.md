# Vim with partial XDG support

See: https://tlvince.com/vim-respect-xdg

In order to get this config work, add these env variable to your xinit/shellrc:

```sh
export VIMDOTDIR="$XDG_CONFIG_HOME"/vim
export VIMINIT='set rtp^=$VIMDOTDIR | let $MYVIMRC="$VIMDOTDIR/vimrc" | so $MYVIMRC'
```
