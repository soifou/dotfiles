# DOCKER UI

audacity() {
    docker run --rm -it \
        -v /etc/localtime:/etc/localtime:ro \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v "$XDG_MUSIC_DIR":/home/music \
        -v "$XDG_CONFIG_HOME"/audacity:/home/.audacity-data
        -e DISPLAY=unix$DISPLAY \
        --device /dev/snd:/dev/snd \
        --device /dev/dri:/dev/dri \
        --name audacity \
        soifou/audacity
}
# transmission-qt() {
#     docker run --rm -it \
#         -v /tmp/.X11-unix:/tmp/.X11-unix \
#         -v $HOME/Downloads:/Torrents \
#         -v $HOME/.config/transmission:/root/.config/transmission \
#         -v /etc/machine-id:/etc/machine-id \
#         -e DISPLAY=unix$DISPLAY \
#         soifou/transmission-qt
# }
snes9x() {
    docker run --rm -it \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /etc/machine-id:/etc/machine-id \
        -v /media/midgar/emulation/console/supernes/rom:/snes \
        -e DISPLAY=unix$DISPLAY \
        soifou/snes9x
}

libreoffice-calc() {
    docker run --rm -it \
        --name docker_libreoffice --hostname libreoffice \
        -e PGID=1000 -e PUID=1000 \
        -m 2048m \
        -e DISPLAY=unix$DISPLAY \
        -v /usr/share/fonts:/usr/share/fonts:ro \
        -v "$XDG_CACHE_HOME"/fontconfig:/home/alpine/.cache/fontconfig \
        -v "$XDG_CONFIG_HOME"/libreoffice:/home/alpine/.config/libreoffice \
        -v /tmp/recently-used:/home/alpine/.recently-used \
        -v $(pwd):/home/alpine \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        woahbase/alpine-libreoffice:x86_64 \
        --calc ${@:1}
}