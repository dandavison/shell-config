export BLACK=30  RED=31  GREEN=32  YELLOW=33  BLUE=34  MAGENTA=35  CYAN=36  WHITE=37
export __PROMPT_COL=$CYAN
export GIT_PS1_SHOWDIRTYSTATE=yes
export GIT_PS1_UNSTAGED="અ "
export GIT_PS1_STAGED="જ "

__prompt_command () {
    PS1=""
    # Python virtualenv if any
    [ -n "$VIRTUAL_ENV" ] && PS1+="($(basename $VIRTUAL_ENV))"
    # Current directory
    PS1+="$(_colorize $__PROMPT_COL "$(pwd | sed "s,$HOME,~,")")"
    # Git repository
    PS1+="$(_colorize $RED "$(__git_ps1 "(%s)")")"
    PS1+=" "
}

export PROMPT_COMMAND=__prompt_command
PS2=''
