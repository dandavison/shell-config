export BROWSER=google-chrome

export EDITOR='emacsclient -n'

export INFOPATH=/usr/homebrew/share/info

export GEM_HOME=$(brew --prefix)

export GIT_MERGE_AUTOEDIT=no

export WORKON_HOME=$HOME/tmp/virtualenvs
source $(which virtualenvwrapper.sh)

PSQL_EDITOR="emacsclient --eval \"(setq-default major-mode 'sql-mode)\"; emacsclient"

