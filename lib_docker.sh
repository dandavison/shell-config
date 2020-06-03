docker-build-with-local-pypi () {
    docker build \
       --build-arg PIP_TRUSTED_HOST=$(docker-machine ip $DOCKER_MACHINE_NAME) \
       --build-arg PIP_INDEX_URL="http://$(docker-machine ip $DOCKER_MACHINE_NAME):5555/simple/" \
       $@
}

# E.g. docker-compose exec -it $service bash
docker-compose-exec () {
    local exec_args=""
    while [[ "$1" == -* ]] ; do exec_args+=" $1" ; shift ; done
    local service="$1"
    shift
    docker exec $exec_args $(docker_compose_get_container "$service") $@
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

docker-container-uri () {
    container_name="$1"
    container_port="$2"
    [ -n "$container_name" -a -n "$container_port" ] || {
        echo "usage: $0 <container-name> <container-port>" >&2
        return 1
    }
    echo "http://$(docker-machine ip $DOCKER_MACHINE_NAME):$(docker port $container_name $container_port | cut -d: -f2)"
}

docker-run-last () {
    docker run --rm -it $@ $(docker images | sed -n 2p | awk '{print $3}')
}
