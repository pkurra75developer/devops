#!/bin/bash
# =============================================================================
# VARIABLES AND DATA TYPES - Complete Guide
# =============================================================================

set -euo pipefail  # Robust error handling

# =============================================================================
# VARIABLE DECLARATION AND ASSIGNMENT
# =============================================================================

# Basic variable assignment (NO SPACES around =)
name="John Doe"
age=30
pi=3.14159

# Variables are untyped by default (everything is a string)
echo "Name: $name"
echo "Age: $age"
echo "Pi: $pi"

# =============================================================================
# VARIABLE NAMING CONVENTIONS
# =============================================================================

# Valid variable names:
valid_name="OK"
ValidName="OK"
_private_var="OK"
VAR123="OK"

# Invalid variable names (would cause errors):
# 123invalid="Error"    # Cannot start with number
# invalid-name="Error"  # Hyphens not allowed
# invalid name="Error"  # Spaces not allowed

# =============================================================================
# VARIABLE EXPANSION AND QUOTING
# =============================================================================

# Different quoting behaviors:
single_quoted='$name will not expand'
double_quoted="$name will expand"
no_quotes=$name

echo "Single quotes: $single_quoted"
echo "Double quotes: $double_quoted"
echo "No quotes: $no_quotes"

# =============================================================================
# ADVANCED VARIABLE EXPANSION
# =============================================================================

# Brace expansion for clarity
echo "Hello ${name}!"
echo "File: ${name}.txt"

# Variable with default values
unset optional_var
echo "Default value: ${optional_var:-'default'}"
echo "Assign default: ${optional_var:='assigned_default'}"
echo "Now optional_var = $optional_var"

# Variable length
echo "Name length: ${#name}"

# Substring extraction
text="Hello World"
echo "Substring (0,5): ${text:0:5}"
echo "Substring (6): ${text:6}"

# =============================================================================
# ARRAYS (Bash 4.0+)
# =============================================================================

# Indexed arrays
fruits=("apple" "banana" "cherry" "date")
echo "First fruit: ${fruits[0]}"
echo "All fruits: ${fruits[@]}"
echo "Array length: ${#fruits[@]}"

# Add elements
fruits+=("elderberry")
echo "Updated fruits: ${fruits[@]}"

# Associative arrays (Bash 4.0+)
declare -A person
person[name]="Alice"
person[age]=25
person[city]="New York"

echo "Person name: ${person[name]}"
echo "All keys: ${!person[@]}"
echo "All values: ${person[@]}"

# =============================================================================
# READING USER INPUT
# =============================================================================

# Basic input
echo -n "Enter your name: "
read user_name
echo "Hello, $user_name!"

# Input with prompt
read -p "Enter your age: " user_age
echo "You are $user_age years old"

# Silent input (for passwords)
read -s -p "Enter password: " password
echo  # New line after silent input
echo "Password length: ${#password}"

# Input with timeout
if read -t 5 -p "Quick! Enter something (5 sec timeout): " quick_input; then
    echo "You entered: $quick_input"
else
    echo "Timeout! No input received"
fi

# Reading multiple values
read -p "Enter first and last name: " first_name last_name
echo "First: $first_name, Last: $last_name"

# =============================================================================
# ENVIRONMENT VARIABLES
# =============================================================================

# Common environment variables
echo "Environment Variables:"
echo "======================"
echo "PATH: $PATH"
echo "HOME: $HOME"
echo "USER: $USER"
echo "PWD: $PWD"
echo "SHELL: $SHELL"

# Setting environment variables
export MY_VAR="This is exported"
MY_LOCAL_VAR="This is local"

# Check if variable is set
if [[ -n "${MY_VAR:-}" ]]; then
    echo "MY_VAR is set: $MY_VAR"
fi

# =============================================================================
# SPECIAL VARIABLES
# =============================================================================

echo "Special Variables:"
echo "=================="
echo "Script name: $0"
echo "Process ID: $$"
echo "Parent PID: $PPID"
echo "Number of arguments: $#"
echo "All arguments: $@"
echo "All arguments (single string): $*"
echo "Last command exit status: $?"
echo "Current user ID: $UID"
echo "Random number: $RANDOM"

# =============================================================================
# VARIABLE TYPES AND ATTRIBUTES
# =============================================================================

# Declare integer variable
declare -i number=10
number="20 + 30"  # Arithmetic evaluation
echo "Integer result: $number"

# Declare read-only variable
declare -r CONSTANT="Cannot change this"
# CONSTANT="new value"  # This would cause an error

# Declare array
declare -a my_array=("one" "two" "three")
echo "Array: ${my_array[@]}"

# Export variable
declare -x EXPORTED_VAR="Available to child processes"

# =============================================================================
# VARIABLE MANIPULATION
# =============================================================================

filename="document.txt.backup"

# Remove shortest match from end
echo "Remove .backup: ${filename%.backup}"

# Remove longest match from end
echo "Remove extension: ${filename%.*}"

# Remove shortest match from beginning
echo "Remove 'doc': ${filename#doc}"

# Remove longest match from beginning
path="/usr/local/bin/script.sh"
echo "Just filename: ${path##*/}"

# Replace first occurrence
echo "Replace first 'o': ${filename/o/O}"

# Replace all occurrences
echo "Replace all 'o': ${filename//o/O}"

# =============================================================================
# INPUT VALIDATION
# =============================================================================

validate_input() {
    local input="$1"
    local type="$2"
    
    case "$type" in
        "number")
            if [[ "$input" =~ ^[0-9]+$ ]]; then
                return 0
            else
                echo "Error: '$input' is not a valid number"
                return 1
            fi
            ;;
        "email")
            if [[ "$input" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
                return 0
            else
                echo "Error: '$input' is not a valid email"
                return 1
            fi
            ;;
    esac
}

# Example usage
read -p "Enter a number: " num
if validate_input "$num" "number"; then
    echo "Valid number: $num"
fi

# =============================================================================
# CONFIGURATION FILE READING
# =============================================================================

# Create a sample config file
cat > config.conf << EOF
# Configuration file
database_host=localhost
database_port=5432
database_name=myapp
debug_mode=true
EOF

# Read configuration
echo "Reading configuration:"
while IFS='=' read -r key value; do
    # Skip comments and empty lines
    [[ "$key" =~ ^[[:space:]]*# ]] && continue
    [[ -z "$key" ]] && continue
    
    # Remove leading/trailing whitespace
    key=$(echo "$key" | xargs)
    value=$(echo "$value" | xargs)
    
    # Set variable dynamically
    declare "$key=$value"
    echo "$key = $value"
done < config.conf

# Clean up
rm -f config.conf

echo "Script completed successfully!"