#!/bin/bash
# =============================================================================
# FUNCTIONS - Complete Guide to Shell Functions
# =============================================================================

set -euo pipefail

# =============================================================================
# BASIC FUNCTION SYNTAX
# =============================================================================

echo "=== BASIC FUNCTION SYNTAX ==="

# Method 1: function keyword
function greet() {
    echo "Hello from function!"
}

# Method 2: function name followed by ()
say_hello() {
    echo "Hello, World!"
}

# Method 3: POSIX style (most portable)
welcome() {
    echo "Welcome to shell scripting!"
}

# Call functions
echo "Calling functions:"
greet
say_hello
welcome

# =============================================================================
# FUNCTIONS WITH PARAMETERS
# =============================================================================

echo -e "\n=== FUNCTIONS WITH PARAMETERS ==="

# Function with single parameter
greet_person() {
    local name="$1"
    echo "Hello, $name!"
}

# Function with multiple parameters
greet_full() {
    local first_name="$1"
    local last_name="$2"
    echo "Hello, $first_name $last_name!"
}

# Function with default parameters
greet_with_default() {
    local name="${1:-World}"
    local greeting="${2:-Hello}"
    echo "$greeting, $name!"
}

# Function with parameter validation
greet_validated() {
    if [[ $# -eq 0 ]]; then
        echo "Error: Name is required" >&2
        return 1
    fi
    
    local name="$1"
    if [[ -z "$name" ]]; then
        echo "Error: Name cannot be empty" >&2
        return 1
    fi
    
    echo "Hello, $name!"
}

# Test parameter functions
echo "Testing parameter functions:"
greet_person "Alice"
greet_full "John" "Doe"
greet_with_default
greet_with_default "Bob"
greet_with_default "Charlie" "Hi"

if greet_validated "Dave"; then
    echo "Validation passed"
fi

# =============================================================================
# SPECIAL PARAMETERS IN FUNCTIONS
# =============================================================================

echo -e "\n=== SPECIAL PARAMETERS ==="

show_parameters() {
    echo "Function: ${FUNCNAME[0]}"
    echo "Number of parameters: $#"
    echo "All parameters: $*"
    echo "All parameters (array): $@"
    echo "Script name: $0"
    
    local i=1
    for param in "$@"; do
        echo "Parameter $i: $param"
        ((i++))
    done
}

echo "Testing special parameters:"
show_parameters "arg1" "arg2" "arg3"

# =============================================================================
# RETURN VALUES
# =============================================================================

echo -e "\n=== RETURN VALUES ==="

# Function returning exit status
is_even() {
    local number="$1"
    if (( number % 2 == 0 )); then
        return 0  # Success (true)
    else
        return 1  # Failure (false)
    fi
}

# Function returning string via echo
get_timestamp() {
    echo "$(date '+%Y-%m-%d %H:%M:%S')"
}

# Function returning value via global variable
calculate_sum() {
    local a="$1"
    local b="$2"
    sum_result=$((a + b))  # Global variable
}

# Function returning multiple values
get_file_info() {
    local file="$1"
    if [[ -f "$file" ]]; then
        file_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
        file_modified=$(stat -f%Sm "$file" 2>/dev/null || stat -c%y "$file" 2>/dev/null)
        return 0
    else
        return 1
    fi
}

# Test return value functions
echo "Testing return values:"

number=42
if is_even $number; then
    echo "$number is even"
else
    echo "$number is odd"
fi

timestamp=$(get_timestamp)
echo "Current timestamp: $timestamp"

calculate_sum 15 25
echo "Sum result: $sum_result"

# Create test file for file info
echo "test content" > test_file.txt
if get_file_info "test_file.txt"; then
    echo "File size: $file_size bytes"
    echo "Modified: $file_modified"
fi

# =============================================================================
# LOCAL VS GLOBAL VARIABLES
# =============================================================================

echo -e "\n=== LOCAL VS GLOBAL VARIABLES ==="

global_var="I am global"

demonstrate_scope() {
    local local_var="I am local"
    global_var="Modified global"  # Modifies global
    local shadowed_global="I shadow global"
    
    echo "Inside function:"
    echo "  Local variable: $local_var"
    echo "  Global variable: $global_var"
    echo "  Shadowed: $shadowed_global"
}

shadowed_global="Original global value"

echo "Before function call:"
echo "  Global variable: $global_var"
echo "  Shadowed global: $shadowed_global"

demonstrate_scope

echo "After function call:"
echo "  Global variable: $global_var"
echo "  Shadowed global: $shadowed_global"
# echo "  Local variable: $local_var"  # This would cause an error

# =============================================================================
# RECURSIVE FUNCTIONS
# =============================================================================

echo -e "\n=== RECURSIVE FUNCTIONS ==="

# Factorial function
factorial() {
    local n="$1"
    if [[ $n -le 1 ]]; then
        echo 1
    else
        local prev=$(factorial $((n - 1)))
        echo $((n * prev))
    fi
}

# Fibonacci function
fibonacci() {
    local n="$1"
    if [[ $n -le 1 ]]; then
        echo $n
    else
        local a=$(fibonacci $((n - 1)))
        local b=$(fibonacci $((n - 2)))
        echo $((a + b))
    fi
}

# Directory tree traversal
traverse_directory() {
    local dir="$1"
    local depth="${2:-0}"
    local indent=""
    
    # Create indentation
    for ((i=0; i<depth; i++)); do
        indent+="  "
    done
    
    echo "${indent}$(basename "$dir")/"
    
    # Process subdirectories
    for item in "$dir"/*; do
        if [[ -d "$item" ]]; then
            traverse_directory "$item" $((depth + 1))
        elif [[ -f "$item" ]]; then
            echo "${indent}  $(basename "$item")"
        fi
    done
}

echo "Testing recursive functions:"
echo "Factorial of 5: $(factorial 5)"
echo "Fibonacci of 7: $(fibonacci 7)"

# Create test directory structure
mkdir -p test_tree/{dir1/{subdir1,subdir2},dir2}
touch test_tree/{file1.txt,dir1/file2.txt,dir1/subdir1/file3.txt}

echo "Directory traversal:"
traverse_directory "test_tree"

# =============================================================================
# FUNCTION ARRAYS AND ADVANCED PARAMETER HANDLING
# =============================================================================

echo -e "\n=== ADVANCED PARAMETER HANDLING ==="

# Function accepting array as parameter
process_array() {
    local -n arr_ref=$1  # Name reference (Bash 4.3+)
    local operation="$2"
    
    case "$operation" in
        "sum")
            local sum=0
            for element in "${arr_ref[@]}"; do
                ((sum += element))
            done
            echo "Sum: $sum"
            ;;
        "max")
            local max="${arr_ref[0]}"
            for element in "${arr_ref[@]}"; do
                if (( element > max )); then
                    max=$element
                fi
            done
            echo "Max: $max"
            ;;
        "count")
            echo "Count: ${#arr_ref[@]}"
            ;;
    esac
}

# Alternative method for older bash versions
process_array_old() {
    local operation="$1"
    shift  # Remove first argument
    local arr=("$@")  # Remaining arguments become array
    
    case "$operation" in
        "sum")
            local sum=0
            for element in "${arr[@]}"; do
                ((sum += element))
            done
            echo "Sum: $sum"
            ;;
        "average")
            local sum=0
            for element in "${arr[@]}"; do
                ((sum += element))
            done
            local avg=$((sum / ${#arr[@]}))
            echo "Average: $avg"
            ;;
    esac
}

# Test array functions
numbers=(10 20 30 40 50)
echo "Testing array functions:"
process_array numbers "sum"
process_array numbers "max"
process_array numbers "count"

process_array_old "sum" "${numbers[@]}"
process_array_old "average" "${numbers[@]}"

# =============================================================================
# FUNCTION LIBRARIES AND MODULARIZATION
# =============================================================================

echo -e "\n=== FUNCTION LIBRARIES ==="

# Math library functions
math_add() { echo $(($1 + $2)); }
math_subtract() { echo $(($1 - $2)); }
math_multiply() { echo $(($1 * $2)); }
math_divide() {
    if [[ $2 -eq 0 ]]; then
        echo "Error: Division by zero" >&2
        return 1
    fi
    echo $(($1 / $2))
}

# String utility functions
string_length() { echo "${#1}"; }
string_upper() { echo "${1^^}"; }  # Bash 4.0+
string_lower() { echo "${1,,}"; }  # Bash 4.0+
string_reverse() {
    local str="$1"
    local reversed=""
    for ((i=${#str}-1; i>=0; i--)); do
        reversed+="${str:$i:1}"
    done
    echo "$reversed"
}

# File utility functions
file_backup() {
    local file="$1"
    local backup_file="${file}.backup.$(date +%Y%m%d_%H%M%S)"
    if [[ -f "$file" ]]; then
        cp "$file" "$backup_file"
        echo "Backup created: $backup_file"
    else
        echo "Error: File $file not found" >&2
        return 1
    fi
}

file_size_human() {
    local file="$1"
    if [[ -f "$file" ]]; then
        local size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
        if (( size >= 1073741824 )); then
            echo "$((size / 1073741824)) GB"
        elif (( size >= 1048576 )); then
            echo "$((size / 1048576)) MB"
        elif (( size >= 1024 )); then
            echo "$((size / 1024)) KB"
        else
            echo "$size bytes"
        fi
    else
        echo "File not found" >&2
        return 1
    fi
}

# Test library functions
echo "Testing math functions:"
echo "10 + 5 = $(math_add 10 5)"
echo "10 - 5 = $(math_subtract 10 5)"
echo "10 * 5 = $(math_multiply 10 5)"
echo "10 / 5 = $(math_divide 10 5)"

echo -e "\nTesting string functions:"
test_string="Hello World"
echo "Original: $test_string"
echo "Length: $(string_length "$test_string")"
echo "Upper: $(string_upper "$test_string")"
echo "Lower: $(string_lower "$test_string")"
echo "Reversed: $(string_reverse "$test_string")"

echo -e "\nTesting file functions:"
echo "test content for backup" > test_backup.txt
file_backup "test_backup.txt"
echo "File size: $(file_size_human "test_backup.txt")"

# =============================================================================
# ERROR HANDLING IN FUNCTIONS
# =============================================================================

echo -e "\n=== ERROR HANDLING IN FUNCTIONS ==="

# Function with comprehensive error handling
safe_divide() {
    local dividend="$1"
    local divisor="$2"
    local result_var="$3"
    
    # Input validation
    if [[ $# -ne 3 ]]; then
        echo "Usage: safe_divide <dividend> <divisor> <result_variable>" >&2
        return 1
    fi
    
    # Check if inputs are numbers
    if ! [[ "$dividend" =~ ^-?[0-9]+$ ]]; then
        echo "Error: '$dividend' is not a valid integer" >&2
        return 2
    fi
    
    if ! [[ "$divisor" =~ ^-?[0-9]+$ ]]; then
        echo "Error: '$divisor' is not a valid integer" >&2
        return 2
    fi
    
    # Check for division by zero
    if [[ $divisor -eq 0 ]]; then
        echo "Error: Division by zero" >&2
        return 3
    fi
    
    # Perform calculation and store result
    local -n result_ref=$result_var
    result_ref=$((dividend / divisor))
    
    return 0
}

# Function with cleanup on error
process_file_safe() {
    local input_file="$1"
    local output_file="$2"
    local temp_file=$(mktemp)
    
    # Cleanup function
    cleanup() {
        rm -f "$temp_file"
    }
    
    # Set trap for cleanup
    trap cleanup EXIT ERR
    
    # Validate input
    if [[ ! -f "$input_file" ]]; then
        echo "Error: Input file '$input_file' not found" >&2
        return 1
    fi
    
    # Process file
    echo "Processing $input_file..."
    if ! grep -v "^#" "$input_file" > "$temp_file"; then
        echo "Error: Failed to process file" >&2
        return 2
    fi
    
    # Move to final location
    if ! mv "$temp_file" "$output_file"; then
        echo "Error: Failed to create output file" >&2
        return 3
    fi
    
    echo "Successfully created $output_file"
    trap - EXIT ERR  # Remove trap
    return 0
}

# Test error handling functions
echo "Testing error handling:"

if safe_divide 20 4 division_result; then
    echo "20 / 4 = $division_result"
else
    echo "Division failed with exit code $?"
fi

if ! safe_divide 20 0 division_result; then
    echo "Division by zero properly handled (exit code: $?)"
fi

# Create test file for processing
cat > input_test.txt << EOF
# This is a comment
Line 1
Line 2
# Another comment
Line 3
EOF

if process_file_safe "input_test.txt" "output_test.txt"; then
    echo "File processing successful"
    echo "Output content:"
    cat output_test.txt
fi

# =============================================================================
# FUNCTION HOOKS AND CALLBACKS
# =============================================================================

echo -e "\n=== FUNCTION HOOKS AND CALLBACKS ==="

# Function that accepts callback functions
process_with_callback() {
    local data="$1"
    local callback_function="$2"
    
    echo "Processing: $data"
    
    # Call the callback function
    if declare -f "$callback_function" >/dev/null; then
        "$callback_function" "$data"
    else
        echo "Warning: Callback function '$callback_function' not found" >&2
    fi
}

# Callback functions
on_success() {
    echo "Success callback: Processed '$1' successfully"
}

on_error() {
    echo "Error callback: Failed to process '$1'"
}

# Logger callback
log_processing() {
    echo "[$(date)] Processing: $1" >> processing.log
}

# Test callbacks
echo "Testing callbacks:"
process_with_callback "data1" "on_success"
process_with_callback "data2" "log_processing"

# =============================================================================
# FUNCTION PERFORMANCE AND OPTIMIZATION
# =============================================================================

echo -e "\n=== FUNCTION PERFORMANCE ==="

# Memoization example
declare -A fibonacci_cache

fibonacci_memoized() {
    local n="$1"
    
    # Check cache first
    if [[ -n "${fibonacci_cache[$n]:-}" ]]; then
        echo "${fibonacci_cache[$n]}"
        return
    fi
    
    # Calculate and cache result
    if [[ $n -le 1 ]]; then
        fibonacci_cache[$n]=$n
        echo $n
    else
        local a=$(fibonacci_memoized $((n - 1)))
        local b=$(fibonacci_memoized $((n - 2)))
        local result=$((a + b))
        fibonacci_cache[$n]=$result
        echo $result
    fi
}

# Benchmark functions
benchmark_function() {
    local func_name="$1"
    local arg="$2"
    local iterations="${3:-1}"
    
    local start_time=$(date +%s.%N)
    
    for ((i=1; i<=iterations; i++)); do
        "$func_name" "$arg" >/dev/null
    done
    
    local end_time=$(date +%s.%N)
    local duration=$(echo "$end_time - $start_time" | bc -l)
    
    printf "Function %s: %.4f seconds (%d iterations)\n" "$func_name" "$duration" "$iterations"
}

echo "Performance comparison:"
benchmark_function "fibonacci" "10" 100
benchmark_function "fibonacci_memoized" "10" 100

# =============================================================================
# ADVANCED FUNCTION FEATURES
# =============================================================================

echo -e "\n=== ADVANCED FEATURES ==="

# Function with variable number of arguments
log_message() {
    local level="$1"
    shift
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $*"
}

# Function returning structured data
get_system_info() {
    local -A info
    info[hostname]=$(hostname)
    info[user]=$(whoami)
    info[shell]="$SHELL"
    info[pwd]=$(pwd)
    
    # Return as key=value pairs
    for key in "${!info[@]}"; do
        echo "$key=${info[$key]}"
    done
}

# Function with configuration
configure_function() {
    local config_file="$1"
    
    # Default configuration
    local debug=false
    local verbose=false
    local output_format="text"
    
    # Load configuration if file exists
    if [[ -f "$config_file" ]]; then
        source "$config_file"
    fi
    
    echo "Configuration loaded:"
    echo "  Debug: $debug"
    echo "  Verbose: $verbose"
    echo "  Output format: $output_format"
}

# Test advanced features
echo "Testing advanced features:"

log_message "INFO" "System started successfully"
log_message "ERROR" "Connection failed" "retrying in 5 seconds"

echo -e "\nSystem information:"
while IFS='=' read -r key value; do
    echo "  $key: $value"
done < <(get_system_info)

# Create config file
cat > function_config.sh << 'EOF'
debug=true
verbose=true
output_format="json"
EOF

configure_function "function_config.sh"

# =============================================================================
# FUNCTION TESTING AND VALIDATION
# =============================================================================

echo -e "\n=== FUNCTION TESTING ==="

# Simple test framework
test_function() {
    local test_name="$1"
    local expected="$2"
    local actual="$3"
    
    if [[ "$expected" == "$actual" ]]; then
        echo "✓ PASS: $test_name"
        return 0
    else
        echo "✗ FAIL: $test_name"
        echo "  Expected: $expected"
        echo "  Actual: $actual"
        return 1
    fi
}

# Test suite for math functions
run_math_tests() {
    local passed=0
    local total=0
    
    echo "Running math function tests:"
    
    ((total++))
    if test_function "Addition test" "15" "$(math_add 10 5)"; then
        ((passed++))
    fi
    
    ((total++))
    if test_function "Subtraction test" "5" "$(math_subtract 10 5)"; then
        ((passed++))
    fi
    
    ((total++))
    if test_function "Multiplication test" "50" "$(math_multiply 10 5)"; then
        ((passed++))
    fi
    
    ((total++))
    if test_function "Division test" "2" "$(math_divide 10 5)"; then
        ((passed++))
    fi
    
    echo "Test results: $passed/$total passed"
    
    if [[ $passed -eq $total ]]; then
        echo "All tests passed!"
        return 0
    else
        echo "Some tests failed!"
        return 1
    fi
}

run_math_tests

# =============================================================================
# FUNCTION DOCUMENTATION AND HELP
# =============================================================================

echo -e "\n=== FUNCTION DOCUMENTATION ==="

# Self-documenting function
calculate_circle_area() {
    # Function: calculate_circle_area
    # Description: Calculates the area of a circle given its radius
    # Parameters:
    #   $1 - radius (numeric value)
    # Returns:
    #   Prints the area to stdout
    # Exit codes:
    #   0 - Success
    #   1 - Invalid input
    # Example:
    #   area=$(calculate_circle_area 5)
    
    local radius="$1"
    
    # Show help if requested
    if [[ "$radius" == "-h" || "$radius" == "--help" ]]; then
        sed -n '/^[[:space:]]*#/p' "${BASH_SOURCE[0]}" | \
        sed -n "/Function: ${FUNCNAME[0]}/,/Example:/p" | \
        sed 's/^[[:space:]]*#[[:space:]]*//'
        return 0
    fi
    
    # Validate input
    if [[ ! "$radius" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        echo "Error: Invalid radius '$radius'" >&2
        return 1
    fi
    
    # Calculate area (π * r²)
    local area=$(echo "scale=2; 3.14159 * $radius * $radius" | bc)
    echo "$area"
}

# Function registry for help system
declare -A function_registry
function_registry[calculate_circle_area]="Calculates the area of a circle"
function_registry[math_add]="Adds two numbers"
function_registry[string_reverse]="Reverses a string"

show_available_functions() {
    echo "Available functions:"
    for func in "${!function_registry[@]}"; do
        echo "  $func - ${function_registry[$func]}"
    done
}

echo "Testing documentation system:"
calculate_circle_area --help
echo "Circle area (radius=5): $(calculate_circle_area 5)"

show_available_functions

# =============================================================================
# CLEANUP AND SUMMARY
# =============================================================================

# Clean up test files
rm -rf test_tree test_file.txt test_backup.txt* input_test.txt output_test.txt
rm -f processing.log function_config.sh

echo -e "\n=== FUNCTIONS SUMMARY ==="
echo "✓ Basic function syntax and calling"
echo "✓ Parameters and arguments"
echo "✓ Return values and exit codes"
echo "✓ Local vs global variables"
echo "✓ Recursive functions"
echo "✓ Advanced parameter handling"
echo "✓ Function libraries and modularization"
echo "✓ Error handling and validation"
echo "✓ Callbacks and hooks"
echo "✓ Performance optimization"
echo "✓ Advanced features"
echo "✓ Testing and validation"
echo "✓ Documentation and help systems"

echo "Script completed successfully!"

