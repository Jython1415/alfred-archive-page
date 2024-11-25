#!/bin/zsh --no-rcs

# %s%N is to get the timestamp in nanoseconds
start_time=$(date +%s%N)

response=$(/usr/bin/curl -I --max-time "${request_timeout}" "${1}")
response_code=$?

end_time=$(date +%s%N)
duration_ms=$(( (end_time - start_time) / 1000000 ))

# Using "sec" here for the standard UNIX timestamp
start_time_sec=$(( start_time / 1000000000 ))

# Check for error code 28 (timeout)
if [ response_code -eq 28 ]; then
    output="error: timeout"
else
    output="success"
fi

cat <<EOJSON
{
    "alfredworkflow": {
        "arg": "${output},
        "variables": {
            "response_body": "${response}",
            "response_time_ms": "${duration_ms}",
            "response_time_sec": "${start_time_sec}",
        }
    }
}
EOJSON
