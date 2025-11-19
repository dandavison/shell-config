_fzf() {
    command fzf \
    --layout reverse \
    --exact \
    --cycle \
    --height 50% \
    --info hidden \
    --prompt ' ' \
    --border rounded \
    --color light \
    "$@"
}

f-git-show-file() {
    local commit file
    commit=$(
        git log --stat --color=always "$@" |
            delta |
            _fzf |
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
    app="$(command fd -d 1 '.+\.app' /Applications ~/Applications/Chrome\ Apps.localized/ |
        rg -r '$2$1' '^(.*/([^/]+)\.app)/?$' |
        _fzf --with-nth 1 '-d' / |
        sed -E 's,[^/]+/,/,')"
    [ -n "$app" ] && open "$app"
}

f-wormhole-open() {
    local project
    local dirs="$(command fd -d 1 . ~/src ~/src/temporalio ~/src/temporalio/projects ~/src/temporal/repos ~/tmp/3p)"
    dirs+="\n/Users/dan/src/temporal/repos/sdk-python/temporalio/bridge/sdk-core"
    project="$(echo "$dirs" |
        rg -v '^/Users/dan/src/(temporalio|temporalio/projects)/$' |
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

f-tmux-back() {
    f-tmux "$(cat /tmp/tmux-last-window)"
}

f-workspace() {
    echo temporal nexus ai | tr ' ' '\n' | _fzf > /tmp/ws
}

f-visible-word() {
    f-word-from-stdin <<<"$(tmux capture-pane -p)"
}

f-word-from-stdin() {
    rg -o '[[:alnum:]_.,/~@#+=:-]{4,}' |
    rg '[[:alpha:]]' |
    LC_ALL=C sort -u |
    _fzf
}

f-git-stash-list() {
    local selected
    selected="$(
        git stash list --date=relative |
        # Transform: stash@{TIME}: On branch: DATE message
        # Into: INDEX|{TIME}: On branch: message
        sed -E 's/^stash@//' |                          # Remove stash@ prefix
        sed -E 's/^(\{[^}]+\}): /\1|/' |                # Replace first ": " with "|" to separate time
        nl -v 0 -w 1 -s '|' |                           # Add line numbers
        awk -F'|' '{
            # $1 = line number, $2 = {TIME}, $3 = description with date
            idx = $1
            time = $2
            desc = $3
            # Remove the date timestamp (YYYY-MM-DD HH:MM) from description
            gsub(/[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}[ ]?/, "", desc)
            printf "%s|%s: %s\n", idx, time, desc
        }' |
        _fzf --with-nth 2.. --delimiter '|' |           # Display only the formatted part
        cut -d'|' -f1                                   # Extract the index
    )"
    [ -n "$selected" ] && echo -n "stash@{$selected}"
}