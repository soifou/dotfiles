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
        soifou/composer:test ${@:1}
}
composer-7.0() {
    docker run --rm -it \
        -v $(pwd):/usr/src/app \
        -v ~/.composer:/home/composer/.composer \
        -v ~/.ssh/id_rsa:/home/composer/.ssh/id_rsa:ro \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        soifou/composer ${@:1}
}
composer-5.6() {
    docker run --rm -it \
        -v $(pwd):/usr/src/app \
        -v ~/.composer:/home/composer/.composer \
        -v ~/.ssh/id_rsa:/home/composer/.ssh/id_rsa:ro \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        soifou/composer:php-5.6 ${@:1}
}
php7cc() {
    docker run -it --rm \
        -v $(pwd):/app \
        --net=$DOCKER_NETWORK_NAME \
        ypereirareis/php7cc $1
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