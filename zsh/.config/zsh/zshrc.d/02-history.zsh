#-----------------------------------------------------
# Vars
HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTFILESIZE=100000
HISTSIZE=10000
SAVEHIST=10000
# HISTCONTROL=ignoreboth

HISTIGNORE='history:man:run-help'
typeset -gT HISTIGNORE histignore

#-----------------------------------------------------
# Options
setopt bang_hist                 # Treat the '!' character specially during expansion.
setopt extended_history          # Write the history file in the ":start:elapsed;command" format.
setopt inc_append_history        # Write to the history file immediately, not when the shell exits.
setopt share_history             # Share history between all sessions.
setopt hist_expire_dups_first    # Expire duplicate entries first when trimming history.
setopt hist_ignore_dups          # Don't record an entry that was just recorded again.
setopt hist_ignore_all_dups      # Delete old recorded entry if new entry is a duplicate.
setopt hist_find_no_dups         # Do not display a line previously found.
setopt hist_ignore_space         # Don't record an entry starting with a space.
setopt hist_save_no_dups         # Don't write duplicate entries in the history file.
setopt hist_reduce_blanks        # Remove superfluous blanks before recording entry.
setopt hist_verify               # Don't execute immediately upon history expansion.
setopt hist_beep                 # Beep when accessing nonexistent history.

#-----------------------------------------------------
# Hooks

autoload -Uz add-zsh-hook

# Choose what to store in history
function _zshaddhistory_ignore_command {
	emulate -L zsh
	local -r line=${1%%$'\n'}
	local -r cmd=${line%% *}

    # ${#line} -ge 5
    # $line != *--(help|version)
    # $line != (git status|git graph)
    # ${cmd} != (l[sal])

    # Only a known command
    if whence ${${(z)1}[1]} >| /dev/null; then
        # That does not belong to histignore list
        if (( $+histignore[(r)${cmd}] )); then
            return 1
        fi
    else
        return 1
    fi
}
add-zsh-hook zshaddhistory _zshaddhistory_ignore_command
