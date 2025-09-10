#!/bin/bash
# =============================================================================
# SHELL SCRIPTING BASICS - Hello World and Fundamentals
# =============================================================================
# 
# SHEBANG EXPLANATION:
# #!/bin/bash - Tells the system which interpreter to use
# Other common shebangs:
# #!/bin/sh     - POSIX shell (more portable)
# #!/bin/zsh    - Z shell
# #!/usr/bin/env bash - More portable bash (finds bash in PATH)
# #!/bin/dash   - Debian Almquist Shell (faster, POSIX compliant)

# =============================================================================
# COMMENTS AND DOCUMENTATION
# =============================================================================
# Single line comments start with #
# Multi-line comments can be done with:
: '
This is a multi-line comment
Everything between the quotes is ignored
Useful for documentation blocks
'

# =============================================================================
# BASIC OUTPUT METHODS
# =============================================================================

# Simple echo - most common output method
echo "Hello, World!"

# Echo with escape sequences (use -e flag)
echo -e "Line 1\nLine 2\tTabbed"

# Echo without newline (use -n flag)
echo -n "No newline here: "
echo "Continues on same line"

# Printf - more control over formatting (like C printf)
printf "Formatted output: %s %d %.2f\n" "String" 42 3.14159

# =============================================================================
# SHELL OPTIONS AND SETTINGS
# =============================================================================

# Display current shell
echo "Current shell: $SHELL"
echo "Shell version: $BASH_VERSION"

# Show all available shells
echo "Available shells:"
cat /etc/shells

# =============================================================================
# SCRIPT EXECUTION METHODS
# =============================================================================

# Method 1: Make executable and run directly
# chmod +x script.sh
# ./script.sh

# Method 2: Run with interpreter
# bash script.sh
# sh script.sh

# Method 3: Source the script (runs in current shell)
# source script.sh
# . script.sh

# =============================================================================
# BASIC SHELL SETTINGS FOR ROBUST SCRIPTS
# =============================================================================

# Exit on any error (recommended for production scripts)
# set -e

# Exit on undefined variables (helps catch typos)
# set -u

# Make pipes fail if any command fails
# set -o pipefail

# Combine all three (common pattern)
# set -euo pipefail

# =============================================================================
# SCRIPT METADATA
# =============================================================================

# Get script name and directory
SCRIPT_NAME=$(basename "$0")
SCRIPT_DIR=$(dirname "$0")
SCRIPT_PATH=$(realpath "$0")

echo "Script name: $SCRIPT_NAME"
echo "Script directory: $SCRIPT_DIR"
echo "Full script path: $SCRIPT_PATH"

# =============================================================================
# BASIC SYSTEM INFORMATION
# =============================================================================

echo "System Information:"
echo "==================="
echo "Hostname: $(hostname)"
echo "Username: $(whoami)"
echo "Current directory: $(pwd)"
echo "Date: $(date)"
echo "Uptime: $(uptime)"

# =============================================================================
# EXIT CODES
# =============================================================================

# Scripts should return appropriate exit codes
# 0 = success, 1-255 = various error conditions

echo "Script completed successfully!"
exit 0  # Explicit success exit (optional, default is 0)