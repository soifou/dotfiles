# prompt string to display, for regular users
export PROMPT_CHAR="λ"
export PROMPT_CHAR_COLOR="blue"
# prompt string to display, for the root user
export PROMPT_CHAR_ROOT="#"
export PROMPT_CHAR_ROOT_COLOR="red"
# if SHORTEN_CWD is set to 1, `/home/nerdypepper/code` is shortened to
# `/h/n/code`
export SHORTEN_CWD=1
export CWD_COLOR="blue"
# if EXPAND_TILDE is set to 0, `/home/nerdypepper` is shortened to `~`
export EXPAND_TILDE=0
# there are three possible states for a git repo
# - unstaged (working tree has been modified)
# - staged (staging area has been modified)
# - clean (all staged changes have committed)
# symbol to represent clean repo state
export GIT_CLEAN="·"
export GIT_CLEAN_COLOR="green"
# symbol to represent unstaged repo state
export GIT_WT_MODIFIED="×"
export GIT_WT_MODIFIED_COLOR="red"
# symbol to represent staged repo state
export GIT_INDEX_MODIFIED="±"
export GIT_INDEX_MODIFIED_COLOR="yellow"
# if HEAD ref peels to branch
export BRANCH_COLOR="green"
# if HEAD ref peels to a commit (detached state)
export COMMIT_COLOR="green"
