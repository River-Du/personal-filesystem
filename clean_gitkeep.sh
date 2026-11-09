#!/bin/sh

set -eu

# Remove all .gitkeep placeholder files from this directory and its subdirectories.
SCRIPT_DIR=$(dirname -- "$0")
SCRIPT_DIR=$(CDPATH= cd -- "$SCRIPT_DIR" && pwd)

# Count each batch without parsing filenames, which may contain spaces or newlines.
if deleted_counts=$(find "$SCRIPT_DIR" -type f -name '.gitkeep' -exec sh -c '
    deleted_count=0
    for file do
        rm -f "$file" || exit 1
        deleted_count=$((deleted_count + 1))
    done
    printf "%s\n" "$deleted_count"
' sh {} +); then
    total_deleted=0
    for count in $deleted_counts; do
        total_deleted=$((total_deleted + count))
    done

    if [ "$total_deleted" -eq 0 ]; then
        printf 'No .gitkeep files found.\n'
    else
        printf 'Removed %s .gitkeep file(s).\n' "$total_deleted"
    fi
else
    printf 'Cleanup failed. Some .gitkeep files may remain.\n' >&2
    exit 1
fi
