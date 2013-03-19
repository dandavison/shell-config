GIT_PS1_SHOWDIRTYSTATE=yes
GIT_PS1_UNSTAGED="અ "
GIT_PS1_STAGED="જ "

if [[ -n ${ZSH_VERSION-} ]]; then

    # Prior to printing the prompt: set window name to current directory 
    function precmd () {
	tmux rename-window "$(print -Pn "%~%")"
    }

    # Prior to running a command: set window name to command name
    function preexec () {
	tmux rename-window "$1"
	# GIT_LAST_BRANCH=$(git rev-parse HEAD)
    }

    setopt PROMPT_SUBST
    PROMPT=""
    if _dan_is_laptop ; then
	:
    else
	PROMPT="%{$fg[red]%}%n%{$reset_color%}@"   # name@
	PROMPT+="%{$fg[red]%}%m%{$reset_color%}:"  # hostname
    fi

    PROMPT+="%{$fg[cyan]%}%3~%{$reset_color%}"         # cwd truncated to terminal n dirs
    PROMPT+="%{$fg[red]%}%(?..(%?%))%{$reset_color%} " # exit status if nonzero

    RPROMPT=$'%{${fg[green]}%}$(__git_ps1)%{${fg[default]}%}'
else
    black=30 ; red=31 ; green=32 ; yellow=33 ; blue=34 ; magenta=35 ; cyan=36 ; white=37

    _host=$(hostname)
    if [ `whoami` != 'davison' ] ; then
	_col=$red
    elif [ $(hostname) = "cotinga.local" ] ; then
	_col=$cyan
	_host=""
    else
	_col=$red
    fi

    export PROMPT_COMMAND='PS1="$(_colorize $_col $_host$(_dan_abbreviate_path $(pwd)))$(_colorize $red "$(__git_ps1 "(%s)")") "'
    PS2=''
fi
