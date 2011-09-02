#!/usr/bin/env bash

export FIGNORE=.pyc:#:.DS_Store:.git
GIT_PS1_STAGED="જ "
GIT_PS1_UNSTAGED="અ "
source ~/lib/bash/bash_completion
source ~/lib/bash/git-completion.bash

complete -W "--stat" gd gs
complete -W "--oneline --grep --author" gl
