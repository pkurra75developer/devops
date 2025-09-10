#!/bin/bash
# =============================================================================
# DEMO: Indexed and Associative Arrays in Bash
# =============================================================================
# This script demonstrates indexed arrays, associative arrays, and array manipulation.
# =============================================================================

set -euo pipefail

echo "=== ARRAYS Demo ==="

# Indexed array
fruits=("apple" "banana" "cherry")
echo "Indexed array elements:"
for i in "${!fruits[@]}"; do
    echo "  [$i] = ${fruits[i]}"
done

# Add element
fruits+=("date")
echo "Added 'date': ${fruits[*]}"

# Associative array (Bash 4+)
declare -A capitals
capitals=( ["France"]="Paris" ["Japan"]="Tokyo" ["India"]="New Delhi" )
echo "Associative array elements:"
for country in "${!capitals[@]}"; do
    echo "  $country -> ${capitals[$country]}"
done
