#!/usr/bin/env bash

notif_time_ms=2000

if [ "$1" = "up" ]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+

elif [ "$1" = "down" ]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

elif [ "$1" = "mute" ]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q '\[MUTED\]'; then
        notify-send -e -t $notif_time_ms -h string:x-dunst-stack-tag:osd "Volume" "Muted"
        return 2> /dev/null
        exit
    fi
fi

notify-send -e -t $notif_time_ms -h int:value:$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}') -h string:x-dunst-stack-tag:osd "Volume"
