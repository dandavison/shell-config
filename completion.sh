load-completions() {
    autoload -Uz compinit && compinit -C

    local dir=$ZSH_STARTUP_CACHE/completions
    # _cached <name> <command...>: generate the completion script once, then
    # source the cached file (~ms) instead of forking the tool (~100-400ms).
    # Clear with `zsh-startup-cache-clear` (e.g. after upgrading a tool).
    _cached() {
        local f=$dir/$1; shift
        if [[ ! -s $f ]]; then
            mkdir -p $dir
            "$@" >| $f.tmp 2>/dev/null && [[ -s $f.tmp ]] && mv $f.tmp $f || rm -f $f.tmp
        fi
        [[ -s $f ]] && source $f
    }

    _cached temporal  temporal completion zsh
    _cached wormhole  env COMPLETE=zsh wormhole
    _cached should    env _SHOULD_COMPLETE=source_zsh should
    _cached delta     delta --generate-completion zsh
    # _cached uv        uv generate-shell-completion zsh
    # _cached neomorphus env _NEOMORPHUS_COMPLETE=zsh_source neomorphus
    # compdef neo=neomorphus
}
# Defer past the first prompt so the shell is interactive immediately.
zsh-defer load-completions
