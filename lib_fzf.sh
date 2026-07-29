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

# Set $base to the SHA of a commit selected from git log.
basez() {
    local sha
    sha="$(f-git-select-commit)"
    [[ -n "$sha" ]] || return
    base="$sha"
    echo "base=$base"
}
