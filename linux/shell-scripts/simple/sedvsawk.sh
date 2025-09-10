#!/bin/bash
# =============================================================================
# DEMO: sed vs awk
# =============================================================================
# Purpose:
#   To show the difference between sed and awk on the same input file.
#   - sed: primarily used for text substitution, deletion, and line editing.
#   - awk: used for processing fields, filtering, and calculations.
# =============================================================================

set -euo pipefail

# Create a sample input file
cat > sample.txt << EOF
Alice 30 NewYork
Bob 25 London
Charlie 35 Tokyo
EOF

echo -e "\n=== Original File ==="
cat sample.txt

# -----------------------------------------------------------------------------
# sed example: Replace 'Alice' with 'Alicia'
# -----------------------------------------------------------------------------
echo -e "\n=== sed Example: Replace 'Alice' with 'Alicia' ==="
sed 's/Alice/Alicia/' sample.txt

# -----------------------------------------------------------------------------
# sed example: Delete the second line
# -----------------------------------------------------------------------------
echo -e "\n=== sed Example: Delete the second line ==="
sed '2d' sample.txt

# -----------------------------------------------------------------------------
# awk example: Print only the names (1st column)
# -----------------------------------------------------------------------------
echo -e "\n=== awk Example: Print names (1st column) ==="
awk '{print $1}' sample.txt

# -----------------------------------------------------------------------------
# awk example: Print names and ages where age > 30
# -----------------------------------------------------------------------------
echo -e "\n=== awk Example: Filter age > 30 ==="
awk '$2 > 30 {print $1, $2}' sample.txt

# -----------------------------------------------------------------------------
# awk example: Add a new field (e.g., +10 to age)
# -----------------------------------------------------------------------------
echo -e "\n=== awk Example: Increase age by 10 ==="
awk '{print $1, $2+10, $3}' sample.txt

# -----------------------------------------------------------------------------
# Cleanup
# -----------------------------------------------------------------------------
rm -f sample.txt
echo -e "\nDemo complete!"
