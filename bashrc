#!/bin/bash

black=30 ; red=31 ; green=32 ; yellow=33 ; blue=34 ; magenta=35 ; cyan=36 ; white=37

function _colorize {
    echo "\[\033[${1}m\]$2\[\033[0m\]"
}
function _dan_git_branch {
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
function _dan_abbreviate_path {
    path=$(echo "$1" | sed "s,$HOME,~,")
    abbrv=$(echo "$path" | sed 's,^.*/.*/\(.*/.*\)$,\1,')
    [ "$abbrv" = "$path" ] && echo "$path" || echo ../$abbrv
}

export _system=`uname`

if [ `whoami` = 'root' ] ; then
    prompt_char='#'
    prompt_col=$red
else
    prompt_char=''
    prompt_col=$cyan
fi

host=$HOSTNAME:
if [ $host = 'Luscinia:' ] || [ $_system = 'Darwin' ] ; then
    host=''
fi

export PROMPT_COMMAND='PS1="$(_colorize $prompt_col $host$(_dan_abbreviate_path $(pwd)))$(_colorize $red "$(_dan_git_branch)") "'

PS2=''

source ~/config/bash/shellrc

# http://linuxart.com/log/archives/2005/10/13/super-useful-inputrc/
export INPUTRC=~/.inputrc
bind 'set blink-matching-paren on'

[ $machine != compute_node ] && eval "`dircolors -b ~/.dircolors`"

export HISTIGNORE="ls:ll:cd:rm:beh:[ \t]*:&" # '&' supresses duplicate entries
export HISTFILESIZE=10000
shopt -s cmdhist                             # store multiline entries as a single history entry

# http://www.debian-administration.org/articles/543
export HISTTIMEFORMAT="%s "
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"
PROMPT_COMMAND=$PROMPT_COMMAND'echo $PWD "$(history 1)" >> ~/.bash_eternal_history'

## http://www.caliban.org/bash/
## export CDPATH=.:~:~/docs:~/src:~/src/ops/docs:/mnt:/usr/src/redhat:/usr/src/redhat/RPMS:/usr/src:/usr/lib:/usr/local:

source ~/config/bash/git-completion.bash
if [ -f `brew --prefix`/etc/autojump ]; then
  . `brew --prefix`/etc/autojump
  # Redefine autojump's j so as not to echo the new location
  function j { new_path="$(autojump $@)"; [ -n "$new_path" ] && cd "$new_path" ; }
fi

source ~/config/bash/bash_completion
