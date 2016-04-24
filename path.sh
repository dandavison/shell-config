__dan_uniquify_path () {
    echo "$1" | perl -p -e 's/:/\n/g' | awk '!_[$0]++' | perl -p -e 's/\n/:/g' | sed 's,^:,,' | sed 's,:$,,'
}

if __dan_is_osx ; then
    for dir in $(/bin/cat <<EOF
/usr/local/texlive/2015/bin/x86_64-darwin
/usr/local/bin
$HOME/src/1p/misc
$HOME/src/1p/emacs-config/bin
$HOME/bin
$HOME/src/counsyl/bin
EOF
    ) ; do
	[ -d $dir ] && PATH=$dir:$PATH || {
	    echo "Directory doesn't exist: $dir" 1>&2
	}
    done
    PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
    MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
fi

export PATH=$(__dan_uniquify_path $PATH)
