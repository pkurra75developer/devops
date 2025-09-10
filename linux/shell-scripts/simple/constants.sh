#!/bin/bash
# --------------------------------------
# Bash Constants / Readonly Variables Demo
# --------------------------------------

# Declare a readonly constant
readonly PI=3.14159
echo "Value of PI: $PI"

# Attempt to change PI (will cause an error)
# Uncommenting the next line will produce an error
# PI=3
# echo "New value of PI: $PI"

# Readonly can also be applied after declaration
MAX_USERS=100
readonly MAX_USERS
echo "Maximum users allowed: $MAX_USERS"

# Attempting to modify it now will fail
# MAX_USERS=200  # ❌ Error: MAX_USERS: readonly variable

# --------------------------------------
# Notes:
# 1. readonly variables cannot be modified after assignment.
# 2. Useful for constants like PI, configuration values, etc.
# 3. Alternative: use 'declare -r VAR=value' (same effect).
# --------------------------------------
