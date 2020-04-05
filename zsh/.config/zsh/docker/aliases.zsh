## docker aliases

# standard containers list output is too wide
alias dps='docker ps -a --format="table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"'
# cleanup unused containers and volumes
alias dsp='docker system prune -f && docker volume prune -f'
# list volumes/binds by container
alias dvbc="docker ps -a --format '{{ .ID }}' | xargs -I {} docker inspect -f '{{ .Name }}{{ printf \"\\n\" }}{{ range .Mounts }}{{ printf \"\\n\\t\" }}{{ .Type }} {{ if eq .Type \"bind\" }}{{ .Source }}{{ end }}{{ .Name }} => {{ .Destination }}{{ end }}{{ printf \"\\n\" }}' {}"
