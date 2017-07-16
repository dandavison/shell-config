_cwd=$(pwd)
cd ~/src/shell-config

. lib.sh
. lib_zsh.sh
. path.sh

. git-functions.sh
. env.sh
__dan_is_osx && . osx_env.sh
. dircolors.sh
. zsh/zsh.sh
. prompt.sh
. fasd.sh
. alias.sh
. zsh/bindings.sh
[[ -f extra.sh ]] && . extra.sh
. tmux.sh

cd "$_cwd"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
