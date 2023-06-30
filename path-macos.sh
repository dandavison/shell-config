for dir in $(
    /bin/cat <<EOF
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
); do
    [ -d $dir ] && PATH=$dir:$PATH || {
        echo "Directory doesn't exist: $dir" 1>&2
    }
done

export PATH=$(echo $PATH | tr ':' '\n' | awk '!_[$0]++' | tr '\n' ':')
