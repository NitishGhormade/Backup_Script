#!/bin/bash

# Backup Script - Compresses files/folders and stores them with optional cleanup

# Function to display usage instructions
usage() {
    echo "Usage: $0 /path/to/source /path/to/destination [--cleanup <days>]"
    exit 1
}

# Ensure source and destination are provided
if [ "$#" -lt 2 ]; then
    usage
fi

# Variables
SOURCE=$1
DESTINATION=$2
LOG_FILE="$DESTINATION/backup.log"
CLEANUP_DAYS=0

# Check if cleanup argument is provided
if [ "$3" == "--cleanup" ]; then
    if [ -z "$4" ]; then
        echo "Error: Please specify the number of days for cleanup."
        usage
    fi
    CLEANUP_DAYS=$4
fi

# Ensure the source exists
if [ ! -d "$SOURCE" ]; then
    echo "Error: Source directory does not exist."
    exit 1
fi

# Ensure the destination exists or create it
if [ ! -d "$DESTINATION" ]; then
    mkdir -p "$DESTINATION"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create destination directory."
        exit 1
    fi
fi

# Generate backup filename with timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$DESTINATION/backup_$(basename "$SOURCE")_$TIMESTAMP.tar.gz"

# Log start of backup
echo "[$(date)] Starting backup of $SOURCE to $BACKUP_FILE" | tee -a "$LOG_FILE"

# Perform backup
tar -czf "$BACKUP_FILE" -C "$(dirname "$SOURCE")" "$(basename "$SOURCE")"
if [ $? -eq 0 ]; then
    echo "[$(date)] Backup completed successfully." | tee -a "$LOG_FILE"
else
    echo "[$(date)] Error: Backup failed." | tee -a "$LOG_FILE"
    exit 1
fi

# Perform cleanup if requested
if [ "$CLEANUP_DAYS" -gt 0 ]; then
    echo "[$(date)] Cleaning up backups older than $CLEANUP_DAYS days." | tee -a "$LOG_FILE"
    find "$DESTINATION" -type f -name "backup_*.tar.gz" -mtime +$CLEANUP_DAYS -exec rm -f {} \;
    if [ $? -eq 0 ]; then
        echo "[$(date)] Cleanup completed successfully." | tee -a "$LOG_FILE"
    else
        echo "[$(date)] Error: Cleanup failed." | tee -a "$LOG_FILE"
    fi
fi
