#!/usr/bin/env bash

app_command=$1
app_wm_class=$2

workspace=$(wmctrl -d | grep "\*" | cut -d " " -f 1)
win_list=$(wmctrl -lx | grep "$app_wm_class" | grep "$workspace " | awk '{print $1}')

if [ -z "$win_list" ]; then
    $app_command
    exit 0
fi

active_win_id=$(xprop -root | grep '^_NET_ACTIVE_W' | awk -F'# 0x' '{print $2}')

if [[ "$win_list" == *"$active_win_id"* ]]; then
    switch_to=$(echo $win_list | sed s/.*$active_win_id// | awk '{print $1}')

    if [ -z "$switch_to" ]; then
        wmctrl -ia $(echo $win_list | awk '{print $1}')
    else
        wmctrl -ia $switch_to
    fi
    exit 0

else
    win_stack=$(xprop -root|grep "^_NET_CLIENT_LIST_STACKING" | tr "," " " | sed s/0x//)
    win_stack=(${win_stack##*#})

    for (( idx=${#win_stack[@]}-1 ; idx>=0 ; idx-- )) ; do
        win_id=$(echo ${win_stack[idx]} | sed s/0x//)

        if [[ "$win_list" == *"$win_id"* ]]; then
            win_id=$(echo $win_list | grep -o "0x[^ ]*$win_id")
            wmctrl -ia $win_id
            exit 0
        fi
    done

    wmctrl -xa $app_wm_class
fi
