#!/usr/bin/env bash

hyprctl reload

dunstctl reload

killall waybar
waybar &

killall -SIGUSR1 kitty
