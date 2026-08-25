export BAT_THEME=GitHub
export COMPOSE_MENU=0 # https://github.com/docker/for-mac/issues/7366
export DAN_NO_PREEXEC=1
export DELTA_PAGER='less -R -j.3 -g'
export E=localhost:7233 # sdk-python pytest -E$E
export EDITOR=micro
export FILTER_BRANCH_SQUELCH_WARNING=1
export FSI_ACTION=micro
export GH_PAGER=delta
export GIT_EDITOR=micro
export GIT_SEQUENCE_EDITOR='gitu sequence-editor'
export GLAMOUR_STYLE=light
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export HOMEBREW_SHELLENV_PREFIX="/opt/homebrew"
export HYPERLINKED_SCHEME=vscode # TODO: wormholify?
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
export JAVA_HOME=${JAVA_HOME:-/opt/homebrew/opt/openjdk@17}
export LESS='-IR'
export LLM='claude --print'
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export OPEN_IN_EDITOR=~/bin/editor
export OSC1717=V1
export PIP_INDEX_URL=
export PS_LINK_FORMAT=wormhole
export RGI_EDITOR=micro
export RIPGREP_CONFIG_PATH=~/.config/ripgrep/config
export WORDCHARS="${WORDCHARS/\//}"
export WORMHOLE_DEFAULT_PROJECT=temporal
export WORMHOLE_EDITOR=micro
export WORMHOLE_SEARCH_PATHS=~/src/temporalio:~/src/temporalio-etc:~/src:~/src/devenv
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export ZSH_STARTUP_CACHE=$XDG_CACHE_HOME/zsh-startup

export CPPFLAGS="-I$JAVA_HOME/include"
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="\
--ansi
--border rounded
--color light
--cycle
--exact
--height 50%
--info hidden
--layout reverse
--prompt ' '
"

_ls_colors=$ZSH_STARTUP_CACHE/ls_colors
[[ -s $_ls_colors ]] || { mkdir -p $ZSH_STARTUP_CACHE; /opt/homebrew/bin/vivid generate one-light >| $_ls_colors }
export LS_COLORS="$(<$_ls_colors)"
unset _ls_colors


# To add local TeX .sty files:
#   Add to /opt/homebrew/texlive/texmf-local/tex/latex/local
#   Run `texhash`

[ -e /Applications ] && export MANPATH="$MANPATH:/opt/homebrew/opt/coreutils/libexec/gnuman" # $(brew --prefix coreutils) is too slow

