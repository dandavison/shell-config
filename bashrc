#!/bin/bash -x

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ `whoami` = 'root' ] ; then
    prompt_char='#'
else
    prompt_char='>'
fi    

export BROWSER=firefox
export EDITOR='emacs-snapshot -nw -q'

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


# f=~/src/config/look/set-look
# [ $machine != compute_node ] && [ -e $f ] && . $f

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
    branch=$(git status 2>/dev/null | head -n1 | cut -d" " -f 4)
    # branch=$(git branch -l --contains HEAD 2>/dev/null | cut -c 3- | tr -d '()')
    [ -n "$branch" ] && echo "[$branch]"
}

case $machine in
    laptop )
	if [ `whoami` = 'root' ] ; then 
	    prompt_col=$red
	else
	    prompt_col=$blue
	fi
	## export PS1="\[\033[${prompt_col}m\]\w${prompt_char} \[\033[0m\]"
        # export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"' what did this do? set window title?
	export PROMPT_COMMAND='PS1="$(colourise $prompt_col \\w)$(colourise $red "$(git_branch)")$(colourise $prompt_col $prompt_char) "'
	;;
    *)
	prompt_col=$green
	export PS1='\[\033[${prompt_col}m\]\h:\w$prompt_char \[\033[0m\]'
	export PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"' ;;
esac
## The default on markov/blackcap is
## echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"
## export PS1='\h:\w\040'

PS2=''

[ $machine != compute_node ] && eval "`dircolors -b ~/.dircolors`"

# export PATH=$HOME/bin:${PATH%:$HOME/bin}:/sbin
export PATH=$HOME/bin:$PATH:$HOME/src/plants:/usr/local/arm-elf/bin:/usr/local/src/willgit/bin

## why do I get ~/bin twice?
[ $HOSTNAME == "oak" ] && export PATH=$HOME/lib/shellfish:$PATH


alias c='cat'
alias emacs-fast='emacs -Q -l /home/dan/src/config/emacs/vanilla.el'
alias e='echo'
alias exit='sync-history ; builtin exit'
alias f='find'
alias g='grep'
alias gd='getmail-dan'

alias gb='git branch'
alias gc='git checkout'
alias gcm='git checkout master'
alias gd='git diff'
alias gl='git log'
alias gs='git stash'
alias gst='git status'
alias gitk-all='gitk --all --simplify-by-decoration'
alias h='head'
alias gt='gthumb'
alias hs='sync-history'
alias less='less -S'
alias l='ls -lh'
alias lt='ls -lht'
alias ls='/bin/ls --color=tty'
alias mairix='mairix -t'
alias ma='mairix -t'
alias mk='mkdir'
alias m='more'
alias mutt='LANG=en mutt -y'
alias mu='mutt'
alias pol='~/src/plants/plants-org-image-links'
alias ps2pdf='ps2pdf -dAutoRotatePages=/None'
alias ps-me='ps -u `whoami`'
alias r='Rscript'
alias rlpr='ssh ddavison@hats.princeton.edu lpr -P xebutleraptsd'
alias R='R --silent --no-restore --no-save --vanilla'
alias s='sync-dirs'
alias sync-history='history -a ; history -n'
alias tm='tree | more'
alias tree='tree -AC --noreport'
alias t='tree'
alias top='top -d.8'
alias tl='topleft'
alias xdvi='xdvi -expert -s 5'
alias xpdf='xpdf -fullscreen -bg white'
alias xterm='~/src/scripts/xterm-dan'
alias x='xterm'
alias tailmessages='tail -f /var/log/messages'

# export HISTIGNORE="ls:l:exit:[ \t]*:&" ## '&' supresses duplicate entries
export HISTFILESIZE=2000
shopt -s cmdhist ## stores multiline entries as a single history entry

## http://www.caliban.org/bash/
## export CDPATH=.:~:~/docs:~/src:~/src/ops/docs:/mnt:/usr/src/redhat:/usr/src/redhat/RPMS:/usr/src:/usr/lib:/usr/local:

## export EDITOR='emacs -nw -q'

export luscinia=dan@luscinia.princeton.edu
export tichodroma=dan@tichodroma.princeton.edu
export yakuba=dan@yakuba.princeton.edu
export oak=davison@oak.well.ox.ac.uk
export gate=davison@gate.stats.ox.ac.uk ## 163.1.210.59 ## 
export genecluster=davison@genecluster.stats.ox.ac.uk ##'163.1.210.63'
export wtchg_cluster=davison@login1-cluster1.well.ox.ac.uk
export arizona=ddavison@arizona.princeton.edu

# alias ssh-zeon='ssh -X davison@zeon.well.ox.ac.uk'
# alias ssh-morgan='ssh -X davison@morgan.well.ox.ac.uk'
# alias ssh-octopus='ssh -X davison@octopus.well.ox.ac.uk'
# alias ssh-zuse='ssh -X gu-dd@zuse.osc.ox.ac.uk'
# alias ssh-queeg="ssh -X ddavison@$queeg"
# alias ssh-redqueen="ssh -X ddavison@$redqueen"

## http://linuxart.com/log/archives/2005/10/13/super-useful-inputrc/
export INPUTRC=~/.inputrc
## export R_HOME=/usr/local/src/R/R-svn-trunk
