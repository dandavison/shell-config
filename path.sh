if _dan_is_osx ; then
    for dir in $(cat <<EOF
/usr/local/bin
/usr/local/share/python
/usr/local/share/npm/bin
/usr/local/heroku/bin
$HOME/bin
$HOME/.cabal/bin
$HOME/misc
/usr/local/texlive/2012/bin/x86_64-darwin
EOF
    ) ; do
	[ -d $dir ] && export PATH=$dir:$PATH || {
	    echo "Directory doesn't exist: $dir" 1>&2
	}
    done
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi

PATH="$PATH:$(readlink -f ../fasd)"

PATH=$(_dan_uniquify_path $PATH)
