#!/bin/bash

if [ `whoami` = 'root' ] ; then
    prompt_char='#'
else
    prompt_char='>'
fi    

case $HOSTNAME in
    Luscinia | Tichodroma | Microtus )
	machine=laptop ;;
    gate )
	machine=gate ;;
    genecluster )
	machine=genecluster
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/local/lib:/usr/local/lib64
	;;
    zuse )
	machine=zuse ;;
    redqueen )
	machine=redqueen
	which module > /dev/null && {
	    module load intel-compilers
	    module load intel-mkl
	}
	;;
    queeg )
	machine=queeg
	which module > /dev/null && {
	    module load pgi
	}
	;;
    comp* )
	machine=compute_node ;;
    * )
	machine=other ;;
esac


## Setting xterm name (shown in ion tabs) is done with the PROMPT_COMMAND variable
## see http://www.ibiblio.org/pub/Linux/docs/HOWTO/Xterm-Title
## an excerpt from which follows:
# ----------------------------------
# 3.1.  xterm escape sequences
#   Window and icon titles may be changed in a running xterm by using
#   XTerm escape sequences. The following sequences are useful in this
#   respect:
#   ·  ESC]0;stringBEL -- Set icon name and window title to string
#   ·  ESC]1;stringBEL -- Set icon name to string
#   ·  ESC]2;stringBEL -- Set window title to string
#      where ESC is the escape character (\033), and BEL is the bell
#      character (\007).
#   Printing one of these sequences within the xterm will cause the window
#   or icon title to be changed.
# -----------------------------------
## see also bash cookbook section 16.2
black=30 ; red=31 ; green=32 ; yellow=33 ; blue=34 ; magenta=35 ; cyan=36 ; white=37


function colourise {
    echo "\[\033[${1}m\]$2\[\033[0m\]"
}

function git_branch {
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}

export _system=`uname`

host=$HOSTNAME:
if [ $host = 'Luscinia:' ] || [ $_system = 'Darwin' ] ; then
    host=''
fi

case $machine in
    * )
	if [ `whoami` = 'root' ] ; then 
	    prompt_col=$red
	else
	    prompt_col=$blue
	fi
	## export PS1="\[\033[${prompt_col}m\]\w${prompt_char} \[\033[0m\]"
        # export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"' what did this do? set window title?
	export PROMPT_COMMAND='PS1="$(colourise $prompt_col $host\\w)$(colourise $red "$(git_branch)")$(colourise $prompt_col $prompt_char) "'
	;;
    * )
	prompt_col=$blue
	export PS1='\[\033[${prompt_col}m\]\h:\w$prompt_char \[\033[0m\]'
	export PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"' ;;
esac
## The default on markov/blackcap is
## echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"
## export PS1='\h:\w\040'

PS2=''

source ~/config/bash/shellrc

## http://linuxart.com/log/archives/2005/10/13/super-useful-inputrc/
export INPUTRC=~/.inputrc
## export R_HOME=/usr/local/src/R/R-svn-trunk

[ $machine != compute_node ] && eval "`dircolors -b ~/.dircolors`"

# export HISTIGNORE="ls:l:exit:[ \t]*:&" ## '&' supresses duplicate entries
export HISTFILESIZE=2000
shopt -s cmdhist ## stores multiline entries as a single history entry

## http://www.caliban.org/bash/
## export CDPATH=.:~:~/docs:~/src:~/src/ops/docs:/mnt:/usr/src/redhat:/usr/src/redhat/RPMS:/usr/src:/usr/lib:/usr/local:

source ~/config/bash/git-completion.bash 
