export _dan_system=`uname`

if [ "$_dan_system" = "Darwin" ] ; then
    export BROWSER=google-chrome
    export PGDATA=/usr/local/var/db/postgresql/defaultdb
else
    export BROWSER=google-chrome
fi
export EDITOR='emacsclient > /dev/null'
export INFOPATH=/usr/homebrew/share/info
