#!/bin/bash
# =============================================================================
# DEMO: Command-line Argument Parsing with getopts
# =============================================================================
# This script demonstrates how to parse command-line arguments using getopts.
# =============================================================================

set -euo pipefail

echo "=== GETOPS Demo ==="

while getopts ":u:p:h" opt; do
    case "$opt" in
        u) echo "Username: $OPTARG" ;;
        p) echo "Password: $OPTARG" ;;
        h) echo "Usage: $0 -u username -p password" ;;
        \?) echo "Invalid option: -$OPTARG" >&2 ;;
        :) echo "Option -$OPTARG requires an argument." >&2 ;;
    esac
done

# Example usage:
# ./demo_getopts.sh -u Alice -p 1234 -h
