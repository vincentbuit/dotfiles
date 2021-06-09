# sh/rc.sh - startup for POSIX shells
# NVM (special snowflake does not want PREFIX set) ----------------------------
unset PREFIX # = Bad design from nvm, needs a workaround as I will be using PREFIX later on
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias nvm="PREFIX='' nvm"

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

# Import local profile 
for x in /etc/profile.d/*.sh "$XDG_CONFIG_HOME/profile.d"/*.sh; do
    [ -e "$x" ] || continue
    echo "$x" | grep -q perl || . "$x"
done
# ALIASES ---------------------------------------------------------------------
# Alias noargs gebruik je om default arguments mee te geven indien er geen arguments gegeven zijn.
alias_noargs() {
    eval "alias $1='alias_$1() { ((\$#)) || set -- $2;$1 \"\$@\"; }; alias_$1'"
}

alias_noargs tig '--branches --remotes --tags'

# SCRIPTS ---------------------------------------------------------------------
git_promptline() {
    git rev-parse --is-inside-work-tree >/dev/null 2>&1 \
         && {
            git rev-list --walk-reflogs --count refs/stash 2>/dev/null ||echo 0
            git status --porcelain --branch 2>/dev/null
         } | awk '
            NR == 1 { stashes = $0 }
            /^## HEAD/ { branch = "(detached)" }
            /^## Initial commit on master$/ { branch = "master" }
            /^## / {
                remotesplit = index($2, "...")
                if (remotesplit) {
                    branch = substr($2, 1, remotesplit - 1)
                    remote = substr($2, remotesplit + 3)
                } else { branch = $2}
                $1 = $2 = ""
                n = split($0, x, ",")
                for (i = 1; i <= n; i++) {
                    split(x[i], y, " ")
                    rs[substr(y[1], (i - 3) * -1)] = \
                        substr(y[2], 1, length(y[2]) - (i == n ? 1 : 0))
                }
                behind = rs["behind"]; ahead = rs["ahead"]
            }
            /^.[MD] / { unstaged += 1 }
            /^[^ ?]. / { staged += 1 }
            /^\?\? / { untracked += 1 }
            /^(.U|U.|AA|DD) / { state = "|merge" }
            END {
                if (remote != "") {
                    if (substr(remote, index(remote, "/") + 1) == branch) {
                        remote = (ahead + behind == 0) ? ":" : ""
                    } else { remote = ":" remote }
                }
                untracked = untracked > 0 ? "?" : ""
                unstaged = unstaged > 0 ? "*" : ""
                staged = staged > 0 ? "+" : ""
                behind = behind > 0 ? "↓" behind : ""
                ahead = ahead > 0 ? "↑" ahead : ""
                stashes = stashes > 0 ? "~" stashes : ""
                printf("%s%s%s ", untracked, unstaged, staged)
                printf("(%s%s%s%s%s)", branch, remote, behind, ahead, state)
                printf("%s", stashes)
            }' 2>/dev/null
}
