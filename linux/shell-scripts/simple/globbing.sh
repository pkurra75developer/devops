#!/bin/bash
# =============================================================================
# GLOBBING DEMO SCRIPT
# =============================================================================
# This script demonstrates shell globbing: matching filenames using patterns.
# Globbing is different from regex: it is used for filename expansion.
# =============================================================================

set -euo pipefail

echo "=== Globbing Demo ==="

# -------------------------------------------------------------------
# 1. Setup sample files
# -------------------------------------------------------------------
mkdir -p tmp_glob_demo
cd tmp_glob_demo

# Create sample files
touch file1.txt file2.txt fileA.txt test.sh demo.py .hiddenfile
mkdir -p subdir
touch subdir/subfile1.sh subdir/subfile2.sh

echo "Sample files created:"
ls -1A

# -------------------------------------------------------------------
# 2. Globbing patterns
# -------------------------------------------------------------------

echo -e "\n--- '*' : matches zero or more characters ---"
echo "*.txt matches:"
echo *.txt

echo -e "\n--- '?' : matches exactly one character ---"
echo "file?.txt matches:"
echo file?.txt

echo -e "\n--- '[...]' : matches any one character in set ---"
echo "file[12].txt matches:"
echo file[12].txt

echo -e "\n--- '[!...]' : matches any character NOT in set ---"
echo "file[!12].txt matches:"
echo file[!12].txt

echo -e "\n--- '{a,b,c}' : matches any of the comma-separated strings ---"
echo "file{1,2,A}.txt matches:"
echo file{1,2,A}.txt

# -------------------------------------------------------------------
# 3. Hidden files
# -------------------------------------------------------------------
echo -e "\n--- Hidden files ---"
echo "Using '*' does not match dotfiles:"
echo *
echo "Using '.*' matches hidden files:"
echo .*

# -------------------------------------------------------------------
# 4. Recursive globbing (Bash 4+)
# -------------------------------------------------------------------
echo -e "\n--- Recursive globbing with '**' ---"
shopt -s globstar  # enable recursive globbing
echo "**/*.sh matches all .sh files recursively:"
echo **/*.sh

# -------------------------------------------------------------------
# 5. Quoting
# -------------------------------------------------------------------
echo -e "\n--- Quoting patterns ---"
echo "Unquoted *.txt expands to matching files:"
echo *.txt
echo "Quoted '*.txt' is treated literally:"
echo '*.txt'

# -------------------------------------------------------------------
# 6. Cleanup
# -------------------------------------------------------------------
cd ..
rm -rf tmp_glob_demo

echo -e "\n=== Globbing demo complete ==="
