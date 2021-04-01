typeset -U path
path=(~/bin $path[@])

export EDITOR=nvim

# ccache
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME"/ccache.config
export CCACHE_DIR="$XDG_CACHE_HOME"/ccache

# gpg
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# less
export LESSHISTFILE=-
