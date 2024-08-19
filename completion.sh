# autoload -Uz compinit && (compinit -C &>/dev/null &)

load-completions () {
    autoload -Uz compinit && compinit -C
    eval "$(delta --generate-completion zsh 2>/dev/null)"
    eval "$(temporal completion zsh 2>/dev/null)"
    eval "$(wezterm shell-completion --shell zsh)"
}
load-completions
