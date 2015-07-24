if _dan_is_osx ; then
    for dir in $(/bin/cat <<EOF
/usr/local/bin
$HOME/bin
EOF
    ) ; do
	[ -d $dir ] && PATH=$dir:$PATH || {
	    echo "Directory doesn't exist: $dir" 1>&2
	}
    done
    PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
    MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
fi

export PATH=$(_dan_uniquify_path $PATH)
