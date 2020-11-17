# Debian and X11

```
$ xinit [i3|bspwm|bsp]
```

## Order of execution

In the Debian system, what many people traditionally put in the `.xinitrc` should go in `.xsession` instead.

1 - xinitrc
2 - xsessionrc
3 - xprofile
4 - xsession

## Unclutter home folder

Some filepaths are hardcoded in the init shell script of Debian.
The only way I found is to changed those harcoded values in `/etc/X11/Xsession`:

```sh
USRRESOURCES=$XDG_CONFIG_HOME/x/Xresources
USERXSESSION=$XDG_CONFIG_HOME/x/xsession
USERXSESSIONRC=$XDG_CONFIG_HOME/x/xsessionrc
ERRFILE=$XDG_CACHE_HOME/xsession-errors
```

And commented an else condition in `/etc/X11/Xsession.d/20x11-common_process-args` to avoid to be prompt for a not found WM alias:

```sh
*)
    # Specific program was requested.
    STARTUP_FULL_PATH=$(/usr/bin/which "${1%% *}" || true)
    if [ -n "$STARTUP_FULL_PATH" ] && [ -e "$STARTUP_FULL_PATH" ]; then
        ...
    #else
    #  message "unable to launch \"$1\" X session ---" \
    #          "\"$1\" not found; falling back to default session."
    fi
;;
```

## Display Manager (DM)

If a new Xorg session is started from a DM, `XDG_SESSION_TYPE` will be set to x11.
At least this is the case for my current DM [ly](https://github.com/nullgemm/ly), a TUI display manager.
Otherwise, starting from shell directly, it will be set to TTY.

Ly needs 2 additional steps:
1 - xinitc must have executable permissions (chmod +x)
2 - shell init

See xinitrc.

Links:

-   https://www.sitepoint.com/understanding-nix-login-scripts
