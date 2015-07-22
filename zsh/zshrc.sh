TMUX_BASE_SESSION_NAME=base
DIR=~/config/shell

source $DIR/lib.sh
source $DIR/lib_zsh.sh
source $DIR/path.sh

if [[ -z $TMUX ]] ; then
    tmux attach -t $TMUX_BASE_SESSION_NAME || tmux new-session -s $TMUX_BASE_SESSION_NAME
fi

source $DIR/git-functions.sh
source $DIR/env.sh
_dan_is_osx && source $DIR/osx_env.sh
source $DIR/dircolors.sh
source $DIR/zsh/zsh.sh
source $DIR/prompt.sh
source $DIR/fasd.sh
source $DIR/alias.sh
source $DIR/zsh/bindings.sh
[[ -f extra.sh ]] && source $DIR/extra.sh
source $DIR/tmux.sh
