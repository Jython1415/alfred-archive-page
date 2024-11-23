#!/bin/zsh --no-rcs

# Input timestamp (YYYYMMDDHHMMSS)
input_timestamp="${1}"

# Convert the input timestamp to seconds since epoch using UTC
input_epoch=$(TZ=UTC date -j -f "%Y%m%d%H%M%S" "${input_timestamp}" "+%s")

# Get the current time in seconds since epoch (UTC)
current_epoch=$(TZ=UTC date "+%s")

seconds_since=$((current_epoch - input_epoch))

echo -n "${seconds_since}"
