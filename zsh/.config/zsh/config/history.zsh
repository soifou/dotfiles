# History
#-----------------------------------------------------
# https://zsh.sourceforge.io/Doc/Release/Options.html#History
#-----------------------------------------------------
# Vars

HISTFILE="${XDG_DATA_HOME:-~/.local/share}"/zsh/history
HISTFILESIZE=100000
HISTSIZE=120000 # Larger than $SAVEHIST for hist_expire_dups_first to work
SAVEHIST=100000
HISTCONTROL=ignoreboth # Default (ignorespace+ignoredups)
HISTORY_IGNORE="(ls|l|ll|lt|[bf]g|man|pass|kill|exit|reset|clear|cd|cd -|cd ..|cd ../|pwd|date|* --help)"

#-----------------------------------------------------
# Options

setopt bang_hist                 # Treat the '!' character specially during expansion.
setopt extended_history          # Write the history file in the ":start:elapsed;command" format.
setopt hist_beep                 # Beep when accessing nonexistent history.
setopt hist_expire_dups_first    # Expire duplicate entries first when trimming history.
setopt hist_find_no_dups         # Do not display a line previously found.
setopt hist_ignore_all_dups      # Delete old recorded entry if new entry is a duplicate.
setopt hist_ignore_dups          # Don't record an entry that was just recorded again.
setopt hist_ignore_space         # Don't record an entry starting with a space.
setopt hist_no_store             # Do not record `history` command to history
setopt hist_reduce_blanks        # Remove superfluous blanks before recording entry.
setopt hist_save_no_dups         # Don't write duplicate entries in the history file.
setopt hist_verify               # Don't execute immediately upon history expansion.
setopt inc_append_history        # Write to the history file immediately, not when the shell exits.
setopt share_history             # Share history between all sessions.

#-----------------------------------------------------
# Hooks

autoload -Uz add-zsh-hook

# Additional conditions whether to store current entry in history file
function _zshaddhistory_ignore_command {
	local -r line=${1%%$'\n'}
	local -r cmd=${line%% *}

    # Ignore failed commands.
    # This also handle commands starting with environment variables.
    # https://superuser.com/a/902508
    local j=1
    while ([[ ${${(z)1}[$j]} == *=* ]]) {
        ((j++))
    }
    whence ${${(z)1}[$j]} >| /dev/null || return 1

    # Ignore short commands
    [[ ${#line} -lt 5 ]] && return 1

    # Ignore trivial flags commands
    # [[ $line == *--(help|version) ]] && return 1

    # Ignore blacklist commands
    (( $+histignore[(r)${cmd}] )) && return 1

    return 0
}
add-zsh-hook zshaddhistory _zshaddhistory_ignore_command

#-------------------------------------------------------
# Alias

alias history='fc -t "%d/%m/%Y %H:%M:%S" -l'
