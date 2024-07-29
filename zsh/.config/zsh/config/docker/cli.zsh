alias sf="php bin/console"

# list volumes/binds by container
alias dvbc="docker container ls --format '{{ .ID }}' | xargs -I {} docker inspect -f '{{ .Name }}{{ printf \"\\n\" }}{{ range .Mounts }}{{ printf \"\\n\\t\" }}{{ .Type }} {{ if eq .Type \"bind\" }}{{ .Source }}{{ end }}{{ .Name }} => {{ .Destination }}{{ end }}{{ printf \"\\n\" }}' {}"

php() {
    cpath="/app/${$(pwd)//$XDG_DEVELOP_DIR/}"

    tty=
    tty -s && tty=--tty

    docker run $tty -i --rm \
        -u `id -u`:`id -g` \
        -v "$PWD":$cpath \
        -w $cpath \
        --net=$DOCKER_NETWORK_NAME \
        soifou/php-alpine:cli-${PHP_VERSION:-8.3}-wkhtmltopdf php ${@:1}
}

composer() {
    tty=
    tty -s && tty=--tty
    docker run $tty -i --rm \
        -u `id -u`:`id -g` \
        --env COMPOSER_HOME=/composer \
        -v $COMPOSER_HOME:/composer \
        --env COMPOSER_CACHE_DIR=/composer/cache \
        -v $COMPOSER_CACHE_DIR:/composer/cache \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/group:/etc/group:ro \
        -v $(pwd):/app \
        --env SSH_AUTH_SOCK=/ssh-auth.sock \
        --net=$DOCKER_NETWORK_NAME \
        soifou/php-alpine:cli-${PHP_VERSION:-8.3}-composer ${@:1}
}

ngrok() {
    if [ "$#" -ne 2 ]; then
        echo "\e[0;35mOops, syntax is:\e[0m\n $ ngrok [web_container] [domain.dev]"
    else
        NGROK_CONTAINER_NAME=ngrok_web
        docker run --rm -it -d \
            -v $XDG_CONFIG_HOME/ngrok2/ngrok.yml:/home/ngrok/.ngrok2/ngrok.yml \
            --name $NGROK_CONTAINER_NAME \
            -p 4040 \
            --link "$1":http \
            --net=$DOCKER_NETWORK_NAME \
            wernight/ngrok ngrok http -host-header=$2 http:80
        echo "\e[0;35mngrok address -> http://0.0.0.0:$(docker port $NGROK_CONTAINER_NAME | awk -F: '{ print $2}')\e[0m\n"
        echo "To stop: docker kill $NGROK_CONTAINER_NAME"
    fi
}

adb() {
    if [[ $(docker ps | grep adbd | wc -l) == 0 ]]; then
        echo "\e[0;35mStarting an adbd server..."
        docker run -d --privileged -v /dev/bus/usb:/dev/bus/usb --name adbd sorccu/adb
    fi
    docker run --rm -ti \
        -v "$PWD":/home \
        -u $(id -u $(whoami)) \
        --net container:adbd \
        sorccu/adb adb ${@:1}
}

dip() {
    if [ "$#" -ne 1 ]; then
        echo "\e[0;35mOops, syntax is:\e[0m\n $ dip [web_container]"
    else
        docker inspect $1 | grep IPAddress | tail -n1 | awk -F\" '{print $4}'
    fi
}
