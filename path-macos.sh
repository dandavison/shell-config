for dir in $(
    /bin/cat <<EOF
/Library/TeX/texbin
/opt/homebrew/bin
/opt/homebrew/sbin
/opt/homebrew/opt/coreutils/libexec/gnubin
/opt/homebrew/opt/gnu-sed/libexec/gnubin
$HOME/.cargo/bin
$HOME/go/bin
$HOME/src/devenv/emacs-config/bin
$HOME/src/devenv/tools/bash
$HOME/.local/bin
$HOME/bin
EOF
); do
    [ -d $dir ] && PATH=$dir:$PATH || {
        echo "Directory doesn't exist: $dir" 1>&2
    }
done

export PATH=$(echo $PATH | tr ':' '\n' | awk '!_[$0]++' | tr '\n' ':')
