src-matching-files() {
    local repo=${SRC_REPO:-$(git remote get-url origin | sed 's,^https://,,')}
    src search --stream --json "repo:$repo $*" | jq -r 'select(.type=="content").path' | sort
}

src-grep-args() {
    local matching_files=$(src-matching-files "$@")
    [ -n "$matching_files" ] || {
        echo "No matching files" 1>&2
        matching_files=/dev/null
    }
    echo "${@:$#}" -- "$matching_files"
}

src-grep-args-scala() {
    src-grep-args 'file:\.scala$' $@
}

src-grep-args-scala-strato() {
    src-grep-args 'file:\.(scala|thrift|strato)$' $@
}

src-git-grep() {
    git grep -nW $(src-grep-args $@)
}

src-git-grep-scala-strato() {
    git grep -nW $(src-grep-args-scala-strato $@)
}

src-strato-column-hits-with-matching-scala-files() {
    src-matching-files 'file:\.strato$' $@ |
        sed -E 's,.+/([^/]+)\.strato,\1,' |
        sort |
        uniq |
        while read column; do
            local files=$(src-matching-files 'file:\.scala' $column)
            [ -n "$files" ] && echo $column
        done
}
