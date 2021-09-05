#!/bin/bash

link() {
    [[ -L "$2" && $(readlink "$2") == "$1" ]] && return
    if [[ ! -e "$2" ]]; then
        ln -s "$1" "$2"
        return
    fi
    echo "$2 exists and indicates different path."
    echo "please remove it and try again."
}

link .zshenv "$HOME/.config/zsh/zshenv"
link .zshrc "$HOME/.config/zsh/zshrc"
link .zprofile "$HOME/.config/zsh/zprofile"
