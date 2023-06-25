#!/bin/dash

# Dates images based off recently modified time

if test $# -ge 1
then
    for item in "$@"
    do
        ls_log=$(ls -l | sed -n -E "/$item/p")   
        time=$(echo $ls_log | cut -f6-8 -d' ')
        convert -gravity south -pointsize 36 -draw "text 0,10 '$time'" "$item" "$item"

    done

else
    echo "Usage: $0 <images...>" 1>&2
fi