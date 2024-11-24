#!/bin/zsh --no-rcs

# Input timestamp (YYYYMMDDHHMMSS)
input_timestamp="${snapshot_timestamp_raw}"
input_epoch=$(TZ=UTC date -j -f "%Y%m%d%H%M%S" "${input_timestamp}" "+%s")
current_epoch=$(TZ=UTC date "+%s")
seconds_since_snapshot=$((current_epoch - input_epoch))

# Compare with the snapshot tolerance in seconds
snapshot_tolerance_days="${snapshot_tolerance}"
snapshot_tolerance_seconds=$((snapshot_tolerance_days * 86400))

# Determine if the snapshot is still valid
if (( snapshot_tolerance_seconds >= $seconds_since_snapshot )); then
  echo -n 1
else
  echo -n 0
fi
