__dan_uniquify_path () {
    echo "$1" | perl -p -e 's/:/\n/g' | awk '!_[$0]++' | perl -p -e 's/\n/:/g' | sed 's,^:,,' | sed 's,:$,,'
}

# $(brew --prefix coreutils)/libexec/gnubin

if __dan_is_osx ; then
    for dir in $(/bin/cat <<EOF
/usr/local/texlive/2015/bin/x86_64-darwin
/usr/local/bin
/usr/local/opt/coreutils/libexec/gnubin
/usr/local/opt/postgresql@9.6/bin
$HOME/src/counsyl/1p/misc
$HOME/src/misc
$HOME/src/emacs-config/bin
$HOME/bin
EOF
    ) ; do
	[ -d $dir ] && PATH=$dir:$PATH || {
	    echo "Directory doesn't exist: $dir" 1>&2
	}
    done
    MANPATH="$MANPATH:$(brew --prefix coreutils)/libexec/gnuman"
fi

export PATH=$(__dan_uniquify_path $PATH)
