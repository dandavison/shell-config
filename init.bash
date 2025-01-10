_cwd=$(pwd)
cd ~/src/devenv/shell-config

source lib.sh
source lib_fzf.sh
source lib_git.sh
source lib_prompt.sh
source ./3p/git-prompt.sh
__dan_is_macos && source path-macos.sh
source bash/prompt.sh
source bash/history.sh
source bash/completion/completion.sh
source bash/completion/virtualenv-activate.sh
source bash/readline.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source alias.sh

source env.sh
[ -f extra.sh ] && source extra.sh
source nvm.sh 2>/dev/null
cd "$_cwd"
unset _cwd
