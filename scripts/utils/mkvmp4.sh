#!/bin/sh

# USAGE:
#   $ mkv2mp4
#   Enter MKV file path: /home/download/movie.mkv

echo -n "Enter MKV file path: "
read mkv_file
filename="${mkv_file%.*}.mp4"
ffmpeg -i "$mkv_file" -c:v copy -c:a copy "$filename"