#!/bin/bash

set -eu 

find . -type f \
        -path "*/*" \
        -not -path "*.sh" \
        -not -path "*.md" \
        -not -path "*scripts*" \
        -not -path "*.git*" \
        -not -path "*.DS_Store" \
        -not -path "*.luarc.json" \
        -not -path "*stylua.toml" \
        -not -path "*wofi*" \
        -not -path "*sway*" \
        -not -path "*waybar*" \
        -not -path "*swaylock*" \
        -not -path "*mako*" \
        -not -path "*bashtop*" \
        -not -path "*homebrew*" \
        -not -path "*Makekfile*" \
        | cut -c 3-
