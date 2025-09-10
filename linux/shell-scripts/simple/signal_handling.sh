#!/bin/bash
# =============================================================================
# trap_demo.sh
# =============================================================================
# Comprehensive demonstration of Bash 'trap' command
# Topics covered:
# 1. EXIT trap – cleanup on script exit
# 2. ERR trap – catch errors
# 3. SIGINT trap – handle Ctrl+C
# 4. SIGTERM trap – graceful termination
# 5. Multiple signals trap
# 6. Removing traps
# =============================================================================

set -euo pipefail  # Strict mode: exit on error, unset var, or failed pipeline

echo "=== TRAP DEMO SCRIPT ==="

# =============================================================================
# 1. EXIT trap: Run on script exit (normal or via exit command)
# =============================================================================
tmpfile=$(mktemp)  # Create temporary file
trap 'echo "[EXIT TRAP] Cleaning up temp file: $tmpfile"; rm -f "$tmpfile"' EXIT

echo -e "\n--- EXIT Trap Example ---"
echo "Temporary file created at $tmpfile"
echo "Writing some data to temp file..."
echo "Hello Trap" > "$tmpfile"
cat "$tmpfile"

# =============================================================================
# 2. ERR trap: Triggered when a command fails
# =============================================================================
trap 'echo "[ERR TRAP] Error occurred at line $LINENO"; exit 1' ERR

echo -e "\n--- ERR Trap Example ---"
echo "About to run a failing command..."
false  # This fails and triggers ERR trap
echo "This line will NOT execute due to set -e"

# =============================================================================
# 3. SIGINT trap: Handle Ctrl+C interruption
# =============================================================================
trap 'echo "[SIGINT TRAP] Script interrupted by user (Ctrl+C)"; exit 2' SIGINT

echo -e "\n--- SIGINT Trap Example ---"
echo "Press Ctrl+C in the next 5 seconds..."
sleep 5
echo "No Ctrl+C pressed, continuing..."

# =============================================================================
# 4. SIGTERM trap: Graceful termination (e.g., kill command)
# =============================================================================
trap 'echo "[SIGTERM TRAP] Received SIGTERM. Cleaning up and exiting"; exit 3' SIGTERM

echo -e "\n--- SIGTERM Trap Example ---"
echo "Try running 'kill -15 $$' from another terminal"
sleep 5
echo "No SIGTERM received, continuing..."

# =============================================================================
# 5. Multiple signals in one trap
# =============================================================================
trap 'echo "[MULTI-SIGNAL TRAP] Exiting due to SIGINT or SIGTERM"; exit 4' SIGINT SIGTERM

echo -e "\n--- Multiple Signals Trap Example ---"
echo "Try pressing Ctrl+C or sending SIGTERM during next 5 seconds..."
sleep 5
echo "No signals received, continuing..."

# =============================================================================
# 6. Removing a trap
# =============================================================================
echo -e "\n--- Removing Traps Example ---"
trap - SIGINT SIGTERM  # Remove traps for SIGINT and SIGTERM
echo "SIGINT and SIGTERM traps removed. Now Ctrl+C will terminate normally."
sleep 3

# =============================================================================
# CLEANUP
# =============================================================================
rm -f "$tmpfile"
echo -e "\n=== TRAP DEMO COMPLETE ==="
echo "Covered: EXIT, ERR, SIGINT, SIGTERM, multiple signals, removing traps"
