#!/usr/bin/env bash

username=${1:-$(id -un)}
unsynced=""
missing=""

while IFS= read -r -d '' repo_file; do
    rel_path="${repo_file#./}"

    if [[ "$rel_path" == home/* ]]; then
        system_path="/home/$username/${rel_path#home/}"
    else
        system_path="/$rel_path"
    fi

    if [ ! -f "$system_path" ]; then
        missing="${missing:+$missing\n}\t$system_path"
    elif [ "$(sha256sum "$repo_file" | cut -d' ' -f1)" != "$(sha256sum "$system_path" | cut -d' ' -f1)" ]; then
        unsynced="${unsynced:+$unsynced\n}\t$system_path"
    fi
done < <(find . -mindepth 2 -type f -not -path './.git/*' -print0)

if [ -z "$unsynced" ] && [ -z "$missing" ]; then
    echo "All files are synced :)"
else
    [ -n "$unsynced" ] && echo -e "Unsynced Files:\n$unsynced"
    [ -n "$unsynced" ] && [ -n "$missing" ] && echo ""
    [ -n "$missing" ] && echo -e "Missing Files:\n$missing"
fi
