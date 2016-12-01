#!/bin/sh



clear
echo "number of second(s):"
read seconds
clear
echo "Duration will be $seconds second(s)."

copies=$(($seconds*24))

echo ""
echo "Making $copies copies..."
for i in $(seq 1 $copies)
#for ((i=1; i<=$copies; i++))
#for i in $copies
   do
      #echo $i
      cp /media/photos/gltch/a.jpg /media/photos/gltch/working/a$i.jpg
done

echo""
echo "Resizing..."
#mogrify -resize 300x300 /media/photos/gltch/working/*.jpg
mogrify -resize 640x480 /media/photos/gltch/working/*.jpg
#mogrify -resize 1024x768 /media/photos/gltch/working/*.jpg

path=/media/photos/gltch/working/*
for f in $path
   do
      randomin=$(shuf -n 1 /media/photos/gltch/char.txt)
      randomout=$(shuf -n 1 /media/photos/gltch/char.txt)
      echo $randomin
      echo "to"
      echo $randomout
      echo
      sed -i "s/$randomin/$randomout/" $f
      mogrify -rotate 180 $f
      randomin=$(shuf -n 1 /media/photos/gltch/char.txt)
      randomout=$(shuf -n 1 /media/photos/gltch/char.txt)
      sed -i "s/$randomin/$randomout/" $f
      mogrify -rotate 180 $f
      #mogrify -resize 1024x768 $f
done

echo ""
echo "Converting to video/gif"
convert /media/photos/gltch/working/*.jpg /media/photos/gltch/done/a.gif
ffmpeg -f gif -i /media/photos/gltch/done/a.gif /media/photos/gltch/done/a.mp4
#convert /media/photos/gltch/working/*.jpg /media/photos/gltch/done/a.avi
#ffmpeg -i /media/photos/gltch/working/*.jpg /media/photos/gltch/done/a.avi
#ffmpeg -framerate 1/5 -i /media/photos/gltch/working/*.jpg -c:v libx264 -r 30 -pix_fmt yuv420p /media/photos/gltch/done/a.mp4

echo ""
echo "Cleaning up..."
rm /media/photos/gltch/working/*
echo "done."