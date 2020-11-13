# Load general shell settings
. "${XDG_CONFIG_HOME:-$HOME/.config}/sh/rc.sh"

# History ---------------------------------------------------------------------
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_FIND_NO_DUPS
setopt appendhistory

# Prompt definition -----------------------------------------------------------
PROMPT='%F{green}%B%n@%m%f:%F{blue}%1~%f%(?..%F{red})%#%f%b '
zle_highlight=(default:bold)