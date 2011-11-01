[[ -z $TMUX ]] && { tmux attach || tmux }

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
