# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md

typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path]='fg=green'

# source ~/devenv/shell-config//zsh/3p/zsh-syntax-highlighting--dracula.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh &> /dev/null
