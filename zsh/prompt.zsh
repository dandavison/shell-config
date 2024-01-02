# Based on oh-my-zsh/themes/robbyrussell.zsh-theme
# But using __git_ps1 from https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
setopt prompt_subst

export GIT_PS1_SHOWDIRTYSTATE=yes
export GIT_PS1_UNSTAGED="અ "
export GIT_PS1_STAGED="જ "

PROMPT='%(?:'                # Introduce ternary expression using last exit status as condition
PROMPT+='%{$fg_bold[cyan]%}' # Cyan for condition-true branch
PROMPT+='%c'                 # Current project / directory name
PROMPT+=':'                  # ternary expression separator
PROMPT+='%{$fg[red]%}'       # Red for condition-false branch
PROMPT+='%c'                 # Current project / directory name
PROMPT+=')'                  # End ternary expression
PROMPT+='%{$reset_color%}'
PROMPT+='%{$fg[red]%}'
PROMPT+='$(__git_ps1 "(%s)")'
PROMPT+='%{$reset_color%} '

preexec() {
    [ -n "$DAN_NO_PREEXEC" ] && return
    clear
    print "\n" # Avoid Apple M2 camera
    print -nP "$PS1"
    print -r -- "$1"
}
