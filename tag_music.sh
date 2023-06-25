#!/bin/dash

# Updates ID3 tags of .mp3 files based upon their directory and file name
# Edits title, artist, track, album and year

if test $# -ge 1 
then
    for directory in "$@"
    do 
        mp3_files=$(find "$directory" -name "*.mp3")
        # Why does this print new lines if you do echo "${mp3_files}" but not without it
        echo "$mp3_files" |
        while read -r file_name
        do
            # We need the title, artist and track number from file name
            title=$(echo "$file_name" | sed -E 's/^.* - (.*) - .*$/\1/g')
            artist=$(echo "$file_name" | sed -E 's/^.* - (.*).mp3$/\1/g')
            track=$(echo "$file_name" | sed -E 's/.*\/(.*) - .*/\1/g' | sed -E 's/(.*) - .*/\1/g') # Why does the first sed actually get rid of the whole directory?? - good since the directory my not be nested
            
            # We need album and year from directory name 
            album=$(echo "$file_name" | sed -E 's/,(.*)\/.*$/,\1/g' | sed -E 's/^.*\///g')
            year=$(echo "$file_name" | sed -E 's/,(.*)\/.*$/,\1/g' | sed -E 's/^.*\///g' | sed -E 's/^.*, //g')

            id3 -t "$title" -a "$artist" -T "$track" -A "$album" -y "$year" "$file_name" > /dev/null
        done
    done
else
    echo "Usage: $0 <directories of .mp3 files...>" 1>&2
fi