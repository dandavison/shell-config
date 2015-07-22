_dan_is_osx () {
    [ -e /Applications ]
}

_dan_uniquify_path () {
    echo "$1" | perl -p -e 's/:/\n/g' | awk '!_[$0]++' | perl -p -e 's/\n/:/g' | sed 's,^:,,' | sed 's,:$,,'
}

_colorize () {
    echo "\[\033[${1}m\]$2\[\033[0m\]"
}

_dan_git_branch () {
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

_dan_abbreviate_path () {
    path=$(echo "$1" | sed "s,$HOME,~,")
    abbrv=$(echo "$path" | sed 's,^.*/.*/\(.*/.*\)$,\1,')
    [ "$abbrv" = "$path" ] && echo "$path" || echo ../"$abbrv"
}

ssh_ () {
    host=$1
    mkdir -p ~/$host
    cd ~/$host
    /usr/bin/ssh $*
}

cdp () {
    mkdir -p "$1" && cd "$1"
}

# gcs () {
#     git stash save && git checkout $0 && git stash pop
# }

git-fetch-branch () {
    git fetch origin $1:$1 && git checkout $1
}

git-review () {
    git fetch origin $1:$1
    git checkout $1 && egit-diff master...
}

git-review-merge () {
    merge_commit=$1
    git rev-list --parents -n1 $merge_commit | read merge parent1 parent2
    git checkout $parent2 && egit-diff $parent1...$parent2
}

hub-pr () {
    head=$(git symbolic-ref --short HEAD)
    EDITOR='emacsclient -n' hub pull-request -b dev:master -h dev:$head $1
}

switchto () {
        workon $1 && cdproject
}

git-prune-merged () {
    gbd | head -n20 | awk '{print $1}' | while read b ; do git branch -d $b ; done
}

ega () {
    touch $1 && git add $1 && emacsclient -n $1
}


grip-chrome () {
    tmpfile=$(mktemp)
    grip --export $1 $tmpfile > /dev/null 2>&1 && chrome $tmpfile
}
    

grip-python () {
    (echo '```python'
     cat
     echo '```') | grip --export -
}
