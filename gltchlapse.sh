#!/bin/sh

clear
echo "Existing file(s) in output folder:"
ls /mnt/photos/gltch/done/ | xargs -n1 basename
echo
echo "Name the thing:"
read name

echo "Copying files and resizing..."
cp -a /mnt/photos/gltch/queue/. /mnt/photos/gltch/working/

mogrify -format jpg /mnt/photos/gltch/working/*.png

path=/mnt/photos/gltch/working/*
for f in $path
   do
      randomin=$(shuf -n 1 /mnt/photos/gltch/char.txt)
      randomout=$(shuf -n 1 /mnt/photos/gltch/char.txt)
      mogrify -rotate 90 $f
      echo "Glitching..."
      echo $randomin
      echo "to"
      echo $randomout
      echo
      sed -i "s/$randomin/$randomout/" $f
      mogrify -rotate 180 $f
      randomin=$(shuf -n 1 /mnt/photos/gltch/char.txt)
      randomout=$(shuf -n 1 /mnt/photos/gltch/char.txt)
      sed -i "s/$randomin/$randomout/" $f
      mogrify -rotate 90 $f
done

mogrify -resize 640x480 /mnt/photos/gltch/working/*.jpg

echo ""
echo "Converting to video/gif"
convert -delay 33x1000 /mnt/photos/gltch/working/*.jpg /mnt/photos/gltch/done/$name.gif
ffmpeg -f gif -i /mnt/photos/gltch/done/$name.gif /mnt/photos/gltch/done/$name.mp4
#convert /mnt/photos/gltch/working/*.png /mnt/photos/gltch/done/a.avi
#ffmpeg -i /mnt/photos/gltch/working/*.png /mnt/photos/gltch/done/a.avi
#ffmpeg -framerate 1/5 -i /mnt/photos/gltch/working/*.png -c:v libx264 -r 30 -pix_fmt yuv420p /mnt/photos/gltch/done/a.mp4

echo ""
echo "Cleaning up..."
rm /mnt/photos/gltch/working/*
echo "done."
