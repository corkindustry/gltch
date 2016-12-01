#!/bin/sh
clear
echo "Existing file(s) in output folder:"
ls done/ | xargs -n1 basename
echo
echo "Name the thing:"
read name

echo "Copying files and resizing..."
cp -a queue/. working/
mogrify -resize 640x480 working/*.jpg

echo ""
echo "Converting to video/gif"
convert working/*.jpg done/$name.gif

echo ""
echo "Cleaning up..."
rm working/*
echo "done."