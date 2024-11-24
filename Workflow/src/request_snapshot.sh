#!/bin/zsh --no-rcs

resposne = $(/usr/bin/curl -s --max-time "${request_timeout}" "${1}")

if [ $? -eq 28 ]; then
    echo -n 28
else
    echo -n "${response}"
fi
