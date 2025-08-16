#!usr/bin/env bash

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
