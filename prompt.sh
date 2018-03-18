# -*-coding: utf-8;-*-
export __BLACK=30 __RED=31 __GREEN=32 __YELLOW=33 __BLUE=34 __MAGENTA=35 __CYAN=36 __WHITE=37
export GIT_PS1_SHOWDIRTYSTATE=yes
export GIT_PS1_UNSTAGED="અ "
export GIT_PS1_STAGED="જ "


__prompt_command () {
    local exit="$?"
    __save_history_and_set_terminal_title
    __facet_prompt_commands

    PS1=""
    PS1+="$(__virtualenv_ps1)"
    PS1+="$(__current_directory_ps1 $exit)"

    local task_ps1="$(__my_git_ps1)"
    [ -n "$task_ps1" ] || task_ps1="$(__facet_ps1)"
    PS1+="$task_ps1"
    PS1+="$(__docker_compose_ps1)"
    [[ $(echo -n $PS1 | wc -c) -gt 150 ]] && PS1+="\n$"
    PS1+=" "
}


__colorize () {
    echo "\[\033[${1}m\]$2\[\033[0m\]"
}


__save_history_and_set_terminal_title () {
    cmd=$(history 1)
    echo "$cmd" >> ~/.bash_eternal_history

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

__current_directory_ps1 () {
    local col=$__CYAN
    local exit=$1
    [ "$exit" -ne 0 ] && col=$__RED
    local dir="$(pwd | sed "s,$HOME,~,")"
    echo -n $(__colorize $col "${dir}")
}

__facet_ps1() {
    (pwd | egrep -q '(counsyl|facet)' > /dev/null) &&
        echo -n "($(cat ~/.facet/state.json | jq .facet | tr -d '"\n'))"
}


__facet_prompt_commands () {
    [ -e ~/.facet/prompt-commands ] && . ~/.facet/prompt-commands
    rm -f ~/.facet/prompt-commands
}


__my_git_ps1 () {
    echo -n $(__git_ps1 "(%s)")
}


__virtualenv_ps1 () {
    [ -n "$VIRTUAL_ENV" ] || return
    echo -n "($(basename $VIRTUAL_ENV))"
}


__docker_compose_ps1 () {
    [ -n "$(__find_file_upwards docker-compose.yml .)" ] || return
    local dc_ps1=""
    local containers=$(docker-compose ps -q 2>/dev/null)
    [ -n "$containers" ] || return
    local counts=$(docker inspect --format "{{ .State.Status }}" $containers | sort | uniq -c)
    dc_ps1=""
    while read count state ; do
        case $state in
            running)
                symbol="🌵"  # ⚡ 🍏
                ;;
            exited)
                symbol="🍄"  # ⭕ 🔴 🍎
                ;;
            *)
                echo "Invalid state: '$state'" 1>&2
                return
                ;;
        esac
        dc_ps1+="$(printf "${symbol}%.0s " $(seq 1 $count))"
    done <<< "$counts"
    dc_ps1=" ($dc_ps1)"
    dc_ps1=$(__colorize $__CYAN "$dc_ps1")
    echo -n "$dc_ps1"
}


# Find first occurrence of file in parent directories
__find_file_upwards () {
    local file="$1"
    local dir=$(readlink -f "$2")

    if [[ -f "$dir/$file" ]]; then
        echo "$dir/$file"
    elif [[ "$dir" = / ]]; then
        echo
    else
        echo $(__find_file_upwards "$file" $(dirname "$dir"))
    fi
}


export PROMPT_COMMAND=__prompt_command
export PS2=''
