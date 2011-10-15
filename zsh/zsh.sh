autoload -U colors
colors

autoload -U zargs

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:functions' ignored-patterns '_*' # ignore for absent commands
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose false

autoload -Uz compinit
compinit

unsetopt NOCLOBBER
setopt rmstarsilent

setopt AUTO_CD
setopt CHASE_LINKS

setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS

bindkey '\ep' history-beginning-search-backward
bindkey '\en' history-beginning-search-forward

HISTSIZE=999999999999999999
SAVEHIST=999999999999999999
HISTFILE=~/zsh_.history

unsetopt CLOBBER
unsetopt BEEP

setopt NOHUP
setopt NO_BG_NICE

# set INFOPATH for emacs info file reading

