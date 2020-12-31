typeset -ag precmd_functions;
precmd_functions=( __prompt_command ${precmd_functions[@]} )

# __dan_preexec_function () {
#     local columns=$(tput cols)
#     if [ $columns -ge 140 ]; then
#         export GIT_PAGER="delta --side-by-side"
#     else
#         export GIT_PAGER="delta"
#     fi
# }
# typeset -ag preexec_functions;
# preexec_functions=( __dan_preexec_function ${preexec_functions[@]} )

# Based on oh-my-zsh/themes/robbyrussell.zsh-theme
# But using __git_ps1 from https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=yes
export GIT_PS1_UNSTAGED="અ "
export GIT_PS1_STAGED="જ "


PROMPT="%(?:%{$fg_bold[cyan]%}%c:%{$fg[red]%}%c)%{$reset_color%}"
PROMPT+='%{$fg[red]%}$(__git_ps1 "(%s)")%{$reset_color%} '
