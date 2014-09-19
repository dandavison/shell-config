export FIGNORE=.pyc:#:.DS_Store:.git

BASH_COMPLETION=~/lib/shell/bash/bash_completion
BASH_COMPLETION_DIR=~/lib/shell/bash/bash_completion.d
BASH_COMPLETION_COMPAT_DIR=~/lib/shell/bash/bash_completion.d
source ~/lib/shell/bash/bash_completion

complete -W "--stat --word-diff" gd gs
complete -W "--oneline --grep --author" gl
