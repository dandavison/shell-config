alias 'make-explain'="make -rnd | perl -p -e 's,(^ +),\1\1\1\1,'"
alias 'tmux-current-session'='tmux display-message -p "#S"'
alias ..='cd ..'
alias R='R --silent --no-restore --no-save --vanilla'
alias acurl='curl --user $(cat ~/.ssh/auth)'
alias agp='ag --python'
alias b='git branch-by-date|head'
alias beh='tac ~/.bash_eternal_history'
alias c='cat'
alias cb='cargo build'
alias cdt='cd "$_"'
alias cdtemp='cd $(mktemp -d)'
alias cgrep='grep --color=always'
alias chrome='open -a /Applications/Google\ Chrome.app'
alias copy='reattach-to-user-namespace pbcopy'
alias ctl='(column -t | less -SX) <'
alias d=docker
alias dc=docker-compose
alias di='docker images'
alias dm='docker-machine'
alias dmenv='docker-machine-env-docker'
alias dmip="docker-machine ip $DOCKER_MACHINE_NAME"
alias dmstart="docker-machine start $DOCKER_MACHINE_NAME"
alias dmstop="docker-machine stop $DOCKER_MACHINE_NAME"
alias docker-clean='docker-rm-all && docker-prune'
alias docker-prune='docker rmi $(docker images -f "dangling=true" -q)'
alias docker-rm-all='docker rm -f $(docker ps -a -q)'
alias dps='docker ps'
alias e="emacs-find-file"
alias ee="emacs -nw -q"
alias ef='emacs-find'
alias eg='emacs-magit-status'
alias ep='emacs_pipe'
alias es='emacs-grep'
alias f='find'
alias ff='find . -type f -name'
alias fromip="who | grep \"^$USER\" | sed 1q | perl -n -e 's,.*\(([0-9.]+)\),\1, and print'"
alias g='grep'
alias ga='git add'
alias gb='git branch'
alias gbc='git branch --contains'
alias gbd='git branch-by-date'
alias gbda='git branch-by-date'
alias gbdh='git branch-by-date|head'
alias gbl='git blame'
alias gc='git checkout'
alias gcbz='git branch -D z 2> /dev/null ; git checkout -b z'
alias gcl='git clean'
alias gcln='git clean -nd'
alias gclo='git clone'
alias gcm='git checkout master'
alias gcmm='git branch master origin/master && git checkout master'
alias gco='git commit'
alias gcoa='git commit --amend'
alias gcof='git-commit-file'
alias gconf='git config'
alias gconfl='git config -l'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdcs='git diff --cached --stat=200,200'
alias gdm='git diff master'
alias gdob='git diff origin/$(git rev-parse --abbrev-ref HEAD)'
alias gds='git diff --stat=200,200'
alias gdsm='git diff --stat=200,200 master...'
alias gdsc='git diff --cached --stat=200,200'
alias gdww='git diff --word-diff=color --word-diff-regex="[a-zA-z_]+"'
alias gdw='git diff --word-diff=color'
alias gf='git fetch'
alias gfb='git-fetch-branch'
alias gfc='git-fuzzy-checkout'
alias gg='git grep'
alias ghci='ghci -fwarn-incomplete-patterns'
alias git-init='git init && git commit --allow-empty -m "Init"'
alias gitk-all='gitk --all --simplify-by-decoration'
alias gl1='gl -n1'
alias gl='git log1'
alias gla='gl --format="%an"'
alias gless='grep --color=always | less -R'
alias glh='git log --oneline -n 20'
alias glme='gl --author=dan'
alias glo='git log origin/$(git rev-parse --abbrev-ref HEAD)'
alias glp='gl -p'
alias gls='gl --stat'
alias glsp='gl -p --stat'
alias gm='git merge'
alias gp='git pull'
alias gpo='git pull origin'
alias gpob='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias gprob='git pull --rebase origin $(git rev-parse --abbrev-ref HEAD)'
alias gr1='git reset HEAD~1'
alias gr2='git reset HEAD~2'
alias gr='git reset'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias gre='git remote'
alias grep='grep --color=auto'
alias gres='git remote -v show'
alias grh='git reset --hard'
alias grhh='git reset --hard HEAD'
alias grhob='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'
alias gri4='git rebase --interactive HEAD~3'
alias gri='git rebase --interactive'
for i in 1 2 3 4 5 6 7 8 9 10; do
    alias gri${i}="git rebase --interactive HEAD~${i}"
done
alias grio='git rebase --interactive origin/$(git rev-parse --abbrev-ref HEAD)'
alias gs='git show'
alias gss='git show --stat=120,120'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstr='git stash save && git stash drop stash@{1}'
alias gsts='git stash save `date "+%Y-%m-%d %H:%M"`'
alias gstsd='git stash save debugging'
alias gstsp='git stash show -p'
alias gsww='git show --word-diff=color --word-diff-regex="[a-zA-z_]+"'
alias gsw='git show --word-diff=color'
alias h='head'
alias hibernateoff="sudo pmset -a hibernatemode 0"
alias hibernateon="sudo pmset -a hibernatemode 5"
alias hist='tac ~/.bash_eternal_history'
alias hubc='open https://github.counsyl.com/dev/website/commit/$(git rev-list -n1 HEAD)'
alias ip=ipython
alias isort='isort --force_single_line_imports --lines 999999 --dont-skip __init__.py'
alias jp=jsonpipe
alias l='less'
alias le='lein'
alias ler='lein repl'
alias less='less -SX'
alias lh='ls -lh'
alias ll='ls -lh'
alias ls='ls --color=tty --hide="*.pyc" --hide="#*"'
alias lt='ls -lht'
alias lth='ls -lht | head'
alias mk='mkdir -p'
alias nwp=wifi-poke
alias np=ping-world
alias npu='until ping-world; do sleep 1; done'
alias open='reattach-to-user-namespace open'
alias p=python
alias path='readlink -f'
alias pi='pip install'
alias pf='pip freeze'
alias pu='pip uninstall'
alias pupf='pip uninstall -y $(pip freeze)'
alias ps-me='ps -u `whoami`'
alias psl='ps auxwww | less'
alias pvirtualenv='echo $VIRTUAL_ENV'
alias pwdr='pwd | sed "s,.*$HOME/,,"'
alias pyz='py /tmp/z.py'
alias rn='rename'
alias rs='rsync -z --progress'
alias s='switchto'
alias ssh='ssh -A'
alias sw='switchto website'
alias t='tree'
alias ta='tmux attach'
alias tail-messages='tail -f /var/log/messages'
alias tcs='tmux-current-session'
alias tl='topleft'
alias tls='tmux list-sessions'
alias tns='tmux new-session'
alias tree='tree -AC --noreport'
alias virtualenv-temp='rm -fr /tmp/v && virtualenv /tmp/v && . /tmp/v/bin/activate'
alias vpro='vagrant provision'
alias vssh='vagrant ssh'
