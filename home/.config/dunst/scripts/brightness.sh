#!/usr/bin/env bash

notif_time_ms=2000

if [ "$1" = "up" ]; then
    brightnessctl -e4 -n2 set 5%+
elif [ "$1" = "down" ]; then
    brightnessctl -e4 -n2 set 5%-
fi

notify-send -t $notif_time_ms -h int:value:$(brightnessctl -m | cut -d, -f4 | tr -d '%') -h string:x-dunst-stack-tag:osd "Brightness"
