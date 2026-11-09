#!/usr/bin/env bash

logos=(
    arch
    debian
    fedora
    lfs
    gentoo
    endeavouros
    ubuntu
)

logo="${logos[$RANDOM % ${#logos[@]}]}"

fastfetch \
    --logo-type builtin \
    --logo "$logo" \
    --load-config ~/.config/fastfetch/config.jsonc
