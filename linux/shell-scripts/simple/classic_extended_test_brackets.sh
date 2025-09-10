#!/bin/bash
# =============================================================================
# DEMO: [ ... ] vs [[ ... ]] in Bash
# =============================================================================

set -euo pipefail

echo "=== Demo: [ ... ] vs [[ ... ]] ==="

# Sample variables
file="hello.txt"
text="hello world"
empty=""

# Create a sample file
echo "Sample content" > "$file"

# ---------------------------------------------------------------------------
# 1. Basic file test
# ---------------------------------------------------------------------------
echo -e "\n1. Basic file test"

# Using classic [ ... ]
if [ -f "$file" ]; then
    echo "[ ... ] : $file exists and is a file"
fi

# Using extended [[ ... ]]
if [[ -f "$file" ]]; then
    echo "[[ ... ]] : $file exists and is a file"
fi

# ---------------------------------------------------------------------------
# 2. String comparison
# ---------------------------------------------------------------------------
echo -e "\n2. String comparison"

# Classic [ ... ] requires quoting and separate conditions
if [ "$text" = "hello world" ]; then
    echo "[ ... ] : text matches exactly"
fi

# Extended [[ ... ]] allows more powerful comparisons
if [[ $text == hello* ]]; then
    echo "[[ ... ]] : text starts with 'hello'"
fi

# ---------------------------------------------------------------------------
# 3. Logical operators
# ---------------------------------------------------------------------------
echo -e "\n3. Logical operators"

# Classic [ ... ] needs separate tests combined with && outside
if [ -n "$text" ] && [ -f "$file" ]; then
    echo "[ ... ] : text is non-empty AND file exists"
fi

# Extended [[ ... ]] supports && inside
if [[ -n $text && -f $file ]]; then
    echo "[[ ... ]] : text is non-empty AND file exists"
fi

# ---------------------------------------------------------------------------
# 4. Handling empty variables safely
# ---------------------------------------------------------------------------
echo -e "\n4. Empty variable handling"

# Classic [ ... ] without quotes breaks if variable is empty
# Uncommenting the next line will fail: [ $empty = "test" ]
# if [ $empty = "test" ]; then echo "This fails"; fi

# [[ ... ]] handles empty variables safely
if [[ $empty == "" ]]; then
    echo "[[ ... ]] safely handles empty variables"
fi

# ---------------------------------------------------------------------------
# 5. Pattern matching vs regex
# ---------------------------------------------------------------------------
echo -e "\n5. Pattern matching"

# [[ ... ]] supports glob pattern matching
if [[ $file == *.txt ]]; then
    echo "[[ ... ]] : file ends with .txt (pattern matching)"
fi

# [ ... ] does NOT support pattern matching (treats literally)
if [ "$file" = "*.txt" ]; then
    echo "[ ... ] : won't match, only literal '*.txt'"
fi

# ---------------------------------------------------------------------------
# CLEANUP
# ---------------------------------------------------------------------------
rm -f "$file"

echo -e "\n=== Demo complete ==="
