#!/bin/bash
# =============================================================================
# DEMO: Job Control in Bash
# =============================================================================
# Purpose:
#   To demonstrate basic job control features in Bash:
#     - Running jobs in the background
#     - Bringing jobs to the foreground
#     - Suspending jobs
#     - Listing jobs
# =============================================================================

set -euo pipefail

echo "=== Job Control Demo ==="

# -----------------------------------------------------------------------------
# Run a long-running process in the background
# -----------------------------------------------------------------------------
echo -e "\nStarting a background job: sleep 10 &"
sleep 10 &
# The & symbol runs the job in the background, immediately returning control to the shell.
# The shell will show a job ID and the PID of the process, e.g., [1] 12345

# -----------------------------------------------------------------------------
# List current background jobs
# -----------------------------------------------------------------------------
echo -e "\nListing current jobs:"
jobs
# The 'jobs' command lists all jobs started in the current shell session.
# It shows job ID, status, and command.

# -----------------------------------------------------------------------------
# Start another job in background
# -----------------------------------------------------------------------------
echo -e "\nStarting another background job: sleep 20 &"
sleep 20 &

# List jobs again
echo -e "\nUpdated jobs list:"
jobs

# -----------------------------------------------------------------------------
# Suspend a foreground job (uncomment to try)
# -----------------------------------------------------------------------------
echo -e "\nTry suspending a foreground job: sleep 30"
echo "Press Ctrl+Z to suspend this job"
# sleep 30
# Note: Ctrl+Z suspends the process and sends it to background as 'stopped'.
# You can see it with 'jobs'

# -----------------------------------------------------------------------------
# Bring a job back to foreground
# -----------------------------------------------------------------------------
echo -e "\nBringing job [1] to foreground using fg %1"
# fg %1
# Uncomment the above line after starting jobs to bring them to foreground

# -----------------------------------------------------------------------------
# Kill a background job (optional)
# -----------------------------------------------------------------------------
# echo -e "\nKilling background job [2]"
# kill %2
# This terminates the job with job ID 2.

# -----------------------------------------------------------------------------
# Key Observations:
# -----------------------------------------------------------------------------
# 1. & lets you continue working while a job runs in the background.
# 2. Ctrl+Z suspends a foreground process.
# 3. fg brings a suspended/background job to the foreground.
# 4. jobs lists all jobs started in the current shell session.
# 5. kill can terminate any job by job ID or PID.
# 6. Job control is shell-specific and does not persist across terminal sessions.

echo -e "\nDemo complete! Try commands manually for interactive testing."
