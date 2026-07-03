fzf-set-environment-variables() {
    export FZF_DEFAULT_COMMAND="fd --type file --color=always"
    export FZF_DEFAULT_OPTS="\
--ansi
--border rounded
--color light
--cycle
--exact
--height 50%
--info hidden
--layout reverse
--prompt ' '
"
}

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
