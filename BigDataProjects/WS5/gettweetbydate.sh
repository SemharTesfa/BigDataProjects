#!/bin/bash

# Check if the correct number of arguments was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 YY-MM-DD"
    exit 1
fi

DATE=$1
OUTPUT_DIR=~/TWEETS
OUTPUT_FILE="$OUTPUT_DIR/$DATE.out"

# Create the TWEETS directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Search for the date in both tweet files and write to the output file
grep "$DATE" ~/downloaded_tweets_extend_nolf.ASCII.CLEAN.tsv > "$OUTPUT_FILE"
grep "$DATE" ~/downloaded_tweets_extend_original_ids_nolf.ASCII.CLEAN.tsv >> "$OUTPUT_FILE"
