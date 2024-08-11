HISTFILE="$XDG_DATA_HOME/zsh/histfile"
HISTSIZE=1000
SAVEHIST=1000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

setopt autocd extendedglob nomatch notify
setopt auto_pushd pushd_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history
setopt append_history
setopt hist_reduce_blanks

unsetopt beep

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:cd:*' ignore-parents parent pwd

autoload -U compinit && compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
autoload -U colors && colors

# prompt
() {
    local current_dir=">%{$fg[yellow]%}%~%{$reset_color%}"
    local new_line=$'\n'
    if [ -n "$RANGER_LEVEL" ]; then
        local user="%{$fg[yellow]%}%n%{$reset_color%}"
    else
        local user="%{$fg[red]%}%n%{$reset_color%}"
    fi
    local host="%{$fg[blue]%}%m%{$reset_color%}"
    PROMPT="$current_dir$new_line$user@$host%# "
}

# is runit or systemd?
[[ $(readlink /sbin/init) == "runit-init" ]] && runit=1

# alias
alias ls='ls --color=auto'
alias q='exit'
alias run='(){$@ > /dev/null 2>&1 &!}'
alias dosa='doas'
alias sfs='~/build/simple-file-server/server.py'
alias mksh='(){echo "#!/bin/zsh" > $1 && chmod u+x $1}'
alias git-syu='git submodule update --remote && git submodule foreach git submodule update --checkout --recursive'
if [[ $runit == 1 ]]; then
    alias slp='doas /usr/local/bin/suspend'
    alias slpe='{ sleep 1; doas /usr/local/bin/suspend; }&; tmux detach'
    alias svs='(){ doas sv $1 /run/runit/services/$2 }'
    alias svu='(){ sv $1 /tmp/user/1000/runit/services/$2 }'
else
    alias slp='doas systemctl suspend'
    alias slpe='{ sleep 1; doas systemctl suspend; }&; tmux detach'
    alias start='systemctl --user start desktop.target'
fi

# for sway/fragments/suspend-binds
alias lide="rm -f /tmp/no-lidswitch"
alias lidd="touch /tmp/no-lidswitch"
alias lids="if [[ -f /tmp/no-lidswitch ]]; then echo "disabled"; else echo "enabled"; fi"

# binds
bindkey -d
bindkey -M vicmd 'H' vi-beginning-of-line
bindkey -M vicmd 'L' vi-end-of-line
bindkey -M vicmd '^R' history-incremental-search-backward
bindkey -M vicmd '^S' history-incremental-search-forward
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M viins '^S' history-incremental-search-forward
bindkey -M viins "jk" vi-cmd-mode
bindkey -M vicmd "\e[3~" delete-char 
bindkey -M viins "\e[3~" delete-char 
bindkey -v

# disable console stop
stty stop undef
stty start undef

# change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(fix_cursor)

if [[ -f $ZDOTDIR/specialrc ]] {
    . "$ZDOTDIR/specialrc"
}
