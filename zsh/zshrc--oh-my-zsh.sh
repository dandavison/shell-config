# oh-my-zsh
export ZSH="/Users/dan/.oh-my-zsh"
plugins=(fasd)
source $ZSH/oh-my-zsh.sh

# personal
source ~/src/shell-config/init.sh
compdef _gnu_generic bat delta
