sourcegraph-search-files() {
    local repo=$(git remote get-url origin | sed 's,^https://,,')
    src search --stream --json "repo:$repo $@" | jq -r ".path"
}

sourcegraph-search-files-scala-strato() {
    sourcegraph-search-files "file:\.(strato|scala)$ $@"
}

sourcegraph-search-files-scala() {
    sourcegraph-search-files "file:\.scala$ $@"
}

sourcegraph-search() {
    git grep -F --function-context $@ -- $(sourcegraph-search-files $@)
}

sourcegraph-search-scala() {
    git grep -F --function-context $@ -- $(sourcegraph-search-files-scala $@)
}

sourcegraph-search-scala-strato() {
    git grep -F --function-context $@ -- $(sourcegraph-search-files-scala-strato $@)
}

rgd-scala() {
    rgd -g '*.scala' -g '!*Test.scala' $@
}
