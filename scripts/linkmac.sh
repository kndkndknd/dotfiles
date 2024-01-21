#!/bin/bash

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

local links= find . -type f \
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