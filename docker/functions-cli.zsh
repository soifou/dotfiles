# install npm utils (bower generate-md grunt gulp node npm yarn)
# @see: https://github.com/mkenney/docker-npm
export DOCKER_NPM_UTILS=$DOCKER_REPOSITORY_PATH/github/docker-npm
if [ -d "${DOCKER_NPM_UTILS}" ]; then
    export PATH="${DOCKER_NPM_UTILS}/bin:$PATH"
fi

# guess project path inside the web container
getContainerPath() {
    if [[ $DOCKER_WEBROOT_PATH == '/app' ]]; then
        ABSOLUTE_PATH=$(pwd -P)
        RELATIVE_PATH="${ABSOLUTE_PATH//$DEVELOPMENT_PATH}"
        echo "$DOCKER_WEBROOT_PATH$RELATIVE_PATH"
    else
        echo "$DOCKER_WEBROOT_PATH"
    fi
}
php() {
    docker run -ti --rm \
        --name php7-cli-running-script \
        -v "$PWD":$(getContainerPath) \
        -w $(getContainerPath) \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        soifou/php-alpine:cli-7.0 ${@:1}
}
php5() {
    docker run -ti --rm \
        --name php5-cli-running-script \
        -v "$PWD":$(getContainerPath) \
        -w $(getContainerPath) \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        soifou/php-alpine:cli-5.6 ${@:1}
}
composer() {
    docker run --rm -it \
        -v $(pwd):/usr/src/app \
        -v ~/.composer:/home/composer/.composer \
        -v ~/.ssh/id_rsa:/home/composer/.ssh/id_rsa:ro \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        soifou/composer ${@:1}
}
c5() {
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
    docker run -it --rm \
        -v $(pwd):/mnt \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        soifou/wpcli-alpine ${@:1}
}
n98() {
    docker run -it --rm \
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
        --name drush \
        -v $(pwd):/var/www/html \
        -v ~/.composer:/home/composer/.composer \
        -v ~/.ssh/id_rsa:/home/composer/.ssh/id_rsa:ro \
        --net=$DOCKER_NETWORK_NAME \
        drupaldocker/drush:8-alpine drush ${@:1}
}
drupal() {
    docker run -ti --rm \
        --name drupal-cli \
        -v "$PWD":$(getContainerPath) \
        -v ~/.console:/.console \
        -w $(getContainerPath) \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        drupalconsole/console:alpine ${@:1}
}
mutt() {
    docker run -it --rm \
        --name mutt \
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
        --name kahlan \
        -v $(pwd):/app \
        kahlan/kahlan:3.0-alpine ${@:1}
}