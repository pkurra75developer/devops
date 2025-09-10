#!/bin/bash
# --------------------------------------
# Bash Environment Variables and Subshell Demo
# --------------------------------------

# -------------------------------
# 1. Regular environment variable (non-exported)
# -------------------------------
MY_VAR="Hello"      # This variable is local to the parent shell
echo "Parent shell: MY_VAR is: $MY_VAR"

# Attempt to access in a subshell
# Since it is NOT exported, the subshell cannot see it
bash -c 'echo "Subshell (non-exported): MY_VAR is: $MY_VAR"'

# -------------------------------
# 2. Exported environment variable
# -------------------------------
export MY_VAR="Hello"   # Now MY_VAR is exported
echo "Parent shell after export: MY_VAR is: $MY_VAR"

# Access in a subshell
# Exported variables are inherited by child processes (subshells)
bash -c 'echo "Subshell (exported): MY_VAR is: $MY_VAR"'

# -------------------------------
# 3. Show parent vs subshell isolation
# -------------------------------
# Change directory in subshell
echo "Parent shell directory before subshell: $PWD"
bash -c 'cd /tmp; echo "Subshell directory after cd: $PWD"'
echo "Parent shell directory after subshell: $PWD"
# Note: The parent shell directory is unaffected by changes in the subshell

# -------------------------------
# 4. Special variables demonstration
# -------------------------------
echo "Number of script arguments: $#"
echo "All script arguments (single string using \$*): $*"
echo "All script arguments (separate words using \$@): $@"
echo "Process ID of current script: $$"

# -------------------------------
# Notes and Key Points:
# -------------------------------
# 1. Variables without 'export' are local to the current shell.
# 2. 'export VAR=value' makes a variable available to child processes (subshells).
# 3. Subshells are child processes created by the shell, e.g., bash -c "commands".
# 4. Changes in subshells (variables, directories, etc.) do NOT affect the parent shell.
# 5. $PWD → current working directory
# 6. $# → number of script arguments
# 7. $* → all arguments as a single string
# 8. $@ → all arguments as separate words
# 9. $$ → process ID of the current script
# --------------------------------------
