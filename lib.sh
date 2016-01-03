. ~/src/1p/wifi/wifi.sh

die () {
    echo "$@" >&2
    return 1
}

__dan_is_osx () {
    [ -e /Applications ]
}

git-fetch-branch () {
    git fetch origin $1:$1 && git checkout $1
}

git-review () {
    git fetch origin $1:$1
    git checkout $1 && egit-diff master...
}

git-review-merge () {
    merge_commit=$1
    git rev-list --parents -n1 $merge_commit | read merge parent1 parent2
    git checkout $parent2 && egit-diff $parent1...$parent2
}

hub-prepare-pr () {
  url=$(hub browse -u)
  open ${url/tree/pull}
}

hub-commit-pr () {
    head=$(git symbolic-ref --short HEAD)
    EDITOR='emacsclient -n' hub pull-request -b dev:master -h dev:$head $1
}

switchto () {
    workon $1 && cdproject
}

git-prune-merged () {
    gbd | head -n20 | awk '{print $1}' | while read b ; do git branch -d $b ; done
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


vpn () {
    SERVICE="Counsyl VPN"
    if scutil --nc status "$SERVICE" | grep -i -qE '^Disconnected'
    then
	scutil --nc start "$SERVICE"
    else
	scutil --nc stop "$SERVICE"
    fi
}

cd-site-packages () {
    cd `python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`
}

docker-machine-env-docker () {
    eval "$(docker-machine env docker)"
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
    docker exec $exec_args $(docker-compose-get-container "$service") $@

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
    local dockerfile_dir=~/src/1p/dockerfiles/simple-http-server

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
}
