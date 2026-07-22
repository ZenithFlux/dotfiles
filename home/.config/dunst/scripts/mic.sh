#!/usr/bin/env bash

notif_time_ms=2000

if [ "$1" = "mute" ]; then
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q '\[MUTED\]'; then
        notify-send -e -t $notif_time_ms -h string:x-dunst-stack-tag:osd "Mic" "Muted"
    else
        notify-send -e -t $notif_time_ms -h int:value:$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $2 * 100}') -h string:x-dunst-stack-tag:osd "Mic"
    fi
fi
