#!/bin/sh
clear
echo "number of second(s):"
read seconds
clear
echo "Duration will be $seconds second(s)."

copies=$(($seconds*24))
queuepath=queue/*

for q in $queuepath
do
fn=${q##*/}
fn=${fn%.*}
clear
echo "Making $copies copies... of $fn"

for i in $(seq 1 $copies)
do
cp $q working/$fn$i.jpg
done
  
echo""
echo "Resizing..."
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
mogrify -rotate 180 $f
randomin=$(shuf -n 1 char.txt)
randomout=$(shuf -n 1 char.txt)
sed -i "s/$randomin/$randomout/" $f
mogrify -rotate 180 $f
done
  
echo ""
echo "Converting to video/gif"
convert working/*.jpg done/$fn.gif
echo ""
echo "Cleaning up..."
rm working/*
done
echo "done."