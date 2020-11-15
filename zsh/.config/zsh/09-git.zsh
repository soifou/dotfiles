#!/usr/bin/env sh

## Env

# git-delta: https://github.com/dandavison/delta/
command -v delta >/dev/null && {
    export GIT_PAGER="delta -n -s --syntax-theme=ansi-dark \
        --hunk-header-style='syntax bold' \
        --hunk-header-decoration-style='black box' \
        --file-style='yellow italic' \
        --file-decoration-style='yellow ul' \
        --minus-style='syntax #450a15' \
        --minus-emph-style='syntax #600818' \
        --plus-style='syntax #0b4820' \
        --plus-emph-style='syntax #175c2e' \
        --line-numbers-zero-style='#4b5263' \
        --line-numbers-minus-style='syntax #600818' \
        --line-numbers-plus-style='syntax #0b4820' \
        --line-numbers-left-format='{nm:^4} ' \
        --line-numbers-right-format='{np:^4}  '
    "
}

## Aliases
alias gaa='git add --all'
alias gba='git branch -a'
alias gcam='git commit -a -m'
alias gcb='git checkout -b'
alias gcd='git checkout develop'
alias gcm='git checkout master'
alias gcmsg='git commit -m'
alias gd='git diff'
alias gdd="git difftool --no-symlinks --dir-diff"
alias gl='git pull'
alias gp='git push'
alias grh='git reset --hard'
alias gst='git status'
## below are those from git aliases
alias ga='git af'
alias gbd='git bd'
alias gco='git co'
alias gcp='git cp'
alias gh='git h'
alias gm='git bm'
