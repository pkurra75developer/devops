#!/bin/bash
# =============================================================================
# PIPELINES DEMO WITH set -o pipefail
# =============================================================================
# This script demonstrates how pipelines work in Bash and the effect of
# 'set -o pipefail' on pipeline exit codes.
#
# A pipeline connects the output of one command to the input of another using '|'.
# Example: ps aux | grep bash
#
# By default, the exit code of a pipeline is the exit code of the LAST command.
# This can hide failures in earlier commands.
#
# 'set -o pipefail' changes this behavior:
#   - The pipeline will exit with the exit code of the first failing command
#   - If all commands succeed, it returns 0
#   - Helps in writing robust scripts where failures in any part of the pipeline should be caught
#
# 'set -euo pipefail' is often used together in scripts:
#   -e : exit immediately on any command failure
#   -u : treat unset variables as an error
#   -o pipefail : fail if any command in a pipeline fails
# =============================================================================

echo "=== Default pipeline behavior ==="
# Here 'false' fails but 'true' succeeds
# Pipeline exit status will be of the last command (true) → 0 (success)
false | true
echo "Pipeline exit code without pipefail: $?"

echo -e "\n=== Pipeline with set -o pipefail ==="
set -o pipefail
# Now the pipeline will return exit code of the first failing command
false | true
echo "Pipeline exit code with pipefail: $?"

echo -e "\n=== Practical pipeline example ==="
# Create a temporary file
echo -e "apple\nbanana\ncherry" > fruits.txt

# Normal pipeline
cat fruits.txt | grep banana | awk '{print toupper($0)}'
echo "Pipeline exit code: $?"

# Pipeline with intentional failure
cat non_existing_file.txt | grep banana | awk '{print $0}'
echo "Pipeline exit code with pipefail (should be non-zero): $?"

# Reset pipefail for demonstration purposes
set +o pipefail

# Clean up
rm -f fruits.txt

echo -e "\nDemo completed!"
