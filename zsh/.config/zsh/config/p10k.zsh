# Temporarily change options.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
    emulate -L zsh -o extended_glob

    # Unset all configuration options.
    unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

    # Prompt colors.
    local red=1
    local green=2
    local yellow=3
    local blue=4
    local magenta=5
    local cyan=6
    local white=7
    local grey=15

    # Left prompt segments.
    typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
        # =========================[ Line #1 ]=========================
        context                   # user@host
        dir                       # current directory
        vcs                       # git status
        background_jobs           # presence of background jobs
        # =========================[ Line #2 ]=========================
        newline                   # \n
        prompt_char               # prompt symbol
    )

    # Right prompt segments.
    typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
        # =========================[ Line #1 ]=========================
        command_execution_time    # previous command duration
        time                      # current time
        # =========================[ Line #2 ]=========================
        newline                   # \n
    )

    # Basic style options that define the overall prompt look.
    typeset -g POWERLEVEL9K_BACKGROUND=                            # transparent background
    typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=  # no surrounding whitespace
    typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '  # separate segments with a space
    typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=        # no end-of-line symbol
    typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION=           # no segment icons

    # Defines character set used by powerlevel10k. It's best to let `p10k configure` set it for you.
    typeset -g POWERLEVEL9K_MODE=nerdfont-v3
    # When set to `moderate`, some icons will have an extra space after them. This is meant to avoid
    # icon overlap when using non-monospace fonts. When set to `none`, spaces are not added.
    typeset -g POWERLEVEL9K_ICON_PADDING=moderate

    # Add an empty line before each prompt except the first. This doesn't emulate the bug
    # in Pure that makes prompt drift down whenever you use the Alt-C binding from fzf or similar.
    typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

    # Enable kitty terminal-shell integration in Powerlevel10k
    typeset -g POWERLEVEL9K_TERM_SHELL_INTEGRATION=true
    ################################[ prompt_char: prompt symbol ]################################

    # Magenta prompt symbol if the last command succeeded.
    typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS}_FOREGROUND=$magenta
    # Red prompt symbol if the last command failed.
    typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS}_FOREGROUND=$red
    # Default prompt symbol.
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='λ'
    # Prompt symbol in command vi mode.
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='λ' # ❯
    # Prompt symbol in visual vi mode is the same as in command mode.
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='❮'
    # Prompt symbol in overwrite vi mode is the same as in command mode.
    typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=false

    ##################################[ dir: current directory ]##################################

    typeset -g POWERLEVEL9K_DIR_FOREGROUND=$blue
    typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=$green
    typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
    # If directory is too long, shorten some of its segments to the shortest possible unique
    # prefix. The shortened directory can be tab-completed to the original.
    typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique

    # Context format when root: user@host. The first part white, the rest grey.
    typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE="%F{$white}%n%f%F{$grey}@%m%f"
    # Context format when not root: user@host. The whole thing grey.
    typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE="%F{$grey}%n@%m%f"
    # Don't show context unless root or in SSH.
    typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_CONTENT_EXPANSION=

    ###################[ command_execution_time: duration of the last command ]###################

    # Show previous command duration only if it's >= 5s.
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=5
    # Don't show fractional seconds. Thus, 7s rather than 7.3s.
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
    # Duration format: 1d 2h 3m 4s.
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
    # Yellow previous command duration.
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$yellow

    #######################[ background_jobs: presence of background jobs ]#######################
    # Show the number of background jobs.
    typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=true
    # Background jobs color.
    typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=6
    # Custom icon.
    typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VISUAL_IDENTIFIER_EXPANSION=''

    #####################################[ vcs: git status ]######################################
    # Custom formatter for Git status.
    #
    # VCS_STATUS_* parameters are set by gitstatus plugin. See reference:
    # https://github.com/romkatv/gitstatus/blob/master/gitstatus.plugin.zsh.
    function _git_formatter() {
        emulate -L zsh

        if [[ -n $P9K_CONTENT ]]; then
            # If P9K_CONTENT is not empty, use it. It's either "loading" or from vcs_info (not from
            # gitstatus plugin). VCS_STATUS_* parameters are not available in this case.
            typeset -g _git_format=$P9K_CONTENT
            return
        fi

        if (( $1 )); then
            # Styling for up-to-date Git status.
            local meta='%f'
            local red='%1F'
            local green='%2F'
            local yellow='%3F'
            local blue='%4F'
            local magenta='%5F'
            local cyan='%6F'
            local white='%7F'
            local grey='%15F'
        else
            # Styling for incomplete and stale Git status.
            local meta='%f'
            local red='%f'
            local green='%f'
            local yellow='%f'
            local blue='%f'
            local magenta='%f'
            local cyan='%f'
            local white='%f'
            local grey='%f'
        fi

        local res
        local where  # branch, tag or revision
        if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
            res+="${white}${POWERLEVEL9K_VCS_BRANCH_ICON} "
            where="${(V)VCS_STATUS_LOCAL_BRANCH}"
        elif [[ -n $VCS_STATUS_TAG ]]; then
            res+="${meta}#"
            where="${(V)VCS_STATUS_TAG}"
        elif [[ -n $VCS_STATUS_COMMIT ]]; then
            res+="${meta}@"
            where="${VCS_STATUS_COMMIT[1,8]}"
        fi

        # If local branch name or tag is at most 32 characters long, show it in full.
        # Otherwise show the first 12 … the last 12.
        (( $#where > 32 )) && where[13,-13]="…"
        res+="${grey}${where//\%/%%}"  # escape %

        # Show tracking branch name if it differs from local branch.
        if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} ]]; then
            res+="${meta}:${grey}${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}"  # escape %
        fi

        # ⇣42 if behind the remote.
        (( VCS_STATUS_COMMITS_BEHIND )) && res+=" ${yellow}⇣${VCS_STATUS_COMMITS_BEHIND}"
        # ⇡42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
        (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && res+=" "
        (( VCS_STATUS_COMMITS_AHEAD  )) && res+="${green}⇡${VCS_STATUS_COMMITS_AHEAD}"
        # ⇠42 if behind the push remote.
        (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
        (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" "
        # ⇢42 if ahead of the push remote; no leading space if also behind: ⇠42⇢42.
        (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && res+="${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
        # *42 if have stashes.
        (( VCS_STATUS_STASHES        )) && res+=" ${cyan}*${VCS_STATUS_STASHES}"
        # 'merge' if the repo is in an unusual state.
        [[ -n $VCS_STATUS_ACTION     ]] && res+=" ${red}${VCS_STATUS_ACTION}"
        # ~42 if have merge conflicts.
        (( VCS_STATUS_NUM_CONFLICTED )) && res+=" ${red}~${VCS_STATUS_NUM_CONFLICTED}"
        # +42 if have staged changes.
        (( VCS_STATUS_NUM_STAGED     )) && res+=" ${yellow}+${VCS_STATUS_NUM_STAGED}"
        # !42 if have unstaged changes.
        (( VCS_STATUS_NUM_UNSTAGED   )) && res+=" ${yellow}!${VCS_STATUS_NUM_UNSTAGED}"
        # ?42 if have untracked files.
        (( VCS_STATUS_NUM_UNTRACKED  )) && res+=" ${magenta}?${VCS_STATUS_NUM_UNTRACKED}"
        # "─" if the number of unstaged files is unknown. This can happen due to
        # POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY (see below) being set to a non-negative number lower
        # than the number of files in the Git index, or due to bash.showDirtyState being set to false
        # in the repository config. The number of staged and untracked files may also be unknown
        # in this case.
        (( VCS_STATUS_HAS_UNSTAGED == -1 )) && res+=" ${modified}─"

        typeset -g _git_format=$res
    }
    functions -M _git_formatter 2>/dev/null

    # Disable async loading indicator to make directories that aren't Git repositories
    # indistinguishable from large Git repositories without known state.
    typeset -g POWERLEVEL9K_VCS_LOADING_TEXT=
    # Don't wait for Git status even for a millisecond, so that prompt always updates
    # asynchronously when Git state changes.
    typeset -g POWERLEVEL9K_VCS_MAX_SYNC_LATENCY_SECONDS=0
    # Set branch icon.
    typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=
    # When in detached HEAD state, show @commit where branch normally goes.
    typeset -g POWERLEVEL9K_VCS_COMMIT_ICON='@'
    # Disable the default Git status formatting.
    typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
    # Install our own Git status formatter.
    typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((_git_formatter(1)))+${_git_format}}'
    typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION='${$((_git_formatter(0)))+${_git_format}}'
    # Enable counters for staged, unstaged, etc.
    typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1
    # typeset -g POWERLEVEL9K_VCS_PREFIX='%fon '
    typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)

    # Grey current time.
    typeset -g POWERLEVEL9K_TIME_FOREGROUND=$grey
    # Format for the current time: 09:51:02. See `man 3 strftime`.
    typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
    # If set to true, time will update when you hit enter. This way prompts for the past
    # commands will contain the start times of their commands rather than the end times of
    # their preceding commands.
    typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=true

    # Transient prompt works similarly to the builtin transient_rprompt option. It trims down prompt
    # when accepting a command line. Supported values:
    #
    #   - off:      Don't change prompt when accepting a command line.
    #   - always:   Trim down prompt when accepting a command line.
    #   - same-dir: Trim down prompt when accepting a command line unless this is the first command
    #               typed after changing current working directory.
    typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off

    # Instant prompt mode.
    #
    #   - off:     Disable instant prompt. Choose this if you've tried instant prompt and found
    #              it incompatible with your zsh configuration files.
    #   - quiet:   Enable instant prompt and don't print warnings when detecting console output
    #              during zsh initialization. Choose this if you've read and understood
    #              https://github.com/romkatv/powerlevel10k/blob/master/README.md#instant-prompt.
    #   - verbose: Enable instant prompt and print a warning when detecting console output during
    #              zsh initialization. Choose this if you've never tried instant prompt, haven't
    #              seen the warning, or if you are unsure what this all means.
    typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

    # Hot reload allows you to change POWERLEVEL9K options after Powerlevel10k has been initialized.
    # For example, you can type POWERLEVEL9K_BACKGROUND=red and see your prompt turn red. Hot reload
    # can slow down prompt by 1-2 milliseconds, so it's better to keep it turned off unless you
    # really need it.
    typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

    # If p10k is already loaded, reload configuration.
    # This works even with POWERLEVEL9K_DISABLE_HOT_RELOAD=true.
    (( ! $+functions[p10k] )) || p10k reload
}

# Tell `p10k configure` which file it should overwrite.
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
