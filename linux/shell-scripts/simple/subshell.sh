#!/bin/bash
# --------------------------------------
# Bash Subshell and Export Demonstration
# --------------------------------------

# -------------------------------
# 1. Define a normal variable (not exported)
# -------------------------------
MY_VAR="Hello"
echo "Parent shell: MY_VAR = $MY_VAR"

# Try to access MY_VAR in a subshell
# This will fail because MY_VAR is NOT exported
bash -c 'echo "Subshell (non-exported): MY_VAR = $MY_VAR"'

# -------------------------------
# 2. Exported variable
# -------------------------------
export MY_VAR="Hello Exported"
echo "Parent shell after export: MY_VAR = $MY_VAR"

# Now the subshell can access MY_VAR
bash -c 'echo "Subshell (exported): MY_VAR = $MY_VAR"'

# -------------------------------
# 3. Directory change example
# -------------------------------
echo "Parent shell directory before subshell: $PWD"

# Change directory in a subshell using parentheses
(
    cd /tmp
    echo "Inside subshell, directory: $PWD"
)

# Parent shell directory remains unchanged
echo "Parent shell directory after subshell: $PWD"

# -------------------------------
# 4. Temporary variable in a subshell
# -------------------------------
# Variable defined inside subshell is NOT visible outside
(
    TEMP_VAR="I am temporary"
    echo "Inside subshell, TEMP_VAR = $TEMP_VAR"
)
# Outside subshell, TEMP_VAR does not exist
echo "Outside subshell, TEMP_VAR = $TEMP_VAR"  # Will be empty

# -------------------------------
# 5. Command substitution example
# -------------------------------
# Subshell is automatically used to capture output
CURRENT_DATE=$(date)
echo "Current date (captured via subshell): $CURRENT_DATE"

# -------------------------------
# 6. Summary / Notes
# -------------------------------
# 1. A subshell is a child process spawned by the shell.
# 2. Variables in parent shell are only visible in subshell if exported.
# 3. Changes in subshell (like directory or temp variables) do NOT affect the parent shell.
# 4. Subshells are automatically created in:
#    - Command substitution: $(command)
#    - Parentheses grouping: ( commands )
#    - Scripts run as ./script.sh (unless sourced)
# 5. 'export VAR=value' makes the variable visible to child processes/subshells.
# 6. This mechanism allows isolation and safe temporary changes in scripts.
# --------------------------------------
