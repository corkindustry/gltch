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
  do
  cp a.jpg working/a$i.jpg
done

echo""
echo "Resizing..."
mogrify -resize 1024x768 working/*.jpg

path=working/*
for f in $path
  do
  randomin=$(shuf -n 1 char.txt)
  randomout=$(shuf -n 1 char.txt)
  echo $randomin
  echo "to"
  echo $randomout
  echo
  sed -i "s/$randomin/$randomout/" $f
done

echo ""
echo "Converting to video/gif"
convert working/*.jpg done/a.gif
ffmpeg -f gif -i done/a.gif done/a.mp4

echo ""
echo "Cleaning up..."
rm working/*
echo "done."