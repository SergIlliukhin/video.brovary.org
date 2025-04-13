#!/bin/bash

# Directory containing the posts
POSTS_DIR="_posts"

# Process each .md file in the posts directory
for file in "$POSTS_DIR"/*.md; do
    if [ -f "$file" ]; then
        # Extract the date from the front matter
        date=$(grep -m 1 "^date:" "$file" | cut -d' ' -f2)
        
        if [ ! -z "$date" ]; then
            # Get the current filename without the directory
            filename=$(basename "$file")
            
            # Create the new filename with the date prefix
            new_filename="$date-${filename}"
            
            # Rename the file
            mv "$file" "$POSTS_DIR/$new_filename"
            echo "Renamed: $filename -> $new_filename"
        else
            echo "Warning: No date found in $file"
        fi
    fi
done 