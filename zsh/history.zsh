typeset -g MY_HISTORY_SEARCH_OFFSET=0
typeset -g MY_HISTORY_SEARCH_PREFIX=""

function my-history-prefix-search() {
    if [[ $LASTWIDGET != my-history-prefix-search-* ]]; then
        # start state machine
        MY_HISTORY_SEARCH_OFFSET=-1
        MY_HISTORY_SEARCH_PREFIX="$LBUFFER"
    fi
    local offset_delta=$1
    local offset=$((MY_HISTORY_SEARCH_OFFSET + $offset_delta))

    (($offset < 0)) && return
    local result=$(
        atuin search \
            --search-mode prefix \
            --limit 1 \
            --offset $offset \
            --format '{command}' \
            "$MY_HISTORY_SEARCH_PREFIX"
    )
    if [[ -n "$result" ]]; then
        BUFFER=$result
        CURSOR=${#BUFFER}
        MY_HISTORY_SEARCH_OFFSET=$offset
    fi
}

function my-history-prefix-search-backward-widget() {
    my-history-prefix-search +1
}

function my-history-prefix-search-forward-widget() {
    my-history-prefix-search -1
}

zle -N my-history-prefix-search-backward-widget
zle -N my-history-prefix-search-forward-widget
