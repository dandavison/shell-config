export BROWSER=google-chrome

export EDITOR='emacsclient -n'

export INFOPATH=/usr/homebrew/share/info
export CLOJURESCRIPT_HOME=/Users/Shared/lib/clojure/clojurescript

export GEM_HOME=$(brew --prefix)

export GIT_MERGE_AUTOEDIT=no

export WORKON_HOME=$HOME/tmp/virtualenvs
source $(which virtualenvwrapper.sh)

PSQL_EDITOR="emacsclient --eval \"(setq-default major-mode 'sql-mode)\"; emacsclient"

export HOMEBREW_GITHUB_API_TOKEN=cf4f93adb741e12d0b5ceaeca3f4235615a336a2
