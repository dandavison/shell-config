f-cargo-test() {
    local test
    test="$(rust-list-tests | fzf)"
    [[ -n "$test" ]] || return
    echo cargo test "$test"
    print -s "cargo test $test" # zsh
    cargo test "$test"
}

_f-hist() {
    atuin history list | fzf --no-sort --exact
}

f-hist-x() {
    eval "$(_f-hist)"
}
