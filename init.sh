_cwd=$(pwd)
cd ~/src/shell-config

is_zsh () { [ -n "$ZSH_VERSION" ] }

source lib.sh
source lib_fzf.sh
source lib_prompt.sh
if is_zsh; then
    source zsh/lib.sh
fi
source git-functions.sh
source path.sh
source env.sh
source pyenv.sh
__dan_is_osx && source env-macos.sh
if is_zsh; then
    source zsh/prompt.sh
    source zsh/bindings.sh
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
else
    source bash/prompt.sh
    source bash/history.sh
    source bash/completion/completion.sh
    source bash/completion/virtualenv-activate.sh
    source ~/src/misc/shrike.sh
    source bash/readline.sh
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi
[ -f extra.sh ] && source extra.sh
source alias.sh
source tmux.sh

cd "$_cwd"
unset _cwd
