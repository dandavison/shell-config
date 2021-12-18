sourcegraph-search-files-0() {
    local root=$(git rev-parse --show-toplevel)
    src search --json $@ | jq -r ".Results[] | select(.__typename=\"FileMatch\") | \"$root/\(.file.path)\"" | sed -E "s,^$HOME,~,"
}

sourcegraph-search-files() {
    src search --stream --json $@ | jq -r ".path"
}

sourcegraph-search() {
    git grep -F --function-context $@ -- $(sourcegraph-search-files $@)
}

rgd-scala() {
    rgd -g '*.scala' -g '!*Test.scala' $@
}
