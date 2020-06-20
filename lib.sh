__dan_is_osx () {
    [ -e /Applications ]
}

cd-site-packages () {
    cd `python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`
}

dan-history () {
    local dir=~/dandavison7@gmail.com/shell_history
    tac $dir/eternal_shell_history_03.* | cut -d\; -f2-
    tac $dir/eternal_shell_history_02.* | awk '{$1=$2=""; print substr($0,3)}'
    tac $dir/eternal_shell_history_01.* | awk '{$1=$2=$3=""; print substr($0, 4)}'
}


die () {
    echo "$@" >&2
    return 1
}

dot-view () {
    local file=$(mktemp).svg
    dot -T svg -o $file < $1
    echo $file
    open -a "/Applications/Google Chrome.app" $file
}

ega () {
    touch $1 && git add $1 && emacsclient -n $1
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

gprof2dot-and-go () {
    local file=$(mktemp).svg
    gprof2dot --format pstats $1 | dot -T svg -o $file
    echo $file
    open -a "/Applications/Google Chrome.app" $file
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


hub-commit-pr () {
    head=$(git symbolic-ref --short HEAD)
    EDITOR='emacsclient -n' hub pull-request -b dev:master -h dev:$head $1
}

hub-pr () {
  url=$(hub browse -u)
  open ${url/tree/pull}
  # while chrome-cli info | grep -q "Loading: Yes"; do
  #     sleep 0.1
  # done
  # chrome-cli execute "document.getElementById('pull_request_body').value = ''"
}

kill-python () {
    kill $(ps aux | grep python | grep -v grep | grep "$1" | awk '{print $2}')
}

mv-downcase () { local f=`mktemp -u`; mv "$1" "$f" && mv "$f" $(tr "[:upper:]" "[:lower:]" <<< "$1"); }

mv-link () {
    local source="$1"
    local target="$2"
    [ -n "$1" ] && [ -n "$2" ] || die "mv-link source target"
    mv "$source" "$target" && ln -s "$target" "$source"
}

python-virtualenv-activate () {
    source $DAN_VIRTUALENVS_DIRECTORY/"$1"/bin/activate
}


python-virtualenv-cd-sitepackages () {
    cd $DAN_VIRTUALENVS_DIRECTORY/$(python-virtualenv-name)/lib/python*/site-packages
}

python-virtualenv-name () {
    basename `git rev-parse --show-toplevel`
}

rust-list-tests () {
   # TODO: distinguish between tests that are indented and thus in a
   # module probably named 'tests', and tests which are not indented.
   rg -H --vimgrep 'fn test' | \
       sed -E s,src/\(.+\)\.rs:\[0-9\]+:\[0-9\]:\ +fn\ \(test\[^\(\]+\).\*,\\1::tests::\\2, | \
       sed -E s,/,::,g | sed -E s,mod::,,
}

src-grep () {
    find ~/src -maxdepth 1 -type d | egrep -v '(3p|counsyl)' | while read d; do
        (cd $d && [ -d .git ] && git grep $@)
    done
}

switchto () {
    workon $1 && cdproject
}

tmux-send-all () {
    tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}' | \
        xargs -I PANE tmux send-keys -t PANE "$1" Enter
}

ping-world () {
    ping -c 1 www.gov.uk
}

pip-local () {
    PIP_INDEX_URL="http://$(docker-machine ip $DOCKER_MACHINE_NAME):5555/simple/" \
    PIP_TRUSTED_HOST=$(docker-machine ip $DOCKER_MACHINE_NAME) \
    pip $@
}

pypi-local () {
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

tail0 () {
    file=$1
    until [[ -e $file ]]; do sleep 0.1; done
    tail -f $file
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
