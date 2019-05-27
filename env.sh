export BROWSER='google-chrome'
export EDITOR='emacsclient -n'
export ALTERNATE_EDITOR='emacs -nw -q'
export GIT_SEQUENCE_EDITOR='emacsclient'
export PSQL_EDITOR="emacsclient --eval \"(setq-default major-mode 'sql-mode)\"; emacsclient"
export PAGER='less'
export PIP_INDEX_URL=
export BAT_THEME=OneHalfDark # GitHub
# export MPLBACKEND="module://itermplot" ITERMPLOT=rv

. env-local.sh
