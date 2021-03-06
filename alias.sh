alias ..='cd ..'
alias R='R --silent --no-restore --no-save --vanilla'
alias acurl='curl --user $(cat ~/.ssh/auth)'
alias agp='ag --python'
alias ansifilter="perl -pe 's/\e\[[0-9;]*[mK]//g'"
alias b='git branch-by-date|head'
alias black-diff='(pyenv shell 3.7.0 && cd $(git rev-parse --show-toplevel) && black --skip-string-normalization -l100 $(git diff --name-only master...))'
alias black-all="(cd $(git rev-parse --show-toplevel) && git ls-files '**/*.py' | xargs black --skip-string-normalization -l100 $(git diff --name-only master...))"
alias blank='for _ in `seq 1 128`; do echo; done && clear'
alias c='code'
alias ci='/Applications/Visual\ Studio\ Code\ -\ Insiders.app/Contents/Resources/app/bin/code'
alias cn='code --new-window'
alias cargo-test-fzf='fzf-cargo-test'
alias cat='bat --plain'
alias cb='cargo build'
alias cdg='cd $(git rev-parse --show-toplevel)'
alias cdtemp='cd $(mktemp -d)'
alias chrome='open -a /Applications/Google\ Chrome.app'
alias clipboard-restart='killall pboard'
alias cog='open -a /Applications/Cog.app'
alias ct='cargo-test-fzf'
alias ddbg='ln -fs ~/src/delta/target/debug/delta ~/bin/delta && delta --version'
alias ddev='ln -fs ~/src/delta/target/release/delta ~/bin/delta && delta --version'
alias drel='ln -fs /usr/local/bin/delta ~/bin/delta; delta --version'
alias dh='delta --help | less'
alias di='docker images'
alias docker-clean='docker-rm-all && docker-prune'
alias docker-prune='docker rmi $(docker images -f "dangling=true" -q)'
alias docker-rm-all='docker rm -f $(docker ps -a -q)'
alias dps='docker ps'
alias dtruss-emacs="(sudo filebyproc.d 2>/dev/null) | g -i emacs"
alias dv='delta --version'
alias d='docker'
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
alias fromip="who | grep \"^$USER\" | sed 1q | perl -n -e 's,.*\(([0-9.]+)\),\1, and print'"
alias g='rg'
alias gaf='git add $(git diff --name-only) && git commit --amend -C HEAD'
alias ga='git add'
alias gbc='git branch --contains'
alias gb='git branch'
alias gbl='git blame'
alias gcal='gcalcli calw --calendar davison@counsyl.com'
alias gcbb='git-force-create-branch'
alias gcbz='git branch -D z 2> /dev/null ; git checkout -b z ; git checkout -'
alias gcln='git clean -nd'
alias gclo='git clone'
alias gcl='git clean'
alias gcmm='git branch master origin/master && git checkout master'
alias gcm='git checkout master 2>/dev/null || git checkout main'
alias gcoa='git commit --amend'
alias gcof='git-commit-file'
alias gconfl='git config -l'
alias gconf='git config --global'
alias gco='git commit'
alias gcpa='git cherry-pick --abort'
alias gcp='git cherry-pick'
alias gc='git checkout'
alias gcz='fzf-git-checkout'
alias gd='git diff'
alias gdcs='gd --cached --stat=200,200'
alias gdcw='gd --cached --word-diff=color'
alias gdc='gd --cached'
alias gdm='gd master...'
alias gdob='gd origin/$(git rev-parse --abbrev-ref HEAD)'
alias gdp='git-diff-prod'
alias gdsc='gd --cached --stat=200,200'
alias gdsm='gd --stat=200,200 master...'
alias gdsob='gd --stat origin/$(git rev-parse --abbrev-ref HEAD)'
alias gds='gd --stat=200,200'
alias gdwc='gd --cached --word-diff=color'
alias gdwwc='gdww --cached'
alias gdww='gd --word-diff=color --word-diff-regex="[a-zA-z_]+"'
alias gdw='gd --word-diff=color'
alias gdz='gd z'
alias gfc='git-fuzzy-checkout'
alias gf='git fixup'
alias ghci='ghci -fwarn-incomplete-patterns'
alias ghrvw='gh repo view --web'
alias gitk-all='gitk --all --simplify-by-decoration'
alias git-init='git init && git set-email-public && git commit --allow-empty -m "∅"'
alias git-no-config='GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG=/dev/null HOME=/dev/null git'
alias _gl='git log --date relative -n 10'
alias gl='_gl --stat'
alias gl1='_gl --stat -n1'
alias gla='_gl --format="%an"'
alias gld='_gl --author=dan'
alias glf='_gl --pretty=fuller'
alias glh='_gl --oneline -n 20'
alias glme='_gl --author=dan'
alias glob='_gl origin/$(git rev-parse --abbrev-ref HEAD)'
alias glp='_gl -p'
alias glsp='_gl -p --stat'
alias gls='_gl --stat'
alias gm='git merge'
alias gnp='git --no-pager'
alias google-chrome='open -a /Applications/Google\ Chrome.app'
alias gpob='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias gpom='git fetch origin master && git branch -d master && git branch master origin/master'
alias gpo='git pull origin'
alias gprob='git pull --rebase origin $(git rev-parse --abbrev-ref HEAD)'
alias gp='git pull'
alias gr1='git reset HEAD~1'
alias gr2='git reset HEAD~2'
alias grba='grb --abort'
alias grbc='grb --continue'
alias grbi='grb --interactive'
alias grb='git rebase'
alias grep='grep --color=auto'
alias gres='git remote -v show'
alias gre='git remote'
alias grh1='echo $(git rev-parse HEAD) && git reset --hard HEAD~1'
alias grhh='git reset --hard HEAD'
alias grhob='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'
alias grh='git reset --hard'
alias gri='grb --interactive'
alias gr='git reset'
for i in 1 2 3 4 5 6 7 8 9; do
    alias gri${i}="grb --interactive HEAD~${i}"
done
alias grhob='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'
alias grim='gri master'
alias griob='grb --interactive origin/$(git rev-parse --abbrev-ref HEAD)'
alias grv1='grve HEAD && gr1'
alias grve='git revert --no-edit'
alias gs='git show'
for i in 1 2 3 4 5 6 7 8 9; do
    alias gs${i}="gs HEAD~${i}"
done
alias gss='gs --stat=256,256'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstk='git stash save --keep-index'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstr='git stash save && git stash drop stash@{1}'
alias gstsd='git stash save debugging'
alias gstsp='git stash show -p'
alias gsts='git stash save `date "+%Y-%m-%d %H:%M"`'
alias gst='git status'
alias gsww='gs --word-diff=color --word-diff-regex="[a-zA-z_]+"'
alias gsw='gs --word-diff=color'
alias h='head'
alias hset='redis-cli hset'
alias hibernateoff="sudo pmset -a hibernatemode 0"
alias hibernateon="sudo pmset -a hibernatemode 5"
alias hist='tac $(ls $DAN_ETERNAL_HISTORY_DIR/eternal_shell_history_0* | tac)'
alias hubc='open https://github.counsyl.com/dev/website/commit/$(git rev-list -n1 HEAD)'
alias hz='fzf-hist-cp'
alias hzx='fzf-hist-x'
alias ip=ipython
alias isort='isort --force_single_line_imports --lines 999999 --dont-skip __init__.py'
alias jp=jsonpipe
alias json-cat='(jq -C . | less -RSX)'
alias jc='json-cat<'
alias l='less'
alias latex='latex -shell-escape -interaction nonstopmode -output-directory=${LATEX_OUTPUT_DIRECTORY:-.}'
alias less='less -S'
alias ll='ls -l'
alias lr='latexrun --latex-args="-shell-escape" -O .build'
alias ls="exa --group-directories-first --ignore-glob '*.pyc|__pycache__|Icon*'"
alias ls-gnu='/usr/local/opt/coreutils/libexec/gnubin/ls -N --color=tty --hide="*.pyc" --hide=__pycache__'  # --git-ignore ; --hide="*."{aux,out,log} if you get very annoyed by LaTeX
alias lt='ls -lht'
alias lth='ls -lht | head'
alias lsof-ports='lsof -i -n -P | rg -i LISTEN'
alias lsof-ports-all='lsof -i -n -P'
alias m='cd $(git rev-parse --show-toplevel) && make'
alias make-explain="make -rnd | perl -p -e 's,(^ +),\1\1\1\1,'"
alias mathematica='open -a /Applications/Mathematica.app'
alias mk='mkdir -p'
alias mt='cd $(git rev-parse --show-toplevel) && make test'
alias mypy='mypy --check-untyped-defs'
alias mv-desktop-last='mv ~/Desktop/"$(ls -t ~/Desktop/| head -n1)"'
alias np=ping-world
alias npu='until ping-world; do sleep 1; done'
alias nwp=wifi-poke
alias path='readlink -f'
alias pdfjoin='pdfjoin --rotateoversize false'
alias pdflatex='pdflatex -shell-escape -interaction nonstopmode -output-directory=${LATEX_OUTPUT_DIRECTORY:-.}'
alias pf='pip freeze'
alias pi='pip install'
alias pipn='pip --disable-pip-version-check'
alias play='open -a /Applications/Cog.app'
alias ps-me='ps -u `whoami`'
alias ps1='ps -Af f'
alias psl='ps auxwww | less'
# top $(ps aux | grep postgres | grep -v grep | awk '{print "-p"$2}')
alias pu='pip uninstall'
alias pupf='pip uninstall -y $(pip freeze)'
alias preview='open -a /Applications/Preview.app'
alias pv='python-virtualenv-activate'
alias pwdr='pwd | sed "s,.*$HOME/,,"'
alias python-pdb='python -m pdb -c continue'
alias rm-tex='rm -v *.{aux,log,out,toc}'
alias rm-pyc="find . -type f -name '*.pyc' -delete"
alias rg='rg --hidden --max-columns 1000'
alias rgc='rg --color=always'
alias rgf='rg --files'
alias rn='rename'
alias rs='rsync -z --progress'
alias s='fzf-rg-preview'
alias sg='stack ghci'
alias skim='open -a /Applications/Skim.app'
alias ssh='ssh -A'
alias sw='switchto website'
alias tail-messages='tail -f /var/log/messages'
alias ta='tmux attach'
alias tb='tmux-back'
alias tcs='tmux-current-session'
alias tls='tmux list-sessions -F "#S"'
alias tl='topleft'
alias tmux-current-session='tmux display-message -p "#S"'
alias tns='tmux new-session'
alias tsc='tmux switch-client -l'
alias t='fzf-tmux'
alias virtualenv-temp='rm -fr /tmp/v && virtualenv /tmp/v && . /tmp/v/bin/activate'
alias vpro='vagrant provision'
alias vssh='vagrant ssh'
alias vscode-list-contexts='(cd ~/src-3p/vscode && rg --color=always RawContextKey)'
alias xenops-cache-size='fd . /tmp/xenops-cache | wc -l'
alias xhyve-nsenter='docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i'
alias z-exec='exec zsh'
