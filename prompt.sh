# -*-coding: utf-8;-*-
export GIT_PS1_SHOWDIRTYSTATE=yes
export GIT_PS1_UNSTAGED="અ "
export GIT_PS1_STAGED="જ "

export _BLACK="\[\033[0;30m\]"
export _BLACKBOLD="\[\033[1;30m\]"
export _RED="\[\033[0;31m\]"
export _REDBOLD="\[\033[1;31m\]"
export _GREEN="\[\033[0;32m\]"
export _GREENBOLD="\[\033[1;32m\]"
export _YELLOW="\[\033[0;33m\]"
export _YELLOWBOLD="\[\033[1;33m\]"
export _BLUE="\[\033[0;34m\]"
export _BLUEBOLD="\[\033[1;34m\]"
export _MAGENTA="\[\033[0;35m\]"
export _MAGENTABOLD="\[\033[1;35m\]"
export _CYAN="\[\033[0;36m\]"
export _CYANBOLD="\[\033[1;36m\]"
export _WHITE="\[\033[0;37m\]"
export _WHITEBOLD="\[\033[1;37m\]"
export _RESETCOLOR="\[\e[00m\]"

# https://dobsondev.com/2014/02/21/customizing-your-terminal/
# function prompt {
#   export PS1="\n$_RED\u $_MAGENTA@ $_GREEN\w $_RESETCOLOR$_GREENBOLD\$(git branch 2> /dev/null)\n $_BLUE[\#] → $_RESETCOLOR"
#   export PS2=" | → $RESETCOLOR"
# }


__prompt_command () {
    local exit="$?"
    __set_env_vars_from_redis
    __save_history_and_set_terminal_title
    __facet_prompt_commands
    _SHRIKE_INDEX=1
    _SHRIKE_TARGET=

    PS1=""
    PS1+="$(__virtualenv_ps1)"
    # PS1+=" $(__git_commit_ps1)"
    PS1+=" $(__current_directory_ps1 $exit)"
    PS1+=" $(__my_git_ps1)"
    # PS1+="$(__facet_ps1)"
    # PS1+="$(__docker_compose_ps1)"
    # [[ $(echo -n $PS1 | wc -c) -gt 150 ]] && PS1+="\n$"
    PS1+=" "
}

__set_env_vars_from_redis () {
    (echo >/dev/tcp/localhost/6379) 2>/dev/null && \
    eval $(redis-cli --raw hgetall env |\
           awk '{i = (NR - 1) % 2; args[i] = $1; if(i == 1) { printf("export %s=%s\n", args[0], args[1]) }}')
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
    local col=$_BLUEBOLD
    local exit=$1
    [ "$exit" -ne 0 ] && col=$_REDBOLD
    local dir="$(pwd | sed "s,$HOME,~,")"  # sed 's,.\+/,,'
    echo -n "${col}${dir}${_RESETCOLOR}"
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
    echo -n "${_BLUE}$(__git_ps1)${_RESETCOLOR}" ## YELLOW
}


__git_commit_ps1 () {
    local commit=$(git rev-parse --short HEAD 2>/dev/null)
    [ -n "$commit" ] || return
    local uncommitted=$(git diff; git diff --cached)
    [ -n "$uncommitted" ] && uncommitted=" $(md5sum - <<< "$uncommitted" | head -c 4)"
    echo -n "${_BLUE}$commit$uncommitted${_RESETCOLOR}"
}

__virtualenv_ps1 () {
    [ -n "$VIRTUAL_ENV" ] || return
    echo -n "${_BLUE}$(basename $VIRTUAL_ENV)${_RESETCOLOR}"
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
    echo -n "${_CYAN}($dc_ps1)${_RESETCOLOR}"
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

PROMPT_COMMAND=
. fasd.sh
export PROMPT_COMMAND="__prompt_command${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
export PS2=''
