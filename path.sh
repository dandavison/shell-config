__dan_uniquify_path () {
    echo "$1" | perl -p -e 's/:/\n/g' | awk '!_[$0]++' | perl -p -e 's/\n/:/g' | sed 's,^:,,' | sed 's,:$,,'
}

# $(brew --prefix coreutils)/libexec/gnubin

for dir in $(/bin/cat <<EOF
/usr/local/opt/texinfo/bin/
/usr/local/texlive/2018/bin/x86_64-darwin
/usr/local/opt/libxml2/bin
/usr/local/bin
/usr/local/opt/coreutils/libexec/gnubin
/usr/local/opt/gnu-sed/libexec/gnubin
/usr/local/opt/postgresql@9.6/bin
/Users/dan/src/3p/emacs-mac/bin
$HOME/.cargo/bin
$HOME/.elan/bin
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
