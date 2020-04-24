_cwd=$(pwd)
cd ~/src/shell-config

is_zsh () { [ -n "$ZSH_VERSION" ] }

source lib.sh
is_zsh && source lib_zsh.sh
source git-functions.sh
source path.sh
source env.sh
source pyenv.sh
__dan_is_osx && source env-macos.sh
if is_zsh; then
    source zsh/zsh.sh
    source zsh/bindings.sh
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
else
    source prompt.sh
    source bash/history.sh
    source bash/completion/completion.sh
    source bash/completion/virtualenv-activate.sh
    # source ~/src/3p/git/contrib/completion/git-completion.bash  # removed to decrease shell start-up time
    source ~/src/misc/shrike.sh
    source bash/readline.sh
    [ -f extra.sh ] && source extra.sh
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi
# source gcloud.sh
source alias.sh
source tmux.sh
source ~/src/wifi/wifi.sh

unfunction is_zsh
cd "$_cwd"
unset _cwd
