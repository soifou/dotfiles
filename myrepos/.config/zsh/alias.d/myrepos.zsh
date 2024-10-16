#!/usr/bin/env zsh

mr() {
    find_mrconfig() {
        local dir="$1"
        local limit="$2"
        local count=0

        while [[ $count -lt $limit ]]; do
            if [ -f "$dir/.mrconfig" ]; then
                echo "$dir/.mrconfig"
                return
            fi
            dir=$(dirname "$dir")
            count=$((count + 1))
        done

        echo "${MR_CONFIG:-}"
    }

    local config_file
    config_file=$(find_mrconfig "$(pwd)" 2)
    [ -z "$config_file" ] \
        && command mr $@ \
        || command mr -t --config "$config_file" $@
}
