#!/usr/bin/env bash

if [ "$_dan_system" = "Darwin" ] ; then
    for path in $(cat <<EOF
/usr/homebrew/bin
/usr/homebrew/share/python
/usr/homebrew/Cellar/python/2.7.2/bin
/usr/homebrew/share/npm/bin
/usr/homebrew/Cellar/ruby/1.9.2-p290/bin
/usr/texbin
EOF
    ) ; do
	export PATH=$path:$PATH
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
