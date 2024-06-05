DOCKER_NETWORK_NAME=lamp-network
LAMP_REPO="$XDG_DEVELOP_DIR/soifou/docker/github/lamp"

alias lamp="docker compose -f $LAMP_REPO/docker-compose.yml"

## databases aliases
alias mysql="lamp exec db mysql -uroot -proot"
alias mysqldump="lamp exec db mysqldump -uroot -proot"
alias mysqlimport="lamp exec -T db mysql -uroot -proot"
alias psql="lamp exec postgres psql -U postgres"
alias mongo="lamp exec mongo"

alias sf="php bin/console"

# list volumes/binds by container
alias dvbc="docker container ls --format '{{ .ID }}' | xargs -I {} docker inspect -f '{{ .Name }}{{ printf \"\\n\" }}{{ range .Mounts }}{{ printf \"\\n\\t\" }}{{ .Type }} {{ if eq .Type \"bind\" }}{{ .Source }}{{ end }}{{ .Name }} => {{ .Destination }}{{ end }}{{ printf \"\\n\" }}' {}"

# switch to different php-fpm versions
lamp-fpm() {
    docker compose -f $LAMP_REPO/docker-compose.yml stop php
    docker compose -f $LAMP_REPO/docker-compose.yml rm -f php
    [ "$1" ] &&
        docker compose -f $LAMP_REPO/docker-compose.yml -f "$LAMP_REPO/docker-compose.php$1.yml" up -d php ||
        docker compose -f $LAMP_REPO/docker-compose.yml up -d php
}

# switch to different mariadb versions
lamp-mariadb() {
    docker compose -f $LAMP_REPO/docker-compose.yml stop db
    docker compose -f $LAMP_REPO/docker-compose.yml rm -f db
    [ "$1" ] &&
        docker compose -f "$LAMP_REPO/docker-compose.mariadb$1.yml" up -d db ||
        docker compose -f $LAMP_REPO/docker-compose.yml up -d db
}

php() {
    cpath="/app/${$(pwd)//$XDG_DEVELOP_DIR/}"

    # NOTE: add custom port in case we want to use the build-in php webserver feature
    # available in many php framework. (-p 8080:8080)
    # php bin/console server:run 0.0.0.0:8080
    # --add-host domain.test:172.17.0.5 \
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        -v "$PWD":$cpath \
        -w $cpath \
        -u `id -u`:`id -g` \
		--env SSH_AUTH_SOCK=/ssh-auth.sock \
        --env COMPOSER_HOME=$cpath/.composer \
        --env COMPOSER_CACHE_DIR=$cpath/.composer/cache \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/group:/etc/group:ro \
        -v $SSH_AUTH_SOCK:/ssh-auth.sock \
        --net=$DOCKER_NETWORK_NAME \
        soifou/php-alpine:cli-${PHP_VERSION:-8.3}-wkhtmltopdf ${@:1}
}

composer() {
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
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
