typeset -g MY_HISTORY_SEARCH_OFFSET=0
typeset -g MY_HISTORY_SEARCH_PREFIX=""
typeset -g MY_HISTORY_SEARCH_ORIGINAL=""
typeset -g MY_HISTORY_DB_PATH=""
typeset -ga MY_HISTORY_SEARCH_CACHE
typeset -g MY_HISTORY_SEARCH_CACHE_EXHAUSTED=0
typeset -g MY_HISTORY_SEARCH_CACHE_BATCH=50

function _my-history-build-filter() {
    local -a where_clauses
    if [[ -n $MY_HISTORY_SEARCH_PREFIX ]]; then
        local escaped=${MY_HISTORY_SEARCH_PREFIX//\'/\'\'}
        if [[ $MY_HISTORY_SEARCH_PREFIX == *[*?]* ]]; then
            where_clauses+=("command GLOB '$escaped'")
        else
            where_clauses+=("instr(command, '$escaped') = 1")
        fi
    fi
    if [[ -n ${DAN_HISTORY_SEARCH_PIN_DIRECTORY:-} ]]; then
        local pwd_sql=${PWD//\'/\'\'}
        local pwd_len=${#PWD}
        where_clauses+=("substr(cwd, 1, $pwd_len) = '$pwd_sql'")
        where_clauses+=("(length(cwd) = $pwd_len OR substr(cwd, $pwd_len+1, 1) = '/')")
    fi
    (( ${#where_clauses[@]} > 0 )) && print -r -- "WHERE ${(j: AND :)where_clauses}"
}

function _my-history-fetch-batch() {
    local db=${MY_HISTORY_DB_PATH:-$HOME/.local/share/atuin/history.db}
    local filter=$(_my-history-build-filter)
    local cache_len=${#MY_HISTORY_SEARCH_CACHE}
    local fetched
    fetched=$(sqlite3 -newline $'\x1e' "$db" \
        "SELECT command FROM history $filter GROUP BY command ORDER BY MAX(timestamp) DESC LIMIT $MY_HISTORY_SEARCH_CACHE_BATCH OFFSET $cache_len;")
    if [[ -z $fetched ]]; then
        MY_HISTORY_SEARCH_CACHE_EXHAUSTED=1
        return
    fi
    local -a rows=("${(ps:\x1e:)${fetched%$'\x1e'}}")
    MY_HISTORY_SEARCH_CACHE+=("${rows[@]}")
    (( ${#rows} < MY_HISTORY_SEARCH_CACHE_BATCH )) && MY_HISTORY_SEARCH_CACHE_EXHAUSTED=1
}

function my-history-prefix-search() {
    if [[ $LASTWIDGET != my-history-prefix-search-* ]]; then
        # start state machine
        MY_HISTORY_SEARCH_OFFSET=-1
        MY_HISTORY_SEARCH_PREFIX="$LBUFFER"
        MY_HISTORY_SEARCH_ORIGINAL="$BUFFER"
        MY_HISTORY_SEARCH_CACHE=()
        MY_HISTORY_SEARCH_CACHE_EXHAUSTED=0
    fi
    local offset_delta=$1
    local offset=$((MY_HISTORY_SEARCH_OFFSET + $offset_delta))

    if (($offset < 0)); then
        BUFFER="$MY_HISTORY_SEARCH_ORIGINAL"
        CURSOR="${#MY_HISTORY_SEARCH_PREFIX}"
        MY_HISTORY_SEARCH_OFFSET=-1
        return
    fi
    while (( offset >= ${#MY_HISTORY_SEARCH_CACHE} )) && (( ! MY_HISTORY_SEARCH_CACHE_EXHAUSTED )); do
        _my-history-fetch-batch
    done
    if (( offset < ${#MY_HISTORY_SEARCH_CACHE} )); then
        BUFFER="${MY_HISTORY_SEARCH_CACHE[offset+1]}"
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
