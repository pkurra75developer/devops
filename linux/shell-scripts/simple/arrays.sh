#!/bin/bash
# --------------------------------------
# Bash Datatypes Demonstration
# --------------------------------------

# -----------------------------
# 1. String
# -----------------------------
name="Praveen"          # Declare a string
greeting="Hello, $name" # String can include variables
echo "$greeting"

# -----------------------------
# 2. Integer
# -----------------------------
age=30                  # Declare an integer (loosely typed)
echo "Age: $age"

# Integer arithmetic
next_year=$(( age + 1 ))  # Arithmetic using $(( ))
echo "Next year, age will be $next_year"

# -----------------------------
# 3. Array
# -----------------------------
fruits=("Apple" "Banana" "Cherry")  # Array declaration

# Accessing array elements
echo "First fruit: ${fruits[0]}"
echo "All fruits: ${fruits[@]}"

# Loop through array
echo "Looping through fruits:"
for fruit in "${fruits[@]}"; do
    echo "- $fruit"
done

# -----------------------------
# 4. Associative Array (key-value)
# -----------------------------
# Note: requires Bash 4+
declare -A colors
colors[apple]="red"
colors[banana]="yellow"
colors[cherry]="dark red"

echo "Apple color: ${colors[apple]}"
echo "All colors:"
for key in "${!colors[@]}"; do
    echo "$key -> ${colors[$key]}"
done

# -----------------------------
# Notes:
# 1. Bash variables are loosely typed; no strict type enforcement.
# 2. Integer arithmetic requires $(( )).
# 3. Arrays use parentheses () and are zero-indexed.
# 4. Associative arrays use declare -A and string keys.
# --------------------------------------
