#!/bin/bash

workdir=.kmz2dae~workdir~`date +%Y%m%d%H%M%S`
mkdir $workdir
cd $workdir
unzip -u ../$1
mv models/*.dae ..
cd ..
rm -rf $workdir