#!/usr/bin/env zsh
# Microbenchmark the widget itself (including the prefetch cache).
# Uses a copy of the real atuin data dir for realistic numbers.
set -u
zmodload zsh/datetime

SCRIPT_DIR=${0:A:h}
source "$SCRIPT_DIR/../history.zsh"

REAL_DATA_DIR=$(atuin info 2>&1 | awk -F'"' '/client db path:/{print $2}' | xargs dirname)
BENCH_TMPDIR=$(mktemp -d)
trap 'rm -rf "$BENCH_TMPDIR"' EXIT INT TERM
mkdir -p "$BENCH_TMPDIR/data"
cp -R "$REAL_DATA_DIR"/. "$BENCH_TMPDIR/data/"
export MY_HISTORY_DB_PATH="$BENCH_TMPDIR/data/history.db"

# Warm the OS page cache so first-press numbers reflect realistic (in-use)
# conditions rather than cold-file-read latency. Touch the command column
# since that is what the search queries actually read.
sqlite3 "$MY_HISTORY_DB_PATH" "SELECT COUNT(*), SUM(length(command)) FROM history;" >/dev/null
sqlite3 "$MY_HISTORY_DB_PATH" "SELECT command FROM history GROUP BY command ORDER BY MAX(timestamp) DESC LIMIT 1;" >/dev/null

time_widget() {
    local label=$1 lbuf=$2 presses=$3
    LASTWIDGET=""
    MY_HISTORY_SEARCH_OFFSET=0
    MY_HISTORY_SEARCH_CACHE=()
    MY_HISTORY_SEARCH_CACHE_EXHAUSTED=0
    LBUFFER=$lbuf
    BUFFER=$lbuf
    local -a per_press
    local i
    for ((i = 1; i <= presses; i++)); do
        local t0=$EPOCHREALTIME
        my-history-prefix-search-backward-widget
        local t1=$EPOCHREALTIME
        per_press+=($(printf "%.3f" $(( (t1 - t0) * 1000 ))))
        LASTWIDGET=my-history-prefix-search-backward-widget
    done
    print "=== $label ==="
    print "  per-press latency (ms): ${per_press[@]}"
    print
}

time_widget "empty prefix, 10 UPs (first fetches batch, rest are cache hits)" "" 10
time_widget "'git ' prefix, 10 UPs" "git " 10
