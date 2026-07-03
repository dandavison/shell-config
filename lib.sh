glow() {
    command glow "$@" | less
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

pyenv-load() {
    source /Users/dan/src/devenv/shell-config/pyenv.sh
}

nvm-load() {
    source /Users/dan/src/devenv/shell-config/nvm.sh
}

__dan_is_macos() {
    [ -e /Applications ]
}

cp() {
    if [[ ! -t 0 && $# -eq 0 ]]; then
        pbcopy
    else
        command cp "$@"
    fi
}

open-file() {
    "$(editor-cli)" --new-window $(resolve-file "$1")
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

python-virtualenv-activate() {
    source $DAN_VIRTUALENVS_DIRECTORY/"$1"/bin/activate
}

python-virtualenv-cd-sitepackages() {
    cd $DAN_VIRTUALENVS_DIRECTORY/$(python-virtualenv-name)/lib/python*/site-packages
}

switchto() {
    workon $1 && cdproject
}

function unset-env-vars() {
    cut -d= -f1 | while read s; do unset $s; done
}

random-leetcode() {
    local file=$(ls lc_* | shuf -n1)
    echo $file
    LEETCODE=$file
    open "https://leetcode.com/problems/$(sed -E "s/lc_(.+)\.py/\1/" <<<$file | tr _ -)"
}
