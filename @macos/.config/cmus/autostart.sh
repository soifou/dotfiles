#!/bin/sh

# Add notification for macOS (https://github.com/PhilipTrauner/cmus-osx)
# @NOTE: if your using pyenv, build python with option --enable-framework
# export PYTHON_CONFIGURE_OPTS="--enable-framework"
# pyenv install 3.6.4
$HOME/.config/cmus/cmus-osx/notify.py "$@" &
