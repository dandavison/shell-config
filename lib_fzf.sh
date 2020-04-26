-fzf-hist-1 () {
    fzf --tac --no-sort < ~/.eternal_shell_history | \
        perl -p -e 's,^ *[^ ]+ *[^ ]+ *,,' | \
        perl -p -e chomp | \
        pbcopy
}

-fzf-hist () {
    hist | tr -s " " | cut -d " " -f 4- | fzf --no-sort --exact
}

fzf-hist-cp () {
    -fzf-hist | tr -d "\n" | pbcopy
}

fzf-hist-x () {
    eval $(-fzf-hist)
}

fzf-maybe () {
    [ -n "$FZF" ] && $@ | fzf
}

fzf-maybe-emacsclient () {
    emacsclient -n $(fzf-maybe git ls-files)
}

fzf-maybe-git-checkout () {
    git checkout $(fzf-maybe git branch --sort=-committerdate)
}

fzf-maybe-git-cherry-pick () {
    git cherry-pick $(git branch | fzf-maybe)
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
    echo | fzf --print-query --preview-window up --preview "echo Input: $input; echo; echo $input | sed 's	{q}	X	'"
}

fzf-tmux () {
    tmux switch-client -t $(tmux list-panes -a -F '#{session_name},#{window_index},#{pane_title}' | \
                            xsv table | \
                            fzf --exact | \
                            awk '{print $1":"$2}')
}
