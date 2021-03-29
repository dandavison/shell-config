__prompt_command () {
    local __exit_for_bash_ps1="$?"
    __save_history_and_set_terminal_title
}

__set_env_vars_from_redis () {
    eval $(redis-cli --raw hgetall env |\
           awk '{i = (NR - 1) % 2; args[i] = $1; if(i == 1) { printf("export %s=%s\n", args[0], args[1]) }}')
}

__save_history_and_set_terminal_title () {

    if ! is_zsh; then
        cmd=$(history 1)
        echo "$cmd" >> $DAN_ETERNAL_HISTORY_FILE
    fi

    if [[ $cmd == *ssh* ]]; then
        # TODO: this doesn't work; use https://github.com/rcaloras/bash-preexec
        local title=$(echo "ssh ${cmd##*ssh}")
    else
        local title="$(pwd | sed "s,$HOME,~,")"
    fi
    printf "\033]2;${title}\033\\"  # set terminal/pty/tmux pane title

    # http://iterm2.com/documentation-escape-codes.html
    # https://groups.google.com/forum/#!msg/iterm2-discuss/Lz7mx06Bxg8/ae9SKC803DkJ;context-place=forum/iterm2-discuss
    # builtin echo -e "\033]50;CurrentDir=$(pwd)\007"

    echo $PWD > /tmp/cwd
}

__facet_prompt_commands () {
    [ -e ~/.facet/prompt-commands ] && . ~/.facet/prompt-commands
    rm -f ~/.facet/prompt-commands
}
