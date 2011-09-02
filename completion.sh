#!/usr/bin/env bash

export FIGNORE=.pyc:#:.DS_Store:.git
source ~/lib/bash/bash_completion
source ~/lib/bash/git-completion.bash

complete -W "--stat" gd gs
complete -W "--oneline --grep --author" gl
