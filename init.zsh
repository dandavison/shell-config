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

tsource lib.sh
tsource lib_fzf.sh
tsource lib_git.sh
tsource zsh/lib.zsh
tsource zsh/history.zsh
tsource ./3p/git-prompt.sh

__dan_is_macos && tsource path-macos.sh

autoload -U colors && colors

autoload -Uz compinit && compinit
eval "$(delta --generate-completion zsh 2>/dev/null)"
eval "$(temporal completion zsh 2>/dev/null)"

tsource zsh/prompt.zsh

tsource zsh/bindings.zsh

tsource alias.sh

setopt interactivecomments
setopt rmstarsilent
source zsh/syntax-highlighting.zsh # tsource breaks syntax highlighting; don't know why

tsource env.sh
tsource secret.sh
tsource ~/src/wormhole/cli/lib.sh
tsource /tmp/wormhole.env

tsource zsh/env.zsh

tsource zsh/atuin.zsh

tsource ../temporal/lib.sh

cd "$_cwd"
unset _cwd
