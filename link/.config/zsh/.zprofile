if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" && -z $TMUX ]] && tmix 1; then
    tmix && exit
fi

if [[ -f $ZDOTDIR/specialprofile ]] {
    . "$ZDOTDIR/specialprofile"
}
