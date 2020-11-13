# sh/rc.sh - startup for POSIX shells
# ENVIRONMENT -----------------------------------------------------------------
set -a
PREFIX="$HOME/.local"
XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$PREFIX/share"
XDG_BIN_HOME="$PREFIX/bin"
. "$XDG_CONFIG_HOME/environment.d/10-applications.conf"
PATH="$GOPATH/bin:$PATH"
PATH="$XDG_BIN_HOME:$PATH"
set +a

# PATH
PATH=$PATH:/opt/mssql/bin:/opt/mssql-tools/bin

# ALIASES ---------------------------------------------------------------------
# Alias noargs gebruik je om default arguments mee te geven indien er geen arguments gegeven zijn.
alias_noargs() {
    eval "alias $1='alias_$1() { ((\$#)) || set -- $2;$1 \"\$@\"; }; alias_$1'"
}

alias_noargs tig '--branches --remotes --tags'

# NVM (special snowflake does not want PREFIX set) ----------------------------
unset PREFIX # = Bad design from nvm, needs a workaround as I will be using PREFIX later on
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias nvm="PREFIX='' nvm"
