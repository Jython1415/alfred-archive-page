#!/bin/zsh --no-rcs

# This script is used to process the "Archive Page.alfredworkflow" export file
# in the ~/Downloads folder.
# 1) Extract the contents of the workflow file (zip) to a temporary directory
# 2) Replace the contents of "./Workflow" with the contents of the extracted directory
# 3) Remove the extracted directory
# 4) (Optional) Delete the input file with the -d flag

# Exit codes
# 0: Success
# 1: Other error
# 2: Missing input file

# Check if the "-d" flag is passed
delete_flag=false
while getopts "d" opt; do
    case $opt in
        d) delete_flag=true ;;
        *) echo "Usage: $0 [-d]" && exit 1 ;;
    esac
done

# Check if the input file exists
input_file=""
if [[ -f ~/Downloads/Archive\ Page.alfredworkflow ]]; then
    input_file=~/Downloads/Archive\ Page.alfredworkflow
elif [[ -f ~/Downloads/Archive.Page.alfredworkflow ]]; then
    input_file=~/Downloads/Archive.Page.alfredworkflow
else
    echo "Error: Missing input file 'Archive Page.alfredworkflow' or 'Archive.Page.alfredworkflow' in the ~/Downloads folder."
    exit 2
fi

# TODO: improve to read the name from the info.plist file

# Create a temporary directory with a partially randomized name
temp_dir=$(mktemp -d /tmp/alfred_workflow.XXXXXX)

# Extract the contents of the workflow file (zip) to the temporary directory
unzip -o "$input_file" -d "$temp_dir"

# Replace the contents of "./Workflow" with the contents of the extracted directory
rm -rf ./Workflow/*
cp -r "$temp_dir"/* ./Workflow/

# Remove the extracted directory
rm -rf "$temp_dir"

# Delete the input file if "-d" flag is set
if $delete_flag; then
    rm -f "$input_file"
    echo "Input file '$input_file' has been deleted."
fi
