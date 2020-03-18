__dan_uniquify_path () {
    echo "$1" | perl -p -e 's/:/\n/g' | awk '!_[$0]++' | perl -p -e 's/\n/:/g' | sed 's,^:,,' | sed 's,:$,,'
}

# $(brew --prefix coreutils)/libexec/gnubin

for dir in $(/bin/cat <<EOF
/usr/local/texlive/2018/bin/x86_64-darwin
/usr/local/bin
/usr/local/opt/coreutils/libexec/gnubin
/usr/local/opt/postgresql@9.6/bin
/usr/local/Cellar/emacs-mac/emacs-26.3-z-mac-7.8/bin
$HOME/.cargo/bin
$HOME/src/elaenia/bin
$HOME/src/emacs-config/bin
$HOME/bin
EOF
    ) ;
do
	[ -d $dir ] && PATH=$dir:$PATH || {
echo "Directory doesn't exist: $dir" 1>&2
}
done

export PATH=$(__dan_uniquify_path $PATH)
