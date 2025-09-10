#!/bin/bash
# =============================================================================
# FULL SHELL SCRIPT DEMO - FILE OPERATIONS + I/O + IFS EXAMPLES
# =============================================================================

# -----------------------------------------------------------------------------
# Safety settings:
#   -a  : export all variables automatically (not always used)
#   -e  : exit immediately if a command exits with a non-zero status
#   -u  : treat unset variables as an error
#   -o pipefail : exit if any command in a pipeline fails
# -----------------------------------------------------------------------------
set -aeuo pipefail

echo "=== FILE OPERATIONS START ==="

# -----------------------------
# Basic file creation and writing
# -----------------------------
echo "Creating simple files..."
echo "Hello World" > hello.txt       # Overwrite or create
echo "Line 2" >> hello.txt           # Append

echo "Multi-line file using heredoc..."
cat > multi.txt << EOF
Line 1
Line 2
Line 3
EOF

# -----------------------------
# Reading files
# -----------------------------
echo -e "\nReading 'hello.txt' using cat:"
cat hello.txt

echo -e "\nReading 'multi.txt' line by line using while read loop:"
while IFS= read -r line; do
    echo "Line read: $line"
done < multi.txt

# -----------------------------
# Using IFS for CSV-like data
# -----------------------------
echo -e "\nCreating CSV data..."
cat > data.csv << EOF
Name,Age,City
John,30,New York
Jane,25,London
Bob,35,Tokyo
EOF

echo "Reading CSV data using IFS=','..."
while IFS=',' read -r name age city; do
    echo "Person: $name ($age) from $city"
done < data.csv

# -----------------------------
# Writing arrays to file
# -----------------------------
fruits=("apple" "banana" "cherry")
printf "%s\n" "${fruits[@]}" > fruits.txt

# -----------------------------
# I/O Redirection Examples
# -----------------------------
echo -e "\nDemonstrating I/O redirection..."

# Standard output redirection
echo "This goes to out.txt" > out.txt

# Append
echo "This appends to out.txt" >> out.txt

# Redirect standard error
ls /notexist 2> err.txt || true

# Redirect both stdout and stderr
ls /tmp /notexist &> combined.txt || true

# Reading output from command substitution
num_files=$(ls | wc -l)
echo "Number of files in current directory: $num_files"

# -----------------------------
# File tests and properties
# -----------------------------
[[ -f hello.txt ]] && echo "hello.txt exists and is a file"
[[ -s multi.txt ]] && echo "multi.txt is non-empty"

# -----------------------------
# Cleanup
# -----------------------------
echo -e "\nCleaning up test files..."
rm -f hello.txt multi.txt fruits.txt data.csv out.txt err.txt combined.txt

# -----------------------------
# Key Observations and Suggestions
# -----------------------------
: << 'OBS'
1. Using IFS is critical when reading lines with spaces or custom delimiters (e.g., CSV files).
2. Redirecting stdout and stderr ensures clean logs in automation scripts.
3. set -aeuo pipefail is highly recommended for robust scripts:
   - Prevents unset variables
   - Stops script on errors
   - Catches pipeline failures
4. Always use 'read -r' with IFS to prevent unwanted escape processing.
5. Command substitution $(...) is safer than backticks `` and allows nesting.
OBS

echo -e "\n=== SCRIPT COMPLETED ==="
