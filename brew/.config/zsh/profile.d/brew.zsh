#!/usr/bin/env zsh

if [ -d "$HOMEBREW_PREFIX" ]; then
    export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"

    case $OSTYPE in
        darwin*)
            # prefer GNU utils when available
            for i in $(fd -t d --base-directory $HOMEBREW_PREFIX/Cellar gnubin | awk -F/ '{print $1}'); do
                export PATH="$HOMEBREW_PREFIX/opt/$i/libexec/gnubin:$PATH"
            done
            # For weird reasons, m4 from XCode on Sonoma must be used with brew:
            # See: https://github.com/facebookincubator/velox/issues/9190#issuecomment-2013730188
            # or https://github.com/facebookincubator/velox/pull/9717/files
            export PATH="$HOMEBREW_PREFIX/opt/m4/bin:$PATH"
        ;;
    esac
fi

