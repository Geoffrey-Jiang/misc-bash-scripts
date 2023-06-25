#!/bin/dash

# Sorts files into categories based upon their number of lines

file_word_count=$(wc -l * | sort -nr)

# Temporary files to sort small medium and large files
TMPFILE_1=$(mktemp /tmp/file.XXXXXXXXXX)
TMPFILE_2=$(mktemp /tmp/file.XXXXXXXXXX)
TMPFILE_3=$(mktemp /tmp/file.XXXXXXXXXX)

trap "rm -f $TMPFILE_1 $TMPFILE_2 $TMPFILE_3;exit" INT TERM EXIT

echo "$file_word_count" | sed 1d |
while read -r line
do
    count=$(echo "$line" | cut -f1 -d' ')
    name=$(echo "$line" | cut -f2 -d' ')

    if test $count -lt 10
    then
        echo "$name" >> $TMPFILE_1
    elif test $count -lt 100
    then
        echo "$name" >> $TMPFILE_2
    else
        echo "$name" >> $TMPFILE_3
    fi
done

echo -n "Small files: "
sort $TMPFILE_1 | tr "\n" ' '
echo ''

echo -n "Medium-sized files: " 
sort $TMPFILE_2 | tr "\n" ' '
echo ''
echo -n "Large files: " 
sort $TMPFILE_3 | tr "\n" ' '
echo ''

exit 0


