_cwd=$(pwd)
cd ~/src/shell-config

. lib.sh
. git-functions.sh
. path.sh
. env.sh
. pyenv.sh
__dan_is_osx && . env-macos.sh
. prompt.sh
. bash/history.sh
. bash/completion.sh
# . ~/src/3p/git/contrib/completion/git-completion.bash  # removed to decrease shell start-up time
. ~/src/shell-config/completion/virtualenv-activate.sh
. readline.sh
. ~/src/misc/shrike.sh
# . gcloud.sh
. alias.sh
[ -f extra.sh ] && . extra.sh
. tmux.sh
. ~/src/wifi/wifi.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

cd "$_cwd"
unset _cwd
