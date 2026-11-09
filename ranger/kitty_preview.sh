#!/usr/bin/env bash
# kitty_preview.sh: preview images in Kitty using icat
file="$1"

# only run in Kitty
if [ -n "$KITTY_WINDOW_ID" ] && [ -e "$file" ]; then
    case "$file" in
        *.png|*.jpg|*.jpeg|*.gif|*.bmp|*.webp)
            kitty +kitten icat --clear
            kitty +kitten icat "$file"
            ;;
        *)
            echo "$file"
            ;;
    esac
fi
