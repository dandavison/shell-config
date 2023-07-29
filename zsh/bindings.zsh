# To determine bytes being sent by key sequences:
# read
# infocmp -L -1

declare -A MY_KEYS
MY_KEYS=(
    UP '^[[A'
    DOWN '^[[B'
    M_UP '^[[1;3A'
    M_DOWN '^[[1;3B'
    M_LEFT '^[[1;3D'
    M_RIGHT '^[[1;3C'
)

bindkey "$MY_KEYS[UP]" my-history-prefix-search-backward-widget
bindkey "$MY_KEYS[DOWN]" my-history-prefix-search-forward-widget
# zsh native widgets are named history-beginning-search-{backward,forward}

bindkey "$MY_KEYS[M_RIGHT]" forward-word
bindkey "$MY_KEYS[M_LEFT]" backward-word

bindkey '\ee' edit-command-line-in-shell-mode

bindkey -s '^_' '^a^ktmux select-window -t :\t\t'

bindkey '^W' kill-region

bindkey '^x^r' replace-string

bindkey "^ " wormhole-switch-widget
# bindkey "^v" wormhole-switch-widget
