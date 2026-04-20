#!/usr/bin/env zsh
# Benchmark the atuin invocation that runs on every UP/DOWN keystroke in
# my-history-prefix-search. Uses a copy of the real atuin data dir so the
# numbers reflect realistic DB size/content without risk to the real DB.
set -eu

REAL_DATA_DIR=$(atuin info 2>&1 | awk -F'"' '/client db path:/{print $2}' | xargs dirname)

BENCH_TMPDIR=$(mktemp -d)
trap 'rm -rf "$BENCH_TMPDIR"' EXIT INT TERM

mkdir -p "$BENCH_TMPDIR/config" "$BENCH_TMPDIR/data"
print "Copying atuin data dir ($REAL_DATA_DIR) to isolated tmp..."
cp -R "$REAL_DATA_DIR"/. "$BENCH_TMPDIR/data/"

cat > "$BENCH_TMPDIR/config/config.toml" <<EOF
data_dir = "$BENCH_TMPDIR/data"
auto_sync = false
update_check = false
EOF
export ATUIN_CONFIG_DIR="$BENCH_TMPDIR/config"

typeset row_count
row_count=$(atuin search --search-mode prefix --limit 1000000 --format '{command}' -- '' 2>/dev/null | wc -l | tr -d ' ')
print "DB has ~$row_count history entries"
print

run_bench() {
    local label=$1; shift
    print "=== $label ==="
    hyperfine --warmup 3 --runs 30 "$@"
    print
}

run_bench "baseline: atuin --version (process-startup floor)" \
    "atuin --version"

run_bench "prefix search, empty prefix, offset 0" \
    "atuin search --search-mode prefix --limit 1 --offset 0 --format {command} -- "

run_bench "prefix search, 'git ' prefix, offset 0" \
    "atuin search --search-mode prefix --limit 1 --offset 0 --format {command} -- git "

run_bench "prefix search, 'git ' prefix, offset 10" \
    "atuin search --search-mode prefix --limit 1 --offset 10 --format {command} -- git "

run_bench "prefix search, 'git ' prefix, offset 100" \
    "atuin search --search-mode prefix --limit 1 --offset 100 --format {command} -- git "

run_bench "prefix search, long-tail prefix, offset 0" \
    "atuin search --search-mode prefix --limit 1 --offset 0 --format {command} -- hyperfine "

run_bench "full-text search (what ^R uses), 'git' query" \
    "atuin search --search-mode full-text --limit 1 --offset 0 --format {command} -- git"

DB="$BENCH_TMPDIR/data/history.db"

run_bench "sqlite3: empty prefix, offset 0 (my-history-prefix-search path)" \
    "sqlite3 '$DB' 'SELECT command FROM history GROUP BY command ORDER BY MAX(timestamp) DESC LIMIT 1 OFFSET 0;'"

run_bench "sqlite3: empty prefix, offset 100" \
    "sqlite3 '$DB' 'SELECT command FROM history GROUP BY command ORDER BY MAX(timestamp) DESC LIMIT 1 OFFSET 100;'"

run_bench "sqlite3: 'git ' prefix, offset 0" \
    "sqlite3 '$DB' \"SELECT command FROM history WHERE instr(command, 'git ') = 1 GROUP BY command ORDER BY MAX(timestamp) DESC LIMIT 1 OFFSET 0;\""

run_bench "sqlite3: 'git ' prefix, offset 100" \
    "sqlite3 '$DB' \"SELECT command FROM history WHERE instr(command, 'git ') = 1 GROUP BY command ORDER BY MAX(timestamp) DESC LIMIT 1 OFFSET 100;\""
