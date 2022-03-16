#!/bin/bash
# CLG - 16-03-2022 SCRIPT TO SORT UPLOADED MEDIA

DIR=/PATH/TO/YOUR/FILES

echo "SCRIPT TO SORT FILES UPLOADED TO THE SERVER"
echo "---------------------------------------------------------";
date -Iseconds;

ARCHIVE="$(find $DIR -maxdepth 1 -type f -name "*.zip" -print)"

if [[ -n "$ARCHIVE" ]]
then
    echo "Archive found : " && ls -l $DIR*.zip
    echo "Extracting..." && unzip $ARCHIVE $DIR
    echo "---------------------------------------------------------";
    echo "Archive extracted";
    echo "---------------------------------------------------------";
else
    echo "---------------------------------------------------------";
    echo "Found no archive";
    echo "---------------------------------------------------------";
fi

VIDEOS="$(find $DIR -maxdepth 1 -type f -name "*.mp4" -print)"

if [[ -n "$VIDEOS" ]]
then
    echo "Video files found : " && ls -l $DIR*.mp4
    echo "Moving files..." && mv $VIDEOS $DIR"mp4/"
    echo "---------------------------------------------------------";
    echo "Video files with ext .mp4 moved to dir. mp4/";
    echo "---------------------------------------------------------";
else
    echo "---------------------------------------------------------";
    echo "Found no video file";
    echo "---------------------------------------------------------";
fi

AUDIO="$(find $DIR -maxdepth 1 -type f -name "*.mp3" -print)"

if [[ -n "$AUDIO" ]]
then
    echo "Audio files found : " && ls -l $DIR*.mp3
    echo "Moving files..." && mv $AUDIO $DIR"mp3/"
    echo "---------------------------------------------------------";
    echo "Audio files with ext .mp3 moved to dir. mp3/";
    echo "---------------------------------------------------------";
else
    echo "Found no audio file";
    echo "---------------------------------------------------------";
fi

IMAGES="$(find $DIR -maxdepth 1 -type f -name "*.png" -or -name "*.jpg"-print)"

if [[ -n "$IMAGES" ]]
then
    echo "Images files found : " && ls -l $DIR*.mp3
    echo "Moving files..." && mv $IMAGES $DIR"img/"
    echo "---------------------------------------------------------";
    echo "Images with ext .png or .jpg moved to dir. img/";
    echo "---------------------------------------------------------";
else
    echo "Found no images";
    echo "---------------------------------------------------------";
fi

OTHER="$(find $DIR -maxdepth 1 -type f -name "*" -print)"

if [[ -n "$OTHER" ]]
then
    echo "Moving other files..." && mv $OTHER $DIR"other/"
    echo "---------------------------------------------------------";
    echo "Moving all other files to other/.";
    echo "---------------------------------------------------------";
else
    echo "No other file was found";
    echo "---------------------------------------------------------";
fi

echo "Done."
