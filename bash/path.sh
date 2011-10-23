#!/usr/bin/env bash

if [ "$_dan_system" = "Darwin" ] ; then
    PATH=""
    for path in $(cat <<EOF
/bin
/usr/bin
/usr/local/bin
/usr/texbin
/usr/local/Cellar/emacs/HEAD/bin
/usr/local/share/npm/bin
/usr/local/Cellar/ruby/1.9.2-p290/bin
/usr/local/Cellar/python/2.7.2/bin
/usr/local/share/python
EOF
    ) ; do
	PATH=$path:$PATH
    done

    export PYTHON_SITE_PACKAGES=/usr/homebrew/Cellar/python/2.7.2/lib/python2.7/site-packages
else
    export PATH=/usr/homebrew/src/postgresql/bin:$PATH
fi

export PATH=$HOME/bin:$PATH
export NODE_PATH=/usr/homebrew/lib/node

export PATH=$(_dan_uniquify_path $PATH)
export PYTHONPATH=$(_dan_uniquify_path $PYTHONPATH)
export NODEPATH=$(_dan_uniquify_path $NODEPATH)
