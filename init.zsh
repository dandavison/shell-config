_cwd=$(pwd)
cd ~/src/devenv/shell-config

function tsource {
    [ -e "$1" ] || {
        return 1
    }
    if true; then
        source "$1"
    else
        local __date=/opt/homebrew/opt/coreutils/libexec/gnubin/date
        local __start_ns=$($__date +%s%N)
        source "$1"
        local __end_ns=$($__date +%s%N)
        local __delta_ns=$((__end_ns - __start_ns))
        local __delta_ms=${__delta_ns:0:-6}
        if ((__delta_ms > 999)); then
            __delta_ms=${__delta_ms::-3},${__delta_ms: -3}
        fi
        echo "$1: ${__delta_ms} ms"
    fi
}

setopt interactivecomments
setopt rmstarsilent
setopt AUTO_CD
autoload -U colors && colors

tsource zsh/atuin-history/history.zsh
tsource ./3p/git-prompt.sh
tsource zsh/env.zsh
tsource env.sh
tsource path-macos.sh
tsource ~/tmp/3p/zsh-defer/zsh-defer.plugin.zsh
tsource completion.sh
tsource zsh/prompt.zsh
tsource zsh/bindings.zsh
tsource ~/src/wormhole/shell/lib.sh
source zsh/syntax-highlighting.zsh # tsource breaks syntax highlighting; don't know why
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
