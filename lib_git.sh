git-log-all-refs() {
    local b
    git-list-refs | while read b; do _gl "$@" $b; done
}

git-review() {
    git fetch origin $1:$1
    git checkout $1 && egit-diff master...
}

git-review-merge() {
    local merge_commit=$1
    git rev-list --parents -n1 $merge_commit | read merge parent1 parent2
    git checkout $parent2 && egit-diff $parent1...$parent2
}

git-make-repos() {
    for d in */; do
        [ -e "$d/.git" ] && continue
        echo $d
        (
            cd $d
            git init && git set-email-public && git commit --allow-empty -m "∅"
            git add .
            find . -type f -name '*.pyc' -o -name '*.elc' | xargs git rm -f --ignore-unmatch {}
            git commit -m init
        ) >/dev/null
    done
}

alias gcf=git-checkout-maybe-remote-branch

# From decluttering of gitconfig:
#
#     copy-head = !git head | tr -d '\n' | pbcopy
# delete-merged-current = "!f() { git branch --merged | grep -v \\* | grep -v master$ | xargs -n 1 git branch -d; }; f"
# delete-merged-master = "!f() { git branch --merged master | grep -v '^[\\* ] master$' | xargs -n 1 git branch -d; }; f"
# grep-history = "!f() { git rev-list --all | xargs git grep $1 } ; f"
#     log1 = log \
#          --date relative \
#          --format='%n\
# %C(green) ------------------------------------------------------------------------------%n\
# %C(green)%h %C(green)%ad %ae%n\
# %n\
#     %s%n\
# %n\
#     %-b%n\
# '
#     log2 = log --graph --color --decorate --date=relative --abbrev-commit
#     log3 = log --pretty=oneline --abbrev-commit
#     log4 = log --stat
#     log5 = log --format='%C(red)%ad%C(reset) %ae %h%n%n    %s%n%n'
#     lp = "!git log --graph --color=always --format=\"%C(auto)%h%d %s %C(black)%C(bold)<%an> %cr%C(auto)\" \"$@\" \
#           | fzf --ansi -m --no-sort --reverse --tiebreak=index \
#           --preview \"(grep -o '[a-f0-9]\\{7\\}' | head -1 | xargs -I % sh -c 'git -c core.pager=cat show --color=never % | delta') <<< {}\" #"
#     log6 = log --date=format:'%a %Y-%m-%d %k:%M' --color=always --format='%n%C(green)%ad %C(blue)%an <%ae> %C(auto)%h%d%n%n %s%n%w(0,2,2)%+b%C(reset)' --compact-summary
# state = !"echo $(git rev-parse --abbrev-ref HEAD; git rev-parse HEAD; _diff=$(git diff; git diff --cached); [ -n \"$_diff\" ] && md5sum - <<< \"$_diff\")"
