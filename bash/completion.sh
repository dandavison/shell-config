export FIGNORE=.pyc:#:.DS_Store:.git

. $(brew --prefix)/etc/bash_completion
# [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

. ~/src/3p/tmuxinator/completion/tmuxinator.bash
. ~/src/3p/maven-bash-completion/bash_completion.bash
# eval "$(pip completion --bash)"  # removed to decrease shell start-up time
# which register-python-argcomplete >/dev/null 2>&1 && eval "$(register-python-argcomplete pytest)"
# . ~/src/3p/fzf/shell/completion.bash  # removed to decrease shell start-up time
