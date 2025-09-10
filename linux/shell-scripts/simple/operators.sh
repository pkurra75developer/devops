#!/bin/bash
# ==========================================================
# Bash Operators Demo - Interactive & Fully Documented
# ==========================================================
# This script demonstrates all commonly used operator types:
# 1. Arithmetic Operators
# 2. Relational / Comparison Operators
# 3. Logical Operators
# 4. String Operators
# 5. File Test Operators
# 6. Assignment Operators
# ----------------------------------------------------------
# The script is interactive and explains every step.
# ==========================================================

# -------------------------------
# 1. Arithmetic Operators
# -------------------------------
echo "=== Arithmetic Operators ==="
read -p "Enter first number (a): " a
read -p "Enter second number (b): " b

# Basic arithmetic using $(( ))
echo "a + b = $((a + b))"
echo "a - b = $((a - b))"
echo "a * b = $((a * b))"
echo "a / b = $((a / b))"
echo "a % b = $((a % b))"
echo "a ** b = $((a ** b))"  # exponentiation

echo ""

# -------------------------------
# 2. Relational / Comparison Operators
# -------------------------------
echo "=== Relational Operators ==="

if [ $a -eq $b ]; then
    echo "a is equal to b"
else
    echo "a is NOT equal to b"
fi

if [ $a -ne $b ]; then
    echo "a is not equal to b (using -ne)"
fi

if [ $a -lt $b ]; then
    echo "a is less than b"
fi

if [ $a -le $b ]; then
    echo "a is less than or equal to b"
fi

if [ $a -gt $b ]; then
    echo "a is greater than b"
fi

if [ $a -ge $b ]; then
    echo "a is greater than or equal to b"
fi

echo ""

# -------------------------------
# 3. Logical Operators
# -------------------------------
echo "=== Logical Operators ==="

# AND operator &&
if [ $a -lt $b ] && [ $b -lt 100 ]; then
    echo "a < b AND b < 100"
fi

# OR operator ||
if [ $a -gt 100 ] || [ $b -lt 100 ]; then
    echo "a > 100 OR b < 100"
fi

# NOT operator !
if ! [ $a -eq $b ]; then
    echo "a is NOT equal to b (using !)"
fi

echo ""

# -------------------------------
# 4. String Operators
# -------------------------------
echo "=== String Operators ==="
read -p "Enter first string: " str1
read -p "Enter second string: " str2

# String equality
if [ "$str1" = "$str2" ]; then
    echo "Strings are equal"
else
    echo "Strings are not equal"
fi

# Not equal
if [ "$str1" != "$str2" ]; then
    echo "Strings are different (using !=)"
fi

# Check if string is empty
if [ -z "$str1" ]; then
    echo "str1 is empty"
fi

# Check if string is not empty
if [ -n "$str2" ]; then
    echo "str2 is not empty"
fi

# Lexicographical comparison
if [[ "$str1" < "$str2" ]]; then
    echo "str1 is lexicographically less than str2"
fi

echo ""

# -------------------------------
# 5. File Test Operators
# -------------------------------
echo "=== File Test Operators ==="
read -p "Enter a file or directory path: " file

if [ -e "$file" ]; then
    echo "$file exists"
else
    echo "$file does NOT exist"
fi

if [ -f "$file" ]; then
    echo "$file is a regular file"
fi

if [ -d "$file" ]; then
    echo "$file is a directory"
fi

if [ -r "$file" ]; then
    echo "$file is readable"
fi

if [ -w "$file" ]; then
    echo "$file is writable"
fi

if [ -x "$file" ]; then
    echo "$file is executable"
fi

if [ -s "$file" ]; then
    echo "$file is not empty"
fi

echo ""

# -------------------------------
# 6. Assignment Operators
# -------------------------------
echo "=== Assignment Operators ==="
read -p "Enter a number for assignment demo: " x

echo "Initial x = $x"

((x += 5))
echo "After x += 5, x = $x"

((x -= 2))
echo "After x -= 2, x = $x"

((x *= 3))
echo "After x *= 3, x = $x"

((x /= 2))
echo "After x /= 2, x = $x"

((x %= 4))
echo "After x %= 4, x = $x"


echo ""
echo "=== End of Bash Operators Demo ==="
