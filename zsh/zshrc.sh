_cwd=$(pwd)
cd ~/config/shell

source lib.sh
source lib_zsh.sh
source path.sh

if [[ -z $TMUX ]] ; then
    tmux attach || tmux
fi

source git-functions.sh
_dan_is_osx && source osx_env.sh
source dircolors.sh
source zsh/zsh.sh
source prompt.sh
source fasd.sh
source alias.sh
source zsh/bindings.sh
[[ -f extra.sh ]] && source extra.sh
source tmux.sh

cd "$_cwd"

