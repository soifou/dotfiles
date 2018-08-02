# mysql aliases
alias mysql-cli="docker exec -it lamp_db mysql -uroot -proot"
alias mysql="docker exec -i lamp_db mysql -uroot -proot"
alias mysqldump="docker exec -i lamp_db mysqldump -uroot -proot"

# all containers output is too wide
alias dps='docker ps -a --format="table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"'
alias dsp='docker system prune -f && docker volume prune -f'
