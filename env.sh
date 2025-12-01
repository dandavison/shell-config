# zsh
export DAN_NO_PREEXEC=1
export WORDCHARS="${WORDCHARS}/"

export ALTERNATE_EDITOR='emacs -nw -q'
export GIT_SEQUENCE_EDITOR='emacsclient'
export OPEN_IN_EDITOR=~/bin/code
export RGI_EDITOR=wormhole
export PS_LINK_FORMAT=wormhole
export HOMEBREW_NO_AUTO_UPDATE=1
export LESS='-FIR'
export DELTA_PAGER='less -FR -j.3 -g'
export HYPERLINKED_SCHEME=cursor
export BAT_THEME=GitHub
export GH_PAGER=delta
export FILTER_BRANCH_SQUELCH_WARNING=1
export PIP_INDEX_URL=
export PSQL_EDITOR="emacsclient --eval \"(setq-default major-mode 'sql-mode)\"; emacsclient"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export LS_COLORS="$(/opt/homebrew/bin/vivid generate one-light)"

export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

fzf-set-environment-variables

# To add local TeX .sty files:
#   Add to /opt/homebrew/texlive/texmf-local/tex/latex/local
#   Run `texhash`

__dan_is_macos && export MANPATH="$MANPATH:/opt/homebrew/opt/coreutils/libexec/gnuman" # $(brew --prefix coreutils) is too slow
# export MPLBACKEND="module://itermplot" ITERMPLOT=rv

export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export HOMEBREW_SHELLENV_PREFIX="/opt/homebrew"
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

export JAVA_HOME=${JAVA_HOME:-/opt/homebrew/opt/openjdk@17}
export CPPFLAGS="-I$JAVA_HOME/include"

export COMPOSE_MENU=0 # https://github.com/docker/for-mac/issues/7366

export E=localhost:7233  # sdk-python pytest -E$E
