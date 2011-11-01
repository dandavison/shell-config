_dan_is_laptop () {
    # zsh: $(whoami) == davison && $(hostname) == (cotinga|int)*
    [ $(whoami) = "davison" ] && {
	[[ $(hostname) == cotinga.* ]] || [[ $(hostname) == int191.* ]]
    }
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
