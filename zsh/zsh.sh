autoload -U colors
colors

autoload -U zargs

autoload -U compinit
compinit

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:functions' ignored-patterns '_*' # ignore for absent commands
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose false
zstyle ':completion:*' menu select=6

# prevent git from completing file names, which is unbearably slow
# http://www.zsh.org/mla/users/2010/msg00435.html
__git_files(){ _main_complete _files }

# bindkey -M menuselect '^o' accept-and-infer-next-history

setopt CLOBBER
setopt rmstarsilent

setopt AUTO_CD
setopt CHASE_LINKS

setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS

HISTSIZE=999999999999999999
SAVEHIST=999999999999999999
HISTFILE=~/zsh_.history

fpath+=~/config/shell/zsh/functions

autoload edit-command-line-in-shell-mode
zle -N edit-command-line-in-shell-mode
bindkey '\ee' edit-command-line

unsetopt BEEP

setopt NOHUP
setopt NO_BG_NICE

set INFOPATH for emacs info file reading
