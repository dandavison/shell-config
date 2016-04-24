_cwd=$(pwd)
cd ~/src/1p/shell-config

set -a

. lib.sh
. path.sh
. git-functions.sh
. env.sh
__dan_is_osx && . osx_env.sh
. dircolors.sh
. prompt.sh
. bash/history.sh
. bash/completion.sh
. ~/src/git/contrib/completion/git-completion.bash
. fasd.sh
. readline.sh
. alias.sh
[ -f extra.sh ] && . extra.sh
. bash/alias_completion.sh
. tmux.sh

set +a

# confused
export PROMPT_COMMAND=__prompt_command

cd "$_cwd"
