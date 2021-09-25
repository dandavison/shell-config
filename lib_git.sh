git-force-create-branch () {
    local branch="$1"
    [ -n "$branch" ] && git branch -D "$branch" && git checkout -b "$branch" && git checkout -
}

git-commit-file () {
    git add "$1" && git commit -m "$1"
}

git-delete-squashed-branch () {
    local branch=$1
    local main=master
    git checkout $branch \
    && git rebase $main \
    && git checkout $main \
    && git branch -d $branch
}

git-prune-merged () {
    git branch-by-date | \
        awk '{print $1}' | \
        while read b ; do
            git branch -d $b 2> /dev/null
        done
}

git-delete-temp-branches () {
    git branch-by-date | \
        awk '{print $1}' | \
        grep '^z-' | \
        while read b ; do
            git branch -D $b 2> /dev/null
        done
}

git-diff-prod () {
    git diff $@ -- . ':(exclude)*/test*' ':(exclude)*/fake*'
}

git-prod () {
    git $@ -- . ':(exclude)*/test*' ':(exclude)*/fake*'
}

git-checkout-maybe-remote-branch () {
    git checkout $1 && git pull origin $1 || {
            git fetch origin $1:$1 && git checkout $1
        }
}

alias gcf=git-checkout-maybe-remote-branch


git-review () {
    git fetch origin $1:$1
    git checkout $1 && egit-diff master...
}

git-review-merge () {
    local merge_commit=$1
    git rev-list --parents -n1 $merge_commit | read merge parent1 parent2
    git checkout $parent2 && egit-diff $parent1...$parent2
}

git-show-merge () {
    local merge_commit=$1
    git rev-list --parents -n1 $merge_commit | (
        read merge parent1 parent2
        git diff $2 $parent1...$parent2
    )
}

git-unified-diff () {
    local commit="$1"
    local file="$2"
    git show "$commit~1":"$file" > "/tmp/before-$(basename $file)"
    git show "$commit":"$file" > "/tmp/after-$(basename $file)"
    diff -u "/tmp/before-$(basename $file)" "/tmp/after-$(basename $file)"
}

git-python-xargs () {
    git ls-files | grep '\.py$' | xargs $@
}

git-link () {
    [[ -n $1 ]] || return 1
    git commit --allow-empty -m ""
}

git-ls-xargs () {
    (cd $(git rev-parse --show-toplevel) && git ls | xargs $@)
}

git-sed () {
    git ls-files | xargs -P 0 sed --follow-symlinks -i -E "$@"
}

git-perl-python () {
    git ls-files '**/*.py' | xargs -P 0 perl -pi -e "$@"
}

git-graft-1 () {
    stock=$1
    scion=$2
    git checkout -b "z-temp-graft-branch"
    git rebase --onto $stock $scion "z-temp-graft-branch"
    echo "Done; on a temp branch. You probably want to use reset --hard to make your working branch point at this temp branch's HEAD"
}

git-graft () {
    new_commits=$1
    original_branch=$(git rev-parse --abbrev-ref HEAD)
    git checkout -b "z-temp-graft-branch"
    git rebase --onto $original_branch $new_commits $(git rev-parse --abbrev-ref HEAD)
    echo "Done; on temp branch $(git rev-parse --abbrev-ref HEAD). "
    echo "You probably want to use reset --hard to make your original branch "
    echo "$original_branch point at this temp branch's HEAD."
}

git-grep-joint () {
    git grep "$2" $(git grep -l "$1")
}

git-make-repos () {
    for d in */; do
        [ -e "$d/.git" ] && continue
        echo $d
        (
            cd $d
            git init && git set-email-public && git commit --allow-empty -m "∅"
            git add .
            find . -type f -name '*.pyc' -o -name '*.elc' | xargs git rm -f --ignore-unmatch {}
            git commit -m init
        ) > /dev/null
    done
}
