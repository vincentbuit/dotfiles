# BASH SETTINGS --------------------------------------------------------------
# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

#History
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
history -a
shopt -s histappend
shopt -s checkwinsize

#Prompt
# PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ' # Use when entire path should be displayed
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
    PS1="$([ "$COL" -eq 1 ] && printf "\\\\r" || printf "\\\\n")$PROMPT_BASE"
    promptcol="$([ "$1" -eq 0 ] && echo "$WHITE" || echo "$RED")"
}

PROMPT_COMMAND='configure_prompt $?'
PROMPT_BASE='\[${GREEN}\]\u@\h\[${WHITE}\]:\[${BLUE}\]\W\[${promptcol}\]\$\[${NONE}\] '

# ENVIRONMENT ----------------------------------------------------------------
export PREFIX="$HOME/.local"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$PREFIX/share"
export XDG_BIN_HOME="$PREFIX/bin"
export PATH="$XDG_BIN_HOME:$PATH"