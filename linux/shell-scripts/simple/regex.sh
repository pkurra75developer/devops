#!/bin/bash
# =============================================================================
# REGEX MASTERCLASS DEMO SCRIPT
# =============================================================================
# This script demonstrates regular expressions in Bash using grep, egrep, sed
# and shows examples for almost every regex concept.
# =============================================================================

set -euo pipefail

echo "=== Regex Masterclass ==="

# -----------------------------------------------------------------------------
# Sample data file for demonstration
# -----------------------------------------------------------------------------
cat <<EOF > sample.txt
apple
banana
cherry
apple pie
banana split
cherry tart
123
abc123
ABC
_a_b_c_
EOF

echo -e "\nSample data:"
cat sample.txt

# =============================================================================
# 1. LITERAL MATCHING
# =============================================================================
echo -e "\n--- 1. Literal matching ---"
# Match exact string "apple"
grep "apple" sample.txt

# Match multiple words literally
grep "banana split" sample.txt

# =============================================================================
# 2. METACHARACTERS
# =============================================================================
echo -e "\n--- 2. Metacharacters ---"
# . → matches any single character
grep "a.le" sample.txt    # matches apple (a-p-l-e), also able to match aXle

# ^ → beginning of line
grep "^apple" sample.txt   # lines starting with apple

# $ → end of line
grep "pie$" sample.txt     # lines ending with pie

# \ → escape special characters
grep "\." <<< "file.txt"   # matches literal dot

# =============================================================================
# 3. CHARACTER CLASSES
# =============================================================================
echo -e "\n--- 3. Character classes ---"
# [abc] → match a, b or c
grep "[ch]erry" sample.txt   # matches cherry, cherry tart

# [a-z] → lowercase letters
grep "[a-z][a-z][a-z]" sample.txt

# [0-9] → digits
grep "[0-9]" sample.txt

# [^...] → negation inside class
grep "[^a-z]" sample.txt    # lines with any non-lowercase letter

# =============================================================================
# 4. QUANTIFIERS (BRE vs ERE)
# =============================================================================
echo -e "\n--- 4. Quantifiers ---"
# * → 0 or more
grep "a*" <<< "aaa abc a"   # matches zero or more a's (prints all lines)

# + → 1 or more (use egrep / grep -E)
grep -E "a+" <<< "aaa abc a"

# ? → 0 or 1
grep -E "ap?" <<< "apple ape a"

# {n} → exactly n times
grep -E "a{2}" <<< "aaa abc a"  # matches "aa"

# {n,m} → between n and m times
grep -E "a{1,2}" <<< "aaa abc a"

# =============================================================================
# 5. GROUPING AND ALTERNATION
# =============================================================================
echo -e "\n--- 5. Grouping & alternation ---"
# () → grouping (with -E)
# | → alternation
grep -E "(apple|banana)" sample.txt

# Nested grouping
grep -E "(apple|banana) (pie|split)" sample.txt

# =============================================================================
# 6. ANCHORS
# =============================================================================
echo -e "\n--- 6. Anchors ---"
# ^ → beginning
grep "^a" sample.txt

# $ → end
grep "tart$" sample.txt

# \b → word boundary (grep -P for Perl regex)
grep -P "\bapple\b" sample.txt   # matches 'apple' exactly

# =============================================================================
# 7. ESCAPES
# =============================================================================
echo -e "\n--- 7. Escapes ---"
# \d → digit, \w → word character, \s → whitespace (grep -P)
grep -P "\d" sample.txt
grep -P "\w+" sample.txt
grep -P "\s" <<< "apple pie"

# =============================================================================
# 8. EXAMPLES USING GREP ON FILES
# =============================================================================
echo -e "\n--- 8. Realistic file examples ---"
# Lines containing numbers
grep "[0-9]" sample.txt

# Lines not containing numbers
grep -v "[0-9]" sample.txt

# Lines starting with underscore
grep "^_" sample.txt

# Lines ending with underscore
grep "_$" <<< "_a_b_c_"

# Lines containing 'apple' or 'cherry'
grep -E "apple|cherry" sample.txt

# Lines containing 'apple' followed by 'pie' (space in between)
grep "apple pie" sample.txt

# =============================================================================
# 9. USING SED WITH REGEX
# =============================================================================
echo -e "\n--- 9. Using sed ---"
# Substitute 'apple' with 'APPLE'
sed 's/apple/APPLE/' sample.txt

# Delete lines containing numbers
sed '/[0-9]/d' sample.txt

# Print only matching part (grep -o equivalent in sed)
sed -n 's/.*\(apple\).*/\1/p' sample.txt

# =============================================================================
# 10. USING AWK WITH REGEX
# =============================================================================
echo -e "\n--- 10. Using awk ---"
# Print lines matching regex
awk '/apple|banana/' sample.txt

# Print only the second field if fields are separated by space
awk '/ / {print $2}' <<< "apple pie"

# =============================================================================
# CLEANUP
# =============================================================================
rm -f sample.txt

echo -e "\n=== Regex Masterclass Complete ==="
