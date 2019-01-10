alias ..='cd ..'
alias R='R --silent --no-restore --no-save --vanilla'
alias acurl='curl --user $(cat ~/.ssh/auth)'
alias agp='ag --python'
alias b='git branch-by-date|head'
alias beh='tac ~/.bash_eternal_history'
alias black-diff='(pyenv shell 3.7.0 && cd $(git rev-parse --show-toplevel) && black --skip-string-normalization -l100 $(git diff --name-only master...))'
alias black-all="(cd $(git rev-parse --show-toplevel) && git ls-files '**/*.py' | xargs black --skip-string-normalization -l100 $(git diff --name-only master...))"
alias cat='bat --plain'
alias cb='cargo build'
alias cdg='cd $(git rev-parse --show-toplevel)'
alias cdt='cd "$_"'
alias cdtemp='cd $(mktemp -d)'
alias cgrep='grep --color=always'
alias chrome='open -a /Applications/Google\ Chrome.app'
alias clipboard-restart='killall pboard'
alias column='~/src/column/column'
alias copy='pbcopy'
alias ctl='(column -t | less -SX) <'
alias curl='curl -s'
alias d='docker'
alias db='docker build'
alias dc='docker-compose'
alias de='docker exec'
alias del='docker exec -it $(docker ps -q | head -n1) bash'
alias di='docker images'
alias docker-clean='docker-rm-all && docker-prune'
alias docker-prune='docker rmi $(docker images -f "dangling=true" -q)'
alias docker-rm-all='docker rm -f $(docker ps -a -q)'
alias dps='docker ps'
alias dr='docker run'
alias drl="docker-run-last"
alias e="emacsclient-dwim"
alias ee="emacs -nw -q"
alias ef='emacs-find-file'
alias eg='emacs-magit-status'
alias egd='emacs-magit-diff'
alias egs='emacs-magit-show'
alias es='emacs-grep'
alias exa='exa -I "*.pyc"'
alias f='rlwrap facet'
alias ff='find . -type f -iname'
alias fromip="who | grep \"^$USER\" | sed 1q | perl -n -e 's,.*\(([0-9.]+)\),\1, and print'"
alias g='grep'
alias ga='git add'
alias gb='git branch'
alias gbc='git branch --contains'
alias gbd='git-branch-by-date'
alias gbdwf='gbdw|fzf'
alias gbdh='git-branch-by-date|head'
alias gbl='git blame'
alias gc='git checkout'
alias gcal='gcalcli calw --calendar davison@counsyl.com'
alias gcbd='git branch -D dev 2> /dev/null ; git checkout -b dev ; git checkout -'
alias gcbz='git branch -D z 2> /dev/null ; git checkout -b z ; git checkout -'
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
alias gdcw='git diff --cached --word-diff=color'
alias gdm='git diff master'
alias gdp='git-diff-prod'
alias gdob='git diff origin/$(git rev-parse --abbrev-ref HEAD)'
alias gdsob='git diff --stat origin/$(git rev-parse --abbrev-ref HEAD)'
alias gds='git diff --stat=200,200'
alias gdsc='git diff --cached --stat=200,200'
alias gdsm='git diff --stat=200,200 master...'
alias gdw='git diff --word-diff=color'
alias gdwc='git diff --cached --word-diff=color'
alias gdww='git diff --word-diff=color --word-diff-regex="[a-zA-z_]+"'
alias gdz='git diff z'
alias gf='git fetch'
alias gfc='git-fuzzy-checkout'
alias gg='git grep -P'
alias gh='git-branch-by-date|head'
alias ghci='ghci -fwarn-incomplete-patterns'
alias git-init='git init && git set-email-public && git commit --allow-empty -m "∅"'
alias gitk-all='gitk --all --simplify-by-decoration'
alias gl1='gl -n1'
alias gl='git log1 --stat'
alias gla='gl --format="%an"'
alias gless='grep --color=always | less -R'
alias glf='git log --pretty=fuller'
alias glh='git log --oneline -n 20'
alias glme='gl --author=dan'
alias glob='git log origin/$(git rev-parse --abbrev-ref HEAD)'
alias glp='gl -p'
alias gls='gl --stat'
alias glsp='gl -p --stat'
alias gm='git merge'
alias gp='git pull'
alias gpo='git pull origin'
alias gpob='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias gpom='git fetch origin master && git branch -d master && git branch master origin/master'
alias gprob='git pull --rebase origin $(git rev-parse --abbrev-ref HEAD)'
alias gr1='git reset HEAD~1'
alias gr2='git reset HEAD~2'
alias gr='git reset'
alias grb='git rebase'
alias grba='grb --abort'
alias grbc='grb --continue'
alias grbi='grb --interactive'
alias gre='git remote'
alias grep='grep --color=auto'
alias gres='git remote -v show'
alias grh='git reset --hard'
alias grhh='git reset --hard HEAD'
alias grh1='echo $(git rev-parse HEAD) && git reset --hard HEAD~1'
alias grhob='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'
alias gri='grb --interactive'
for i in 1 2 3 4 5 6 7 8 9 10; do
    alias gri${i}="grb --interactive HEAD~${i}"
done
alias grim='gri master'
alias griob='grb --interactive origin/$(git rev-parse --abbrev-ref HEAD)'
alias grhob='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'
alias grve='git revert --no-edit'
alias gs='git show'
alias gss='git show --stat=256,256'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstk='git stash save --keep-index'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstr='git stash save && git stash drop stash@{1}'
alias gsts='git stash save `date "+%Y-%m-%d %H:%M"`'
alias gstsd='git stash save debugging'
alias gstsp='git stash show -p'
alias gsw='git show --word-diff=color'
alias gsww='git show --word-diff=color --word-diff-regex="[a-zA-z_]+"'
alias h='head'
alias hibernateoff="sudo pmset -a hibernatemode 0"
alias hibernateon="sudo pmset -a hibernatemode 5"
alias hist='tac ~/.bash_eternal_history'
alias hubc='open https://github.counsyl.com/dev/website/commit/$(git rev-list -n1 HEAD)'
alias ip=ipython
alias isort='isort --force_single_line_imports --lines 999999 --dont-skip __init__.py'
alias jp=jsonpipe
alias k=kill-fzf
alias l='less'
alias le='lein'
alias ler='lein repl'
alias less='less -SX'
alias l1='ls -1'
alias ll='ls -l'
alias lr='latexrun --latex-args="-shell-escape" -O .build'
alias ls='exa'
alias lt='exa -l --sort newest'
alias lth='ls -lt | head'
alias lsof-ports='lsof -i -n -P'
alias make-explain="make -rnd | perl -p -e 's,(^ +),\1\1\1\1,'"
alias mathematica='open -a /Applications/Mathematica.app'
alias mk='mkdir -p'
alias mv-desktop-last='mv ~/Desktop/"$(ls -t ~/Desktop/| head -n1)"'
alias np=ping-world
alias npu='until ping-world; do sleep 1; done'
alias nwp=wifi-poke
alias paste='pbpaste'
alias path='readlink -f'
alias pdfjoin='pdfjoin --rotateoversize false'
alias pf='pip freeze'
alias pi='pip install'
alias pip='pip --disable-pip-version-check'
alias ps-me='ps -u `whoami`'
alias psl='ps auxwww | less'
# top $(ps aux | grep postgres | grep -v grep | awk '{print "-p"$2}')
alias pu='pip uninstall'
alias pupf='pip uninstall -y $(pip freeze)'
alias preview='open -a /Applications/Preview.app'
alias pvirtualenv='echo $VIRTUAL_ENV'
alias pwdr='pwd | sed "s,.*$HOME/,,"'
alias pyz='py /tmp/z.py'
alias reload='. ~/.bashrc'
alias rm-tex='rm -f *.{aux,lof,log,lot,out,toc}'
alias rn='rename'
alias rs='rsync -z --progress'
alias sg='stack ghci'
alias skim='open -a /Applications/Skim.app'
alias ssh='ssh -A'
alias sw='switchto website'
alias t='tmux'
alias ta='tmux attach'
alias tail-messages='tail -f /var/log/messages'
alias tcs='tmux-current-session'
alias tl='topleft'
alias tls='tmux list-sessions -F "#S"'
alias tmux-current-session='tmux display-message -p "#S"'
alias tns='tmux new-session'
alias tree='tree -AC --noreport'
alias virtualenv-temp='rm -fr /tmp/v && virtualenv /tmp/v && . /tmp/v/bin/activate'
alias vpro='vagrant provision'
alias vssh='vagrant ssh'
alias xhyve-nsenter='docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i'
