#!/usr/bin/env bash

if [[ ! -n $XDG_CONFIG_HOME ]]; then
    XDG_CONFIG_HOME=$HOME/.config
fi
if [[ ! -n $XDG_DATA_HOME ]]; then
    XDG_DATA_HOME=$HOME/.local/share
fi
if [[ ! -n $XDG_CACHE_HOME ]]; then
    XDG_CACHE_HOME=$HOME/.cache
fi

link() {
    [[ -L "$2" && $(readlink "$2") == "$1" ]] && return
    if [[ ! -e "$2" ]]; then
        ln -s "$1" "$2"
        return
    fi
    echo "$2 exists and indicates different path."
    echo "please remove it and try again."
}

link .zshenv "$XDG_CONFIG_HOME/zsh/zshenv"
link .zshrc "$XDG_CONFIG_HOME/zsh/zshrc"
link .zprofile "$XDG_CONFIG_HOME/zsh/zprofile"

mkdir -p "$XDG_DATA_HOME/zsh"
mkdir -p "$XDG_CACHE_HOME/zsh"
