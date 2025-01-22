# alias ls='lsd --icon never'
# top $(ps aux | grep postgres | grep -v grep | awk '{print "-p"$2}')
alias _gl='git log --date relative --color=always'
alias -g 'o/m'='origin/main'
alias -g H='HEAD'
alias -g H0='HEAD'
alias -g H1='HEAD~1'
alias -g H2='HEAD~2'
alias -g H3='HEAD~3'
alias -g H4='HEAD~4'
alias -g B='git symbolic-ref --short HEAD'
alias -g snap='$(git-snapshot)'
alias ..='cd ..'
alias ansifilter="perl -pe 's/\e\[[0-9;]*[mK]//g'"
alias b='git branch-by-date | rg -v "^z-" | head'
alias bat='bat --style header,grid --theme ansi'
alias batz='bat $(fzf)'
alias blank='for _ in `seq 1 128`; do echo; done && clear'
alias c='f-git-checkout-branch'
alias cargo-test-fzf='f-cargo-test'
alias cat='LESS=-FIRX bat --plain'
alias cd='wormhole-cd'
alias cdg='cd $(git rev-parse --show-toplevel)'
alias cdtemp='cd $(mktemp -d)'
alias chrome='open -a /Applications/Google\ Chrome.app'
alias clipboard-restart='killall pboard'
alias comp='load-completions'
alias count='sort | uniq -c | sort -rn'
alias cw='cat-which'
alias d='delta-toggle'
alias delta-dbg='ln -fs ~/src/delta/target/debug/delta ~/bin/delta && delta --version'
alias delta-dev='ln -fs ~/src/delta/target/release/delta ~/bin/delta && delta --version'
alias delta-rel='ln -fs /opt/homebrew/bin/delta ~/bin/delta; delta --version'
alias di='docker images'
alias dl='delta-toggle line-numbers'
alias docker-clean='docker-rm-all && docker-prune'
alias docker-prune='docker rmi $(docker images -f "dangling=true" -q)'
alias docker-rm-all='docker rm -f $(docker ps -a -q)'
alias ds='delta-toggle side-by-side'
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
alias ff='find . -type f -iname'
alias fg='git-forgit'
alias fo='open-file'
alias fr='resolve-file'
alias fromip="who | grep \"^$USER\" | sed 1q | perl -n -e 's,.*\(([0-9.]+)\),\1, and print'"
alias fs='cat-file'
alias fzf='fzf --exact'
alias g='rg-delta'
alias ga='git add'
alias gaf='git add $(git diff --name-only) && git commit --amend -C HEAD'
alias gap='git add -p'
alias gar='git apply -R -'
alias gb='git branch'
alias gbcz='git branch -C z'
alias gbl='git blame'
alias gbz='f-git-branch'
alias gc='git checkout --quiet'
alias gcal='gcalcli calw --calendar dan.davison@temporal.io'
alias gcbb='git-force-create-branch'
alias gcl='git clean'
alias gcln='git clean -nd'
alias gclo='git clone'
alias gcm='git checkout main'
alias gcmm='git branch main origin/main && git checkout main'
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
alias gcpz='f-git-cherry-pick'
alias gcz='f-git-checkout-branch'
alias gd='git diff'
alias gdc='gd --cached'
alias gdc='git diff --cached'
alias gdcs='gd --cached --stat=200,200'
alias gdcs='gdsc'
alias gdcw='gd --cached --word-diff=color'
alias gdm='gd main...'
alias gdml='dl && gdm'
alias gdob='gd origin/$(git rev-parse --abbrev-ref HEAD)'
alias gdobs='gd --stat origin/$(git rev-parse --abbrev-ref HEAD)'
alias gdom='gd origin/main...'
alias gdom='git diff origin/main'
alias gdp='git-diff-prod'
alias gds='gd --stat=200,200'
alias gds='git diff --stat=200,200'
alias gdsc='gd --cached --stat=200,200'
alias gdsc='gds --cached'
alias gdsm='gd --stat=200,200 main...'
alias gdsob='gd --stat origin/$(git rev-parse --abbrev-ref HEAD)'
alias gdsom='gd --stat=200,200 origin/main...'
alias gdw='gd --word-diff=color'
alias gdwc='gd --cached --word-diff=color'
alias gdww='gd --word-diff=color --word-diff-regex="[a-zA-z_]+"'
alias gdwwc='gdww --cached'
alias gdz='f-git-diff'
alias gf='git fixup'
alias gfc='git-fuzzy-checkout'
alias gfom='git fetch origin main:main'
alias gg='git grep -n'
alias ghci='ghci -fwarn-incomplete-patterns'
alias ghprc='gh pr create --web'
alias ghprch='gh pr checkout'
alias ghprv='gh pr view --web'
alias ghrv='gh repo view --web'
alias git-init='git init && git commit --allow-empty -m "∅"'
alias git-no-config='GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG=/dev/null HOME=/dev/null git'
alias gitk-all='gitk --all --simplify-by-decoration'
alias gl='_gl --stat'
alias gl1='_gl --stat -n1'
alias gla='_gl --format="%an"'
alias gld='_gl --author=dan'
alias glf='_gl --pretty=fuller'
alias glh='_gl --oneline -n 20'
alias glm='git log main'
alias glme='_gl --author=dan'
alias glob='_gl origin/$(git rev-parse --abbrev-ref HEAD)'
alias glom='git log origin/main'
alias glp='_gl -p'
alias gls='_gl --stat'
alias glsp='_gl -p --stat'
alias glz='f-git-log-branch'
alias gm='git merge'
alias gma='git merge --abort'
alias gmom='git merge origin/main'
alias gnp='git --no-pager'
alias gp='git pull'
alias gpo='git pull origin'
alias gpob='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias gpom='git fetch origin main && git branch -d main && git branch main origin/main'
alias gprob='git pull --rebase origin $(git rev-parse --abbrev-ref HEAD)'
alias gpu='git push'
alias gpuf='git push --force'
alias gr='git rebase'
alias gra='gr --abort'
alias grc='gr --continue'
alias gre='git remote'
alias grep='grep --color=auto'
alias gres='git remote -v show'
alias grh='git reset --hard'
alias grh1='echo $(git rev-parse HEAD) && git reset --hard HEAD~1'
alias grhh='git reset --hard HEAD'
alias grhob='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'
alias grhob='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'
alias grhom='git reset --hard origin/main'
alias grhz='f-git-reset-hard'
alias gri='gr --interactive'
alias grim='gri main || gri main'
alias griob='gr --interactive origin/$(git rev-parse --abbrev-ref HEAD)'
alias griz='f-git-rebase-interactive'
alias grm='gr main'
alias grom='gr origin/main'
alias grp-upstream='git rev-parse --abbrev-ref --symbolic-full-name "@{u}"'
alias grs='git reset'
alias grs1='git reset HEAD~1'
alias grs2='git reset HEAD~2'
alias grsz='f-git-reset'
alias grv='git revert --no-edit'
alias grva='git revert --abort'
alias grvs='git show | git apply -R -'
alias grvz='f-git-revert'
alias grz='f-git-rebase'
alias gs='git show'
alias gsz='f-git-show'
alias gss='gs --stat=256,256'
alias gst='git status'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstk='git stash save --keep-index'
alias gstl='git stash list'
alias gstlp='git stash list -p'
alias gstp='git stash pop'
alias gstr='git stash save && git stash drop stash@{1}'
alias gsts='git stash save `date "+%Y-%m-%d %H:%M"`'
alias gstsd='git stash save debugging'
alias gstsp='git stash show -p'
alias gstz='f-git-stash'
alias gsw='gs --word-diff=color'
alias gsww='gs --word-diff=color --word-diff-regex="[a-zA-z_]+"'
alias hz='f-hist-cp'
alias hzx='f-hist-x'
alias idea='/Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea'
alias ip='ipython --no-banner'
alias isort-dan='isort --force_single_line_imports --lines 999999 --dont-skip __init__.py'
alias jql='(jq -C . | less -RSX)'
alias j='(jq -C . | less -RSX)'
alias l='gl'
alias latex-default='latex -shell-escape -interaction nonstopmode -output-directory=${LATEX_OUTPUT_DIRECTORY:-.}'
alias le='less'
alias less='less -S'
alias lg='lazygit'
alias ll='ls -l'
alias lp='glp'
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
alias nr='npm run'
alias np=ping-world
alias npu='until ping-world; do sleep 1; done'
alias nwp=wifi-poke
alias o=f-open
alias p=python
alias pdfjoin='pdfjoin --rotateoversize false'
alias pdflatex='pdflatex -shell-escape -interaction nonstopmode -output-directory=${LATEX_OUTPUT_DIRECTORY:-.}'
alias pf='pip freeze'
alias pi='pip install'
alias pipn='pip --disable-pip-version-check'
alias pipiup='pip install --upgrade pip'
alias play='open -a /Applications/Cog.app'
alias preview='open -a /Applications/Preview.app'
alias ps-me='ps -u `whoami`'
alias ps1='ps -Af f'
alias psl='ps auxwww | less'
alias pu='pip uninstall'
alias pupf='pip uninstall -y $(pip freeze)'
alias pv='python-virtualenv-activate'
alias pwdr='pwd | sed "s,.*$HOME/,,"'
alias pytest='python -m pytest --no-header'
alias pytest-quiet='python -m pytest --no-header --tb=short --disable-warnings --log-level=ERROR --log-cli-level=ERROR'
alias python-pdb='python -m pdb -c continue'
alias R='R --silent --no-restore --no-save --vanilla'
alias r=f-rg
alias rg='rg --hidden -g "!.git/*"'
alias rn='f-rg --exclude-tests'
alias rgb=rg-blame
alias rgc='rg --color=always'
alias rgd=rg-delta
alias rgz=f-rg
alias rgf='rg --files'
alias rm-pyc="find . -type f -name '*.pyc' -delete"
alias rm-tex='rm -v *.{aux,log,out,toc}'
alias ssh='ssh -A'
alias tree='tree --gitignore --hyperlink'
alias t='tree --gitignore --hyperlink'
alias tls='tmux list-sessions -F "#S"'
alias tda='temporal-delete-all'
alias tonc='temporal operator namespace create -n default'
alias ts='temporal server start-dev --dynamic-config-value frontend.enableExecuteMultiOperation=true'
alias tmux-current-session='tmux display-message -p "#S"'
alias v='cursor .'
alias vscode-list-contexts='(cd ~/tmp/3p/vscode && rg --color=always RawContextKey)'
alias vd='vscode-debug'
alias vs='vscode-summary'
alias wl='wormhole-list'
alias wo='f-wormhole-open'
alias w='wormhole-list'
alias wf='which-follow'
alias xhyve-nsenter='docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i'
alias zsh-help='run-help'

for i in 1 2 3 4 5 6 7 8 9; do
    alias gs${i}="gs HEAD~${i}"
done

for i in 1 2 3 4 5 6 7 8 9; do
    alias gri${i}="git rebase --interactive HEAD~${i}"
done
