cp() {
    if [[ ! -t 0 && $# -eq 0 ]]; then
        pbcopy
    else
        command cp "$@"
    fi
}

delta-toggle() {
    eval "export DELTA_FEATURES='$(-delta-features-toggle $1 | tee /dev/stderr)'"
}

# Wide diff context interactively (where delta pages), default context when piped.
# `-t 1` is the same signal git uses to decide whether to invoke the pager.
git() {
    if [[ -t 1 ]]; then
        GIT_DIFF_OPTS=--unified=77 command git "$@"
    else
        command git "$@"
    fi
}

# gh infers the head branch from the local branch name, which is wrong whenever the
# remote-side name differs (see `git publish`). Name it explicitly instead.
prc() {
    gh pr create --web --head "$(git pr-branch)" "$@"
}

prv() {
    gh pr view --web "$(git pr-branch)" "$@"
}
