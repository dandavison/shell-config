if _dan_is_laptop ; then
    for dir in $(cat <<EOF
/bin
/usr/bin
/usr/homebrew/bin
/usr/homebrew/sbin
/usr/texbin
/usr/homebrew/Cellar/emacs/HEAD/bin
$HOME/node_modules/coffee-script/bin
/usr/homebrew/Cellar/ruby/1.9.2-p290/bin
/usr/homebrew/Cellar/python/2.7.2/bin
/usr/homebrew/share/python
$HOME/bin
EOF
    ) ; do
	[ -d $dir ] && export PATH=$dir:$PATH || {
	    echo "Directory doesn't exist: $dir" 1>&2
	}
    done
    export NODE_PATH=/usr/homebrew/lib/node
fi
export PYTHONPATH=~/lib/python/ipython
export PERL5LIB=/usr/homebrew/lib/perl5/site_perl:${PERL5LIB}
