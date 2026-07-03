cp() {
    if [[ ! -t 0 && $# -eq 0 ]]; then
        pbcopy
    else
        command cp "$@"
    fi
}

delta-toggle() {
    eval "export DELTA_FEATURES='$(-delta-features-toggle $1 | tee /dev/stderr)'"
}
