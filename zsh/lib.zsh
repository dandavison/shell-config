cp-desktop-latest () {
    cp -r ~/Desktop/*(om[1]) $1
}

cp-tmp-latest () {
    cp -r /tmp/*(om[1]) $1
}

function insert-fzf-path-in-command-line() {
    # https://github.com/Julian/dotfiles/blob/4da75802dd2d9a7246c8b7dbbaed8a99c315a2ed/.config/zsh/commands.zsh#L44-L54
    # Copied from https://github.com/garybernhardt/selecta/blob/master/EXAMPLES.md
    local selected_path
    echo
    selected_path=$(fd --type file | fzf) || return
    LBUFFER+="${(q-)selected_path}"
    zle reset-prompt
}

zle -N insert-fzf-path-in-command-line
bindkey "^F" insert-fzf-path-in-command-line
