export DAN_NO_PREEXEC=1
# Line-editor operations stop on / in addition to word characters
export WORDCHARS="${WORDCHARS/\//}"

export EDITOR=micro # 'editor --wait'
export GIT_EDITOR=micro # 'editor --wait'
export OPEN_IN_EDITOR=~/bin/editor
export RGI_EDITOR=micro
export FSI_ACTION=micro
# Fallback default only; wormhole.toml's `editor` field is the source of truth.
export WORMHOLE_EDITOR=micro

export WORMHOLE_SEARCH_PATHS=~/src/temporal-all/repos:~/src:~/src/devenv
if [[ -f "$WORMHOLE_PROJECT_DIR/go.mod" ]]; then
  export RIPGREP_CONFIG_PATH=~/src/devenv/dotfiles/rg/go--real-code.config
fi
export PS_LINK_FORMAT=wormhole
export HOMEBREW_NO_AUTO_UPDATE=1
export LESS='-FIRX'
export DELTA_PAGER='less -FR -j.3 -g'
export LLM='claude --print'
# Consumed by the external `hyperlinked` lib, which builds `<scheme>://file/...`
# URLs. Not routed through wormhole (it has no scheme form) and fixed at shell
# init, so it doesn't track live editor switches. Left static; revisit if it
# becomes worth teaching `hyperlinked` to emit wormhole URLs.
export HYPERLINKED_SCHEME=vscode
export BAT_THEME=GitHub
export GH_PAGER=delta
export GLAMOUR_STYLE=light
export FILTER_BRANCH_SQUELCH_WARNING=1
export PIP_INDEX_URL=
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

# Root for everything cached to speed up shell startup (completions, LS_COLORS).
# Clear with `zsh-startup-cache-clear`.
export ZSH_STARTUP_CACHE=$XDG_CACHE_HOME/zsh-startup

# vivid's output is static; cache it ($(<file) reads without forking, vs a
# ~14ms `vivid generate` fork).
_ls_colors=$ZSH_STARTUP_CACHE/ls_colors
[[ -s $_ls_colors ]] || { mkdir -p $ZSH_STARTUP_CACHE; /opt/homebrew/bin/vivid generate one-light >| $_ls_colors }
export LS_COLORS="$(<$_ls_colors)"
unset _ls_colors

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

# To add local TeX .sty files:
#   Add to /opt/homebrew/texlive/texmf-local/tex/latex/local
#   Run `texhash`

[ -e /Applications ] && export MANPATH="$MANPATH:/opt/homebrew/opt/coreutils/libexec/gnuman" # $(brew --prefix coreutils) is too slow
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

export E=localhost:7233 # sdk-python pytest -E$E
