typeset -gi TESTS_RUN=0
typeset -gi TESTS_FAILED=0

setup_atuin_isolated() {
    TEST_TMPDIR=$(mktemp -d)
    export ATUIN_CONFIG_DIR="$TEST_TMPDIR/config"
    mkdir -p "$ATUIN_CONFIG_DIR" "$TEST_TMPDIR/data"
    cat > "$ATUIN_CONFIG_DIR/config.toml" <<EOF
data_dir = "$TEST_TMPDIR/data"
auto_sync = false
update_check = false
EOF
}

teardown_atuin_isolated() {
    [[ -n ${TEST_TMPDIR:-} && -d $TEST_TMPDIR ]] && rm -rf "$TEST_TMPDIR"
    unset ATUIN_CONFIG_DIR TEST_TMPDIR
}

seed_history() {
    local cmd id
    for cmd in "$@"; do
        id=$(atuin history start -- "$cmd")
        atuin history end --exit 0 -- "$id" >/dev/null 2>&1
    done
}

reset_widget_state() {
    LASTWIDGET=""
    MY_HISTORY_SEARCH_OFFSET=0
    MY_HISTORY_SEARCH_PREFIX=""
    BUFFER=""
    LBUFFER=""
    RBUFFER=""
    CURSOR=0
}

mark_lastwidget_backward() { LASTWIDGET=my-history-prefix-search-backward-widget }
mark_lastwidget_forward()  { LASTWIDGET=my-history-prefix-search-forward-widget }

assert_eq() {
    local label=$1 expected=$2 actual=$3
    (( TESTS_RUN++ ))
    if [[ $expected == $actual ]]; then
        print -r -- "  PASS  $label"
    else
        (( TESTS_FAILED++ ))
        print -r -- "  FAIL  $label"
        print -r -- "        expected: $expected"
        print -r -- "        actual:   $actual"
    fi
}

report_and_exit() {
    print
    if (( TESTS_FAILED == 0 )); then
        print "$TESTS_RUN passed."
        exit 0
    fi
    print "$TESTS_FAILED of $TESTS_RUN failed."
    exit 1
}
