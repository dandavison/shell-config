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
    report_and_exit
}
main
