#!/bin/bash
# dumbplot: Output plot on the terminal given list of X,Y coordinates.
#   Can either be a scatter plot or a bar (or bar-like) plot that
#   assumes that the y-coordinate is numeric and just displays the
#   x-coordinate data as-is, and in the order that it is fed to the
#   scripts.
#
# Dependency: gnuplot
#
# Author: http://jeroenjanssens.com

usage () {
cat << EOF
dumbplot: Use gnuplot to quickly get ascii plot of x-y data.

usage: dumbplot OPTIONS

OPTIONS:
  -a      As-is.  Use the x-coord (first coord) as categorical data for plotting.
  -b      Boxplot.  Use vertical boxes rather than just a marker.  Autosets -a switch.
  -w      Terminal width do use.  Defaults to actual terminal width.
  -v      Terminal height to use.  Defaults to terminal height / 2.
  -h      Show this message

Example usage:
    $ paste -d, <(echo 1 2 4 8 9 | tr ' ' '\n') <(echo 1 2 4 2 1 | tr ' ' '\n') | dumbplot
    $ paste -d, <(echo a b c d e | tr ' ' '\n') <(echo 1 2 4 10 6 | tr ' ' '\n') | dumbplot -a
    $ paste -d, <(echo a b c d e | tr ' ' '\n') <(echo 1 2 4 10 6 | tr ' ' '\n') | dumbplot -b
    $ paste -d, <(echo a b c d e | tr ' ' '\n') <(echo 1 2 4 10 6 | tr ' ' '\n') | dumbplot -b -w 80 -v 22

EOF
}




ASIS=
BARCHART=
PWIDTH=$(tput cols)
PHEIGHT=$(tput lines)

PHEIGHT=$(echo $PHEIGHT / 2 | bc)

while getopts "abw:v:" OPTION
do
	case $OPTION in
		a)
			ASIS=1
			;;
		b)
			ASIS=1
			BARCHART=1
			;;
		w)
            PWIDTH=$OPTARG
			;;
		v)
            PHEIGHT=$OPTARG
			;;
		h)
			usage
			exit 1
			;;
	esac
done




## Decision logic to execute right gnuplot command
if [ ! -z "$ASIS" ] ; then
    if [ ! -z "$BARCHART" ] ; then
        # Categorical data, uses boxes in plot
        nl -s, -f nl | gnuplot -e "set term dumb size $PWIDTH,$PHEIGHT" -e 'set datafile separator ","; set nokey;  plot "-" using 1:3:xtic(2) with boxes'
    else
        # Categorical data, do NOT use boxes
        nl -s, -f nl | gnuplot -e "set term dumb size $PWIDTH,$PHEIGHT" -e 'set datafile separator ","; set nokey;  plot "-" using 1:3:xtic(2)'
    fi
else
    # Scatterplot of data
    gnuplot -e "set term dumb size $PWIDTH,$PHEIGHT" -e 'set datafile separator ","; set nokey;  plot "-"'
fi

