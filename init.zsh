_cwd=$(pwd)
cd ~/src/devenv/shell-config

zmodload zsh/datetime  # $EPOCHREALTIME: fork-free microsecond clock

function tsource {
    if false; then
        source "$1"
    else
        local __start=$EPOCHREALTIME
        source "$1"
        printf '%s: %.0f ms\n' "$1" $(( (EPOCHREALTIME - __start) * 1000 ))
    fi
}

setopt interactivecomments
setopt rmstarsilent
setopt AUTO_CD
autoload -U colors && colors

tsource ~/tmp/3p/zsh-defer/zsh-defer.plugin.zsh

# Deferred to just after the first prompt. Pass an absolute path: deferred tasks
# run after init.zsh cd's back to the original directory.
zsh-defer source $PWD/zsh/atuin-history/history.zsh  # atuin up/down history-search widgets
tsource ./3p/git-prompt.sh
tsource zsh/env.zsh
tsource env.sh
tsource path-macos.sh
tsource completion.sh
tsource zsh/prompt.zsh
tsource zsh/bindings.zsh
tsource ~/src/wormhole/shell/lib.sh
zsh-defer source $PWD/zsh/syntax-highlighting.zsh
tsource secret.sh
tsource zsh/atuin-history/atuin.zsh
tsource ../temporal/temporal.sh
tsource alias.sh

cd "$_cwd"
unset _cwd

tsource ~/src/wormhole/shell/zsh/prompt.sh

if [ -z "$SKIP_XOLMIS" ]; then
    SKIP_XOLMIS=1 xolmis
fi
