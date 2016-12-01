#!/bin/sh
clear
echo "Existing file(s) in output folder:"
ls done/ | xargs -n1 basename
echo
echo "Name the thing:"
read name

echo "Copying files and resizing..."
cp -a queue/. working/

mogrify -format jpg working/*.png

path=working/*
for f in $path
   do
      randomin=$(shuf -n 1 char.txt)
      randomout=$(shuf -n 1 char.txt)
      mogrify -rotate 90 $f
      echo "Glitching..."
      echo $randomin
      echo "to"
      echo $randomout
      echo
      sed -i "s/$randomin/$randomout/" $f
      mogrify -rotate 180 $f
      randomin=$(shuf -n 1 char.txt)
      randomout=$(shuf -n 1 char.txt)
      sed -i "s/$randomin/$randomout/" $f
      mogrify -rotate 90 $f
done

mogrify -resize 640x480 working/*.jpg

echo ""
echo "Converting to video/gif"
convert -delay 33x1000 working/*.jpg done/$name.gif
ffmpeg -f gif -i done/$name.gif done/$name.mp4

echo ""
echo "Cleaning up..."
rm working/*
echo "done."
