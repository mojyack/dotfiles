if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" && -z $TMUX ]] && tmix 1; then
    tmix && exit
fi
