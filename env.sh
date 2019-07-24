export ALTERNATE_EDITOR='emacs -nw -q'
export BAT_THEME=GitHub  # OneHalfDark GitHub
export BROWSER='google-chrome'
export DAN_VIRTUALENVS_DIRECTORY=~/tmp/virtualenvs
export EDITOR='emacsclient -n'
export FZF=
export GIT_SEQUENCE_EDITOR='emacsclient'
export PAGER='less'
export PIP_INDEX_URL=
export PSQL_EDITOR="emacsclient --eval \"(setq-default major-mode 'sql-mode)\"; emacsclient"

__dan_is_osx && export MANPATH="$MANPATH:$(brew --prefix coreutils)/libexec/gnuman"
# export MPLBACKEND="module://itermplot" ITERMPLOT=rv

. env-local.sh
