# Load general shell settings
. "${XDG_CONFIG_HOME:-$HOME/.config}/sh/rc.sh"

# Input customatization -------------------------------------------------------
bindkey -v

# Prompt definition -----------------------------------------------------------
PROMPT='%F{green}%B%n@%m%f:%F{blue}%1~%f%(?..%F{red})%#%f%b '
zle_highlight=(default:bold)

function precmd {
    RPROMPT="$(git_promptline)"
}