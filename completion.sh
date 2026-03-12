load-completions() {
    autoload -Uz compinit && compinit -C
    source <(delta --generate-completion zsh 2>/dev/null)
    source <(temporal completion zsh 2>/dev/null)
    source <(COMPLETE=zsh wormhole)
    # eval "$(uv generate-shell-completion zsh)"
    source <(_NEOMORPHUS_COMPLETE=zsh_source neomorphus)
    compdef neo=neomorphus
}
load-completions
