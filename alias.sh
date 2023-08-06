# alias ls='lsd --icon never'
# top $(ps aux | grep postgres | grep -v grep | awk '{print "-p"$2}')
alias _gl='git log --date relative'
alias -g 'o/m'=origin/master
alias -g H1='HEAD~1'
alias -g H2='HEAD~2'
alias -g H3='HEAD~3'
alias -g H4='HEAD~4'
alias ..='cd ..'
alias acurl='curl --user $(cat ~/.ssh/auth)'
alias agp='ag --python'
alias ansifilter="perl -pe 's/\e\[[0-9;]*[mK]//g'"
alias b='git branch-by-date|head'
alias bat='bat --style header,grid'
alias bazel-query='bazel query --noshow_progress --noshow_loading_progress --ui_event_filters=-INFO'
alias blank='for _ in `seq 1 128`; do echo; done && clear'
alias c='cat'
alias cargo-test-fzf='fzf-cargo-test'
alias cat='bat --style header,grid'
alias cb='cargo build'
alias cd='wormhole-cd'
alias cdg='cd $(git rev-parse --show-toplevel)'
alias cdtemp='cd $(mktemp -d)'
alias chrome='open -a /Applications/Google\ Chrome.app'
alias clipboard-restart='killall pboard'
alias co='code'
alias cog='open -a /Applications/Cog.app'
alias coi='/Applications/Visual\ Studio\ Code\ -\ Insiders.app/Contents/Resources/app/bin/code'
alias con='code --new-window'
alias count='sort | uniq -c | sort -rn'
alias ct='cargo-test-fzf'
alias delta-dbg='ln -fs ~/src/delta/target/debug/delta ~/bin/delta && delta --version'
alias delta-dev='ln -fs ~/src/delta/target/release/delta ~/bin/delta && delta --version'
alias delta-rel='ln -fs /opt/homebrew/bin/delta ~/bin/delta; delta --version'
alias dh='delta -h | less'
alias dhh='delta --help | less'
alias di='docker images'
alias docker-clean='docker-rm-all && docker-prune'
alias docker-prune='docker rmi $(docker images -f "dangling=true" -q)'
alias docker-rm-all='docker rm -f $(docker ps -a -q)'
alias ds='delta-side-by-side'
alias e="emacsclient -n"
alias ee="emacs -nw -q"
alias ef='emacs-find-file'
alias eg='emacs-magit-status'
alias egd='emacs-magit-diff'
alias egr='emacs-grep'
alias egs='emacs-magit-show'
alias emacs-app='open -n /Applications/Emacs.app/'
alias emacs-byte-compile="emacs --batch --eval '(package-initialize)' -f batch-byte-compile"
alias es='emacs-grep'
alias f='fzf'
alias facet='rlwrap facet'
alias ff='find . -type f -iname'
alias fo='open-file'
alias fr='resolve-file'
alias fromip="who | grep \"^$USER\" | sed 1q | perl -n -e 's,.*\(([0-9.]+)\),\1, and print'"
alias fs='cat-file'
alias fzf='fzf --exact'
alias g='rg'
alias ga='git add'
alias gaf='git add $(git diff --name-only) && git commit --amend -C HEAD'
alias gap='git add -p'
alias gar='git apply -R -'
alias gb='git branch'
alias gbcz='git branch -C z'
alias gbl='git blame'
alias gc='git checkout'
alias gcal='gcalcli calw --calendar dan.davison@temporal.io'
alias gcbb='git-force-create-branch'
alias gcl='git clean'
alias gcln='git clean -nd'
alias gclo='git clone'
alias gcm='git checkout master 2>/dev/null || git checkout main'
alias gcmm='git branch master origin/master && git checkout master'
alias gco='git commit'
alias gcoa='git commit --amend'
alias gcoan='git commit --amend --no-edit'
alias gcof='git-commit-file'
alias gcon='git commit --no-edit'
alias gconf='git config --global'
alias gconfl='git config -l'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcz='fzf-git-checkout'
alias gd='git diff'
alias gdc='gd --cached'
alias gdcs='gd --cached --stat=200,200'
alias gdcw='gd --cached --word-diff=color'
alias gdob='gd origin/$(git rev-parse --abbrev-ref HEAD)'
alias gdobs='gd --stat origin/$(git rev-parse --abbrev-ref HEAD)'
alias gdom='gd origin/master...'
alias gdp='git-diff-prod'
alias gds='gd --stat=200,200'
alias gdsc='gd --cached --stat=200,200'
alias gdsob='gd --stat origin/$(git rev-parse --abbrev-ref HEAD)'
alias gdsom='gd --stat=200,200 origin/master...'
alias gdw='gd --word-diff=color'
alias gdwc='gd --cached --word-diff=color'
alias gdww='gd --word-diff=color --word-diff-regex="[a-zA-z_]+"'
alias gdwwc='gdww --cached'
alias gdz='gd z'
alias gf='git fixup'
alias gfc='git-fuzzy-checkout'
alias gfom='git fetch origin master'
alias gg='git grep -n'
alias ghci='ghci -fwarn-incomplete-patterns'
alias ghrvw='gh repo view --web'
alias git-init='git init && git-user-public && git commit --allow-empty -m "∅"'
alias git-init-temporal='git init && git-user-temporal && git commit --allow-empty -m "∅"'
alias git-no-config='GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG=/dev/null HOME=/dev/null git'
alias gitk-all='gitk --all --simplify-by-decoration'
alias gl='_gl --stat'
alias gl1='_gl --stat -n1'
alias gla='_gl --format="%an"'
alias glances='glances --theme-white'
alias gld='_gl --author=dan'
alias glf='_gl --pretty=fuller'
alias glh='_gl --oneline -n 20'
alias glme='_gl --author=dan'
alias glob='_gl origin/$(git rev-parse --abbrev-ref HEAD)'
alias glp='_gl -p'
alias gls='_gl --stat'
alias glsp='_gl -p --stat'
alias gm='git merge'
alias gnp='git --no-pager'
alias gp='git pull'
alias gpo='git pull origin'
alias gpob='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias gpom='git fetch origin master && git branch -d master && git branch master origin/master'
alias gprob='git pull --rebase origin $(git rev-parse --abbrev-ref HEAD)'
alias gr='git reset'
alias gr1='git reset HEAD~1'
alias gr2='git reset HEAD~2'
alias grb='git rebase'
alias grba='grb --abort'
alias grbc='grb --continue'
alias grbi='grb --interactive'
alias gre='git remote'
alias grep='grep --color=auto'
alias gres='git remote -v show'
alias grh='git reset --hard'
alias grh1='echo $(git rev-parse HEAD) && git reset --hard HEAD~1'
alias grhh='git reset --hard HEAD'
alias grhob='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'
alias grhob='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'
alias gri='grb --interactive'
alias grim='gri main || gri master'
alias griob='grb --interactive origin/$(git rev-parse --abbrev-ref HEAD)'
alias grm='git remote'
alias grv='git revert --no-edit'
alias grvs='git show | git apply -R -'
alias gs='git show'
alias gss='gs --stat=256,256'
alias gst='git status'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstk='git stash save --keep-index'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstr='git stash save && git stash drop stash@{1}'
alias gsts='git stash save `date "+%Y-%m-%d %H:%M"`'
alias gstsd='git stash save debugging'
alias gstsp='git stash show -p'
alias gsw='gs --word-diff=color'
alias gsww='gs --word-diff=color --word-diff-regex="[a-zA-z_]+"'
alias h='head'
alias hibernateoff="sudo pmset -a hibernatemode 0"
alias hibernateon="sudo pmset -a hibernatemode 5"
alias hist='tac $(ls $DAN_ETERNAL_HISTORY_DIR/eternal_shell_history_0* | tac)'
alias hset='redis-cli hset'
alias hz='fzf-hist-cp'
alias hzx='fzf-hist-x'
alias idea='/Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea'
alias ip=ipython
alias isort='isort --force_single_line_imports --lines 999999 --dont-skip __init__.py'
alias jcat='(jq -C . | less -RSX)'
alias jp=jsonpipe
alias l='git log'
alias latex='latex -shell-escape -interaction nonstopmode -output-directory=${LATEX_OUTPUT_DIRECTORY:-.}'
alias less='less -S'
alias ll='ls -l'
alias lr='latexrun --latex-args="-shell-escape" -O .build'
alias ls='/opt/homebrew/opt/coreutils/libexec/gnubin/ls -N --color=tty --hide=__pycache__' # --git-ignore ; --hide="*."{aux,out,log} if you get very annoyed by LaTeX
alias lsof-ports-all='sudo lsof -i -n -P'
alias lsof-ports='sudo lsof -i -n -P | rg -i LISTEN'
alias lt='ls -lt'
alias lth='ls -lt | head'
alias m='cd $(git rev-parse --show-toplevel) && make'
alias make-explain="make -rnd | perl -p -e 's,(^ +),\1\1\1\1,'"
alias mathematica='open -a /Applications/Mathematica.app'
alias mk='mkdir -p'
alias mt='cd $(git rev-parse --show-toplevel) && make test'
alias mv-desktop-last='mv ~/Desktop/"$(ls -t ~/Desktop/| head -n1)"'
alias mypy='mypy --check-untyped-defs'
alias np=ping-world
alias npu='until ping-world; do sleep 1; done'
alias nwp=wifi-poke
alias o=open-app
alias p=python
alias pdfjoin='pdfjoin --rotateoversize false'
alias pdflatex='pdflatex -shell-escape -interaction nonstopmode -output-directory=${LATEX_OUTPUT_DIRECTORY:-.}'
alias pf='pip freeze'
alias pi='pip install'
alias pipn='pip --disable-pip-version-check'
alias play='open -a /Applications/Cog.app'
alias preview='open -a /Applications/Preview.app'
alias ps-me='ps -u `whoami`'
alias ps1='ps -Af f'
alias psl='ps auxwww | less'
alias pu='pip uninstall'
alias pupf='pip uninstall -y $(pip freeze)'
alias pv='python-virtualenv-activate'
alias pwdr='pwd | sed "s,.*$HOME/,,"'
alias pytest='pytest --no-header'
alias python-pdb='python -m pdb -c continue'
alias R='R --silent --no-restore --no-save --vanilla'
alias rgc='rg --color=always'
alias rgd=rg-delta
alias rgf='rg --files'
alias rm-pyc="find . -type f -name '*.pyc' -delete"
alias rm-tex='rm -v *.{aux,log,out,toc}'
alias rn='rename'
alias rs='rsync -z --progress'
alias s='fzf-rg-preview'
alias sgg='src-git-grep-scala-strato'
alias skim='open -a /Applications/Skim.app'
alias ssh='ssh -A'
alias sw='switchto website'
alias t='lsd --tree'
alias ta='tmux attach'
alias tail-messages='tail -f /var/log/messages'
alias tb='tmux-back'
alias tcs='tmux-current-session'
alias tl='topleft'
alias tls='tmux list-sessions -F "#S"'
alias tmux-current-session='tmux display-message -p "#S"'
alias tns='tmux new-session'
alias v=code
alias virtualenv-temp='rm -fr /tmp/v && virtualenv /tmp/v && . /tmp/v/bin/activate'
alias vpro='vagrant provision'
alias vscode-list-contexts='(cd ~/src-3p/vscode && rg --color=always RawContextKey)'
alias vssh='vagrant ssh'
alias xenops-cache-size='fd . /tmp/xenops-cache | wc -l'
alias xhyve-nsenter='docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i'
alias z=zed
alias z-exec='exec zsh'

for i in 1 2 3 4 5 6 7 8 9; do
    alias gs${i}="gs HEAD~${i}"
done

for i in 1 2 3 4 5 6 7 8 9; do
    alias gri${i}="grb --interactive HEAD~${i}"
done
