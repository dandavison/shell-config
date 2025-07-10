_fzf() {
    fzf --layout reverse --exact --cycle --height 50% --info hidden --prompt ' ' --border rounded --color light "$@"
}

f-git-show-file() {
    local commit file
    commit=$(
        git log --stat --color=always "$@" |
            delta |
            fzf --layout reverse --exact --ansi --info hidden --prompt ' ' --border rounded --color light |
            awk '{print $2}'
    )
    [[ -n "$commit" ]] || return
    file=$(git show --name-only --pretty=format: "$commit" | _fzf)
    git show "$commit" "$file"
}

f-cargo-test() {
    local test
    test="$(rust-list-tests | _fzf)"
    [[ -n "$test" ]] || return
    echo cargo test "$test"
    print -s "cargo test $test" # zsh
    cargo test "$test"
}

f-cat() {
    bat --style="header,grid" "$(fd . "$1" | _fzf)"
}

f-vscode() {
    code "$(_fzf)"
}

f-docker-exec() {
    local container
    container="$(
        docker ps --format '{{.ID}}\t{{.Names}}\t{{.Image}}' |
            _fzf |
            awk '{print $1}'
    )"
    docker exec -it "$container" bash
}

f-emacs() {
    emacsclient -n "$(_fzf)"
}

f-git-branch() {
    git-branch-by-date | rg -v '^z-' | _fzf | awk '{print $1}'
}

_f-git-log() {
    git log --color=always --oneline --decorate | _fzf | awk '{print $1}'
}

f-git-checkout-branch() {
    git checkout --quiet "$(f-git-branch)"
}

f-git-checkout-commit() {
    git checkout --quiet "$(_f-git-log)"
}

f-git-diff() {
    git diff "$(fzf)"
}

f-git-diff-main() {
    git diff main "$(fzf)"
}

f-git-rebase() {
    git rebase "$(f-git-branch)"
}

f-git-rebase-interactive() {
    git rebase --interactive "$(_f-git-log)"
}

f-git-reset() {
    git reset "$(_f-git-log)"
}

f-git-reset-hard() {
    git reset --hard "$(_f-git-log)"
}

f-git-revert() {
    git revert --no-edit "$(_f-git-log)"
}

f-git-cherry-pick() {
    git cherry-pick "$(f-git-branch)"
}

f-git-log-branch() {
    git log --stat --decorate "$(f-git-branch)"
}

f-git-show() {
    git show "$(_f-git-log)"
}

_f-hist() {
    atuin history list | _fzf --no-sort --exact
}

f-hist-cp() {
    _f-hist | tr -d "\n" | pbcopy
}

f-hist-x() {
    eval "$(_f-hist)"
}

f-kill() {
    kill "$@" "$(ps | _fzf | awk '{print $1}')"
}

f-open() {
    local app
    app="$(command fd -d 1 '.+\.app' /Applications /System/Applications /System/Applications/Utilities ~/Applications/Chrome\ Apps.localized/ |
        rg -r '$2$1' '^(.*/([^/]+)\.app)/?$' |
        _fzf '--with-nth' 1 '-d' / |
        sed -E 's,[^/]+/,/,')"
    [ -n "$app" ] && open "$app"
}

f-wormhole-open() {
    local project
    project="$(command fd -d 1 . ~/src ~/src/ai ~/src/temporalio ~/tmp/3p |
        rg -v '^/Users/dan/src/(ai|temporalio)/$' |
        rg -r '$2$1' '^(.*/([^/]+))/?$' |
        _fzf '--with-nth' 1 '-d' / |
        sed -E 's,[^/]+/,/,')"
    echo "$project"
    [ -n "$project" ] && wormhole-open "$project"
}

f-preview-jq() {
    # https://github.com/pawelduda/fzf-live-repl
    local file="$1"
    echo | _fzf --print-query --preview "jq '{q}' < '$file'" --preview-window "top:95%"
}

f-preview-regex-python() {
    local input="$1"
    echo | _fzf --print-query --preview-window up --preview "python -c \"
import re
print('Input: $input\n')
m = re.match({q}, '$input')
print(m.groups() if m else '<no match>')\""
}

f-preview-regex-sed() {
    local input="$1"
    echo | _fzf \
        --print-query \
        --preview-window up \
        --preview "printf \"$input\n\n\n─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────\n\n\n\"; echo \"$input\" | sed -E 's/\x1b\[[0-9;]*[mK]//g' | sed -E '{q}'"
}

fzf-set-environment-variables() {
    export FZF_DEFAULT_COMMAND="fd --type file --color=always"
    export FZF_DEFAULT_OPTS="--ansi"
}

f-tmux() {
    if [ -n "$1" ]; then
        local next_window="$1"
    else
        local next_window
        next_window="$(
            tmux list-panes -a -F '#{session_name},#{window_index},#{pane_title}' |
                xsv table |
                _fzf --exact |
                awk '{print $1":"$2}'
        )"
    fi
    tmux display-message -p -F '#{session_name}:#{window_index}' >/tmp/tmux-last-window
    tmux switch-client -t "$next_window"
}

tmux-back() {
    f-tmux "$(cat /tmp/tmux-last-window)"
}
