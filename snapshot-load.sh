#!/bin/dash

# Simple program that loads from a created snapshot and saves current directory as a snapshot
# Uses snapshot_save.sh!

if test $# -eq 1
then
    snapshot_name=".snapshot.$1"
    if test -r "$snapshot_name"
    then
        # We have a valid snapshot name

        # Create new snapshot with current directory
        sh snapshot-save.sh

        # Grab files from the snapshot
        snapshot_files=$( (cd "$snapshot_name" ; ls -1a) | sed -E '/^\.(.*)/d')
        
        # When copying, src is 'snapshot_name/file_name' and dest is 'filename'
        echo "${snapshot_files}" |
        while read -r file_name
        do
            src_name=$(echo $file_name | sed -E "s/(.*)/$snapshot_name\/\1/g")
            cp "$src_name" "$file_name"
        done
    else
        echo "Invalid snapshot number" 1>&2
        exit 1
    fi
else
    echo "Usage: $0 <snapshot_number>" 1>&2
    exit 1

fi