#!/bin/bash

# SCRIPT_DIR="$(cd "$(dirname "$0")" && cd "../.bin" && pwd)"

# for dotfile in "${SCRIPT_DIR}"/.??* ; do
#     [[ "$dotfile" == "${SCRIPT_DIR}/.git" ]] && continue
#     [[ "$dotfile" == "${SCRIPT_DIR}/.github" ]] && continue
#     [[ "$dotfile" == "${SCRIPT_DIR}/.DS_Store" ]] && continue

#     ln -fnsv "$dotfile" "$HOME"
# done

# cf. https://github.com/arrow2nd/dotfiles/tree/main

set -eu

DOT_DIR="$HOME/dotfiles"
SCRIPTS_DIR="$DOT_DIR/scripts/$(uname)"

if ! type -p git >/dev/null; then
    echo "error: git not found on the system" >&2
    exit 1
fi

if [[ ! -d "$SCRIPTS_DIR" ]]; then
    echo "error: unsupport environment ($(uname))" >&2
    exit 1
fi

function script_run {
    if [[ ! -f "$1" ]]; then
        echo "$1 does not exist."
        exit 1
    fi

    sh -c "$1"
}

function link_dotfile_old {
    echo "[ Link dotfiles ]"

    local links=$(script_run "$SCRIPTS_DIR/find.sh")

    IFS=$'\n'
    for f in $links; do
        mkdir -p "$HOME/$(dirname "$f")"

        if [ -L "$HOME/$f" ]; then
            ln -sfv "$DOT_DIR/$f" "$HOME/$f"
        else
            ln -siv "$DOT_DIR/$f" "$HOME/$f"
        fi
    done
    unset IFS
}

function link_dotfiles {
    echo "[ Link dotfiles ]"

    # .bin 配下のファイルを ~ にリンク
    find "$DOT_DIR/.bin" -type f | while read -r FILE; do
        ln -sfv "$FILE" "$HOME/$(basename "$FILE")"
    done

    # .config 配下のファイルを ~/.config にリンク
    find "$DOT_DIR/.config" -type f | while read -r FILE; do
        RELATIVE_PATH="${FILE#$DOT_DIR/.config/}"
        DEST="$HOME/.config/$RELATIVE_PATH"
        mkdir -p "$(dirname "$DEST")"
        ln -sfv "$FILE" "$DEST"
    done
}

link_dotfiles
echo "[ Finished! ]"