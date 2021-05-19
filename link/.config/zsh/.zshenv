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

# rust
export RUST_HOME="$XDG_DATA_HOME"/rust
export RUSTUP_HOME="${RUST_HOME}"/rustup
export CARGO_HOME"=${RUST_HOME}"/cargo
