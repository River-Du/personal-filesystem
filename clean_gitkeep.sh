#!/bin/sh

set -e

# Remove all .gitkeep placeholder files from this directory and its subdirectories.
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
find "$SCRIPT_DIR" -type f -name '.gitkeep' -exec rm -f {} +
