#!/bin/dash

# Simple program that creates a snapshot of current directory and stores it in a backup directory
# Ignores files starting with . and snapshot_save.sh itself

snapshot_name=".snapshot.0"
snapshot_no=0

# Grab the correct snapshot name by checking for existing snapshots
while test -d "$snapshot_name"
do
    snapshot_no=$((snapshot_no + 1))
    snapshot_name=$(echo "$snapshot_name" | sed -E "s/^(\..*\.).*$/\1$snapshot_no/g")
done

# Create new directory for the backup
mkdir "$snapshot_name"
echo "Creating snapshot $snapshot_no"

# Grab all files without . and snapshot_____.sh scripts
current_files=$(ls -1a | sed -E '/^\.(.*)/d' | sed -E '/^snapshot-(.*).sh$/d')

echo "${current_files}" |
while read -r file_name
do
    # To properly copy files, the destination must be 'snapshot_name/file_name'
    destination=$(echo $file_name | sed -E "s/(.*)/$snapshot_name\/\1/g")
    cp "$file_name" "$destination"
done