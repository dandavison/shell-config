#!/usr/bin/env bash

export FIGNORE=.pyc:#:.DS_Store:.git

BASH_COMPLETION=~/lib/bash/bash_completion
BASH_COMPLETION_DIR=~/lib/bash/bash_completion.d
BASH_COMPLETION_COMPAT_DIR=~/lib/bash/bash_completion.d
source ~/lib/bash/bash_completion

source ~/lib/bash/git-completion.bash

complete -W "--stat --word-diff" gd gs
complete -W "--oneline --grep --author" gl
