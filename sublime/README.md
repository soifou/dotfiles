# Sublime Text 3

## Overview

- File/project/gist managers
- Linters
- Formatters
- Material theme

## Prerequisites

- Install Sublime text.
- Install Package control.

You can install it with this make command.

```
$ make
```

SublimeLinter 4 is imminent but not yet released. My config depend on it.

```
$ make linter
```

## Configuration

Symlink the config for the desired env:

```
$ stow @linux
or
$ stow @osx
```

Open Sublime and wait it fetchs all packages.
Look at the console to see what's going on.
