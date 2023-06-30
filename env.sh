export ALTERNATE_EDITOR='emacs -nw -q'
export BAT_THEME=GitHub
export BROWSER='google-chrome'
export CARGO_BUILD_TARGET=aarch64-apple-darwin
export GIT_SEQUENCE_EDITOR='emacsclient'
export OPEN_IN_EDITOR=~/bin/code
export HOMEBREW_NO_AUTO_UPDATE=1
export LESS='-FIRS'
export DELTA_PAGER='less -FRS'
export PIP_INDEX_URL=
export PSQL_EDITOR="emacsclient --eval \"(setq-default major-mode 'sql-mode)\"; emacsclient"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export LS_COLORS="$(vivid generate one-light)"

export FZF_DEFAULT_COMMAND='fd'
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
