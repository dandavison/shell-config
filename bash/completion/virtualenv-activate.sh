#!/bin/bash

__virtualenv_activate_previous_extglob_setting=$(shopt -p extglob)
shopt -s extglob

__virtualenv_activate_complete_commands() {
    COMPREPLY=( $(compgen -W "${commands[*]}" -- "$cur") )
}

_virtualenv_activate_virtualenv_activate() {
    __virtualenv_activate_complete_commands
}

_virtualenv_activate() {
    local previous_extglob_setting=$(shopt -p extglob)
    shopt -s extglob

    local commands=($(ls ~/tmp/virtualenvs))

    COMPREPLY=()
    local cur prev words cword
    _get_comp_words_by_ref -n : cur prev words cword

    local command='virtualenv_activate' command_pos=0
    local counter=1
    while [ $counter -lt $cword ]; do
      case "${words[$counter]}" in
          *)
              command="${words[$counter]}"
              command_pos=$counter
              break
              ;;
      esac
      (( counter++ ))
    done

    local completions_func=_virtualenv_activate_${command}

    declare -F $completions_func >/dev/null && $completions_func

    eval "$previous_extglob_setting"
    return 0
}

eval "$__virtualenv_activate_previous_extglob_setting"
unset __virtualenv_activate_previous_extglob_setting

complete -F _virtualenv_activate python-virtualenv-activate
complete -F _virtualenv_activate pv
