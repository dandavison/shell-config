if _dan_is_osx ; then
    for dir in $(cat <<EOF
/usr/local/bin
/usr/local/share/python
/usr/local/share/npm/bin
/usr/local/heroku/bin
$HOME/.cabal/bin
/usr/local/texlive/2012/bin/x86_64-darwin
EOF
    ) ; do
	[ -d $dir ] && PATH=$dir:$PATH || {
	    echo "Directory doesn't exist: $dir" 1>&2
	}
    done
    PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi

PATH="$HOME/bin:$PATH"
PATH="$HOME/misc:$PATH"
PATH="$PATH:$(readlink -f ../fasd)"

export PATH=$(_dan_uniquify_path $PATH)
