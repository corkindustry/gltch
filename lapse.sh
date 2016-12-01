#!/bin/sh

clear
echo "Existing file(s) in output folder:"
ls /media/photos/gltch/done/ | xargs -n1 basename
echo
echo "Name the thing:"
read name

echo "Copying files and resizing..."
cp -a /media/photos/gltch/queue/. /media/photos/gltch/working/
mogrify -resize 640x480 /media/photos/gltch/working/*.jpg

echo ""
echo "Converting to video/gif"
convert /media/photos/gltch/working/*.jpg /media/photos/gltch/done/$name.gif
#ffmpeg -f gif -i /media/photos/gltch/done/$name.gif /media/photos/gltch/done/$name.mp4
#convert /media/photos/gltch/working/*.jpg /media/photos/gltch/done/a.avi
#ffmpeg -i /media/photos/gltch/working/*.jpg /media/photos/gltch/done/a.avi
#ffmpeg -framerate 1/5 -i /media/photos/gltch/working/*.jpg -c:v libx264 -r 30 -pix_fmt yuv420p /media/photos/gltch/done/a.mp4

echo ""
echo "Cleaning up..."
rm /media/photos/gltch/working/*
echo "done."