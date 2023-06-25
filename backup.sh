#!/bin/dash

# Simple program that creates a backup file of a file specified by the command line argument
# The backup is numbered appropiately and multiple can be created

if  test $# -eq 1
then
    backup_no=0
    backup_file_name=$(echo "$1" | sed -E "s/(.*)/\.\1\.$backup_no/g")
    # Update the backup_file_name's number until it is a new number correctly
    while test -f "$backup_file_name"
    do
        backup_no=$((backup_no + 1))
        backup_file_name=$(echo "$backup_file_name" | sed -E "s/(\..*)*\.(.*)$/\1\.$backup_no/g")
    done

    # Copy the file!
    
    cp  "$1" "$backup_file_name"
    echo "Backup of '$1' saved as '$backup_file_name'"

else
    echo "Usage: $0 <file_name>" 1>&2
    exit 1
fi