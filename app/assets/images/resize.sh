for i in *.jpg; do
  echo $i  `basename $i .jpg`_m.jpg
  convert -resize 860x600 $i `basename $i .jpg`_m.jpg
done
