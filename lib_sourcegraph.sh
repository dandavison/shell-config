src-matching-files() {
    local repo=${SRC_REPO:-$(git remote get-url origin | sed 's,^https://,,')}
    src search --stream --json "repo:$repo $*" | jq -r 'select(.type=="content").path' | sort
}

src-grep-args() {
    echo "${@:$#}" -- $(src-matching-files "$@")
}

src-grep-args-scala() {
    src-grep-args 'file:\.scala$' $@
}

src-grep-args-scala-strato() {
    src-grep-args 'file:\.(strato|scala)$' $@
}

src-git-grep() {
    git grep -W $(src-grep-args $@)
}
