glow() {
    command glow "$@" | less
}

sockets() {
    (osqueryi --list --separator ',' |
        cut -c 1-300 |
        column -t -s ',' |
        sed '1d' |
        rg -v '(rapportd|node.mojom.NodeService|wormhole)') <<EOF
SELECT s.pid, s.local_port, p.cmdline, p.cwd
FROM process_open_sockets AS s
INNER JOIN processes AS p
ON s.pid = p.pid
WHERE s.state = 'LISTEN'
ORDER BY p.cmdline;
EOF
}

sockets-all() {
    (osqueryi --list --separator ',' |
        cut -c 1-300 |
        column -t -s ',' |
        sed '1d') <<EOF
SELECT s.pid, s.local_port, p.cmdline, p.cwd
FROM process_open_sockets AS s
INNER JOIN processes AS p
ON s.pid = p.pid
ORDER BY p.cmdline;
EOF
}

processes() {
    (osqueryi --list --separator ',') <<EOF
SELECT p.pid, p.name, p.cwd
FROM processes AS p
ORDER BY p.cmdline;
EOF
}

vscode() {
    if [ -z "$1" ]; then
        if ls | rg -q '\.code-workspace$'; then
            code *.code-workspace
        else
            code .
        fi
    else
        code -g "$@"
    fi
}

which-follow() {
    local p
    p="$(which -a "$1" | tee /dev/stderr | tail -n1)"
    if [[ -z "$p" ]]; then
        :
    elif [[ "$p" == *" not found" ]]; then
        echo "$p"
    elif [[ "$p" == *": aliased to "* ]]; then
        echo "$p"
        local p2
        p2=$(echo "$p" | rg -r '$1' '.+aliased to ([^ ]+).*')
        [ "$p" != "$p2" ] && which-follow "$p2"
    else
        readlink -f "$p"
    fi
}

bat-files() {
    local f
    while read f; do bat --decorations always --paging=never $f; done | less -R
}

pyenv-load() {
    source /Users/dan/src/devenv/shell-config/pyenv.sh
}

nvm-load() {
    source /Users/dan/src/devenv/shell-config/nvm.sh
}

__dan_is_macos() {
    [ -e /Applications ]
}

cat-which() {
    bat --style header,grid $(which "$1")
}

cc() {
    echo "$@" | claude --print --allowedTools=Bash
}

open-file() {
    code --new-window $(resolve-file "$1")
}

cd-site-packages() {
    cd $(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")
}

delta-toggle() {
    eval "export DELTA_FEATURES='$(-delta-features-toggle $1 | tee /dev/stderr)'"
}

die() {
    echo "$@" >&2
    return 1
}

dot-view() {
    local file=$(mktemp).svg
    dot -T svg -o $file <$1
    echo $file
    open -a "/Applications/Google Chrome.app" $file
}

ega() {
    touch $1 && git add $1 && emacsclient -n $1
}

emacs-set-minimal() {
    rm -f ~/.emacs
    ln -s ~/devenv/emacs-config/emacs-minimal.el ~/.emacs
}

emacs-set-normal() {
    rm -f ~/.emacs
    ln -s ~/devenv/emacs-config/emacs.el ~/.emacs
}

fd() {
    if test -t 1; then
        command fd --color=always --hyperlink=always "$@" |
            rg -r $'\e]8;;cursor://file$1' $'^\e]8;;file://'$(hostname)'(.*)'
    else
        command fd "$@"
    fi
}

fd-list-files-by-size() {
    command fd . "$@" --type f --exec du -ah {} | sort -rh
}

# https://gist.github.com/SlexAxton/4989674
gifify() {
    if [[ -n "$1" ]]; then
        if [[ $2 == '--good' ]]; then
            ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
            time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - >$1.gif
            rm out-static*.png
        else
            ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 >$1.gif
        fi
    else
        echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
    fi
}

gprof2dot-and-go() {
    local file=$(mktemp).svg
    gprof2dot --format pstats $1 | dot -T svg -o $file
    echo $file
    open -a "/Applications/Google Chrome.app" $file
}

grip-chrome() {
    tmpfile=$(mktemp)
    grip --export $1 $tmpfile >/dev/null 2>&1 && chrome $tmpfile
}

grip-python() {
    (
        echo '```python'
        cat
        echo '```'
    ) | grip --export -
}

hub-commit-pr() {
    head=$(git symbolic-ref --short HEAD)
    EDITOR='emacsclient -n' hub pull-request -b dev:master -h dev:$head $1
}

hub-pr() {
    url=$(hub browse -u)
    open ${url/tree/pull}
    # while chrome-cli info | grep -q "Loading: Yes"; do
    #     sleep 0.1
    # done
    # chrome-cli execute "document.getElementById('pull_request_body').value = ''"
}

hyperlink() {
    local url="$1"
    local text="$2"
    printf '\e]8;;%s\e\\%s\e]8;;\e\\\n' "$url" "$text"
}

kill-python() {
    kill $(ps aux | grep python | grep -v grep | grep "$1" | awk '{print $2}')
}

mv-downcase() {
    local f=$(mktemp -u)
    mv "$1" "$f" && mv "$f" $(tr "[:upper:]" "[:lower:]" <<<"$1")
}

mv-link() {
    local source="$1"
    local target="$2"
    [ -n "$1" ] && [ -n "$2" ] || die "mv-link source target"
    mv "$source" "$target" && ln -s "$target" "$source"
}

python-virtualenv-activate() {
    source $DAN_VIRTUALENVS_DIRECTORY/"$1"/bin/activate
}

python-virtualenv-cd-sitepackages() {
    cd $DAN_VIRTUALENVS_DIRECTORY/$(python-virtualenv-name)/lib/python*/site-packages
}

python-virtualenv-name() {
    basename $(git rev-parse --show-toplevel)
}

rust-list-tests() {
    # TODO: distinguish between tests that are indented and thus in a
    # module probably named 'tests', and tests which are not indented.
    rg -H --vimgrep 'fn test' |
        sed -E s,src/\(.+\)\.rs:\[0-9\]+:\[0-9\]:\ +fn\ \(test\[^\(\]+\).\*,\\1::tests::\\2, |
        sed -E s,/,::,g | sed -E s,mod::,,
}

src-grep() {
    local d
    find ~/src -maxdepth 1 -type d | egrep -v '(3p|counsyl)' | while read d; do
        (cd $d && [ -d .git ] && git grep $@)
    done
}

switchto() {
    workon $1 && cdproject
}

tmux-send-all() {
    tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}' |
        xargs -I PANE tmux send-keys -t PANE "$1" Enter
}

ping-world() {
    ping -c 1 www.gov.uk
}

pip-local() {
    PIP_INDEX_URL="http://$(docker-machine ip $DOCKER_MACHINE_NAME):5555/simple/" \
    PIP_TRUSTED_HOST=$(docker-machine ip $DOCKER_MACHINE_NAME) \
        pip $@
}

pypi-local() {
    local port=${1:-5555}
    local package_dir=~/tmp/packages
    local image_name=simple-http-server
    local container_name=$image_name
    local dockerfile_dir=~/devenv/dockerfiles/simple-http-server

    (cd $dockerfile_dir && docker build -t $image_name .)
    dir2pi $package_dir
    docker rm -f $container_name 2>/dev/null
    echo "Starting local PyPi server: http://$(docker-machine ip $DOCKER_MACHINE_NAME):$port"
    docker run -p $port:80 --rm --name $container_name -v $package_dir:/srv simple-http-server
}

random-leetcode() {
    local file=$(ls lc_* | shuf -n1)
    echo $file
    LEETCODE=$file
    open "https://leetcode.com/problems/$(sed -E "s/lc_(.+)\.py/\1/" <<<$file | tr _ -)"
}

tail0() {
    file=$1
    until [[ -e $file ]]; do sleep 0.1; done
    tail -f $file
}

# toggle iTerm Dock icon
# https://gist.github.com/CrazyApi/5377685
# http://apple.stackexchange.com/questions/209250/remove-iterm-from-cmdtab-apps?rq=1
# http://apple.stackexchange.com/questions/92004/is-there-a-way-to-hide-certain-apps-from-the-cmdtab-menu
toggle-iterm() {
    pb='/usr/libexec/PlistBuddy'
    iTerm='/Applications/iTerm.app/Contents/Info.plist'

    echo "Do you wish to hide iTerm in Dock?"
    select ync in "Hide" "Show" "Cancel"; do
        case $ync in
        'Hide')
            $pb -c "Add :LSUIElement bool true" $iTerm
            echo "relaunch iTerm to take effectives"
            break
            ;;
        'Show')
            $pb -c "Delete :LSUIElement" $iTerm
            echo "run killall 'iTerm' to exit, and then relaunch it"
            break
            ;;
        'Cancel')
            break
            ;;
        esac
    done
}

function unset-env-vars() {
    cut -d= -f1 | while read s; do unset $s; done
}

function hyperlink() {
    local url="$1"
    local text="$2"
    printf '\e]8;;%s\e\\%s\e]8;;\e\\\n' "$url" "$text"
}

function fdd() {
    local _path
    command fd --color=always "$@" |
        while read _path; do
            abspath=$(readlink -f $(echo -n $_path | ansifilter))
            url="vscode://file/$abspath"
            hyperlink $url $_path
        done
}

function whichf() {
    readlink -f $(which "$1")
}

function -tempyral() {
    local file=$1
    local class=$2
    local _path=/Users/dan/src/temporalio/tempyral/media/videos/$file/1080p60/$class.mp4
    : >/tmp/log &&
        manim -qh scenes/$file.py $class && pkill 'QuickTime Player' &&
        sleep 1 &&
        open $_path
}

function tempyral-execute-workflow() {
    -tempyral execute_workflow ExecuteWorkflow
}

function tempyral-execute-update() {
    -tempyral execute_update ExecuteUpdate
}

function tempyral-call-activity() {
    -tempyral call_activity CallActivity
}

function r() {
    RG_PATH="$2" f-rg "$1"
}

function rn() {
    RG_PATH="$2" f-rg --exclude-tests "$1"
}

dump-files() {
    (fd -t f '\.py$' . | while read f; do bat --decorations always --paging=never "$f"; done) 
}

phonelink() {
    python -m http.server 8000 &
    local server_pid=$!
    sleep 2
    ngrok http 8000 &
    local ngrok_pid=$!
    sleep 3
    local url=$(curl -s http://localhost:4040/api/tunnels | python -c "import sys, json; print(json.load(sys.stdin)['tunnels'][0]['public_url'])")
    qrencode -tANSI "$url/$*"
    echo "Server: $url/$*"
    wait $server_pid $ngrok_pid
}
