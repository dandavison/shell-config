# -*-coding: utf-8;-*-
export __BLACK=30 __RED=31 __GREEN=32 __YELLOW=33 __BLUE=34 __MAGENTA=35 __CYAN=36 __WHITE=37
export GIT_PS1_SHOWDIRTYSTATE=yes
export GIT_PS1_UNSTAGED="અ "
export GIT_PS1_STAGED="જ "

__prompt_command () {
    PS1=""
    PS1+="$(__virtualenv_ps1)"
    PS1+="$(__current_directory_ps1)"
    PS1+="$(__my_git_ps1)"
    PS1+="$(__docker_compose_ps1)"
    PS1+=" "
}


__current_directory_ps1 () {
    echo -n "$(__colorize $__CYAN "$(pwd | sed "s,$HOME,~,")")"
}


__my_git_ps1 () {
    echo -n "$(__colorize $__RED "$(__git_ps1 "(%s)")")"
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


export PROMPT_COMMAND=__prompt_command
export PS2=''
