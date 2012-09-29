if _dan_is_laptop ; then
    for dir in $(cat <<EOF
/usr/local/bin
/usr/local/share/python
$HOME/bin
/Applications/Emacs.app/Contents/MacOS/bin
EOF
    ) ; do
	[ -d $dir ] && export PATH=$dir:$PATH || {
	    echo "Directory doesn't exist: $dir" 1>&2
	}
    done
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi

PATH=$(_dan_uniquify_path $PATH)
