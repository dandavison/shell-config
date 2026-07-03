# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md

# -g so the styles stay global when this file is sourced inside a function
# (tsource, or zsh-defer's drain context).
typeset -gA ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path]='fg=green'

# source ~/devenv/shell-config//zsh/3p/zsh-syntax-highlighting--dracula.sh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh &>/dev/null
