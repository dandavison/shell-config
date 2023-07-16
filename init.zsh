_cwd=$(pwd)
cd ~/src/devenv/shell-config

function tsource {
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
compdef _gnu_generic bat delta

tsource zsh/prompt.zsh

tsource zsh/bindings.zsh

tsource alias.sh

setopt rmstarsilent
source zsh/syntax-highlighting.zsh # tsource breaks syntax highlighting; don't know why

tsource env.sh
tsource zsh/env.zsh
[ -f secret.sh ] && tsource secret.sh

tsource zsh/pm.zsh
[ -f ~/.fzf.zsh ] && tsource ~/.fzf.zsh
eval "$(atuin init zsh --disable-up-arrow)"

cd "$_cwd"
unset _cwd
