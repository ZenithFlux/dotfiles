#!usr/bin/env bash

if ! command -v fzf 2>&1 > /dev/null; then
    if [ -n "$TMUX" ]; then
        echo "'fzf' not found!!"
    fi
    return
fi

dir=$(printf "${PWD}\n${HOME}\n$(find ~/personal ~/work ~/other -maxdepth 1 -type d,l)" | fzf)
if [ -z "$dir" ]; then
    [ -z "$TMUX" ] && return || exit 0
fi
name=$(basename "$dir" | tr . _)

if [ -z "$TMUX" ]; then
    exec tmux new -A -s "$name" -c "$dir"
else
    tmux new -d -s "$name" -c "$dir"
    tmux switch-client -t "$name"
    exit 0
fi
