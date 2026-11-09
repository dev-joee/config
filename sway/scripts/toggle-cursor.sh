#!/bin/bash

STATE_FILE="/tmp/sway_cursor_hidden"

if [ -f "$STATE_FILE" ]; then
    swaymsg seat seat0 hide_cursor 3000
    rm "$STATE_FILE"
else
    swaymsg seat seat0 hide_cursor 1
    touch "$STATE_FILE"
fi
