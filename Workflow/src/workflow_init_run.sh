#!/bin/zsh --no-rcs

file_path="$HOME/Library/Application Support/Alfred/Workflow Data/com.joshua.shew.archive.page/execution_count.txt"

execution_count=0

if [[ -f "$file_path" ]]; then
  first_line=$(head -n 1 "$file_path")
  if [[ "$first_line" =~ ^[0-9]+$ ]]; then
    execution_count=$first_line
  fi
fi

((execution_count++))

echo $execution_count > "$file_path"

echo -n $execution_count
