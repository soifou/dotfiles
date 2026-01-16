#!/usr/bin/env zsh

# Go to the root folder of a git repository
alias cwd='cd "$(git rev-parse --show-toplevel)"'

alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch -a'
alias gcam='git commit -a -m'
alias gcb='git checkout -b'
alias gco='git checkout'
gcm() {
    for branch in main master; do
        if git show-ref --verify --quiet refs/heads/$branch; then
            git checkout $branch
            return 0
        fi
    done
    echo "Error: no main/master branch here" >&2
    exit 1
}
alias gcmsg='git commit -m'
alias gd='git diff'
alias gdd="git difftool --no-symlinks --dir-diff"
alias gl='git pull'
alias gp='git push'
alias grh='git reset --hard'

# Git status lacks hyperlink support
command -v add-osc-8-hyperlink > /dev/null && {
    gst() { git -c color.status=always status "$@" | add-osc-8-hyperlink; }
} || alias gst='git status'

## Alias of git aliases, declared in ~/.config/git/conf.d/aliases
alias gbd='git bd'                   # delete branch(es)
alias gcp='git cp'                   # cherry-pick
alias grl='git rl "border-left"'     # show commits from current remote branch that have been fetched
alias ghh='git h "border-left"'      # show commits history (vertical)
alias ghv='git h "down,border-top"'  # show commits history (horizontal)
alias gfh='git hf "border-left"'     # show commits history for particular file (vertical)
alias gfv='git hf "down,border-top"' # show commits history for particular file (horizontal)
alias gm='git bm'                    # merge branch to current
alias gmg='git mg'                   # list merged branch(es)
alias gmgd='git mgd'                 # delete merged branch(es)
