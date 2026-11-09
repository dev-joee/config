#!/bin/zsh

# Folder containing your logo images
folder="$HOME/.config/fastfetch/assets"

# Pick a random image (png/jpg/webp supported)
# logo=$(ls "$folder"/*.{png,jpg,jpeg,webp} 2>/dev/null | shuf -n 1)
logo=$(ls "$folder"/*.png 2>/dev/null | shuf -n 1)

# Fallback if no image is found
[ -z "$logo" ] && logo="$folder/jedi.png"

# Run fastfetch with the chosen logo
# fastfetch --logo-type kitty-direct --logo-width 35 --logo-height 30 --logo "$logo"
if [ "$logo" = "$HOME/.config/fastfetch/assets/jedi.png" ]; then
	fastfetch --logo-type kitty-direct --logo-width 18 --logo-height 12 --logo-padding-top 0 --logo-padding-left 0 --logo "$logo"
else
	fastfetch --logo-type kitty-direct --logo-width 18 --logo-height 0 --logo-padding-top 2 --logo-padding-left 0 --logo "$logo"
fi

