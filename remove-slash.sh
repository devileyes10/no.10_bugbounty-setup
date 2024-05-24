#!/bin/bash

# Check if a directory is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Assign the directory to a variable
directory="$1"

# Check if the directory exists
if [ ! -d "$directory" ]; then
  echo "Directory not found: $directory"
  exit 1
fi

# Process each file in the directory and its subdirectories
find "$directory" -type f | while IFS= read -r wordlist_file; do
  # Create a temporary file to store the modified wordlist
  temp_file=$(mktemp)

  # Process each line in the wordlist file
  while IFS= read -r line; do
    # Check if the first character is /
    if [[ "$line" == /* ]]; then
      # Remove the first character if it is /
      modified_line="${line:1}"
    else
      # Keep the line unchanged if the first character is not /
      modified_line="$line"
    fi
    # Append the modified line to the temporary file
    echo "$modified_line" >> "$temp_file"
  done < "$wordlist_file"

  # Replace the original wordlist file with the modified one
  mv "$temp_file" "$wordlist_file"

  echo "Processed file: $wordlist_file"
done

echo "All files in directory $directory and its subdirectories have been processed."
