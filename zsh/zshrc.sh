_dan_is_laptop () {
    [[ $(whoami) == davison && $(hostname) == (cotinga|int)* ]]
}

if [[ -z $TMUX ]] ; then
    tmux attach || tmux
fi

_cwd=$(pwd)
cd ~/config/shell

source lib.sh
source git-functions.sh
source env.sh
source dircolors.sh
source zsh/zsh.sh
source path.sh
source prompt.sh
source autojump.sh
source alias.sh
source zsh/bindings.sh
[[ -f extra.sh ]] && source extra.sh
source tmux.sh

cd "$_cwd"
