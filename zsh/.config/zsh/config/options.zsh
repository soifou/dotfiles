#!/usr/bin/env zsh

#-----------------------------------------------------
# Params: man zshparam

# List of non-alphanumeric chars considered part of a word
WORDCHARS=
# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
KEYTIMEOUT=1

#-----------------------------------------------------
# Option: man zshoptions
# Online version: https://zsh.sourceforge.io/Doc/Release/Options.html

setopt auto_cd                   # Change directory when just a path is entered
setopt globdots                  # Lets files beginning with a . be matched without explicitly specifying the dot.
setopt no_flow_control           # Disable start (C-s) and stop (C-q)
setopt ignore_eof                # Do not exit on end-of-file (C-d). Require the use of exit or logout instead
setopt interactivecomments       # Allow comments
