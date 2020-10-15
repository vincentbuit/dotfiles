# BASH SETTINGS --------------------------------------------------------------
# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# ALIASES ---------------------------------------------------------------------
# Alias noargs gebruik je om default arguments mee te geven indien er geen arguments gegeven zijn.
alias_noargs() {
    eval "alias $1='alias_$1() { ((\$#)) || set -- $2;$1 \"\$@\"; }; alias_$1'"
}

alias_noargs tig '--branches --remotes --tags'

# NVM (special snowflake does not want PREFIX set) ---------------------------
unset PREFIX # = Bad design from nvm, needs a workaround as I will be using PREFIX later on
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias nvm="PREFIX='' nvm"

# ENVIRONMENT ----------------------------------------------------------------
export PREFIX="$HOME/.local"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$PREFIX/share"
export XDG_BIN_HOME="$PREFIX/bin"
export PATH="$XDG_BIN_HOME:$PATH"

#History
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
history -a
shopt -s histappend
shopt -s checkwinsize

#Prompt
BOLD=$'\033[0;1m' #base01
INVIS=$'\033[0;30m'
GREEN=$'\033[01;32m'
WHITE=$'\033[00m'
BLUE=$'\033[01;34m'
RED=$'\033[1;31m'
NONE=$'\033[m'

configure_prompt() {
    local ROW COL

    IFS=\; read -sdR -p $'\E[6n' ROW COL
    PS1="\[$([ "$COL" -eq 1 ] && printf '\\r' || printf '\\n')\]$PROMPT_BASE"
    promptcol="$([ "$1" -eq 0 ] && echo "$WHITE" || echo "$RED")"
}

PROMPT_COMMAND='configure_prompt $?'
PROMPT_BASE='\[${GREEN}\]\u@\h\[${WHITE}\]:\[${BLUE}\]\W\[${promptcol}\]\$\[${NONE}\] '

# PATH
PATH=$PATH:/opt/mssql/bin:/opt/mssql-tools/bin
