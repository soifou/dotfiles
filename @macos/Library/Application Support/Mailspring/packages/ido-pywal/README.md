# Mailspring theme with pywal

This theme is a fork from [mailspring-idido](https://github.com/NeoMahler/mailspring-idido).
I adapted the colors to get those generated from [Pywal](https://github.com/dylanaraps/pywal)

## Installation

I assume you have already installed pywal and get used to it.

Create a colors.less file in `~/.config/wal/templates/colors.less`:

```less
   1   │ // Special
   2   │ @background: {background};
   3   │ @foreground: {foreground};
   4   │
   5   │ // Colors
   6   │ @color0: {color0};
   7   │ @color1: {color1};
   8   │ @color2: {color2};
   9   │ @color3: {color3};
  10   │ @color4: {color4};
  11   │ @color5: {color5};
  12   │ @color6: {color6};
  13   │ @color7: {color7};
  14   │ @color8: {color8};
  15   │ @color9: {color9};
  16   │ @color10: {color10};
  17   │ @color11: {color11};
  18   │ @color12: {color12};
  19   │ @color13: {color13};
  20   │ @color14: {color14};
  21   │ @color15: {color15};
```

Regenerate theme and symlink colors.less file:

```sh
$ wal -R
$ ln -sf styles/colors-wal.less $HOME/.cache/wal/colors.less
```

Open Mailspring.
