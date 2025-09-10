#!/bin/bash
# =============================================================================
# OPERATORS AND EXPRESSIONS - Complete Guide
# =============================================================================

set -euo pipefail

# =============================================================================
# ARITHMETIC OPERATORS
# =============================================================================

echo "=== ARITHMETIC OPERATORS ==="

# Basic arithmetic with variables
a=10
b=3

# Method 1: Using $((expression)) - RECOMMENDED
echo "Addition: $a + $b = $((a + b))"
echo "Subtraction: $a - $b = $((a - b))"
echo "Multiplication: $a * $b = $((a * b))"
echo "Division: $a / $b = $((a / b))"
echo "Modulo: $a % $b = $((a % b))"
echo "Exponentiation: $a ** $b = $((a ** b))"

# Method 2: Using expr (older, less efficient)
echo "Using expr:"
echo "Addition with expr: $(expr $a + $b)"
echo "Multiplication with expr: $(expr $a \* $b)"  # Note: * needs escaping

# Method 3: Using let command
let result=a+b
echo "Using let: $a + $b = $result"

# Method 4: Using declare -i (integer variables)
declare -i num1=15 num2=4
result_int=num1+num2  # Automatic arithmetic evaluation
echo "Integer variables: $num1 + $num2 = $result_int"

# =============================================================================
# FLOATING POINT ARITHMETIC (using bc)
# =============================================================================

echo -e "\n=== FLOATING POINT ARITHMETIC ==="

# bc (basic calculator) for floating point
pi=$(echo "scale=4; 22/7" | bc)
echo "Pi approximation: $pi"

# More complex calculations
result=$(echo "scale=2; sqrt(16) + 3.14 * 2" | bc -l)
echo "Complex calculation: $result"

# awk for floating point (alternative)
result=$(awk "BEGIN {printf \"%.2f\", 10.5 + 3.7}")
echo "Using awk: $result"

# =============================================================================
# INCREMENT AND DECREMENT OPERATORS
# =============================================================================

echo -e "\n=== INCREMENT/DECREMENT OPERATORS ==="

counter=5
echo "Initial counter: $counter"

# Pre-increment
echo "Pre-increment: $((++counter))"
echo "Counter is now: $counter"

# Post-increment
echo "Post-increment: $((counter++))"
echo "Counter is now: $counter"

# Pre-decrement
echo "Pre-decrement: $((--counter))"
echo "Counter is now: $counter"

# Post-decrement
echo "Post-decrement: $((counter--))"
echo "Counter is now: $counter"

# Compound assignment operators
counter+=5  # Same as counter=$((counter + 5))
echo "After +=5: $counter"

counter*=2  # Same as counter=$((counter * 2))
echo "After *=2: $counter"

# =============================================================================
# COMPARISON OPERATORS
# =============================================================================

echo -e "\n=== COMPARISON OPERATORS ==="

x=10
y=20
z=10

# Numeric comparisons (use in [[ ]] or (( )))
echo "Numeric Comparisons:"
echo "$x -eq $z: $([[ $x -eq $z ]] && echo "true" || echo "false")"
echo "$x -ne $y: $([[ $x -ne $y ]] && echo "true" || echo "false")"
echo "$x -lt $y: $([[ $x -lt $y ]] && echo "true" || echo "false")"
echo "$x -le $z: $([[ $x -le $z ]] && echo "true" || echo "false")"
echo "$x -gt $y: $([[ $x -gt $y ]] && echo "true" || echo "false")"
echo "$x -ge $z: $([[ $x -ge $z ]] && echo "true" || echo "false")"

# Alternative syntax with (( ))
echo -e "\nUsing (( )) syntax:"
echo "$x == $z: $(( x == z ? 1 : 0 ))"
echo "$x != $y: $(( x != y ? 1 : 0 ))"
echo "$x < $y: $(( x < y ? 1 : 0 ))"
echo "$x <= $z: $(( x <= z ? 1 : 0 ))"
echo "$x > $y: $(( x > y ? 1 : 0 ))"
echo "$x >= $z: $(( x >= z ? 1 : 0 ))"

# =============================================================================
# STRING COMPARISON OPERATORS
# =============================================================================

echo -e "\n=== STRING COMPARISON OPERATORS ==="

str1="apple"
str2="banana"
str3="apple"

echo "String Comparisons:"
echo "'$str1' = '$str3': $([[ "$str1" = "$str3" ]] && echo "true" || echo "false")"
echo "'$str1' != '$str2': $([[ "$str1" != "$str2" ]] && echo "true" || echo "false")"
echo "'$str1' < '$str2': $([[ "$str1" < "$str2" ]] && echo "true" || echo "false")"
echo "'$str1' > '$str2': $([[ "$str1" > "$str2" ]] && echo "true" || echo "false")"

# String length and empty checks
echo -e "\nString Length and Empty Checks:"
echo "Length of '$str1': ${#str1}"
echo "Is '$str1' empty: $([[ -z "$str1" ]] && echo "true" || echo "false")"
echo "Is '$str1' non-empty: $([[ -n "$str1" ]] && echo "true" || echo "false")"

empty_string=""
echo "Is empty string empty: $([[ -z "$empty_string" ]] && echo "true" || echo "false")"

# =============================================================================
# PATTERN MATCHING OPERATORS
# =============================================================================

echo -e "\n=== PATTERN MATCHING OPERATORS ==="

filename="document.txt"
email="user@example.com"

# Wildcard matching
echo "Pattern Matching:"
echo "'$filename' matches '*.txt': $([[ "$filename" == *.txt ]] && echo "true" || echo "false")"
echo "'$filename' matches 'doc*': $([[ "$filename" == doc* ]] && echo "true" || echo "false")"

# Regular expression matching
echo -e "\nRegular Expression Matching:"
echo "'$email' matches email pattern: $([[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]] && echo "true" || echo "false")"

number="12345"
echo "'$number' is all digits: $([[ "$number" =~ ^[0-9]+$ ]] && echo "true" || echo "false")"

# =============================================================================
# LOGICAL OPERATORS
# =============================================================================

echo -e "\n=== LOGICAL OPERATORS ==="

a=5
b=10
c=15

# AND operator (&&)
echo "Logical AND:"
echo "($a < $b) && ($b < $c): $(( (a < b) && (b < c) ? 1 : 0 ))"
echo "($a > $b) && ($b < $c): $(( (a > b) && (b < c) ? 1 : 0 ))"

# OR operator (||)
echo -e "\nLogical OR:"
echo "($a < $b) || ($a > $c): $(( (a < b) || (a > c) ? 1 : 0 ))"
echo "($a > $b) || ($a > $c): $(( (a > b) || (a > c) ? 1 : 0 ))"

# NOT operator (!)
echo -e "\nLogical NOT:"
echo "!($a < $b): $(( !(a < b) ? 1 : 0 ))"
echo "!($a > $b): $(( !(a > b) ? 1 : 0 ))"

# =============================================================================
# BITWISE OPERATORS
# =============================================================================

echo -e "\n=== BITWISE OPERATORS ==="

x=12  # Binary: 1100
y=10  # Binary: 1010

echo "Bitwise Operations:"
echo "$x (binary: $(echo "obase=2; $x" | bc))"
echo "$y (binary: $(echo "obase=2; $y" | bc))"
echo "AND ($x & $y): $((x & y))"
echo "OR ($x | $y): $((x | y))"
echo "XOR ($x ^ $y): $((x ^ y))"
echo "NOT (~$x): $((~x))"
echo "Left shift ($x << 1): $((x << 1))"
echo "Right shift ($x >> 1): $((x >> 1))"

# =============================================================================
# FILE TEST OPERATORS
# =============================================================================

echo -e "\n=== FILE TEST OPERATORS ==="

# Create test files
touch test_file.txt
mkdir -p test_directory
chmod 755 test_file.txt

echo "File Tests:"
echo "File exists (-e): $([[ -e test_file.txt ]] && echo "true" || echo "false")"
echo "Is regular file (-f): $([[ -f test_file.txt ]] && echo "true" || echo "false")"
echo "Is directory (-d): $([[ -d test_directory ]] && echo "true" || echo "false")"
echo "Is readable (-r): $([[ -r test_file.txt ]] && echo "true" || echo "false")"
echo "Is writable (-w): $([[ -w test_file.txt ]] && echo "true" || echo "false")"
echo "Is executable (-x): $([[ -x test_file.txt ]] && echo "true" || echo "false")"
echo "Is empty (-s): $([[ -s test_file.txt ]] && echo "false" || echo "true")"

# File comparison
touch newer_file.txt
sleep 1
touch older_file.txt

echo -e "\nFile Comparison:"
echo "newer_file.txt is newer than older_file.txt (-nt): $([[ newer_file.txt -nt older_file.txt ]] && echo "true" || echo "false")"
echo "older_file.txt is older than newer_file.txt (-ot): $([[ older_file.txt -ot newer_file.txt ]] && echo "true" || echo "false")"

# =============================================================================
# TERNARY OPERATOR (CONDITIONAL EXPRESSION)
# =============================================================================

echo -e "\n=== TERNARY OPERATOR ==="

age=18
status=$((age >= 18 ? 1 : 0))
echo "Age $age, Adult status (1=yes, 0=no): $status"

# String ternary using parameter expansion
name="John"
greeting=${name:+"Hello, $name!"}
greeting=${greeting:-"Hello, stranger!"}
echo "Greeting: $greeting"

# =============================================================================
# OPERATOR PRECEDENCE
# =============================================================================

echo -e "\n=== OPERATOR PRECEDENCE ==="

# Demonstrate precedence with parentheses
result1=$((2 + 3 * 4))      # Multiplication first
result2=$(((2 + 3) * 4))    # Addition first due to parentheses

echo "2 + 3 * 4 = $result1"
echo "(2 + 3) * 4 = $result2"

# Complex expression
result=$((2 ** 3 + 4 * 5 - 6 / 2))
echo "2^3 + 4*5 - 6/2 = $result"

# =============================================================================
# PRACTICAL EXAMPLES
# =============================================================================

echo -e "\n=== PRACTICAL EXAMPLES ==="

# Check if number is even or odd
number=42
if (( number % 2 == 0 )); then
    echo "$number is even"
else
    echo "$number is odd"
fi

# Grade calculator
score=85
if (( score >= 90 )); then
    grade="A"
elif (( score >= 80 )); then
    grade="B"
elif (( score >= 70 )); then
    grade="C"
elif (( score >= 60 )); then
    grade="D"
else
    grade="F"
fi
echo "Score: $score, Grade: $grade"

# Validate input range
read -p "Enter a number between 1 and 100: " input
if [[ "$input" =~ ^[0-9]+$ ]] && (( input >= 1 && input <= 100 )); then
    echo "Valid input: $input"
else
    echo "Invalid input. Please enter a number between 1 and 100."
fi

# Clean up test files
rm -f test_file.txt newer_file.txt older_file.txt
rm -rf test_directory

echo "Script completed successfully!"