fzf() {
    command fzf --layout reverse --exact --cycle --height 50% --info hidden --prompt ' ' --border rounded --color light
}

fzf-cargo-test() {
    local test="$(rust-list-tests | fzf)"
    [[ -n "$test" ]] || return
    echo cargo test "$test"
    print -s "cargo test $test" # zsh
    cargo test "$test"
}

fzf-cat() {
    bat --style="header,grid" $(fd . $1 | fzf)
}

fzf-docker-exec() {
    local container=$(
        docker ps --format '{{.ID}}\t{{.Names}}\t{{.Image}}' |
            fzf |
            awk '{print $1}'
    )
    docker exec -it $container bash
}

fzf-emacs() {
    emacsclient -n $(fzf)
}

fzf-git-branch() {
    git-branch-by-date | fzf | awk '{print $1}'
}

-fzf-git-log() {
    git log --color=always --oneline --decorate | fzf | awk '{print $1}'
}

fzf-git-checkout() {
    git checkout --quiet $(fzf-git-branch)
}

fzf-git-diff() {
    git diff $(-fzf-git-log)
}

fzf-git-rebase() {
    git rebase $(fzf-git-branch)
}

fzf-git-rebase-interactive() {
    git rebase --interactive $(-fzf-git-log)
}

fzf-git-reset() {
    git reset $(-fzf-git-log)
}

fzf-git-reset-hard() {
    git reset --hard $(-fzf-git-log)
}

fzf-git-revert() {
    git revert --no-edit $(-fzf-git-log)
}

fzf-git-cherry-pick() {
    git cherry-pick $(fzf-git-branch)
}

fzf-git-log() {
    git log --stat --decorate $(fzf-git-branch)
}

fzf-git-show() {
    git show $(-fzf-git-log)
}

-fzf-hist() {
    history | fzf --no-sort --exact
}

fzf-hist-cp() {
    -fzf-hist | tr -d "\n" | pbcopy
}

fzf-hist-x() {
    eval $(-fzf-hist)
}

fzf-kill() {
    kill "$@" $(ps aux | fzf | awk '{print $2}')
}

fzf-open() {
    open "$(ls | fzf)"
}

fzf-preview-jq() {
    # https://github.com/pawelduda/fzf-live-repl
    local file="$1"
    echo | fzf --print-query --preview "jq '{q}' < '$file'" --preview-window "top:95%"
}

fzf-preview-regex-python() {
    local input="$1"
    echo | fzf --print-query --preview-window up --preview "python -c \"
import re
print('Input: $input\n')
m = re.match({q}, '$input')
print(m.groups() if m else '<no match>')\""
}

fzf-preview-regex-sed() {
    local input="$1"
    echo | fzf \
        --print-query \
        --preview-window up \
        --preview "printf \""$input"\n\n\n─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────\n\n\n\"; echo \"$input\" | sed -E 's/\x1b\[[0-9;]*[mK]//g' | sed -E '{q}'"
}

fzf-rg() {
    local INITIAL_QUERY=""
    local RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
    FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
        fzf --bind "change:reload:$RG_PREFIX {q} || true" \
        --ansi --query "$INITIAL_QUERY" \
        --height=100% --layout=reverse
}

fzf-set-environment-variables() {
    export FZF_DEFAULT_COMMAND="fd --type file --color=always"
    export FZF_DEFAULT_OPTS="--ansi"
}

fzf-tmux() {
    if [ -n "$1" ]; then
        local next_window="$1"
    else
        local next_window=$(tmux list-panes -a -F '#{session_name},#{window_index},#{pane_title}' |
            xsv table |
            fzf --exact |
            awk '{print $1":"$2}')
    fi
    tmux display-message -p -F '#{session_name}:#{window_index}' >/tmp/tmux-last-window
    tmux switch-client -t "$next_window"
}

tmux-back() {
    fzf-tmux $(cat /tmp/tmux-last-window)
}
