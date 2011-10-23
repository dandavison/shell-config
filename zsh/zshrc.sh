_cwd=$(pwd)
cd ~/config/shell

[[ $TERM != screen ]] && tmux

source lib.sh
source git-functions.sh
source env.sh
source zsh/zsh.sh
source zsh/path.sh
source prompt.sh
source autojump.sh
source dircolors.sh
source alias.sh
source zsh/bindings.sh
[[ -f extra.sh ]] && source extra.sh

cd "$_cwd"
