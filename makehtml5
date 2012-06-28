#!/usr/bin/env bash

source_file=$1
source_file_name=${source_file%.*}
source_file_extension=${source_file##*.}

output_width=$2
output_height=$3

[ "$#" -eq 3 ] || {
	cmd=${0##*/}
	echo ""
	echo "Usage: $cmd source_file output_width output_height"
	echo "Example: $cmd video.dv 320 240"
	echo ""
	exit 1
}

function test_exists () {
	cmd=$1
	type $cmd 2>&1 || { echo >&2 "$cmd not installed?  Aborting."; exit 1; }
}

test_exists ffmpeg2theora
test_exists HandBrakeCLI
test_exists ffmpeg
test_exists bc

aspect_ratio=`echo "scale=3; ${output_width}/${output_height}" | bc`

## Theora/Vorbis/Ogg
ffmpeg2theora --videobitrate 200 --max_size ${output_width}x${output_height} --output ${source_file_name}.ogv ${source_file}

## H.264/AAC/MP4
HandBrakeCLI --preset "iPhone & iPod Touch" --vb 200 --width ${output_width} --two-pass --turbo --optimize --input ${source_file} --output ${source_file_name}.mp4

## VP8/Vorbis/WebM
ffmpeg -pass 1 -passlogfile ${source_file} -threads 16  -keyint_min 0 -g 250 -skip_threshold 0 -qmin 1 -qmax 51 -i ${source_file} -vcodec libvpx -b 204800 -s ${output_width}x${output_height} -aspect ${aspect_ratio} -an -f webm -y NUL
ffmpeg -pass 2 -passlogfile ${source_file} -threads 16  -keyint_min 0 -g 250 -skip_threshold 0 -qmin 1 -qmax 51 -i ${source_file} -vcodec libvpx -b 204800 -s ${output_width}x${output_height} -aspect ${aspect_ratio} -acodec libvorbis -ac 2 -y ${source_file_name}.webm
