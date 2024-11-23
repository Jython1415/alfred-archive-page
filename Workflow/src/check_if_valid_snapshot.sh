#!/bin/zsh --no-rcs

# $1 is assume to be the snapshot tolerance in seconds
if (( $1 >= $seconds_since_snapshot )); then
  echo -n 1
else
  echo -n 0
fi
