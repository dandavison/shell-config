_cwd=$(pwd)
cd ~/src/1p/shell-config

source lib.sh
source path.sh
source git-functions.sh
source env.sh
__dan_is_osx && source osx_env.sh
source dircolors.sh
source prompt.sh
source bash/history.sh
source bash/completion.sh
source ~/src/git/contrib/completion/git-completion.bash
source fasd.sh
source readline.sh
source alias.sh
[ -f extra.sh ] && source extra.sh
source bash/alias_completion.sh
source tmux.sh

# confused
export PROMPT_COMMAND=__prompt_command

cd "$_cwd"
