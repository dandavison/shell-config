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

tsource lib.sh
tsource lib_fzf.sh
tsource lib_git.sh
tsource zsh/lib.zsh
tsource zsh/history.zsh
tsource ./3p/git-prompt.sh
tsource zsh/env.zsh
tsource env.sh
tsource path-macos.sh
tsource completion.sh
tsource zsh/prompt.zsh
tsource zsh/bindings.zsh
tsource alias.sh
source zsh/syntax-highlighting.zsh # tsource breaks syntax highlighting; don't know why
tsource secret.sh
tsource ~/src/wormhole/cli/lib.sh
tsource /tmp/wormhole.env
tsource zsh/atuin.zsh
tsource ../temporal/temporal.sh

cd "$_cwd"
unset _cwd

# tsource ~/src/devenv/shell-config/xolmis.sh
