#!/bin/bash
# =============================================================================
# DEBUGGING AND BEST PRACTICES - Complete Guide
# =============================================================================

# This script demonstrates debugging techniques and best practices for bash scripting
# Author: Script Tutorial
# Date: $(date +%Y-%m-%d)
# Version: 1.0

# =============================================================================
# SCRIPT OPTIONS AND DEBUGGING FLAGS
# =============================================================================

echo "=== SCRIPT OPTIONS AND DEBUGGING FLAGS ==="

# Demonstrate different script options
demo_script_options() {
    echo "Demonstrating bash script options:"
    
    # Save current options
    local original_options="$-"
    echo "Original shell options: $original_options"
    
    echo -e "\n1. set -x (xtrace) - Print commands before execution:"
    echo "   Enabling set -x..."
    set -x
    echo "This command will show its execution"
    local test_var="hello world"
    echo "Variable value: $test_var"
    set +x  # Disable xtrace
    echo "   Disabled set -x"
    
    echo -e "\n2. set -e (errexit) - Exit on command failure:"
    echo "   Without set -e:"
    false || echo "   Command failed but script continues"
    
    echo "   With set -e (in subshell to prevent script exit):"
    (
        set -e
        echo "   About to run false command..."
        false || echo "   This won't be reached"
        echo "   This line won't execute either"
    ) || echo "   Subshell exited due to set -e"
    
    echo -e "\n3. set -u (nounset) - Error on undefined variables:"
    echo "   Without set -u:"
    echo "   Undefined variable: ${undefined_var:-'(empty)'}"
    
    echo "   With set -u (in subshell):"
    (
        set -u
        echo "   About to access undefined variable..."
        echo "   Value: $undefined_var_test"
    ) 2>&1 || echo "   Error caught: undefined variable"
    
    echo -e "\n4. set -o pipefail - Fail on pipe command failure:"
    echo "   Without pipefail:"
    false | echo "   Pipe continues despite false"
    echo "   Exit code: $?"
    
    echo "   With pipefail:"
    set -o pipefail
    false | echo "   Pipe with pipefail" || echo "   Pipe failed as expected"
    set +o pipefail
    
    echo -e "\n5. Combined options (common pattern):"
    echo "   set -euo pipefail is a common combination for strict error handling"
}

demo_script_options

# =============================================================================
# ADVANCED DEBUGGING TECHNIQUES
# =============================================================================

echo -e "\n=== ADVANCED DEBUGGING TECHNIQUES ==="

# Debug function with multiple levels
debug_log() {
    local level="$1"
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Only show debug messages if DEBUG is set
    case "${DEBUG_LEVEL:-0}" in
        3) [[ "$level" =~ ^(ERROR|WARN|INFO|DEBUG)$ ]] && echo "[$timestamp] [$level] $message" >&2 ;;
        2) [[ "$level" =~ ^(ERROR|WARN|INFO)$ ]] && echo "[$timestamp] [$level] $message" >&2 ;;
        1) [[ "$level" =~ ^(ERROR|WARN)$ ]] && echo "[$timestamp] [$level] $message" >&2 ;;
        0) [[ "$level" == "ERROR" ]] && echo "[$timestamp] [$level] $message" >&2 ;;
    esac
}

# Function tracing
trace_function() {
    local func_name="${FUNCNAME[1]}"
    local line_no="${BASH_LINENO[0]}"
    local file_name="${BASH_SOURCE[1]}"
    
    debug_log "DEBUG" "Entering function: $func_name at $file_name:$line_no"
}

# Demonstrate debugging levels
demo_debug_levels() {
    echo "Demonstrating debug levels:"
    
    for level in 0 1 2 3; do
        echo -e "\nDEBUG_LEVEL=$level:"
        DEBUG_LEVEL=$level
        
        debug_log "ERROR" "This is an error message"
        debug_log "WARN" "This is a warning message"
        debug_log "INFO" "This is an info message"
        debug_log "DEBUG" "This is a debug message"
    done
}

demo_debug_levels

# Function with tracing
traced_function() {
    trace_function
    debug_log "INFO" "Executing traced function with args: $*"
    
    local result=$((${1:-0} + ${2:-0}))
    debug_log "DEBUG" "Calculation result: $result"
    
    echo "$result"
}

echo -e "\nTesting function tracing:"
DEBUG_LEVEL=3
traced_function 5 10

# =============================================================================
# ERROR HANDLING PATTERNS
# =============================================================================

echo -e "\n=== ERROR HANDLING PATTERNS ==="

# Basic error handling
basic_error_handling() {
    echo "1. Basic error handling patterns:"
    
    # Pattern 1: Check return code explicitly
    echo "   Pattern 1: Explicit return code checking"
    if ls /nonexistent_directory 2>/dev/null; then
        echo "   Directory exists"
    else
        local exit_code=$?
        echo "   Directory doesn't exist (exit code: $exit_code)"
    fi
    
    # Pattern 2: Using || for error handling
    echo -e "\n   Pattern 2: Using || for error handling"
    ls /nonexistent_directory 2>/dev/null || {
        echo "   Command failed, executing error handler"
        echo "   Could perform cleanup or logging here"
    }
    
    # Pattern 3: Using && for success handling
    echo -e "\n   Pattern 3: Using && for success handling"
    echo "test" > temp_file && {
        echo "   File created successfully"
        rm temp_file
    }
}

# Advanced error handling with cleanup
advanced_error_handling() {
    echo -e "\n2. Advanced error handling with cleanup:"
    
    # Error handler function
    error_handler() {
        local exit_code=$?
        local line_no=$1
        
        echo "ERROR: Command failed with exit code $exit_code at line $line_no" >&2
        
        # Cleanup
        cleanup_resources
        
        # Exit with error
        exit $exit_code
    }
    
    # Cleanup function
    cleanup_resources() {
        echo "Performing cleanup..."
        # Remove temporary files
        rm -f temp_* 2>/dev/null || true
        # Kill background processes
        jobs -p | xargs -r kill 2>/dev/null || true
        echo "Cleanup completed"
    }
    
    # Set up error trap (in subshell to prevent script exit)
    (
        trap 'error_handler $LINENO' ERR
        set -e
        
        echo "   Creating temporary file..."
        echo "test data" > temp_error_test
        
        echo "   Simulating error..."
        false  # This will trigger the error handler
        
        echo "   This line won't execute"
    ) || echo "   Error handling completed"
}

basic_error_handling
advanced_error_handling

# =============================================================================
# RETURN CODE CHECKING BEST PRACTICES
# =============================================================================

echo -e "\n=== RETURN CODE CHECKING BEST PRACTICES ==="

# Function that demonstrates proper return code usage
demo_return_codes() {
    echo "Return code best practices:"
    
    # Function with meaningful return codes
    validate_file() {
        local file="$1"
        
        if [[ -z "$file" ]]; then
            echo "Error: No file specified" >&2
            return 1  # Invalid argument
        fi
        
        if [[ ! -e "$file" ]]; then
            echo "Error: File '$file' does not exist" >&2
            return 2  # File not found
        fi
        
        if [[ ! -r "$file" ]]; then
            echo "Error: File '$file' is not readable" >&2
            return 3  # Permission denied
        fi
        
        if [[ ! -s "$file" ]]; then
            echo "Warning: File '$file' is empty" >&2
            return 4  # File empty
        fi
        
        echo "File '$file' is valid"
        return 0  # Success
    }
    
    # Test the function with different scenarios
    echo -e "\n1. Testing return codes:"
    
    # Create test file
    echo "test content" > valid_test_file
    touch empty_test_file
    
    # Test cases
    local test_cases=(
        ""  # No argument
        "nonexistent_file"  # File doesn't exist
        "valid_test_file"   # Valid file
        "empty_test_file"   # Empty file
    )
    
    for test_case in "${test_cases[@]}"; do
        echo "   Testing: '${test_case:-'(empty)'}'"
        validate_file "$test_case"
        local result=$?
        
        case $result in
            0) echo "     Result: SUCCESS" ;;
            1) echo "     Result: INVALID ARGUMENT" ;;
            2) echo "     Result: FILE NOT FOUND" ;;
            3) echo "     Result: PERMISSION DENIED" ;;
            4) echo "     Result: FILE EMPTY" ;;
            *) echo "     Result: UNKNOWN ERROR ($result)" ;;
        esac
        echo
    done
    
    # Cleanup
    rm -f valid_test_file empty_test_file
}

# Demonstrate command chaining with proper error handling
demo_command_chaining() {
    echo "2. Command chaining with error handling:"
    
    # Bad example (without proper error handling)
    echo "   Bad example (errors not handled):"
    echo "mkdir temp_dir && cd temp_dir && touch file.txt && ls -la"
    mkdir temp_dir && cd temp_dir && touch file.txt && ls -la
    cd .. && rm -rf temp_dir
    
    # Good example (with proper error handling)
    echo -e "\n   Good example (with error handling):"
    create_and_populate_dir() {
        local dir_name="$1"
        
        # Create directory
        if ! mkdir "$dir_name" 2>/dev/null; then
            echo "Failed to create directory '$dir_name'" >&2
            return 1
        fi
        
        # Change to directory
        if ! cd "$dir_name"; then
            echo "Failed to change to directory '$dir_name'" >&2
            rmdir "$dir_name" 2>/dev/null  # Cleanup
            return 2
        fi
        
        # Create file
        if ! touch file.txt; then
            echo "Failed to create file" >&2
            cd ..
            rmdir "$dir_name" 2>/dev/null  # Cleanup
            return 3
        fi
        
        # List contents
        ls -la
        
        # Return to original directory
        cd ..
        
        return 0
    }
    
    if create_and_populate_dir "good_temp_dir"; then
        echo "   Directory operations completed successfully"
        rm -rf good_temp_dir
    else
        echo "   Directory operations failed"
    fi
}

demo_return_codes
demo_command_chaining

# =============================================================================
# WRITING READABLE CODE AND COMMENTS
# =============================================================================

echo -e "\n=== WRITING READABLE CODE AND COMMENTS ==="

# Demonstrate good coding practices
demo_readable_code() {
    echo "Readable code best practices:"
    
    echo -e "\n1. Meaningful variable names:"
    
    # Bad example
    echo "   Bad example:"
    echo '   f="/tmp/data.txt"'
    echo '   n=$(wc -l < "$f")'
    echo '   echo "Lines: $n"'
    
    # Good example
    echo -e "\n   Good example:"
    echo '   input_file="/tmp/data.txt"'
    echo '   line_count=$(wc -l < "$input_file")'
    echo '   echo "Total lines in file: $line_count"'
    
    echo -e "\n2. Function documentation:"
    
    # Well-documented function
    process_log_file() {
        # Purpose: Process a log file and extract error entries
        # Arguments:
        #   $1 - Path to the log file
        #   $2 - Output file for errors (optional, defaults to stderr)
        # Returns:
        #   0 - Success
        #   1 - Invalid arguments
        #   2 - File processing error
        # Example:
        #   process_log_file "/var/log/app.log" "/tmp/errors.txt"
        
        local log_file="${1:?Log file path is required}"
        local error_file="${2:-/dev/stderr}"
        
        # Validate input file
        if [[ ! -f "$log_file" ]]; then
            echo "Error: Log file '$log_file' not found" >&2
            return 1
        fi
        
        # Process the file
        if ! grep -i "error\|warning\|critical" "$log_file" > "$error_file"; then
            echo "Error: Failed to process log file" >&2
            return 2
        fi
        
        echo "Log processing completed successfully"
        return 0
    }
    
    echo "   Example of well-documented function created"
    
    echo -e "\n3. Code organization:"
    
    # Demonstrate good code structure
    organize_code_example() {
        # Constants (uppercase with descriptive names)
        readonly MAX_RETRIES=3
        readonly TIMEOUT_SECONDS=30
        readonly LOG_LEVEL_ERROR=1
        readonly LOG_LEVEL_INFO=2
        readonly LOG_LEVEL_DEBUG=3
        
        # Configuration variables
        local config_file="${CONFIG_FILE:-/etc/myapp.conf}"
        local log_level="${LOG_LEVEL:-$LOG_LEVEL_INFO}"
        local output_dir="${OUTPUT_DIR:-/tmp}"
        
        # Input validation
        if [[ $# -lt 1 ]]; then
            echo "Usage: ${FUNCNAME[0]} <input_file> [options]" >&2
            return 1
        fi
        
        local input_file="$1"
        shift  # Remove processed argument
        
        # Main logic with clear sections
        echo "Starting processing with:"
        echo "  Input file: $input_file"
        echo "  Config file: $config_file"
        echo "  Output directory: $output_dir"
        echo "  Log level: $log_level"
        
        return 0
    }
    
    # Create test file and demonstrate
    echo "test data" > /tmp/test_input.txt
    organize_code_example "/tmp/test_input.txt"
    rm -f /tmp/test_input.txt
}

demo_readable_code

# =============================================================================
# COMMENT BEST PRACTICES
# =============================================================================

echo -e "\n=== COMMENT BEST PRACTICES ==="

demo_comment_practices() {
    echo "Comment best practices:"
    
    echo -e "\n1. Header comments (already shown at top of script)"
    
    echo -e "\n2. Function comments (shown in previous example)"
    
    echo -e "\n3. Inline comments - explain WHY, not WHAT:"
    
    # Good inline comments
    calculate_checksum() {
        local file="$1"
        
        # Use SHA256 for better security than MD5
        local checksum=$(sha256sum "$file" | cut -d' ' -f1)
        
        # Store in uppercase for consistency with legacy systems
        echo "${checksum^^}"
    }
    
    echo -e "\n4. Section comments for code organization:"
    
    complex_function_example() {
        local input="$1"
        
        # ===== INPUT VALIDATION =====
        if [[ -z "$input" ]]; then
            return 1
        fi
        
        # ===== DATA PREPROCESSING =====
        local cleaned_input=$(echo "$input" | tr -d '[:space:]')
        
        # ===== MAIN PROCESSING =====
        local result=$(echo "$cleaned_input" | wc -c)
        
        # ===== OUTPUT FORMATTING =====
        printf "Processed length: %d characters\n" "$result"
        
        return 0
    }
    
    echo "   Example function with section comments created"
    
    echo -e "\n5. TODO and FIXME comments:"
    
    example_with_todos() {
        # TODO: Add input validation for email format
        # FIXME: Handle edge case when file is empty
        # NOTE: This function requires bash 4.0+
        # HACK: Temporary workaround for upstream bug #1234
        
        echo "Function with various comment types"
    }
    
    echo "   Example with TODO/FIXME comments created"
}

demo_comment_practices

# =============================================================================
# SHELLCHECK INTEGRATION
# =============================================================================

echo -e "\n=== SHELLCHECK INTEGRATION ==="

demo_shellcheck() {
    echo "ShellCheck tool demonstration:"
    
    # Check if shellcheck is available
    if ! command -v shellcheck >/dev/null 2>&1; then
        echo "ShellCheck is not installed. Install with:"
        echo "  Ubuntu/Debian: sudo apt-get install shellcheck"
        echo "  macOS: brew install shellcheck"
        echo "  Or download from: https://github.com/koalaman/shellcheck"
        return 1
    fi
    
    echo "ShellCheck is available: $(shellcheck --version | head -1)"
    
    # Create example script with common issues
    cat > bad_example.sh << 'EOF'
#!/bin/bash

# This script has intentional issues for shellcheck demonstration

echo "Starting script..."

# Issue: Unquoted variable
file=$1
echo Processing file: $file

# Issue: Useless use of cat
lines=$(cat $file | wc -l)

# Issue: Unused variable
unused_var="hello"

# Issue: Potential word splitting
for f in $(ls *.txt); do
    echo "File: $f"
done

# Issue: Comparing with = instead of ==
if [ $lines = 0 ]; then
    echo "File is empty"
fi

# Issue: Missing quotes in test
if [ -f $file ]; then
    echo "File exists"
fi

echo "Script completed"
EOF
    
    echo -e "\n1. Running ShellCheck on problematic script:"
    echo "shellcheck bad_example.sh"
    shellcheck bad_example.sh || true
    
    # Create corrected version
    cat > good_example.sh << 'EOF'
#!/bin/bash

# This script demonstrates shellcheck-compliant code

set -euo pipefail

echo "Starting script..."

# Fixed: Quoted variable with validation
file="${1:?Input file is required}"
echo "Processing file: $file"

# Fixed: Direct command without useless cat
lines=$(wc -l < "$file")

# Fixed: Variable is used (or removed if truly unused)
greeting="hello"
echo "$greeting world"

# Fixed: Use array and proper quoting
mapfile -t txt_files < <(find . -name "*.txt" -print0 | xargs -0 -I {} basename {})
for f in "${txt_files[@]}"; do
    echo "File: $f"
done

# Fixed: Use proper comparison operator
if [[ $lines -eq 0 ]]; then
    echo "File is empty"
fi

# Fixed: Quoted variable in test
if [[ -f "$file" ]]; then
    echo "File exists"
fi

echo "Script completed"
EOF
    
    echo -e "\n2. Running ShellCheck on corrected script:"
    echo "shellcheck good_example.sh"
    if shellcheck good_example.sh; then
        echo "✓ No issues found in corrected script"
    fi
    
    # Demonstrate shellcheck directives
    cat > shellcheck_directives.sh << 'EOF'
#!/bin/bash

# Disable specific warnings with directives

# shellcheck disable=SC2034  # Unused variable (intentional)
config_version="1.0"

# shellcheck disable=SC2086  # Intentional word splitting
words="one two three"
echo $words

# shellcheck source=/dev/null  # External source file
source /etc/default/myapp 2>/dev/null || true

echo "Script with directives"
EOF
    
    echo -e "\n3. Using ShellCheck directives:"
    echo "shellcheck shellcheck_directives.sh"
    shellcheck shellcheck_directives.sh || true
    
    # Cleanup
    rm -f bad_example.sh good_example.sh shellcheck_directives.sh
}

demo_shellcheck

# =============================================================================
# TESTING AND VALIDATION
# =============================================================================

echo -e "\n=== TESTING AND VALIDATION ==="

demo_testing_practices() {
    echo "Testing and validation practices:"
    
    # Simple test framework
    run_test() {
        local test_name="$1"
        local expected="$2"
        local actual="$3"
        
        if [[ "$expected" == "$actual" ]]; then
            echo "✓ PASS: $test_name"
            return 0
        else
            echo "✗ FAIL: $test_name"
            echo "  Expected: '$expected'"
            echo "  Actual:   '$actual'"
            return 1
        fi
    }
    
    # Function to test
    add_numbers() {
        local a="${1:-0}"
        local b="${2:-0}"
        echo $((a + b))
    }
    
    # Test cases
    echo -e "\n1. Unit testing example:"
    
    local passed=0
    local total=0
    
    # Test 1: Basic addition
    ((total++))
    if run_test "Basic addition" "5" "$(add_numbers 2 3)"; then
        ((passed++))
    fi
    
    # Test 2: Zero handling
    ((total++))
    if run_test "Zero handling" "3" "$(add_numbers 3 0)"; then
        ((passed++))
    fi
    
    # Test 3: Negative numbers
    ((total++))
    if run_test "Negative numbers" "-1" "$(add_numbers 2 -3)"; then
        ((passed++))
    fi
    
    # Test 4: No arguments
    ((total++))
    if run_test "No arguments" "0" "$(add_numbers)"; then
        ((passed++))
    fi
    
    echo -e "\nTest Results: $passed/$total tests passed"
    
    echo -e "\n2. Input validation testing:"
    
    # Function with validation
    validate_email_format() {
        local email="$1"
        local pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
        
        if [[ $email =~ $pattern ]]; then
            echo "valid"
        else
            echo "invalid"
        fi
    }
    
    # Email validation tests
    local email_tests=(
        "user@example.com:valid"
        "invalid.email:invalid"
        "user@domain:invalid"
        "user.name+tag@example.co.uk:valid"
        "@example.com:invalid"
    )
    
    for test_case in "${email_tests[@]}"; do
        local email="${test_case%:*}"
        local expected="${test_case#*:}"
        local actual=$(validate_email_format "$email")
        
        run_test "Email validation: $email" "$expected" "$actual"
    done
}

demo_testing_practices

# =============================================================================
# PERFORMANCE MONITORING AND PROFILING
# =============================================================================

echo -e "\n=== PERFORMANCE MONITORING ==="

demo_performance_monitoring() {
    echo "Performance monitoring techniques:"
    
    # Time measurement function
    time_function() {
        local func_name="$1"
        shift
        
        local start_time=$(date +%s.%N)
        "$@"
        local end_time=$(date +%s.%N)
        
        local duration=$(echo "$end_time - $start_time" | bc -l 2>/dev/null || echo "N/A")
        echo "Function '$func_name' took: ${duration}s"
    }
    
    # Memory usage monitoring
    monitor_memory() {
        local process_name="$1"
        local pid="$$"
        
        if command -v ps >/dev/null 2>&1; then
            local memory_kb=$(ps -o rss= -p "$pid" 2>/dev/null | tr -d ' ')
            local memory_mb=$((memory_kb / 1024))
            echo "Memory usage for $process_name: ${memory_mb}MB"
        fi
    }
    
    # Example functions to profile
    slow_function() {
        local n="${1:-1000}"
        local sum=0
        for ((i=1; i<=n; i++)); do
            sum=$((sum + i))
        done
        echo "Sum: $sum"
    }
    
    fast_function() {
        local n="${1:-1000}"
        local sum=$(( n * (n + 1) / 2 ))
        echo "Sum: $sum"
    }
    
    echo -e "\n1. Timing function execution:"
    time_function "slow_function" slow_function 1000
    time_function "fast_function" fast_function 1000
    
    echo -e "\n2. Memory monitoring:"
    monitor_memory "current_script"
    
    echo -e "\n3. Built-in time command:"
    echo "Using bash built-in 'time':"
    time slow_function 500 >/dev/null
}

demo_performance_monitoring

# =============================================================================
# LOGGING BEST PRACTICES
# =============================================================================

echo -e "\n=== LOGGING BEST PRACTICES ==="

demo_logging_practices() {
    echo "Logging best practices:"
    
    # Logging configuration
    readonly LOG_FILE="${LOG_FILE:-/tmp/script.log}"
    readonly LOG_LEVEL="${LOG_LEVEL:-INFO}"
    
    # Logging function
    log_message() {
        local level="$1"
        shift
        local message="$*"
        local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        local caller="${BASH_SOURCE[2]##*/}:${BASH_LINENO[1]}"
        
        # Log levels: ERROR=1, WARN=2, INFO=3, DEBUG=4
        local level_num
        case "$level" in
            ERROR) level_num=1 ;;
            WARN)  level_num=2 ;;
            INFO)  level_num=3 ;;
            DEBUG) level_num=4 ;;
            *) level_num=3; level="INFO" ;;
        esac
        
        local current_level_num
        case "$LOG_LEVEL" in
            ERROR) current_level_num=1 ;;
            WARN)  current_level_num=2 ;;
            INFO)  current_level_num=3 ;;
            DEBUG) current_level_num=4 ;;
            *) current_level_num=3 ;;
        esac
        
        # Only log if message level is <= current log level
        if [[ $level_num -le $current_level_num ]]; then
            local log_entry="[$timestamp] [$level] [$caller] $message"
            
            # Write to log file and stderr for errors/warnings
            echo "$log_entry" >> "$LOG_FILE"
            
            if [[ "$level" =~ ^(ERROR|WARN)$ ]]; then
                echo "$log_entry" >&2
            else
                echo "$log_entry"
            fi
        fi
    }
    
    # Convenience functions
    log_error() { log_message "ERROR" "$@"; }
    log_warn()  { log_message "WARN" "$@"; }
    log_info()  { log_message "INFO" "$@"; }
    log_debug() { log_message "DEBUG" "$@"; }
    
    echo -e "\n1. Structured logging example:"
    
    # Clear log file
    > "$LOG_FILE"
    
    log_info "Script started"
    log_debug "Debug information"
    log_warn "This is a warning"
    log_error "This is an error"
    
    echo -e "\n2. Log file contents:"
    cat "$LOG_FILE"
    
    # Cleanup
    rm -f "$LOG_FILE"
}

demo_logging_practices

# =============================================================================
# SECURITY BEST PRACTICES
# =============================================================================

echo -e "\n=== SECURITY BEST PRACTICES ==="

demo_security_practices() {
    echo "Security best practices:"
    
    echo -e "\n1. Input sanitization:"
    
    # Safe input handling
    sanitize_input() {
        local input="$1"
        
        # Remove dangerous characters
        local sanitized=$(echo "$input" | tr -d '`$(){}[]|&;<>?*')
        
        # Limit length
        sanitized="${sanitized:0:100}"
        
        echo "$sanitized"
    }
    
    # Test sanitization
    local dangerous_input='$(rm -rf /); echo "safe"'
    local safe_input=$(sanitize_input "$dangerous_input")
    echo "   Original: $dangerous_input"
    echo "   Sanitized: $safe_input"
    
    echo -e "\n2. Secure temporary files:"
    
    create_secure_temp() {
        local temp_file
        
        # Use mktemp for secure temporary file creation
        temp_file=$(mktemp) || {
            echo "Failed to create temporary file" >&2
            return 1
        }
        
        # Set restrictive permissions
        chmod 600 "$temp_file"
        
        echo "$temp_file"
    }
    
    # Demonstrate secure temp file
    local secure_temp=$(create_secure_temp)
    echo "   Created secure temp file: $secure_temp"
    ls -la "$secure_temp"
    rm -f "$secure_temp"
    
    echo -e "\n3. Path validation:"
    
    validate_path() {
        local path="$1"
        local base_dir="${2:-/tmp}"
        
        # Resolve to absolute path
        local abs_path=$(realpath "$path" 2>/dev/null) || {
            echo "Invalid path: $path" >&2
            return 1
        }
        
        # Check if path is within allowed directory
        if [[ "$abs_path" != "$base_dir"* ]]; then
            echo "Path outside allowed directory: $abs_path" >&2
            return 1
        fi
        
        echo "Valid path: $abs_path"
        return 0
    }
    
    # Test path validation
    echo "   Testing path validation:"
    validate_path "/tmp/safe_file" "/tmp" || true
    validate_path "../../../etc/passwd" "/tmp" || true
}

demo_security_practices

# =============================================================================
# CLEANUP AND SUMMARY
# =============================================================================

echo -e "\n=== CLEANUP ==="

# Cleanup any remaining test files
rm -f temp_* 2>/dev/null || true

echo -e "\n=== DEBUGGING AND BEST PRACTICES SUMMARY ==="
echo "✓ Script options: set -x, set -e, set -u, set -o pipefail"
echo "✓ Advanced debugging techniques and logging levels"
echo "✓ Error handling patterns and return codes"
echo "✓ Writing readable code with proper comments"
echo "✓ ShellCheck integration and code quality"
echo "✓ Testing and validation practices"
echo "✓ Performance monitoring and profiling"
echo "✓ Logging best practices"
echo "✓ Security considerations"

echo -e "\nKey takeaways:"
echo "• Always use 'set
