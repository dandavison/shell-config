_dan_is_laptop () {
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
    git fetch origin $1:$1
}

cp-desktop-latest () {
    cp -r ~/Desktop/*(om[1]) $1
}

cp-tmp-latest () {
    cp -r /tmp/*(om[1]) $1
}

switchto () {
        workon $1 && cdproject
}
