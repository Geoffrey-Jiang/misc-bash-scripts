#!/bin/dash

if test $# = 2
then
    # Test if $1 is an actual number
    test_number=$(echo "$1" | sed -E -n '/^[0-9]+$/p')
    if test ! -z "$test_number"
    then
        if test $1 -ge 0
        then
            count=$1
            word=$2
            i=0
            while test $i -lt "$count"
            do
                echo $word
                i=$((i + 1))
            done
            exit 0
        fi
    fi
    
    echo "$0: argument 1 must be a non-negative integer" 1>&2
    exit 1

else
    echo "Usage: $0 <number of lines> <string>" 1>&2
    exit 1
fi