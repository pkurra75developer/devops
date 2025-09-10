#!/bin/bash
# ====================================================
# Debug Demo Script
# ====================================================
# This script is designed to show the difference between:
#   1. bash script.sh
#   2. bash -x script.sh
#   3. bash -x -c './script.sh'
#
# Usage:
#   make it executable chmo +x debug_demo.sh
#   bash debug_demo.sh
#   bash -x debug_demo.sh
#   bash -x -c './debug_demo.sh'
#
# Try each one and compare the output carefully.
# ====================================================

echo "=== Inside the script ==="

echo "Step 1: Simple echo"
echo "Hello from Step 1"

echo "Step 2: List files"
ls /tmp

echo "Step 3: Run an intentional error"
ls /not_a_real_folder   # This will fail but script continues

echo "Step 4: Done"
