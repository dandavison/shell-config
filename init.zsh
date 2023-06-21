_cwd=$(pwd)
cd ~/src/devenv/shell-config

source lib.sh
source lib_fzf.sh
source lib_git.sh
source zsh/lib.zsh
source ./3p/git-prompt.sh

__dan_is_macos && source path-macos.sh

autoload -U colors && colors

autoload -Uz compinit && compinit
compdef _gnu_generic bat delta

source zsh/prompt.zsh

source zsh/bindings.zsh

source alias.sh

setopt rmstarsilent
source zsh/syntax-highlighting.zsh

source env.sh
source zsh/env.zsh
[ -f secret.sh ] && source secret.sh

source zsh/pm.zsh
source pyenv.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source nvm.sh 2>/dev/null
source ~/tmp/3p/zsh-gpt/zsh-gpt.plugin.zsh

cd "$_cwd"
unset _cwd
