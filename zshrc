_cwd=$(pwd)
cd ~/config/shell

autoload -U compinit
compinit

autoload -U colors
colors

source lib.sh
source env.sh
source zsh/path.sh
source prompt.sh
# source history.sh
source ~/lib/git/contrib/completion/git-completion.bash
# source autojump.sh
# source readline.sh
source dircolors.sh
source alias.sh
# [ -f extra.sh ] && source extra.sh

cd "$_cwd"
