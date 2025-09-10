#!/bin/bash
# ====================================================
# Debugging + Error Handling + Unset Variable Demo
# ====================================================
# - set -x : enable debug (prints commands before executing them)
# - set -e : stop script if any command fails
# - set -u : stop script if an unset variable is used
# You can combine them together:  set -eux
# ====================================================

echo "=== Debugging + Error Handling Demo ==="

# 1. Enable debugging
set -x

echo "Step 1: A valid command"
ls /tmp

echo "Step 2: An invalid command (but we will continue, since set -e is OFF for now)"
ls /not_a_real_folder   # Error, but script continues

# 2. Turn OFF debugging temporarily
set +x
echo "Debugging OFF now."

# 3. Enable 'exit on error'
set -e
echo "Step 3: Now any error will stop the script."

# 4. Try another invalid command (script will exit immediately here)
# Comment this out if you want to test the unset variable part below
ls /another_fake_folder

# ------------------------
# The below lines will NOT run because set -e stopped the script above.
# If you comment out the line above, you can see 'set -u' in action.
# ------------------------

# 5. Enable unset variable check
set -u
echo "Step 4: Now unset variables will cause the script to exit."

echo "My name is $USERNAME"   # If USERNAME is not set, script exits

# ====================================================
# 🔑 Key Observations:
# - set -x : Shows every command before running (debugging).
# - set -e : Script stops immediately when a command fails.
# - set -u : Script stops if you use an unset variable.
#
# ✅ Suggestions (best practices):
# - Use 'set -eux' at the start of critical scripts
#   (-e: exit on error, -u: catch unset vars, -x: debug).
# - Use 'set +x' temporarily to hide sensitive values
#   (like passwords or secrets in logs).
# - Comment out 'set -e' or 'set -u' if you want to test/debug
#   without stopping the script immediately.
# ====================================================
