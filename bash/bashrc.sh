_cwd=$(pwd)
cd ~/config/shell

source lib.sh
source path.sh
source git-functions.sh
source env.sh
_dan_is_osx && source osx_env.sh
source dircolors.sh
source prompt.sh
source bash/history.sh
source bash/completion.sh
source ~/lib/git/contrib/completion/git-completion.bash
source fasd.sh
source readline.sh
source alias.sh
[ -f extra.sh ] && source extra.sh
source tmux.sh

cd "$_cwd"
