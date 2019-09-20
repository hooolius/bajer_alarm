#!/usr/bin/env bash

display=$1
geometry=( $(xdpyinfo | awk '/dimensions:/ { print $2; exit }' | tr "x" " ") )
imagegeo=( 500 1000)
offsetx=$(( (${geometry[0]} - ${imagegeo[0]})/2 ))
offsety=$(( (${geometry[1]} - ${imagegeo[1]})/2 ))
counter=1
dir="$(dirname $(readlink -f "$0"))"

mpg123 $dir/alarm.mp3 &
sound=$!

trap "kill $sound 2> /dev/null" EXIT

while kill -0 $sound 2> /dev/null; do
    echo $dir
    xgamma -display :0 -rgamma 4.0
    xteddy -f $dir/BAJER.png -geometry 1x1+$offsetx+$offsety &
    sleep .5
    kill $!
    xgamma -display :0 -rgamma 1.0
    sleep .5
done

trap - EXIT
