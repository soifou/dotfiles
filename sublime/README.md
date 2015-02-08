My Sublime Text configuration files
========

Overview
--------
- Keymap shortcuts to look into website API languages or frameworks (see `open_browser/` folder)
- Custom settings for the editor himself (theme, font, settings)
- Config of my installed plugins
- Auto-completion for my daily languages

Requirements
------------
- [Sublime Text]
- [Sublime Package]
- [Source Code Pro font]

Installation
------------

[Source Code Pro font]
``` bash
$ wget https://github.com/adobe-fonts/source-code-pro/archive/1.017R.zip
$ unzip 1.017R.zip && cd source-code-pro-1.017R
# mkdir -p /usr/share/fonts/truetype/source-code-pro
# cp *.ttf /usr/share/fonts/truetype/source-code-pro/
# fc-cache
```

Then install [Sublime Text] and [Sublime Package]

Finally, install my config
``` bash
cd ~/dotfiles/sublime
chmod +x install.sh
./install.sh
```

[Sublime Text]: http://www.sublimetext.com/
[Sublime Package]: https://sublime.wbond.net/installation
[Source Code Pro font]: https://github.com/adobe-fonts/source-code-pro