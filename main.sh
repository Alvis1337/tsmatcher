#!/bin/bash

# Define source and destination directories
SOURCE_DIR="torrents"
DEST_DIR="sonarr"

# Ensure required commands are available
command -v fzf >/dev/null 2>&1 || { echo "fzf is required. Install it with 'apt install fzf' or 'brew install fzf'."; exit 1; }

# Loop through each series in torrents
for series_path in "$SOURCE_DIR"/*; do
    # Ensure it's a directory
    [[ -d "$series_path" ]] || continue

    # Extract series name (remove season and year info)
    series_name=$(basename "$series_path" | sed -E 's/\s*\([0-9]{4}\).*//')

    # Extract season number (if exists)
    if [[ "$series_path" =~ S([0-9]{2}) ]]; then
        season_num=$(echo "${BASH_REMATCH[1]}" | sed 's/^0*//')  # Remove leading zeros
        season_folder="Season $season_num"
    else
        season_folder=""
    fi

    # Find the closest matching folder in Sonarr (case insensitive)
    matched_folder=$(find "$DEST_DIR" -maxdepth 1 -type d | awk '{print tolower($0) ":" $0}' | fzf --filter="$(echo "$series_name" | tr '[:upper:]' '[:lower:]')" | cut -d: -f2)

    # If no match is found, skip
    [[ -z "$matched_folder" ]] && echo "No match found for '$series_name', skipping..." && continue

    # Determine the final destination
    if [[ -n "$season_folder" && -d "$matched_folder/$season_folder" ]]; then
        final_dest="$matched_folder/$season_folder"
    else
        final_dest="$matched_folder"
    fi

    echo "Copying files from '$series_path' to '$final_dest'..."

    # Copy all MKV files from subdirectories
    find "$series_path" -type f -name "*.mkv" -exec cp {} "$final_dest"/ \;

    echo "Finished processing '$series_name'."
done

echo "All transfers complete."
