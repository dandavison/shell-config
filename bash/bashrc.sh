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
. ~/src/3p/git/contrib/completion/git-completion.bash
. ~/src/shell-config/completion/virtualenv-activate.sh
# . fasd.sh
. readline.sh
. ~/src/misc/shrike.sh
. alias.sh
[ -f extra.sh ] && . extra.sh
. tmux.sh
# . ~/src/wifi/wifi.sh

export EXA_COLORS=$(tr '\n' ':' < exa-colors)

# confused
export PROMPT_COMMAND=__prompt_command

export NVM_DIR="/Users/dan/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

eval "$(jenv init -)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

cd "$_cwd"
unset _cwd
