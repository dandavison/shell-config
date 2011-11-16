if _dan_is_laptop ; then
    for dir in $(cat <<EOF
/bin
/usr/bin
/usr/local/bin
/usr/local/sbin
/usr/texbin
/usr/local/Cellar/emacs/HEAD/bin
/usr/local/share/npm/bin
/usr/local/Cellar/ruby/1.9.2-p290/bin
/usr/local/Cellar/python/2.7.2/bin
/usr/local/share/python
$HOME/bin
EOF
    ) ; do
	export PATH=$dir:$PATH
    done
    export NODE_PATH=/usr/homebrew/lib/node
fi
export PYTHONPATH=~/lib/python/ipython
