#!/bin/zsh --no-rcs

response=$(/usr/bin/curl -I --max-time "${request_timeout}" "${1}")

if [ $? -eq 28 ]; then
    echo -n 28
else
    echo -n "${response}"
fi
