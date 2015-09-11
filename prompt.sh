BLACK=30 ; RED=31 ; GREEN=32 ; YELLOW=33 ; BLUE=34 ; MAGENTA=35 ; CYAN=36 ; WHITE=37
GIT_PS1_SHOWDIRTYSTATE=yes
GIT_PS1_UNSTAGED="અ "
GIT_PS1_STAGED="જ "
__PROMPT_COL=$cyan


__prompt_command () {
    PS1=""
    # Python virtualenv if any
    [ -n "$VIRTUAL_ENV" ] && PS1+="($(basename $VIRTUAL_ENV))"
    # Current directory
    PS1+="$(_colorize $__PROMPT_COL "$(pwd | sed "s,$HOME,~,")")"
    # Git repository
    PS1+="$(_colorize $red "$(__git_ps1 "(%s)")")"
    PS1+=" "
}

export PROMPT_COMMAND=__prompt_command
PS2=''
