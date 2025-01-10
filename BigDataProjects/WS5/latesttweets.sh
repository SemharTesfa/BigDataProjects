#!/bin/bash


TWEETS_DIR=~/TWEETS
ALLTWEETS_FILE=~/ALLTWEETS.out

# Debug statements to track script execution
echo "Running latesttweets.sh at $(date)" >> ~/latesttweets_debug.log
echo "Finding files in $TWEETS_DIR created in the last 5 minutes" >> ~/latesttweets_debug.log

# Find files created in the last 5 minutes, append content to ALLTWEETS.out, then delete them
find "$TWEETS_DIR" -type f -mmin -5 | while read -r file; do
    echo "Appending $file to $ALLTWEETS_FILE" >> ~/latesttweets_debug.log
    cat "$file" >> "$ALLTWEETS_FILE"
    echo "Deleting $file" >> ~/latesttweets_debug.log
    rm -f "$file"
done
