#!/bin/sh
 
# This script is used by MediaTomb for transcoding support.
 
# Basic function that will transcode any input file into the target type
# 'dvd' ffmpeg supports
video_common() {
    local input="$1"
    local output="$2"
    ffmpeg -i "$input" -target dvd -y "$output"
}
 
# Basic function that will transcode any input file into the wav format
audio_common() {
    local input="$1"
    local output="$2"
    ffmpeg -i "$input" -f wav -y "$output"
}
 
# Function to transcode matroska files to dvd compatible format
transcode_matroska() {
    local input="$1"
    local output="$2"
    local alang="$3"
    local slang="$4"
 
    # Default to english if languages are not set
    [ "$alang" ] || alang="eng"
    [ "$slang" ] || slang="eng"
 
    # Use mencoder if available, else fall back to using ffmpeg.
    # Transcoding using ffmpeg will not include subtitles.
    if which mencoder >/dev/null 2>&1; then
        mencoder "$input" -oac lavc -ovc lavc -of mpeg -mc 0 -noskip \
            -lavcopts vcodec=mpeg2video:vbitrate=6000:acodec=ac3:abitrate=448 \
            -vf harddup -alang "$alang" \
            -slang "$slang" -font 'Bitstream Vera Sans' \
            -o "$output"
    else
        ffmpeg -alang "$alang" -slang "$slang" -i "$input" -target dvd \
            -y "$output"
    fi
}
 
# Our "main" function below.
 
USAGE="
This script is used by MediaTomb for transcoding support. It can also serve as
a script to transcode various files in a format suitable for streaming directly.
 
Synopsis:
 mediatomb-transcode [TRANSCODE FUNCTION OPTION] [GENERIC OPTIONS]
 
Generic Options:
 -h, --help                 Display this help message.
 -i, --input                Input file that is meant to be transcoded.
 -o, --output               Output file that will be read back by MediaTomb.
 --audio-lang               Specify ISO 639 language code to use for audio.
 --subtitle-lang            Specify ISO 639 language code to use for subtitles.
 
Transcode Function Options (one is required):
 --video-common             Perform generic video transcoding.
 --audio-common             Perform generic audio transcoding.
 --transcode-matroska       Used in transcoding matroska files.
"
 
while [ "$#" -gt "0" ]
do
    case "$1" in
        -i|--input)
            INPUT="$2"
            shift; shift;
            ;;
        -o|--output)
            OUTPUT="$2"
            shift; shift;
            ;;
        --video-common)
            USE_VIDEO_COMMON=1
            shift
            ;;
        --audio-common)
            USE_AUDIO_COMMON=1
            shift
            ;;
        --transcode-matroska)
            USE_TRANSCODE_MATROSKA=1
            shift
            ;;
        --audio-lang)
            ALANG="$2"
            shift; shift;
            ;;
        --subtitle-lang)
            SLANG="$2"
            shift; shift;
            ;;
        -h|--help|*)
            echo "${USAGE}"
            exit 1
            ;;
    esac
done
 
# Perform specified function
if [ $USE_VIDEO_COMMON ]; then
    video_common "$INPUT" "$OUTPUT"
elif [ $USE_AUDIO_COMMON ]; then
    audio_common "$INPUT" "$OUTPUT"
elif [ $USE_TRANSCODE_MATROSKA ]; then
    transcode_matroska "$INPUT" "$OUTPUT" "$ALANG" "$SLANG"
else
    # Must specify one transcoding function
    echo "${USAGE}"
    exit 1
fi