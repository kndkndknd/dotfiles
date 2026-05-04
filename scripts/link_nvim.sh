#!/bin/bash

set -eu

DOT_DIR="$HOME/dotfiles"

find "$DOT_DIR/.config/nvim" -type f | while read -r FILE; do
    RELATIVE_PATH="${FILE#$DOT_DIR/.config/nvim/}"
    DEST="$HOME/.config/nvim/$RELATIVE_PATH"
    mkdir -p "$(dirname "$DEST")"
    ln -sfv "$FILE" "$DEST"
done

echo "[ Finished! ]"
