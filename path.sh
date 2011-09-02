#!/usr/bin/env bash

if [ "$_dan_system" = "Darwin" ] ; then
    for path in $(cat <<EOF
/usr/local/bin
/usr/local/share/python
/usr/local/Cellar/python/2.7.2/bin
/usr/texbin
/usr/local/share/npm/bin
EOF
    ) ; do
	export PATH=$path:$PATH
    done

    export PYTHON_SITE_PACKAGES=/usr/local/Cellar/python/2.7.2/lib/python2.7/site-packages
else
    export PATH=/usr/local/src/postgresql/bin:$PATH
fi

export PATH=$HOME/bin:$PATH
export NODE_PATH=/usr/local/lib/node

export PATH=$(_dan_uniquify_path $PATH)
export PYTHONPATH=$(_dan_uniquify_path $PYTHONPATH)
export NODEPATH=$(_dan_uniquify_path $NODEPATH)
