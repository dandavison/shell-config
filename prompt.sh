export __BLACK=30 __RED=31 __GREEN=32 __YELLOW=33 __BLUE=34 __MAGENTA=35 __CYAN=36 __WHITE=37
export GIT_PS1_SHOWDIRTYSTATE=yes
export GIT_PS1_UNSTAGED="અ "
export GIT_PS1_STAGED="જ "

__prompt_command () {
    PS1=""
    # Python virtualenv if any
    [ -n "$VIRTUAL_ENV" ] && PS1+="($(basename $VIRTUAL_ENV))"
    # Current directory
    PS1+="$(_colorize $__CYAN "$(pwd | sed "s,$HOME,~,")")"
    # Git repository
    PS1+="$(_colorize $__RED "$(__git_ps1 "(%s)")")"
    PS1+=" "
}

export PROMPT_COMMAND=__prompt_command
export PS2=''
