alias docker-rm-images-untagged='docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")'
alias docker-rm-containers="docker rm -v $(docker ps -a -q -f status=exited)"
#alias docker-rm-containers='docker ps --filter status=dead --filter status=exited -aq | xargs -r docker rm -v'
alias dclean='docker ps -a | grep -v '\''CONTAINER\|_config\|_data\|_run'\'' | cut -c-12 | xargs docker rm'
# alias node="docker run -it --rm -v \`pwd\`:/pwd -w /pwd node:0.12.2-slim node"
# alias npm="docker run -it --rm -v \`pwd\`:/pwd -w /pwd node:0.12.2-slim npm"
# alias gulp='docker run --rm -v $(pwd)/:/mnt/ -e UID=$(id -u) -e GID=$(id -g) zenoss/gulp gulp'

alias mongo-cli="docker exec -it lamp_mongodb mongo"

alias mysql-cli="docker exec -it lamp_db mysql -uroot -proot"
alias mysql="docker exec -i lamp_db mysql"
alias mysqldump="docker exec -i lamp_db mysqldump"

alias docker-compose-upgrade="bash $HOME/dotfiles/scripts/utils/docker-compose-updater.sh"

# all containers output is too wide
alias dps='docker ps -a --format="table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"'