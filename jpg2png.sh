#!/bin/dash

# Simple script that converts all jpg images into png in current directory

TMPFILE_1=$(mktemp /tmp/XXXXXXXXX)

trap "rm -f $TMP_FILE_1;exit" INT TERM EXIT

find . -name '*.jpg' | sed -E 's/(\.\/)//g' > $TMPFILE_1

while read file_name
do
    target=$(echo $file_name | sed 's/.jpg/.png/g')
    if test -f "$target"
    then
        echo "$target already exists" 1>&2
        continue
    fi
    if convert "$file_name" "$target"
    then
        rm "$file_name"
    fi
done < $TMPFILE_1