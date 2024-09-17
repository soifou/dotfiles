alias sf="php bin/console"

# list volumes/binds by container
alias dvbc="docker container ls --format '{{ .ID }}' | xargs -I {} docker inspect -f '{{ .Name }}{{ printf \"\\n\" }}{{ range .Mounts }}{{ printf \"\\n\\t\" }}{{ .Type }} {{ if eq .Type \"bind\" }}{{ .Source }}{{ end }}{{ .Name }} => {{ .Destination }}{{ end }}{{ printf \"\\n\" }}' {}"

php() {
    [ -f ./.env.local ] && docker run -it --rm \
        -v .:/app \
        -v ./.env.local:/app/.env.local \
        -w /app \
        --net=network.${DOCKER_NETWORK_NAME:-shared} \
        soifou/php-alpine:cli-${PHP_VERSION:-8.3}-wkhtmltopdf php $@

    [ ! -f ./.env.local ] && mise x php -- php $@
}

composer() {
    docker run -it --rm \
        --env COMPOSER_HOME=/composer \
        --env COMPOSER_CACHE_DIR=/composer/cache \
        --env SSH_AUTH_SOCK=/ssh-auth.sock \
        -v $COMPOSER_HOME:/composer \
        -v $COMPOSER_CACHE_DIR:/composer/cache \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/group:/etc/group:ro \
        -v .:/app \
        -w /app \
        --net=network.${DOCKER_NETWORK_NAME:-shared} \
        soifou/php-alpine:cli-${PHP_VERSION:-8.3}-composer ${@:1}
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
    container=$1
    [ "$#" -ne 1 ] && {
        container=$(docker container ls --format="table {{.Names}}" | sed '1d' | fzf)
    }
    docker inspect $container | grep IPAddress | tail -n1 | awk -F\" '{print $4}'
}
