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
composer() {
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        -u $(id -u):$(id -g) \
        -v ~/.composer:/composer \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/group:/etc/group:ro \
        -v $(pwd):/app \
        -v $SSH_AUTH_SOCK:/ssh-auth.sock \
        --env SSH_AUTH_SOCK=/ssh-auth.sock \
        --net=$DOCKER_NETWORK_NAME \
        soifou/composer:php-7.1 ${@:1}
}
composer-7.0() {
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        -u $(id -u):$(id -g) \
        -v ~/.composer:/composer \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/group:/etc/group:ro \
        -v $(pwd):/app \
        -v $SSH_AUTH_SOCK:/ssh-auth.sock \
        --env SSH_AUTH_SOCK=/ssh-auth.sock \
        --net=$DOCKER_NETWORK_NAME \
        soifou/composer:php-7.0 ${@:1}
}
composer-5.6() {
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        -u $(id -u):$(id -g) \
        -v ~/.composer:/composer \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/group:/etc/group:ro \
        -v $(pwd):/app \
        -v $SSH_AUTH_SOCK:/ssh-auth.sock \
        --env SSH_AUTH_SOCK=/ssh-auth.sock \
        --net=$DOCKER_NETWORK_NAME \
        soifou/composer:php-5.6 ${@:1}
}
php7cc() {
    docker run -it --rm \
        -v $(pwd):/app \
        --net=$DOCKER_NETWORK_NAME \
        ypereirareis/php7cc:latest php7cc $1
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
n98() {
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
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
kahlan() {
    docker run --rm -it \
        -v $(pwd):/app \
        kahlan/kahlan:3.0-alpine ${@:1}
}
ngrok() {
    NGROK_CONTAINER_NAME=ngrok_web
    docker run --rm -it -d \
        -v $HOME/.ngrok2/ngrok.yml:/home/ngrok/.ngrok2/ngrok.yml \
        --name $NGROK_CONTAINER_NAME \
        -p 4040 \
        --link "$1":http \
        --net=$DOCKER_NETWORK_NAME \
        wernight/ngrok ngrok http http:80
    echo "\e[0;35mngrok address -> http://$(docker-machine ip $DOCKER_MACHINE_NAME):$(docker port $NGROK_CONTAINER_NAME | awk -F: '{ print $2}')\e[0m\n"
}