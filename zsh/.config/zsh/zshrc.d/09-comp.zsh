#!/usr/bin/env zsh

typeset -A comps=(
    cargo      'rustup completions zsh cargo'
    deno       'deno completions zsh'
    mise       'mise completion zsh'
    pip        'pip completion --shell zsh'
    rg         'rg --generate=complete-zsh'
    rustup     'rustup completions zsh'
    symfony    'symfony self:completion zsh'
    typst      'typst completions zsh'
    uv         'uv generate-shell-completion zsh'
    zsh-patina 'zsh-patina completion'
)

local compdir="$XDG_DATA_HOME/zsh/site-functions"
[[ -d "$compdir" ]] || mkdir -p "$compdir"

for cmd gen in "${(@kv)comps}"; do
    (( $+commands[$cmd] )) || continue
    local compfile="$compdir/_$cmd"
    [[ -f "$compfile" ]] && continue
    znap fpath "_$cmd" "$gen"
done
