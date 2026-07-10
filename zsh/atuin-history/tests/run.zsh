#!/usr/bin/env zsh
set -u
SCRIPT_DIR=${0:A:h}
source "$SCRIPT_DIR/helpers.zsh"
source "$SCRIPT_DIR/../history.zsh"

test_up_empty_prefix_returns_most_recent() {
    print "test_up_empty_prefix_returns_most_recent"
    setup_atuin_isolated
    seed_history "ls" "git status" "git log" "grep foo" "pwd"
    reset_widget_state
    my-history-prefix-search-backward-widget
    assert_eq "UP with empty prefix returns newest command" "pwd" "$BUFFER"
    assert_eq "CURSOR at end of buffer" "${#BUFFER}" "$CURSOR"
    assert_eq "offset advanced to 0" "0" "$MY_HISTORY_SEARCH_OFFSET"
    teardown_atuin_isolated
}

test_up_twice_walks_backward_in_time() {
    print "test_up_twice_walks_backward_in_time"
    setup_atuin_isolated
    seed_history "ls" "git status" "git log" "grep foo" "pwd"
    reset_widget_state
    my-history-prefix-search-backward-widget
    assert_eq "first UP newest" "pwd" "$BUFFER"
    mark_lastwidget_backward
    my-history-prefix-search-backward-widget
    assert_eq "second UP second-newest" "grep foo" "$BUFFER"
    mark_lastwidget_backward
    my-history-prefix-search-backward-widget
    assert_eq "third UP third-newest" "git log" "$BUFFER"
    teardown_atuin_isolated
}

test_up_then_down_returns_to_newer() {
    print "test_up_then_down_returns_to_newer"
    setup_atuin_isolated
    seed_history "ls" "git status" "git log" "grep foo" "pwd"
    reset_widget_state
    my-history-prefix-search-backward-widget
    mark_lastwidget_backward
    my-history-prefix-search-backward-widget
    assert_eq "after 2x UP, buffer is second-newest" "grep foo" "$BUFFER"
    mark_lastwidget_backward
    my-history-prefix-search-forward-widget
    assert_eq "DOWN returns to newest" "pwd" "$BUFFER"
    teardown_atuin_isolated
}

test_down_at_start_does_nothing() {
    print "test_down_at_start_does_nothing"
    setup_atuin_isolated
    seed_history "ls" "git status" "pwd"
    reset_widget_state
    LBUFFER="typed text"
    BUFFER="typed text"
    my-history-prefix-search-forward-widget
    assert_eq "DOWN before any UP leaves buffer alone" "typed text" "$BUFFER"
    teardown_atuin_isolated
}

test_up_with_prefix_strict_match() {
    print "test_up_with_prefix_strict_match"
    setup_atuin_isolated
    seed_history "ls" "git status" "git log --oneline" "grep foo" "git commit"
    reset_widget_state
    LBUFFER="git "
    my-history-prefix-search-backward-widget
    assert_eq "UP with 'git ' prefix returns newest git-prefixed" "git commit" "$BUFFER"
    mark_lastwidget_backward
    my-history-prefix-search-backward-widget
    assert_eq "next UP returns next-newest git-prefixed" "git log --oneline" "$BUFFER"
    mark_lastwidget_backward
    my-history-prefix-search-backward-widget
    assert_eq "next UP returns third-newest git-prefixed" "git status" "$BUFFER"
    teardown_atuin_isolated
}

test_up_with_prefix_skips_non_matching() {
    print "test_up_with_prefix_skips_non_matching"
    setup_atuin_isolated
    seed_history "git status" "ls" "pwd" "git log" "grep foo" "git commit"
    reset_widget_state
    LBUFFER="git "
    my-history-prefix-search-backward-widget
    assert_eq "UP with 'git ' returns newest matching across non-matching" "git commit" "$BUFFER"
    mark_lastwidget_backward
    my-history-prefix-search-backward-widget
    assert_eq "next UP skips non-matching entries" "git log" "$BUFFER"
    teardown_atuin_isolated
}

test_prefix_not_substring() {
    print "test_prefix_not_substring"
    setup_atuin_isolated
    seed_history "git log" "git status" "git commit"
    reset_widget_state
    LBUFFER="it"
    BUFFER="it"
    my-history-prefix-search-backward-widget
    assert_eq "'it' does not match 'git ...' (no substring/fuzzy)" "it" "$BUFFER"
    teardown_atuin_isolated
}

test_no_matches_leaves_buffer_unchanged() {
    print "test_no_matches_leaves_buffer_unchanged"
    setup_atuin_isolated
    seed_history "ls" "pwd" "cd /tmp"
    reset_widget_state
    LBUFFER="xyz"
    BUFFER="xyz"
    my-history-prefix-search-backward-widget
    assert_eq "unmatched prefix leaves buffer" "xyz" "$BUFFER"
    teardown_atuin_isolated
}

test_prefix_locked_on_first_press() {
    print "test_prefix_locked_on_first_press"
    setup_atuin_isolated
    seed_history "git status" "git log" "git commit"
    reset_widget_state
    LBUFFER="git "
    my-history-prefix-search-backward-widget
    assert_eq "first UP gets newest git-prefixed" "git commit" "$BUFFER"
    mark_lastwidget_backward
    my-history-prefix-search-backward-widget
    assert_eq "second UP still uses locked prefix, not updated BUFFER" "git log" "$BUFFER"
    teardown_atuin_isolated
}

test_down_past_newest_restores_typed_text() {
    print "test_down_past_newest_restores_typed_text"
    setup_atuin_isolated
    seed_history "git log" "git status" "git commit"
    reset_widget_state
    LBUFFER="git "
    BUFFER="git "
    my-history-prefix-search-backward-widget
    assert_eq "UP reaches newest match" "git commit" "$BUFFER"
    mark_lastwidget_backward
    my-history-prefix-search-forward-widget
    assert_eq "DOWN past newest restores originally-typed text" "git " "$BUFFER"
    assert_eq "offset reset to -1 sentinel" "-1" "$MY_HISTORY_SEARCH_OFFSET"
    teardown_atuin_isolated
}

test_prefix_starting_with_dash_is_literal() {
    print "test_prefix_starting_with_dash_is_literal"
    setup_atuin_isolated
    seed_history "ls" "--help me" "pwd"
    reset_widget_state
    LBUFFER="--"
    BUFFER="--"
    my-history-prefix-search-backward-widget
    assert_eq "UP with '--' prefix matches literal, not flag" "--help me" "$BUFFER"
    teardown_atuin_isolated
}

test_prefix_with_single_quote_is_handled() {
    print "test_prefix_with_single_quote_is_handled"
    setup_atuin_isolated
    seed_history "ls" "echo 'hello world'" "pwd"
    reset_widget_state
    LBUFFER="echo '"
    BUFFER="echo '"
    my-history-prefix-search-backward-widget
    assert_eq "prefix with single quote matches literally" "echo 'hello world'" "$BUFFER"
    teardown_atuin_isolated
}

test_duplicates_are_collapsed() {
    print "test_duplicates_are_collapsed"
    setup_atuin_isolated
    seed_history "ls" "pwd" "ls" "pwd" "ls"
    reset_widget_state
    my-history-prefix-search-backward-widget
    assert_eq "first UP returns newest unique" "ls" "$BUFFER"
    mark_lastwidget_backward
    my-history-prefix-search-backward-widget
    assert_eq "second UP skips duplicate 'ls', returns 'pwd'" "pwd" "$BUFFER"
    teardown_atuin_isolated
}

test_pin_directory_scopes_to_descendants() {
    print "test_pin_directory_scopes_to_descendants"
    setup_atuin_isolated
    mkdir -p "$TEST_TMPDIR/scope/sub" "$TEST_TMPDIR/other"
    local saved_pwd=$PWD
    (cd "$TEST_TMPDIR/other"      && seed_history "in other")
    (cd "$TEST_TMPDIR/scope"      && seed_history "in scope")
    (cd "$TEST_TMPDIR/scope/sub"  && seed_history "in scope sub")
    (cd "$TEST_TMPDIR/other"      && seed_history "in other 2")
    cd "$TEST_TMPDIR/scope"
    export DAN_HISTORY_SEARCH_PIN_DIRECTORY=1
    reset_widget_state
    my-history-prefix-search-backward-widget
    assert_eq "first UP: newest in-scope is a subdir command" "in scope sub" "$BUFFER"
    mark_lastwidget_backward
    my-history-prefix-search-backward-widget
    assert_eq "second UP: next in-scope is the $PWD command" "in scope" "$BUFFER"
    mark_lastwidget_backward
    my-history-prefix-search-backward-widget
    assert_eq "third UP: out-of-scope not returned, buffer stays" "in scope" "$BUFFER"
    unset DAN_HISTORY_SEARCH_PIN_DIRECTORY
    cd "$saved_pwd"
    teardown_atuin_isolated
}

test_pin_directory_unset_ignores_cwd() {
    print "test_pin_directory_unset_ignores_cwd"
    setup_atuin_isolated
    mkdir -p "$TEST_TMPDIR/scope" "$TEST_TMPDIR/other"
    local saved_pwd=$PWD
    (cd "$TEST_TMPDIR/scope" && seed_history "in scope")
    (cd "$TEST_TMPDIR/other" && seed_history "in other")
    cd "$TEST_TMPDIR/scope"
    unset DAN_HISTORY_SEARCH_PIN_DIRECTORY
    reset_widget_state
    my-history-prefix-search-backward-widget
    assert_eq "without pin: newest across all dirs" "in other" "$BUFFER"
    cd "$saved_pwd"
    teardown_atuin_isolated
}

test_pin_directory_combined_with_prefix() {
    print "test_pin_directory_combined_with_prefix"
    setup_atuin_isolated
    mkdir -p "$TEST_TMPDIR/scope" "$TEST_TMPDIR/other"
    local saved_pwd=$PWD
    (cd "$TEST_TMPDIR/other" && seed_history "git status")
    (cd "$TEST_TMPDIR/scope" && seed_history "git log")
    (cd "$TEST_TMPDIR/scope" && seed_history "ls")
    (cd "$TEST_TMPDIR/other" && seed_history "git push")
    cd "$TEST_TMPDIR/scope"
    export DAN_HISTORY_SEARCH_PIN_DIRECTORY=1
    reset_widget_state
    LBUFFER="git "
    my-history-prefix-search-backward-widget
    assert_eq "prefix + pin: only in-scope git commands" "git log" "$BUFFER"
    unset DAN_HISTORY_SEARCH_PIN_DIRECTORY
    cd "$saved_pwd"
    teardown_atuin_isolated
}

test_glob_substring_match() {
    print "test_glob_substring_match"
    setup_atuin_isolated
    seed_history "ls" "git status" "make build" "curl --force foo" "pwd"
    reset_widget_state
    LBUFFER="*force*"
    BUFFER="*force*"
    my-history-prefix-search-backward-widget
    assert_eq "substring glob matches middle of command" "curl --force foo" "$BUFFER"
    teardown_atuin_isolated
}

test_glob_suffix_match() {
    print "test_glob_suffix_match"
    setup_atuin_isolated
    seed_history "cat foo.py" "ls bar.rs" "cat baz.rs" "pwd"
    reset_widget_state
    LBUFFER="*.rs"
    BUFFER="*.rs"
    my-history-prefix-search-backward-widget
    assert_eq "suffix glob matches newest .rs command" "cat baz.rs" "$BUFFER"
    mark_lastwidget_backward
    my-history-prefix-search-backward-widget
    assert_eq "walks to next .rs command" "ls bar.rs" "$BUFFER"
    teardown_atuin_isolated
}

test_glob_middle_wildcard() {
    print "test_glob_middle_wildcard"
    setup_atuin_isolated
    seed_history "git status" "git push origin main" "git push -u origin feat" "ls"
    reset_widget_state
    LBUFFER="git*push*"
    BUFFER="git*push*"
    my-history-prefix-search-backward-widget
    assert_eq "middle wildcard matches newest git...push" "git push -u origin feat" "$BUFFER"
    teardown_atuin_isolated
}

test_glob_question_mark_single_char() {
    print "test_glob_question_mark_single_char"
    setup_atuin_isolated
    seed_history "ls" "cd" "pwd" "rm" "cat"
    reset_widget_state
    LBUFFER="??"
    BUFFER="??"
    my-history-prefix-search-backward-widget
    assert_eq "?? matches a 2-char command" "rm" "$BUFFER"
    mark_lastwidget_backward
    my-history-prefix-search-backward-widget
    assert_eq "walks to next 2-char command" "cd" "$BUFFER"
    mark_lastwidget_backward
    my-history-prefix-search-backward-widget
    assert_eq "walks to next 2-char command" "ls" "$BUFFER"
    teardown_atuin_isolated
}

test_glob_auto_detect_no_wildcards_is_still_prefix() {
    print "test_glob_auto_detect_no_wildcards_is_still_prefix"
    setup_atuin_isolated
    seed_history "ls foo" "git log" "cat foo git" "git status"
    reset_widget_state
    LBUFFER="git "
    BUFFER="git "
    my-history-prefix-search-backward-widget
    assert_eq "no wildcards: prefix, not substring" "git status" "$BUFFER"
    teardown_atuin_isolated
}

test_cache_refill_walks_past_batch_boundary() {
    print "test_cache_refill_walks_past_batch_boundary"
    setup_atuin_isolated
    seed_history "c1" "c2" "c3" "c4" "c5" "c6" "c7"
    reset_widget_state
    local saved_batch=$MY_HISTORY_SEARCH_CACHE_BATCH
    MY_HISTORY_SEARCH_CACHE_BATCH=3
    my-history-prefix-search-backward-widget
    assert_eq "UP 1" "c7" "$BUFFER"
    mark_lastwidget_backward
    my-history-prefix-search-backward-widget
    my-history-prefix-search-backward-widget
    assert_eq "UP 3 (at batch edge)" "c5" "$BUFFER"
    assert_eq "cache has first batch only" "3" "${#MY_HISTORY_SEARCH_CACHE}"
    my-history-prefix-search-backward-widget
    assert_eq "UP 4 (triggers refill)" "c4" "$BUFFER"
    assert_eq "cache grew after refill" "6" "${#MY_HISTORY_SEARCH_CACHE}"
    my-history-prefix-search-backward-widget
    my-history-prefix-search-backward-widget
    my-history-prefix-search-backward-widget
    assert_eq "UP 7 (past last match, stays)" "c1" "$BUFFER"
    assert_eq "cache exhausted flag set" "1" "$MY_HISTORY_SEARCH_CACHE_EXHAUSTED"
    MY_HISTORY_SEARCH_CACHE_BATCH=$saved_batch
    teardown_atuin_isolated
}

test_multiline_command_retrieved_intact() {
    print "test_multiline_command_retrieved_intact"
    setup_atuin_isolated
    local ml=$'ct temporal --env test \\\n    workflow show \\\n    --workflow-id \'{"a":"b"}\''
    seed_history "ls" "$ml" "pwd"
    reset_widget_state
    my-history-prefix-search-backward-widget
    assert_eq "first UP is single-line newest" "pwd" "$BUFFER"
    mark_lastwidget_backward
    my-history-prefix-search-backward-widget
    assert_eq "second UP returns whole multiline command, not one line" "$ml" "$BUFFER"
    teardown_atuin_isolated
}

main() {
    test_up_empty_prefix_returns_most_recent
    test_up_twice_walks_backward_in_time
    test_up_then_down_returns_to_newer
    test_down_at_start_does_nothing
    test_up_with_prefix_strict_match
    test_up_with_prefix_skips_non_matching
    test_prefix_not_substring
    test_no_matches_leaves_buffer_unchanged
    test_prefix_locked_on_first_press
    test_down_past_newest_restores_typed_text
    test_prefix_starting_with_dash_is_literal
    test_prefix_with_single_quote_is_handled
    test_duplicates_are_collapsed
    test_pin_directory_scopes_to_descendants
    test_pin_directory_unset_ignores_cwd
    test_pin_directory_combined_with_prefix
    test_glob_substring_match
    test_glob_suffix_match
    test_glob_middle_wildcard
    test_glob_question_mark_single_char
    test_glob_auto_detect_no_wildcards_is_still_prefix
    test_cache_refill_walks_past_batch_boundary
    test_multiline_command_retrieved_intact
    report_and_exit
}
main
