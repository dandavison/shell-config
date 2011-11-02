setopt CLOBBER
setopt rmstarsilent
setopt AUTO_CD
setopt CHASE_LINKS
unsetopt BEEP
setopt NOHUP
setopt NO_BG_NICE

setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
HISTSIZE=999999999999999999
SAVEHIST=999999999999999999
HISTFILE=~/.zsh_history

autoload -U colors
colors

autoload -U zargs

autoload -U compinit
compinit

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:functions' ignored-patterns '_*' # ignore for absent commands
zstyle ':completion:*' verbose true
zstyle ':completion:*' menu select=2

# ma is the code for the current completion offering
# 04 is underline
ZLS_COLORS="ma=04:$LS_COLORS"
zstyle ':completion:*' list-colors ${(s.:.)ZLS_COLORS}


# B2Z ch.14
setopt complete_in_word
zstyle ':completion::*:::' completer _complete _prefix
zstyle ':completion:*:prefix:*' add-space true

# prevent git from completing file names, which is unbearably slow
# http://www.zsh.org/mla/users/2010/msg00435.html
__git_files(){ _main_complete _files }

# bindkey -M menuselect '^o' accept-and-infer-next-history

fpath=(~/config/shell/zsh/functions $fpath)

autoload edit-command-line-in-shell-mode
zle -N edit-command-line-in-shell-mode
bindkey '\ee' edit-command-line-in-shell-mode

unfunction _tmux
autoload _tmux

unfunction _tmux
autoload _tmux



