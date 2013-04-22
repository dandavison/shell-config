bindkey '\ep' history-beginning-search-backward
bindkey '\en' history-beginning-search-forward

# bindkey '\e[A' history-beginning-search-backward  # up
# bindkey '\e[B' history-beginning-search-forward   # down

# On the macbook, M-up/down send these sequences normally
bindkey '\e[1;9A' history-beginning-search-backward   # M-up
bindkey '\e[1;9B' history-beginning-search-forward   # M-down

# but these under tmux
bindkey '\e^[[A' history-beginning-search-backward  # M-up
bindkey '\e^[[B' history-beginning-search-forward   # M-down

bindkey '\e^[[C' forward-word  # M-right
bindkey '\e^[[D' backward-word # M-left

bindkey '\ee' edit-command-line-in-shell-mode

bindkey -s '^_' '^a^ktmux select-window -t :\t\t'
bindkey -M menuselect -s '^_' '^g^a^k'

bindkey '^W' kill-region

bindkey '^x^r' replace-string
