docker-start() {
    if [ -z "$1" ]
      then
        echo "No argument supplied : mac or toolbox ?"

    elif [[ $1 == 'mac' ]]; then
        if [[ `docker-machine status $DOCKER_MACHINE_NAME` == "Running" ]]; then
            cd $DEVELOPMENT_PATH/docker
            make down
            for DOCKER_ENV_VAR in `env | grep DOCKER_ | awk -F= '{print $1}'`
            do
                unset $DOCKER_ENV_VAR
            done
        fi

        echo "Now you can run Docker Mac !"

    elif [[ $1 == 'toolbox' ]]; then
        # @TODO: shutdown docker mac stuff if possible
        docker-machine start $DOCKER_MACHINE_NAME
        eval $(docker-machine env $DOCKER_MACHINE_NAME)
        cd $DEVELOPMENT_PATH/docker
        make start
        source $HOME/.zsh/docker/aliases.zsh
    fi
}

docker-clean() {
    docker run --rm \
        -v /var/run/docker.sock:/var/run/docker.sock \
        zzrot/docker-clean ${@:1}
}

# Run commands inside docker containers to keep your OS untouched using alias
docker_alias() {
    docker run -it --rm \
        # -w="": Working directory inside the container
        -v $(pwd):$1 -w $1 \
        ${@:2}
}

# Load my docker CLI commands
source $HOME/.zsh/docker/functions-cli.zsh
# Load my docker UI commands
source $HOME/.zsh/docker/functions-ui.zsh