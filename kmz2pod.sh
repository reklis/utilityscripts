#!/bin/bash


workdir=.kmz2pod~workdir~`date +%Y%m%d%H%M%S`
mkdir $workdir
cd $workdir
unzip -u ../$1

for i in `ls models/*.dae`; do
  #set filename = ${i/%.dae/}
  #echo $filename
  filename=${i/%\.dae/}
  #collada2pod -cs=ogl -PrimitiveType=TriStrips -TriSort=PVRTTriStrip -i="$filename.dae" -o="$filename.pod"
  collada2pod -i="$filename.dae" -o="$filename.pod"
  mv $filename.pod ..
done

cd ..
rm -rf $workdir