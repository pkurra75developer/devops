#!/bin/bash
# =============================================================================
# CONDITIONAL STATEMENTS - Complete Guide
# =============================================================================

set -euo pipefail

# =============================================================================
# BASIC IF STATEMENTS
# =============================================================================

echo "=== BASIC IF STATEMENTS ==="

# Simple if statement
age=25
if [ $age -ge 18 ]; then
    echo "You are an adult (age: $age)"
fi

# if-else statement
temperature=75
if [ $temperature -gt 80 ]; then
    echo "It's hot outside!"
else
    echo "It's not too hot outside."
fi

# if-elif-else statement
score=85
if [ $score -ge 90 ]; then
    echo "Grade: A (Excellent!)"
elif [ $score -ge 80 ]; then
    echo "Grade: B (Good job!)"
elif [ $score -ge 70 ]; then
    echo "Grade: C (Average)"
elif [ $score -ge 60 ]; then
    echo "Grade: D (Below average)"
else
    echo "Grade: F (Failed)"
fi

# =============================================================================
# TEST EXPRESSIONS - [ ] vs [[ ]] vs (( ))
# =============================================================================

echo -e "\n=== TEST EXPRESSIONS COMPARISON ==="

# [ ] - POSIX compliant, basic test
# [[ ]] - Bash extended test (recommended)
# (( )) - Arithmetic evaluation

num=10
str="hello"

echo "Using [ ] (POSIX test):"
if [ "$num" -eq 10 ]; then
    echo "  Number is 10"
fi

if [ "$str" = "hello" ]; then
    echo "  String is 'hello'"
fi

echo "Using [[ ]] (Bash extended test):"
if [[ $num -eq 10 ]]; then
    echo "  Number is 10 (no quotes needed)"
fi

if [[ $str == "hello" ]]; then
    echo "  String is 'hello' (== operator)"
fi

# Pattern matching with [[ ]]
if [[ $str == h* ]]; then
    echo "  String starts with 'h'"
fi

echo "Using (( )) (arithmetic evaluation):"
if (( num == 10 )); then
    echo "  Number is 10 (C-style syntax)"
fi

if (( num > 5 && num < 15 )); then
    echo "  Number is between 5 and 15"
fi

# =============================================================================
# STRING COMPARISONS AND TESTS
# =============================================================================

echo -e "\n=== STRING COMPARISONS ==="

string1="apple"
string2="banana"
empty_string=""
unset_var

echo "String comparison examples:"

# Equality
if [[ "$string1" == "apple" ]]; then
    echo "  string1 equals 'apple'"
fi

# Inequality
if [[ "$string1" != "$string2" ]]; then
    echo "  string1 is not equal to string2"
fi

# Lexicographic comparison
if [[ "$string1" < "$string2" ]]; then
    echo "  '$string1' comes before '$string2' alphabetically"
fi

# Empty string tests
if [[ -z "$empty_string" ]]; then
    echo "  empty_string is empty"
fi

if [[ -n "$string1" ]]; then
    echo "  string1 is not empty"
fi

# Unset variable test
if [[ -z "${unset_var:-}" ]]; then
    echo "  unset_var is unset or empty"
fi

# =============================================================================
# NUMERIC COMPARISONS
# =============================================================================

echo -e "\n=== NUMERIC COMPARISONS ==="

a=10
b=20
c=10

echo "Numeric comparison examples:"

# All numeric comparison operators
if [[ $a -eq $c ]]; then echo "  $a equals $c"; fi
if [[ $a -ne $b ]]; then echo "  $a not equals $b"; fi
if [[ $a -lt $b ]]; then echo "  $a less than $b"; fi
if [[ $a -le $c ]]; then echo "  $a less than or equal to $c"; fi
if [[ $b -gt $a ]]; then echo "  $b greater than $a"; fi
if [[ $b -ge $a ]]; then echo "  $b greater than or equal to $a"; fi

# Arithmetic context comparisons
if (( a == c )); then echo "  $a == $c (arithmetic)"; fi
if (( a < b )); then echo "  $a < $b (arithmetic)"; fi

# =============================================================================
# FILE AND DIRECTORY TESTS
# =============================================================================

echo -e "\n=== FILE AND DIRECTORY TESTS ==="

# Create test files and directories
touch test_file.txt
echo "content" > test_content.txt
mkdir -p test_dir
chmod 755 test_file.txt
chmod 644 test_content.txt

echo "File test examples:"

# File existence and type tests
if [[ -e test_file.txt ]]; then
    echo "  test_file.txt exists"
fi

if [[ -f test_file.txt ]]; then
    echo "  test_file.txt is a regular file"
fi

if [[ -d test_dir ]]; then
    echo "  test_dir is a directory"
fi

# File permission tests
if [[ -r test_file.txt ]]; then
    echo "  test_file.txt is readable"
fi

if [[ -w test_file.txt ]]; then
    echo "  test_file.txt is writable"
fi

if [[ -x test_file.txt ]]; then
    echo "  test_file.txt is executable"
fi

# File size tests
if [[ -s test_content.txt ]]; then
    echo "  test_content.txt is not empty"
fi

if [[ ! -s test_file.txt ]]; then
    echo "  test_file.txt is empty"
fi

# File age comparison
sleep 1
touch newer_file.txt

if [[ newer_file.txt -nt test_file.txt ]]; then
    echo "  newer_file.txt is newer than test_file.txt"
fi

if [[ test_file.txt -ot newer_file.txt ]]; then
    echo "  test_file.txt is older than newer_file.txt"
fi

# =============================================================================
# LOGICAL OPERATORS IN CONDITIONS
# =============================================================================

echo -e "\n=== LOGICAL OPERATORS ==="

user_age=25
has_license=true
income=50000

echo "Logical operator examples:"

# AND operator
if [[ $user_age -ge 18 && $has_license == true ]]; then
    echo "  Can drive (age >= 18 AND has license)"
fi

# OR operator
if [[ $user_age -ge 65 || $income -lt 20000 ]]; then
    echo "  Eligible for discount (senior OR low income)"
fi

# NOT operator
if [[ ! $has_license == false ]]; then
    echo "  Has a valid license"
fi

# Complex logical expressions
if [[ ($user_age -ge 18 && $user_age -le 65) && $income -gt 30000 ]]; then
    echo "  Eligible for premium service"
fi

# =============================================================================
# PATTERN MATCHING WITH [[ ]]
# =============================================================================

echo -e "\n=== PATTERN MATCHING ==="

filename="document.pdf"
email="user@example.com"
phone="123-456-7890"

echo "Pattern matching examples:"

# Wildcard patterns
if [[ $filename == *.pdf ]]; then
    echo "  File is a PDF"
fi

if [[ $filename == doc* ]]; then
    echo "  Filename starts with 'doc'"
fi

# Character classes
if [[ $phone == [0-9][0-9][0-9]-* ]]; then
    echo "  Phone number starts with 3 digits and a dash"
fi

# Regular expressions
if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "  Valid email format"
fi

# Case-insensitive matching (bash 4.0+)
shopt -s nocasematch
if [[ "HELLO" == "hello" ]]; then
    echo "  Case-insensitive match works"
fi
shopt -u nocasematch

# =============================================================================
# CASE STATEMENTS
# =============================================================================

echo -e "\n=== CASE STATEMENTS ==="

# Basic case statement
day="Monday"
case $day in
    "Monday")
        echo "Start of the work week"
        ;;
    "Tuesday"|"Wednesday"|"Thursday")
        echo "Midweek day"
        ;;
    "Friday")
        echo "TGIF!"
        ;;
    "Saturday"|"Sunday")
        echo "Weekend!"
        ;;
    *)
        echo "Unknown day"
        ;;
esac

# Case with patterns
read -p "Enter a file extension: " extension
case $extension in
    txt|log)
        echo "Text file"
        ;;
    jpg|jpeg|png|gif)
        echo "Image file"
        ;;
    mp3|wav|flac)
        echo "Audio file"
        ;;
    mp4|avi|mkv)
        echo "Video file"
        ;;
    [Pp][Dd][Ff])
        echo "PDF file (case insensitive)"
        ;;
    *)
        echo "Unknown file type"
        ;;
esac

# Case with ranges and character classes
read -p "Enter a single character: " char
case $char in
    [a-z])
        echo "Lowercase letter"
        ;;
    [A-Z])
        echo "Uppercase letter"
        ;;
    [0-9])
        echo "Digit"
        ;;
    [[:punct:]])
        echo "Punctuation"
        ;;
    *)
        echo "Other character"
        ;;
esac

# =============================================================================
# NESTED CONDITIONS
# =============================================================================

echo -e "\n=== NESTED CONDITIONS ==="

user_type="admin"
user_active=true
user_age=30

if [[ $user_type == "admin" ]]; then
    echo "Admin user detected"
    if [[ $user_active == true ]]; then
        echo "  Admin is active"
        if [[ $user_age -ge 21 ]]; then
            echo "    Admin has full privileges"
        else
            echo "    Admin has limited privileges (under 21)"
        fi
    else
        echo "  Admin account is inactive"
    fi
elif [[ $user_type == "user" ]]; then
    echo "Regular user"
    if [[ $user_active == true ]]; then
        echo "  User is active"
    else
        echo "  User account is inactive"
    fi
else
    echo "Unknown user type"
fi

# =============================================================================
# CONDITIONAL ASSIGNMENT
# =============================================================================

echo -e "\n=== CONDITIONAL ASSIGNMENT ==="

# Using parameter expansion for conditional assignment
config_file="${CONFIG_FILE:-/etc/default.conf}"
echo "Config file: $config_file"

# Conditional assignment based on test
if [[ -f "/etc/custom.conf" ]]; then
    config_file="/etc/custom.conf"
else
    config_file="/etc/default.conf"
fi
echo "Selected config: $config_file"

# Ternary-like assignment using && and ||
debug_mode=true
log_level=$( [[ $debug_mode == true ]] && echo "DEBUG" || echo "INFO" )
echo "Log level: $log_level"

# =============================================================================
# ERROR HANDLING WITH CONDITIONS
# =============================================================================

echo -e "\n=== ERROR HANDLING ==="

# Function that might fail
risky_operation() {
    local chance=$((RANDOM % 2))
    if [[ $chance -eq 0 ]]; then
        echo "Operation successful"
        return 0
    else
        echo "Operation failed" >&2
        return 1
    fi
}

# Error handling with if statement
if risky_operation; then
    echo "Success: Operation completed"
else
    echo "Error: Operation failed, taking corrective action"
fi

# Short-circuit evaluation
risky_operation && echo "Success callback" || echo "Failure callback"

# =============================================================================
# ADVANCED CONDITIONAL PATTERNS
# =============================================================================

echo -e "\n=== ADVANCED PATTERNS ==="

# Multiple conditions with arrays
valid_users=("alice" "bob" "charlie")
current_user="bob"

# Check if user is in array
if [[ " ${valid_users[*]} " =~ " ${current_user} " ]]; then
    echo "User $current_user is authorized"
else
    echo "User $current_user is not authorized"
fi

# Conditional execution based on command success
if command -v git >/dev/null 2>&1; then
    echo "Git is installed"
    git_version=$(git --version)
    echo "Version: $git_version"
else
    echo "Git is not installed"
fi

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    echo "Running as root - be careful!"
else
    echo "Running as regular user"
fi

# Check system type
case "$(uname -s)" in
    Linux*)
        echo "Running on Linux"
        ;;
    Darwin*)
        echo "Running on macOS"
        ;;
    CYGWIN*|MINGW*)
        echo "Running on Windows"
        ;;
    *)
        echo "Unknown operating system"
        ;;
esac

# =============================================================================
# INPUT VALIDATION WITH CONDITIONS
# =============================================================================

echo -e "\n=== INPUT VALIDATION ==="

validate_email() {
    local email="$1"
    local email_regex="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    
    if [[ -z "$email" ]]; then
        echo "Error: Email cannot be empty"
        return 1
    elif [[ ! "$email" =~ $email_regex ]]; then
        echo "Error: Invalid email format"
        return 1
    else
        echo "Valid email: $email"
        return 0
    fi
}

validate_number() {
    local number="$1"
    local min="$2"
    local max="$3"
    
    if [[ ! "$number" =~ ^[0-9]+$ ]]; then
        echo "Error: Not a valid number"
        return 1
    elif [[ $number -lt $min || $number -gt $max ]]; then
        echo "Error: Number must be between $min and $max"
        return 1
    else
        echo "Valid number: $number"
        return 0
    fi
}

# Test validation functions
validate_email "user@example.com"
validate_email "invalid-email"
validate_number "25" "1" "100"
validate_number "150" "1" "100"

# =============================================================================
# MENU SYSTEM WITH CASE
# =============================================================================

echo -e "\n=== MENU SYSTEM ==="

show_menu() {
    echo "=== Main Menu ==="
    echo "1. View files"
    echo "2. System info"
    echo "3. Network status"
    echo "4. Exit"
    echo "================="
}

process_menu_choice() {
    local choice="$1"
    
    case $choice in
        1|"view"|"files")
            echo "Listing files:"
            ls -la | head -5
            ;;
        2|"system"|"info")
            echo "System information:"
            echo "Hostname: $(hostname)"
            echo "Uptime: $(uptime)"
            ;;
        3|"network"|"net")
            echo "Network status:"
            if command -v ip >/dev/null 2>&1; then
                ip addr show | grep "inet " | head -3
            else
                echo "Network tools not available"
            fi
            ;;
        4|"exit"|"quit")
            echo "Goodbye!"
            return 1
            ;;
        *)
            echo "Invalid choice: $choice"
            return 2
            ;;
    esac
    return 0
}

# Simulate menu interaction
echo "Simulating menu choices:"
for choice in 1 2 "invalid" 4; do
    echo "Choice: $choice"
    if ! process_menu_choice "$choice"; then
        [[ $? -eq 1 ]] && echo "Exiting menu" && break
    fi
    echo
done

# =============================================================================
# CONDITIONAL COMPILATION/EXECUTION
# =============================================================================

echo -e "\n=== CONDITIONAL EXECUTION ==="

# Debug mode
DEBUG=${DEBUG:-false}

debug_log() {
    if [[ $DEBUG == true ]]; then
        echo "[DEBUG] $*" >&2
    fi
}

debug_log "This is a debug message"

# Feature flags
FEATURE_ADVANCED=${FEATURE_ADVANCED:-false}

if [[ $FEATURE_ADVANCED == true ]]; then
    echo "Advanced features enabled"
    # Advanced functionality here
else
    echo "Basic mode"
    # Basic functionality here
fi

# Environment-specific behavior
ENVIRONMENT=${ENVIRONMENT:-development}

case $ENVIRONMENT in
    "production")
        echo "Production mode: Logging to file"
        ;;
    "staging")
        echo "Staging mode: Verbose logging"
        ;;
    "development")
        echo "Development mode: Debug logging"
        ;;
    *)
        echo "Unknown environment: $ENVIRONMENT"
        ;;
esac

# =============================================================================
# CLEANUP AND SUMMARY
# =============================================================================

# Clean up test files
rm -f test_file.txt test_content.txt newer_file.txt
rm -rf test_dir

echo -e "\n=== CONDITIONAL STATEMENTS SUMMARY ==="
echo "✓ Basic if/else statements"
echo "✓ Test expressions: [ ], [[ ]], (( ))"
echo "✓ String and numeric comparisons"
echo "✓ File and directory tests"
echo "✓ Logical operators"
echo "✓ Pattern matching"
echo "✓ Case statements"
echo "✓ Nested conditions"
echo "✓ Error handling"
echo "✓ Input validation"
echo "✓ Menu systems"
echo "✓ Conditional execution"

echo "Script completed successfully!"