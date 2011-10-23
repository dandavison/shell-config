GIT_PS1_SHOWDIRTYSTATE=yes
GIT_PS1_UNSTAGED="અ "
GIT_PS1_STAGED="જ "

_host=$(hostname)

if [[ -n ${ZSH_VERSION-} ]]; then
    setopt PROMPT_SUBST
    PROMPT=""
    if [[ $(whoami) == davison && $(hostname) == "cotinga.local" ]] ; then
	:
    else
	PROMPT="%{$fg[red]%}%n%{$reset_color%}@"   # name@
	PROMPT+="%{$fg[red]%}%m%{$reset_color%}:"  # hostname
    fi

    PROMPT+="%{$fg[cyan]%}%2~%{$reset_color%}"         # cwd truncated to last two dirs
    PROMPT+="%{$fg[red]%}%(?..(%?%))%{$reset_color%} " # exit status if nonzero

    RPROMPT=$'%{${fg[green]}%}$(__git_ps1)%{${fg[default]}%}'
else
    black=30 ; red=31 ; green=32 ; yellow=33 ; blue=34 ; magenta=35 ; cyan=36 ; white=37

    if [ `whoami` != 'davison' ] ; then
	col=$red
    elif [ $(hostname) = "cotinga.local" ] ; then
	col=$cyan
	host=""
    else
	col=$red
    fi

    export PROMPT_COMMAND='PS1="$(_colorize $prompt_col $_host$(_dan_abbreviate_path $(pwd)))$(_colorize $red "$(__git_ps1 "(%s)")") "'
    PS2=''
fi
