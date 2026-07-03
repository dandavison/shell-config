load-completions() {
    autoload -Uz compinit && compinit -C
    # tsource <(temporal completion zsh 2>/dev/null) ~100ms
    tsource <(COMPLETE=zsh wormhole)
    # source <(should --show-completion zsh)  ~400ms
    # source <(delta --generate-completion zsh 2>/dev/null)
    # eval "$(uv generate-shell-completion zsh)"
    # source <(_NEOMORPHUS_COMPLETE=zsh_source neomorphus)
    # compdef neo=neomorphus
}
load-completions
