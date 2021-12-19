_cwd=$(pwd)
cd ~/devenv/shell-config

is_zsh() {
    [ -n "$ZSH_VERSION" ]
}

if is_zsh; then
    # oh-my-zsh
    export ZSH="$HOME/.ohmyzsh"
    plugins=(fasd)
    source $ZSH/oh-my-zsh.sh
    (type sd | grep alias >/dev/null) && unalias sd
fi

source lib.sh
source lib_fzf.sh
source lib_git.sh
source lib_sourcegraph.sh
source lib_prompt.sh
if is_zsh; then
    source zsh/lib.sh
fi
source ./3p/git-prompt.sh
__dan_is_macos && source path-macos.sh
source env.sh
source pyenv.sh
__dan_is_macos && source env-macos.sh
if is_zsh; then
    source zsh/prompt.sh
    source zsh/bindings.sh
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
else
    source bash/prompt.sh
    source bash/history.sh
    source bash/completion/completion.sh
    source bash/completion/virtualenv-activate.sh
    source bash/readline.sh
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi
[ -f extra.sh ] && source extra.sh
source alias.sh
source tmux.sh

if is_zsh; then
    compdef _gnu_generic bat delta
    setopt rmstarsilent
fi

cd "$_cwd"
unset _cwd
