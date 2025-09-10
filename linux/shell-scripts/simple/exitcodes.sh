#!/bin/bash
# ==================================================
# Program: Exit codes demo
# ==================================================
# Every command in Linux/Unix returns an exit code.
# Convention:
#   0   = success
#   >0  = failure (different codes mean different errors)
# The exit code of the last command is stored in $?

echo "=== Exit Code Demo ==="

# Example 1: Successful command
ls /tmp   # 'ls' will normally succeed
echo "Exit code of 'ls /tmp' = $?"   # Expected 0

# Example 2: Failed command
ls /not_a_real_folder   # This should fail
echo "Exit code of 'ls /not_a_real_folder' = $?"   # Non-zero (e.g., 2)

# Example 3: Using exit code in an if condition
read -p "Enter a filename to check: " filename
if [ -f "$filename" ]; then
    echo "File exists!"
    echo "Exit code of file test = $?"   # 0 (success)
else
    echo "File does not exist!"
    echo "Exit code of file test = $?"   # 1 (failure)
fi

# Example 4: Script returning custom exit code
# Normally you end with 'exit 0' for success, or a custom number for failure
# Uncomment below line to try:
# exit 42   # This script will exit with code 42
