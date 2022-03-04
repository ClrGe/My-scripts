#!/bin/bash
# CLG - 09-02-2022 SCRIPT FOR CREATING HLS PLAYLISTS FROM MP4
# 4 different qualities (1080 - 720 - 480 - 360) are distributed according to bandwith -> defined in master.m3u8

DIR=/PATH/TO/YOUR/FILES/

echo "---------------------------------------------------------";
date -Iseconds;

find $DIR -maxdepth 1 -type f -iname "*.mp4" -print0 | while IFS= read -r -d $'\0' line; do

    echo "$line"
    ls -l "$line"

    filename=$(basename $line)
    basename="${filename%.*}"
    mkdir playlist-${basename}

    ffmpeg -i $line -profile:v baseline -level 3.0 -s 1920x1080 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls ${DIR}playlist-${basename}/1080_out.m3u8 &
    ffmpeg -i $line -profile:v baseline -level 3.0 -s 1280x720 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls ${DIR}playlist-${basename}/720_out.m3u8 &
    ffmpeg -i $line -profile:v baseline -level 3.0 -s 800x480 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls ${DIR}playlist-${basename}/480_out.m3u8 &
    ffmpeg -i $line -profile:v baseline -level 3.0 -s 640x360 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls ${DIR}playlist-${basename}/360_out.m3u8 &

    touch ${DIR}playlist-${basename}/master.m3u8

    printf '#EXTM3U\n#EXT-X-STREAM-INF:BANDWIDTH=375000,RESOLUTION=640x360\n360_out.m3u8\n#EXT-X-STREAM-INF:BANDWIDTH=750000,RESOLUTION=800x480\n480_out.m3u8\n#EXT-X-STREAM-INF:BANDWIDTH=2000000,RESOLUTION=1280x720\n720_out.m3u8\n#EXT-X-STREAM-INF:BANDWIDTH=3500000,RESOLUTION=1920x1080\n1080_out.m3u8' > ${DIR}playlist-${basename}/master.m3u8

done

cp -Rf "playlist-*" /PATH/TO/YOUR/FILES

exit 0
