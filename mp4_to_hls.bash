#!/bin/bash
# CLG - 25-04-2022 VIDEO PROCESSING SCRIPT

DIR=/PATH/TO/YOUR/FILES/
VIDEOS="$(find $DIR -maxdepth 1 -type f -name "*.mp4" -print)"

if [[ -n "$VIDEOS" ]]
    then
        echo "Video files found : " && ls -l $DIR*.mp4
        echo "---------------------------------------------------------";
        for filename in *.mp4;
        do
            echo "$filename"
            basename="${filename%.*}"
            mkdir ${DIR}playlist-${basename}
            #CREATE PLAYLISTS IN DIFFERENT RESOLUTIONS
            ffmpeg -i $filename -profile:v baseline -level 3.0 -s 1920x1080 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls ${DIR}playlist-${basename}/1080_out.m3u8 &
            ffmpeg -i $filename -profile:v baseline -level 3.0 -s 1280x720 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls ${DIR}playlist-${basename}/720_out.m3u8 &
            ffmpeg -i $filename -profile:v baseline -level 3.0 -s 800x480 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls ${DIR}playlist-${basename}/480_out.m3u8 &
            ffmpeg -i $filename -profile:v baseline -level 3.0 -s 640x360 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls ${DIR}playlist-${basename}/360_out.m3u8 &
            #CREATE MASTER PLAYLIST TO ORCHESTRATE THE STREAM ACCORDING TO AVAILABLE BANDWIDTH
            touch ${DIR}playlist-${basename}/master.m3u8
            printf '#EXTM3U\n#EXT-X-STREAM-INF:BANDWIDTH=375000,RESOLUTION=640x360\n360_out.m3u8\n#EXT-X-STREAM-INF:BANDWIDTH=750000,RESOLUTION=800x480\n480_out.m3u8\n#EXT-X-STREAM-INF:BANDWIDTH=2000000,RESOLUTION=1280x720\n720_out.m3u8\n#EXT-X-STREAM-INF:BANDWIDTH=3500000,RESOLUTION=1920x1080\n1080_out.m3u8' > playlist-${basename}/master.m3u8
    
            touch log-${basename}-${NOW}.txt        
            2>&1 | tee -a log-${basename}-${NOW}.txt

        done
    else
        echo "---------------------------------------------------------";
        echo "Found no video file";
        echo "---------------------------------------------------------";
fi


