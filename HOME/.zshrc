# Load general shell settings
. "${XDG_CONFIG_HOME:-$HOME/.config}/sh/rc.sh"

# History ---------------------------------------------------------------------
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_FIND_NO_DUPS
setopt appendhistory

# Prompt definition -----------------------------------------------------------
if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ] && [ "$UID" -ne 0 ]; then
    PROMPT='%B%1~%(?..%F{red})%#%f%b '
else
    PROMPT='%B%n@%m %1~%(?..%F{red})%#%f%b '
fi
zle_highlight=(default:bold)