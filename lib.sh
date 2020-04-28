dan-history () {
    local dir=~/dandavison7@gmail.com/shell_history
    tac $dir/eternal_shell_history_03.* | cut -d\; -f2-
    tac $dir/eternal_shell_history_02.* | awk '{$1=$2=""; print substr($0,3)}'
    tac $dir/eternal_shell_history_01.* | awk '{$1=$2=$3=""; print substr($0, 4)}'
}


python-virtualenv-name () {
    basename `git rev-parse --show-toplevel`
}


python-virtualenv-activate () {
    source $DAN_VIRTUALENVS_DIRECTORY/"$1"/bin/activate
}


python-virtualenv-cd-sitepackages () {
    cd $DAN_VIRTUALENVS_DIRECTORY/$(python-virtualenv-name)/lib/python*/site-packages
}

die () {
    echo "$@" >&2
    return 1
}

__dan_is_osx () {
    [ -e /Applications ]
}

src-grep () {
    find ~/src -maxdepth 1 -type d | egrep -v '(3p|counsyl)' | while read d; do
        (cd $d && [ -d .git ] && git grep $@)
    done
}

tmux-send-all () {
    tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}' | \
        xargs -I PANE tmux send-keys -t PANE "$1" Enter
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

pr () {
  url=$(hub browse -u)
  open ${url/tree/pull}
  # while chrome-cli info | grep -q "Loading: Yes"; do
  #     sleep 0.1
  # done
  # chrome-cli execute "document.getElementById('pull_request_body').value = ''"
}

hub-commit-pr () {
    head=$(git symbolic-ref --short HEAD)
    EDITOR='emacsclient -n' hub pull-request -b dev:master -h dev:$head $1
}

switchto () {
    workon $1 && cdproject
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

ega () {
    touch $1 && git add $1 && emacsclient -n $1
}


grip-chrome () {
    tmpfile=$(mktemp)
    grip --export $1 $tmpfile > /dev/null 2>&1 && chrome $tmpfile
}


grip-python () {
    (echo '```python'
     cat
     echo '```') | grip --export -
}


cd-site-packages () {
    cd `python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`
}

docker-run-last () {
    docker run --rm -it $@ $(docker images | sed -n 2p | awk '{print $3}')
}

docker-container-uri () {
    container_name="$1"
    container_port="$2"
    [ -n "$container_name" -a -n "$container_port" ] || {
        echo "usage: $0 <container-name> <container-port>" >&2
        return 1
    }
    echo "http://$(docker-machine ip $DOCKER_MACHINE_NAME):$(docker port $container_name $container_port | cut -d: -f2)"
}

docker_compose_get_container() {
    local service="$1"
    shift
    local container=$(docker-compose $@ ps -q "$service")
    local n_containers=$(echo -n "$container" | grep -c '^')
    [ "$n_containers" -eq 1 ] || \
        die "$n_containers containers found for service: '$service'; expected 1"
    echo "$container"
}

# E.g. docker-compose exec -it $service bash
docker-compose-exec () {
    local exec_args=""
    while [[ "$1" == -* ]] ; do exec_args+=" $1" ; shift ; done
    local service="$1"
    shift
    docker exec $exec_args $(docker_compose_get_container "$service") $@
}

pip-local () {
    PIP_INDEX_URL="http://$(docker-machine ip $DOCKER_MACHINE_NAME):5555/simple/" \
    PIP_TRUSTED_HOST=$(docker-machine ip $DOCKER_MACHINE_NAME) \
    pip $@
}

local-pypi () {
    local port=${1:-5555}
    local package_dir=~/tmp/packages
    local image_name=simple-http-server
    local container_name=$image_name
    local dockerfile_dir=~/src/dockerfiles/simple-http-server

    (cd $dockerfile_dir && docker build -t $image_name .)
    dir2pi $package_dir
    docker rm -f $container_name 2> /dev/null
    echo "Starting local PyPi server: http://$(docker-machine ip $DOCKER_MACHINE_NAME):$port"
    docker run -p $port:80 --rm --name $container_name -v $package_dir:/srv simple-http-server
}

docker-build-with-local-pypi () {
    docker build \
       --build-arg PIP_TRUSTED_HOST=$(docker-machine ip $DOCKER_MACHINE_NAME) \
       --build-arg PIP_INDEX_URL="http://$(docker-machine ip $DOCKER_MACHINE_NAME):5555/simple/" \
       $@
}

ping-world () {
    ping -c 1 www.gov.uk
}

mv-downcase () { local f=`mktemp -u`; mv "$1" "$f" && mv "$f" $(tr "[:upper:]" "[:lower:]" <<< "$1"); }

mv-link () {
    local source="$1"
    local target="$2"
    [ -n "$1" ] && [ -n "$2" ] || die "mv-link source target"
    mv "$source" "$target" && ln -s "$target" "$source"
}

git-commit-file () {
    git add "$1" && git commit -m "$1"
}

tail0 () {
    file=$1
    until [[ -e $file ]]; do sleep 0.1; done
    tail -f $file
}


kill-python () {
    kill $(ps aux | grep python | grep -v grep | grep "$1" | awk '{print $2}')
}


# toggle iTerm Dock icon
# https://gist.github.com/CrazyApi/5377685
# http://apple.stackexchange.com/questions/209250/remove-iterm-from-cmdtab-apps?rq=1
# http://apple.stackexchange.com/questions/92004/is-there-a-way-to-hide-certain-apps-from-the-cmdtab-menu
toggle-iterm () {
    pb='/usr/libexec/PlistBuddy'
    iTerm='/Applications/iTerm.app/Contents/Info.plist'

    echo "Do you wish to hide iTerm in Dock?"
    select ync in "Hide" "Show" "Cancel"; do
        case $ync in
            'Hide' )
                $pb -c "Add :LSUIElement bool true" $iTerm
                echo "relaunch iTerm to take effectives"
                break
                ;;
            'Show' )
                $pb -c "Delete :LSUIElement" $iTerm
                echo "run killall 'iTerm' to exit, and then relaunch it"
                break
                ;;
        'Cancel' )
            break
            ;;
        esac
    done
}


gprof2dot-and-go () {
    local file=$(mktemp).svg
    gprof2dot --format pstats $1 | dot -T svg -o $file
    echo $file
    open -a "/Applications/Google Chrome.app" $file
}


dot-view () {
    local file=$(mktemp).svg
    dot -T svg -o $file < $1
    echo $file
    open -a "/Applications/Google Chrome.app" $file
}

emacs-set-minimal () {
    rm -f ~/.emacs
    ln -s ~/src/emacs-config/emacs-minimal.el ~/.emacs
}

emacs-set-normal () {
    rm -f ~/.emacs
    ln -s ~/src/emacs-config/emacs.el ~/.emacs
}


# https://gist.github.com/SlexAxton/4989674
gifify() {
  if [[ -n "$1" ]]; then
    if [[ $2 == '--good' ]]; then
      ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
      rm out-static*.png
    else
      ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}
