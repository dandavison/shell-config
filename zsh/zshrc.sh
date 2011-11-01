_dan_is_laptop () {
    [[ $(whoami) == davison && $(hostname) == (cotinga|int)* ]]
}

if [[ -z $TMUX ]] ; then
    # Only attempt reattach in ssh session. It didn't work well with
    # iterm2 visor locally.
    if _dan_is_laptop ; then
	tmux
    else
	tmux attach || tmux
    fi
fi

_cwd=$(pwd)
cd ~/config/shell

source lib.sh
source git-functions.sh
source env.sh
source zsh/zsh.sh
source path.sh
source prompt.sh
source autojump.sh
source dircolors.sh
source alias.sh
source zsh/bindings.sh
[[ -f extra.sh ]] && source extra.sh
source tmux.sh

cd "$_cwd"
