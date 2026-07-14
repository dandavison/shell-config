source ~/tmp/3p/zsh-defer/zsh-defer.plugin.zsh

_cwd=$(pwd)
cd ~/src/devenv/shell-config

setopt nounset
setopt interactivecomments
setopt rmstarsilent
setopt AUTO_CD
autoload -U colors && colors

source ./3p/git-prompt.sh
source lib.sh
source zsh/env.zsh
source env.sh
source path-macos.sh
source completion.sh
source zsh/prompt.zsh
source zsh/bindings.zsh
source ~/src/wormhole/shell/lib.sh
source secret.sh
source zsh/atuin-history/atuin.zsh
source ../temporal/temporal.sh
source alias.sh

cd "$_cwd"
unset _cwd

source ~/src/wormhole/shell/zsh/prompt.sh

if [ -z "$SKIP_XOLMIS" ]; then
    SKIP_XOLMIS=1 xolmis
fi

zsh-defer source ~/src/devenv/shell-config/zsh/atuin-history/history.zsh
zsh-defer source ~/src/devenv/shell-config/zsh/syntax-highlighting.zsh
