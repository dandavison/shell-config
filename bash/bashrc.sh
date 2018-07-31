_cwd=$(pwd)
cd ~/src/shell-config

. lib.sh
. path.sh
. git-functions.sh
. env.sh
__dan_is_osx && . env-macos.sh
. pyenv.sh
. dircolors.sh
. prompt.sh
. bash/history.sh
. bash/completion.sh
. ~/src/3p/git/contrib/completion/git-completion.bash
. fasd.sh
. readline.sh
. alias.sh
[ -f extra.sh ] && . extra.sh
. tmux.sh

# confused
export PROMPT_COMMAND=__prompt_command

export NVM_DIR="/Users/dan/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

cd "$_cwd"
unset _cwd
