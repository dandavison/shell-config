#!/usr/bin/env bash

black=30 ; red=31 ; green=32 ; yellow=33 ; blue=34 ; magenta=35 ; cyan=36 ; white=37

if [ `whoami` = 'root' ] ; then
    prompt_char='#'
    prompt_col=$red
else
    prompt_char=''
    prompt_col=$cyan
fi

_host=$HOSTNAME:
if [ $_dan_system = 'Darwin' ] ; then
    _host=''
fi

export PROMPT_COMMAND='PS1="$(_colorize $prompt_col $_host$(_dan_abbreviate_path $(pwd)))$(_colorize $red "$(__git_ps1)") "'

PS2=''
