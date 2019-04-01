# guess project path inside the web container
getContainerPath() {
    if [[ $DOCKER_WEBROOT_PATH == '/app' ]]; then
        PROJECT=$(pwd -P | sed -e "s@$DEVELOPMENT_PATH/@@g")
        echo "$DOCKER_WEBROOT_PATH/$PROJECT"
    else
        echo "$DOCKER_WEBROOT_PATH"
    fi
}
php() {
    # @NOTE: we add a custom port in case we want to use the build-in php webserver feature
    # available in many php framework.
    # $ php bin/console server:run 0.0.0.0:8080
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        -v "$PWD":$(getContainerPath) \
        -w $(getContainerPath) \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        soifou/php-alpine:cli-7.3 ${@:1}
}
php7.2() {
    docker run -ti --rm \
        -v "$PWD":$(getContainerPath) \
        -w $(getContainerPath) \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        soifou/php-alpine:cli-7.2 ${@:1}
}
php7.1() {
    docker run -ti --rm \
        -v "$PWD":$(getContainerPath) \
        -w $(getContainerPath) \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        soifou/php-alpine:cli-7.1 ${@:1}
}
php7.0() {
    docker run -ti --rm \
        -v "$PWD":$(getContainerPath) \
        -w $(getContainerPath) \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        soifou/php-alpine:cli-7.0 ${@:1}
}
php5.6() {
    docker run -ti --rm \
        -v "$PWD":$(getContainerPath) \
        -v $HOME/.ssh:/ssh \
        -w $(getContainerPath) \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        soifou/php-alpine:cli-5.6 ${@:1}
}
phppm() {
    docker run --rm \
        -v "$PWD":/var/www \
        -p 8888:80 \
        --net="$DOCKER_NETWORK_NAME" \
        phppm/nginx --bootstrap=symfony --static-directory=web/ --app-env=dev
}
composer() {
    tty=
    tty -s && tty=--tty
    # --add-host domain.test:172.17.0.5 \
    docker run \
        $tty \
        --interactive \
        --rm \
        --env SSH_AUTH_SOCK=/ssh-auth.sock \
        -u `id -u`:`id -g` \
        -v $COMPOSER_HOME:/composer \
        -v $COMPOSER_CACHE_DIR:/composer/cache \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/group:/etc/group:ro \
        -v $(pwd):/app \
        -v $SSH_AUTH_SOCK:/ssh-auth.sock \
        --net=$DOCKER_NETWORK_NAME \
        soifou/composer:latest ${@:1}
}
composer-7.1() {
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        --env SSH_AUTH_SOCK=/ssh-auth.sock \
        -u `id -u`:`id -g` \
        -v $COMPOSER_HOME:/composer \
        -v $COMPOSER_CACHE_DIR:/composer/cache \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/group:/etc/group:ro \
        -v $(pwd):/app \
        -v $SSH_AUTH_SOCK:/ssh-auth.sock \
        --net=$DOCKER_NETWORK_NAME \
        soifou/composer:php-7.1 ${@:1}
}
composer-5.6() {
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        --env SSH_AUTH_SOCK=/ssh-auth.sock \
        -u `id -u`:`id -g` \
        -v $COMPOSER_HOME:/composer \
        -v $COMPOSER_CACHE_DIR:/composer/cache \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/group:/etc/group:ro \
        -v $(pwd):/app \
        -v $SSH_AUTH_SOCK:/ssh-auth.sock \
        --net=$DOCKER_NETWORK_NAME \
        soifou/composer:php-5.6 ${@:1}
}
php7cc() {
    docker run -it --rm \
        -v $(pwd):/app \
        --net=$DOCKER_NETWORK_NAME \
        ypereirareis/php7cc:latest php7cc $1
}
phpunit() {
    docker run --rm -it \
        -v $(pwd):/app \
        --net=$DOCKER_NETWORK_NAME \
        soifou/phpunit-alpine:latest ${@:1}
}
wp() {
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        -v $(pwd):/mnt \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        soifou/wpcli-alpine:latest ${@:1}
}
magerun() {
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        -v $HOME/.n98-magerun:/.n98-magerun \
        -v $(pwd):/mnt \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        soifou/n98-magerun-alpine ${@:1}
}
gitcheck() {
    docker run --rm \
        -v `pwd`:/files:ro \
        badele/alpine-gitcheck
}
drush() {
    docker run --rm -it \
        -v $(pwd):/var/www/html \
        -v ~/.composer:/home/composer/.composer \
        -v ~/.ssh/id_rsa:/home/composer/.ssh/id_rsa:ro \
        -v $(pwd)/aliases.drushrc.php:/root/.drush/aliases.drushrc.php \
        -v $SSH_AUTH_SOCK:/ssh-auth.sock \
        --env SSH_AUTH_SOCK=/ssh-auth.sock \
        --net=$DOCKER_NETWORK_NAME \
        drupaldocker/drush:8-alpine drush ${@:1}
}
drupal() {
    docker run -ti --rm \
        -v "$PWD":$(getContainerPath) \
        -v ~/.console:/.console \
        -w $(getContainerPath) \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        drupalconsole/console:alpine ${@:1}
}
mutt() {
    docker run -it --rm \
        -v /etc/localtime:/etc/localtime \
        -e GMAIL -e GMAIL_NAME \
        -e GMAIL_PASS -e GMAIL_FROM \
        jess/mutt
}
htop() {
    docker run --rm -it \
        --pid host \
        --net none \
        --name htop \
        jess/htop
}
ngrok() {
    if [ "$#" -ne 2 ]; then
        echo "\e[0;35mOops, syntax is:\e[0m\n $ ngrok [web_container] [domain.dev]"
    else
        NGROK_CONTAINER_NAME=ngrok_web
        docker run --rm -it -d \
            -v $HOME/.ngrok2/ngrok.yml:/home/ngrok/.ngrok2/ngrok.yml \
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
        --net container:adbd \
        sorccu/adb adb ${@:1}
}
dip() {
    if [ "$#" -ne 1 ]; then
        echo "\e[0;35mOops, syntax is:\e[0m\n $ dip [web_container]"
        # echo "You want probably get IP adresse of one of theses running containers:"
        # DC=
    else
        docker inspect $1 | grep IPAddress | tail -n1 | awk -F\" '{print $4}'
    fi
}
