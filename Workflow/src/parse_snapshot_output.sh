#!/bin/zsh --no-rcs

# Use jq to extract the URL and timestamp, separated by " | "
result=$(echo "${1}" | jq -r '.archived_snapshots.closest | select(.available == true) | "\(.url) | \(.timestamp)"')

if [ -z "$result" ]; then
  echo -n 1
else
  echo -n "$result"
fi
