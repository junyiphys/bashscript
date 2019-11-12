#!bin/bash
# A simple method for converting video with ffmpeg method
#-c:v libx264 -b:v 1500k video x.264, 1500k bitrate
for name in *.MTS; do
  ffmpeg -y -i "$name" -c:v libx264 -deinterlace -crf 27 -preset slower -q:a 2  -af "volume=7dB"  "${name%.*}.mp4" 
done 


#https://unix.stackexchange.com/questions/183308/help-with-script-over-a-list-of-files
LIST=''
for i in *.mp4; do
    if [ -n "$LIST" ]; then LIST="$LIST +"; fi
    LIST="$LIST$i"
done

mkvmerge -o newfile.mp4 $LIST
