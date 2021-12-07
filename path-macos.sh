__dan_uniquify_path () {
    echo "$1" | perl -p -e 's/:/\n/g' | awk '!_[$0]++' | perl -p -e 's/\n/:/g' | sed 's,^:,,' | sed 's,:$,,'
}

# $(brew --prefix coreutils)/libexec/gnubin

# /opt/homebrew/opt/texinfo/bin/
# /opt/homebrew/texlive/2018/bin/x86_64-darwin

for dir in $(/bin/cat <<EOF
/opt/homebrew/bin
/opt/homebrew/sbin
/opt/homebrew/opt/coreutils/libexec/gnubin
/opt/homebrew/opt/gnu-sed/libexec/gnubin
/opt/homebrew/opt/postgresql/bin
$HOME/.cargo/bin
$HOME/src/emacs-config/bin
$HOME/.local/bin
$HOME/bin
EOF
    ) ;
do
	[ -d $dir ] && PATH=$dir:$PATH || {
echo "Directory doesn't exist: $dir" 1>&2
}
done

export PATH=$(__dan_uniquify_path $PATH)
