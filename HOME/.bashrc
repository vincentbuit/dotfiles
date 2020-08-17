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
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# ENVIRONMENT ----------------------------------------------------------------
export PREFIX="$HOME/.local"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$PREFIX/share"
export XDG_BIN_HOME="$PREFIX/bin"
export PATH="$XDG_BIN_HOME:$PATH"