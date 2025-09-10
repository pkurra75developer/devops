#!/bin/bash
# --------------------------------------
# Simple Calculator Script in Bash
# Demonstrates variables, arithmetic, user input, and decimal division
# --------------------------------------

# Read first number from user
read -p "Enter first number: " n1

# Read second number from user
read -p "Enter second number: " n2

# Perform arithmetic operations using integer arithmetic
sum=$(( n1 + n2 ))            # Addition
difference=$(( n1 - n2 ))     # Subtraction
product=$(( n1 * n2 ))        # Multiplication

# Division: use 'bc' for decimal precision
# scale=2 sets the number of decimal places to 2
quotient=$(echo "scale=2; $n1 / $n2" | bc)

# Display results
echo "Sum: $sum, Difference: $difference, Product: $product, Quotient: $quotient"

# --------------------------------------
# Notes:
# 1. $(( ... )) is Bash arithmetic expansion (integers only)
# 2. bc allows decimal division and scale controls precision
# 3. read -p prompts the user and stores input in a variable
# --------------------------------------
