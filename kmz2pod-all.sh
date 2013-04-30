#!/bin/bash

workdir=.kmz2pod~all~workdir
mkdir $workdir
cd $workdir
unzip -u ../*\\.kmz

for i in `ls models/*.dae`; do
  #set filename = ${i/%.dae/}
  #echo $filename
  filename=${i/%\.dae/}
  collada2pod -cs=ogl -PrimitiveType=TriStrips -TriSort=PVRTTriStrip -i="$filename.dae" -o="$filename.pod"
  mv $filename.pod ..
done

cd ..
rm -rf $workdir