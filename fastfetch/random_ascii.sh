#!/bin/bash

# Directory containing your ASCII logo .txt files
LOGO_DIR="$HOME/.config/fastfetch/assets/"

# Pick a random .txt file
LOGO_FILE=$(find "$LOGO_DIR" -type f -name "*.txt" | shuf -n 1)

# If no file found, exit
[ -z "$LOGO_FILE" ] && { echo "No .txt logos found in $LOGO_DIR"; exit 1; }

# Run fastfetch with the selected logo
fastfetch --logo-type file --logo "$LOGO_FILE"

