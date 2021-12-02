export SHELL=zsh
export ALTERNATE_EDITOR='emacs -nw -q'
export BROWSER='google-chrome'
export DAN_VIRTUALENVS_DIRECTORY=~/tmp/virtualenvs
export EDITOR='emacsclient -n'
export GIT_SEQUENCE_EDITOR='emacsclient'
export HOMEBREW_NO_AUTO_UPDATE=1
export LESS='-FIRX'
export DELTA_PAGER='less -FRSX'
export PIP_INDEX_URL=
export PSQL_EDITOR="emacsclient --eval \"(setq-default major-mode 'sql-mode)\"; emacsclient"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export XENOCANTO_DATA_DIRECTORY=/tmp/xeno-quero-data
export EXA_COLORS=$(tr '\n' ':' < exa-colors)
export DAN_ETERNAL_HISTORY_DIR=~/google-drive/shell_history
export DAN_ETERNAL_HISTORY_FILE=$DAN_ETERNAL_HISTORY_DIR/eternal_shell_history_03.99
is_zsh && export HISTFILE=$DAN_ETERNAL_HISTORY_FILE

export FZF_DEFAULT_COMMAND='fd'
fzf-set-environment-variables

# To add local TeX .sty files:
#   Add to /opt/homebrew/texlive/texmf-local/tex/latex/local
#   Run `texhash`

__dan_is_macos && export MANPATH="$MANPATH:/opt/homebrew/opt/coreutils/libexec/gnuman"  # $(brew --prefix coreutils) is too slow
# export MPLBACKEND="module://itermplot" ITERMPLOT=rv

# export   CFLAGS=-I/opt/homebrew/opt/libxml2/include/libxml2
# export CPPFLAGS=-I/opt/homebrew/opt/libxml2/include/libxml2
# export LDFLAGS="-L/opt/homebrew/opt/libxml2/lib"

source env-local.sh

export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export HOMEBREW_SHELLENV_PREFIX="/opt/homebrew";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
