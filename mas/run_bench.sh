#!/bin/bash

# Directory to search
DIR="../Variables/"

# Python script to call
PYTHON_SCRIPT="minimal_satisfiable_assignment.py"

# Log file
LOG_FILE="benchmarks.log"

# Loop through all files in the directory
for file in "$DIR"*; do
    # Check if it's a file (not a directory)
    if [ -f "$file" ]; then
        # Extract basename and remove extension
        filename=$(basename "$file")
        name="${filename%.*}"

        # Log the filename
        echo "$name" >> "$LOG_FILE"

        # Record start time
        start_time=$(date +%s.%N)

        # Run Python script and capture output
        python "$PYTHON_SCRIPT" "$name" >> "$LOG_FILE"

        # Calculate runtime
        end_time=$(date +%s.%N)
        runtime=$(echo "$end_time - $start_time" | bc)

        # Log the runtime
        echo "${runtime}s" >> "$LOG_FILE"

        # Add blank line for readability
        echo "" >> "$LOG_FILE"
    fi
done
