#!/bin/bash
# =============================================================================
# DEMO: Process Substitution in Bash
# =============================================================================
# This script demonstrates how to use process substitution (<(command)) to avoid
# creating temporary files when comparing or processing output from commands.
# =============================================================================

set -euo pipefail

echo "=== PROCESS SUBSTITUTION Demo ==="

# Create example files
echo -e "apple\nbanana\ncherry" > file1.txt
echo -e "apple\nbanana\ndate" > file2.txt

# Compare files without temporary files using process substitution
echo "Differences between file1.txt and file2.txt:"
diff <(sort file1.txt) <(sort file2.txt)

# Cleanup
rm -f file1.txt file2.txt
