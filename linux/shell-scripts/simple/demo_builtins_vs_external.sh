#!/bin/bash
# =============================================================================
# DEMO: Shell Built-ins vs External Commands
# =============================================================================
# This script demonstrates the difference between shell built-in commands and
# external binaries, using echo and type.
# =============================================================================

set -euo pipefail

echo "=== BUILT-INS vs EXTERNAL COMMANDS Demo ==="

# echo is a shell built-in
echo "This is using shell built-in echo"

# /bin/echo is an external command
"/bin/echo" "This is using /bin/echo external command"

# Check command types
echo -e "\nCommand type checks:"
type echo
type /bin/echo
type ls
