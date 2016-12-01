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
        sleep 1
        linecount=$(wc -l working/$fn$i.jpg | awk '{print $1}')
        randomline=$(shuf -i 1-$linecount -n 1)
        echo $randomline
        mogrify -rotate 60 working/$fn$i.jpg
        sed -i $((1 + RANDOM % $randomline))d working/$fn$i.jpg
        mogrify -rotate 300 working/$fn$i.jpg
        mogrify -rotate 90 $f
        randomin=$(shuf -n 1 char.txt)
        randomout=$(shuf -n 1 char.txt)
        sed -i "s/$randomin/$randomout/" working/$fn$i.jpg
        mogrify -rotate 270 $f
        mogrify -resize 800x600 working/$fn$i.jpg
        convert working/$fn$i.jpg -shave 120x170 working/$fn$i.jpg
    done
  
  echo ""
  echo "Converting to video/gif"
  convert working/*.jpg done/$fn.gif
  
  echo ""
  echo "Cleaning up..."
  rm working/*
done
echo "done."