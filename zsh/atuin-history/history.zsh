typeset -g MY_HISTORY_SEARCH_OFFSET=0
typeset -g MY_HISTORY_SEARCH_PREFIX=""
typeset -g MY_HISTORY_SEARCH_ORIGINAL=""
typeset -g MY_HISTORY_DB_PATH=""

function my-history-prefix-search() {
    if [[ $LASTWIDGET != my-history-prefix-search-* ]]; then
        # start state machine
        MY_HISTORY_SEARCH_OFFSET=-1
        MY_HISTORY_SEARCH_PREFIX="$LBUFFER"
        MY_HISTORY_SEARCH_ORIGINAL="$BUFFER"
    fi
    local offset_delta=$1
    local offset=$((MY_HISTORY_SEARCH_OFFSET + $offset_delta))

    if (($offset < 0)); then
        BUFFER="$MY_HISTORY_SEARCH_ORIGINAL"
        CURSOR="${#MY_HISTORY_SEARCH_PREFIX}"
        MY_HISTORY_SEARCH_OFFSET=-1
        return
    fi
    local db=${MY_HISTORY_DB_PATH:-$HOME/.local/share/atuin/history.db}
    local -a where_clauses
    if [[ -n $MY_HISTORY_SEARCH_PREFIX ]]; then
        local escaped=${MY_HISTORY_SEARCH_PREFIX//\'/\'\'}
        where_clauses+=("instr(command, '$escaped') = 1")
    fi
    if [[ -n ${DAN_HISTORY_SEARCH_PIN_DIRECTORY:-} ]]; then
        local pwd_sql=${PWD//\'/\'\'}
        local pwd_len=${#PWD}
        where_clauses+=("substr(cwd, 1, $pwd_len) = '$pwd_sql'")
        where_clauses+=("(length(cwd) = $pwd_len OR substr(cwd, $pwd_len+1, 1) = '/')")
    fi
    local filter=""
    (( ${#where_clauses[@]} > 0 )) && filter="WHERE ${(j: AND :)where_clauses}"
    local result
    result=$(sqlite3 "$db" \
        "SELECT command FROM history $filter GROUP BY command ORDER BY MAX(timestamp) DESC LIMIT 1 OFFSET $offset;")
    if [[ -n "$result" ]]; then
        BUFFER="$result"
        CURSOR="${#BUFFER}"
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
