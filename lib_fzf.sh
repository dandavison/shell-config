fzf-emacs () {
    emacsclient -n $(fzf)
}

-fzf-git-branch-by-date () {
    git-branch-by-date | fzf | awk '{print $1}'
}

fzf-git-checkout () {
    git checkout $(-fzf-git-branch-by-date)
}

fzf-git-log () {
    git log $(-fzf-git-branch-by-date)
}

-fzf-hist () {
    dan-history | fzf --no-sort --exact
}

fzf-hist-cp () {
    -fzf-hist | tr -d "\n" | pbcopy
}

fzf-hist-x () {
    eval $(-fzf-hist)
}

fzf-kill () {
    kill "$@" $(ps aux | fzf | awk '{print $2}')
}

fzf-preview-jq () {
    # https://github.com/pawelduda/fzf-live-repl
    local file="$1"
    echo | fzf --print-query --preview "jq '{q}' < '$file'" --preview-window "top:95%"
}

fzf-preview-regex-python () {
    local input="$1"
    echo | fzf --print-query --preview-window up --preview "python -c \"
import re
print('Input: $input\n')
m = re.match({q}, '$input')
print(m.groups() if m else '<no match>')\""
}


fzf-preview-regex-sed () {
    local input="$1"
    echo | fzf \
               --print-query \
               --preview-window up \
               --preview "printf \""$input"\n\n\n─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────\n\n\n\"; echo \"$input\" | sed -E 's/\x1b\[[0-9;]*[mK]//g' | sed -E '{q}'"
}

fzf-set-environment-variables () {
    export FZF_DEFAULT_COMMAND="fd --type file --color=always"
    export FZF_DEFAULT_OPTS="--ansi"
}

fzf-tmux () {
    if [ -n "$1" ]; then
        local next_window="$1"
    else
        local next_window=$(tmux list-panes -a -F '#{session_name},#{window_index},#{pane_title}' | \
                               xsv table | \
                               fzf --exact | \
                               awk '{print $1":"$2}')
    fi
    tmux display-message -p -F '#{session_name}:#{window_index}' > /tmp/tmux-last-window
    tmux switch-client -t "$next_window"
}

tmux-back () {
    fzf-tmux $(cat /tmp/tmux-last-window)
}
