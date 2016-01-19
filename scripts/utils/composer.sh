#!/bin/sh

# The following shell script can be used for easier accessing this docker image
# from host or from docker-machine
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
echo "Current working directory: '"$(pwd)"'"
docker run --rm -v $(pwd):/app -v ~/.ssh:/root/.ssh composer/composer $@