#!/bin/zsh --no-rcs

# This script is used to process the "Archive Page.alfredworkflow" export file
# in the ~/Downloads folder.
# 1) Extract the contents of the workflow file (zip) to a temporary directory
# 2) Replace the contents of "./Workflow" with the contents of the extracted directory
# 3) Remove the extracted directory

# Exit codes
# 0: Success
# 1: Other error
# 2: Missing input file

# Check if the input file exists
if [[ ! -f ~/Downloads/Archive\ Page.alfredworkflow ]]; then
    echo "Error: Missing input file 'Archive Page.alfredworkflow' in the ~/Downloads folder."
    exit 2
fi

# TODO: improve to read the name from the info.plist file

# Create a temporary directory with a partially randomized name
temp_dir=$(mktemp -d /tmp/alfred_workflow.XXXXXX)

# Extract the contents of the workflow file (zip) to the temporary directory
unzip -o ~/Downloads/Archive\ Page.alfredworkflow -d "$temp_dir"

# Replace the contents of "./Workflow" with the contents of the extracted directory
rm -rf ./Workflow/*
cp -r "$temp_dir"/* ./Workflow/

# Remove the extracted directory
rm -rf "$temp_dir"
