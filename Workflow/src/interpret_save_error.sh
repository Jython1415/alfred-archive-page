#!/bin/zsh --no-rcs

response="${http_response}"

# Define the output format function
output_format() {
  echo "$1"  # known error? (0/1)
  echo "$2"  # notification_title
  echo "$3"  # notification_text
}

case $response in
  404)
    output_format 1 "Page not found (404)" \
      "Please try again later"
    ;;
  429)
    output_format 1 "Too many requests for URL" \
      "The Wayback Machine limits archives to 5 per day per link. Please try archiving this link tomorrow."
    ;;
  520)
    output_format 1 "Internet Archive returned an unexpected error" \
      "Please try again later"
    ;;
  523)
    output_format 1 "The page could not be reached for archiving" ""
    ;;
  *)
    output_format 0 "" ""
    ;;
esac
