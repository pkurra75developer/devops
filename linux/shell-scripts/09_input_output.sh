#!/bin/bash
# =============================================================================
# INPUT/OUTPUT AND REDIRECTION - Complete Guide
# =============================================================================

set -euo pipefail

# =============================================================================
# BASIC OUTPUT METHODS
# =============================================================================

echo "=== BASIC OUTPUT METHODS ==="

# Standard echo
echo "Basic echo output"

# Echo with options
echo -n "No newline: "
echo "continues here"

echo -e "Escape sequences:\n\tTab and newline"

# Printf for formatted output
printf "Formatted output: %s is %d years old\n" "Alice" 30
printf "Decimal: %d, Hex: %x, Octal: %o\n" 255 255 255
printf "Float: %.2f, Scientific: %.2e\n" 3.14159 1234.5

# Here strings and here documents
cat << EOF
This is a here document
Multiple lines
Variables work: $USER
Commands work: $(date)
EOF

# Colored output
echo -e "\033[31mRed text\033[0m"
echo -e "\033[32mGreen text\033[0m"
echo -e "\033[33mYellow text\033[0m"
echo -e "\033[34mBlue text\033[0m"

# Using tput for colors (more portable)
if command -v tput >/dev/null 2>&1; then
    red=$(tput setaf 1)
    green=$(tput setaf 2)
    yellow=$(tput setaf 3)
    blue=$(tput setaf 4)
    reset=$(tput sgr0)
    
    echo "${red}Red with tput${reset}"
    echo "${green}Green with tput${reset}"
    echo "${yellow}Yellow with tput${reset}"
    echo "${blue}Blue with tput${reset}"
fi

# =============================================================================
# STANDARD INPUT METHODS
# =============================================================================

echo -e "\n=== INPUT METHODS ==="

# Basic read
echo "Enter your name (or press Enter for default):"
read -p "Name: " user_name
user_name=${user_name:-"Anonymous"}
echo "Hello, $user_name!"

# Read with timeout
echo "Quick! Enter something within 3 seconds:"
if read -t 3 -p "Input: " quick_input; then
    echo "You entered: $quick_input"
else
    echo "Too slow! Timeout reached."
fi

# Silent read (for passwords)
echo "Enter a password (input will be hidden):"
read -s -p "Password: " password
echo  # New line after hidden input
echo "Password length: ${#password}"

# Read single character
echo "Press any key to continue..."
read -n 1 -s key
echo "You pressed a key!"

# Read into array
echo "Enter multiple words (space-separated):"
read -a word_array -p "Words: "
echo "You entered ${#word_array[@]} words:"
for i in "${!word_array[@]}"; do
    echo "  Word $((i+1)): ${word_array[i]}"
done

# Read with custom delimiter
echo "Enter items separated by commas:"
IFS=',' read -a items -p "Items: "
echo "Items entered:"
for item in "${items[@]}"; do
    echo "  - $(echo "$item" | xargs)"  # xargs trims whitespace
done

# =============================================================================
# FILE DESCRIPTORS AND REDIRECTION
# =============================================================================

echo -e "\n=== FILE DESCRIPTORS AND REDIRECTION ==="

# Standard file descriptors
echo "Standard output (fd 1)"
echo "Standard error (fd 2)" >&2

# Create test files for redirection examples
echo "Creating test files for redirection..."

# Output redirection
echo "This goes to a file" > output.txt
echo "This appends to the file" >> output.txt
echo "File contents:"
cat output.txt

# Error redirection
ls nonexistent_file 2> error.log 2>/dev/null || true
echo "Error log contents:"
cat error.log 2>/dev/null || echo "No errors logged"

# Redirect both stdout and stderr
{
    echo "Standard output"
    echo "Standard error" >&2
} > combined.log 2>&1

echo "Combined log contents:"
cat combined.log

# Separate stdout and stderr
{
    echo "This is stdout"
    echo "This is stderr" >&2
} > stdout.log 2> stderr.log

echo "Stdout file:"
cat stdout.log
echo "Stderr file:"
cat stderr.log

# Discard output
echo "This will be discarded" > /dev/null
echo "This error will be discarded" 2> /dev/null

# Input redirection
cat > input_test.txt << EOF
Line 1
Line 2
Line 3
EOF

echo "Reading from file with input redirection:"
while read line; do
    echo "Read: $line"
done < input_test.txt

# =============================================================================
# ADVANCED REDIRECTION TECHNIQUES
# =============================================================================

echo -e "\n=== ADVANCED REDIRECTION ==="

# Here documents with variable substitution
name="World"
cat << EOF > greeting.txt
Hello, $name!
Today is $(date)
EOF

echo "Greeting file contents:"
cat greeting.txt

# Here documents without variable substitution
cat << 'EOF' > literal.txt
Hello, $name!
Today is $(date)
EOF

echo "Literal file contents:"
cat literal.txt

# Here strings
grep "Line" <<< "Line 1
Line 2
Not a line"

# Process substitution
echo "Process substitution examples:"

# Compare output of two commands
if command -v diff >/dev/null 2>&1; then
    diff <(echo -e "a\nb\nc") <(echo -e "a\nb\nd") || true
fi

# Use command output as input file
while read line; do
    echo "Process: $line"
done < <(echo -e "item1\nitem2\nitem3")

# Multiple input sources
{
    echo "From echo"
    cat input_test.txt
} | while read line; do
    echo "Combined: $line"
done

# =============================================================================
# PIPES AND PIPELINES
# =============================================================================

echo -e "\n=== PIPES AND PIPELINES ==="

# Basic pipes
echo "Basic pipe example:"
echo -e "apple\nbanana\ncherry" | sort | head -2

# Multiple pipes
echo "Multiple pipes:"
ps aux | grep bash | awk '{print $2, $11}' | head -3

# Pipe with error handling
echo "Pipe with error handling:"
if echo -e "line1\nline2\nline3" | grep "line2" > /dev/null; then
    echo "Found line2 in piped input"
fi

# Tee command (split output)
echo "Using tee to split output:"
echo -e "data1\ndata2\ndata3" | tee pipe_output.txt | wc -l
echo "Tee output file:"
cat pipe_output.txt

# Named pipes (FIFOs)
echo "Named pipes example:"
mkfifo named_pipe 2>/dev/null || true

# Write to named pipe in background
{
    sleep 1
    echo "Message through named pipe" > named_pipe
} &

# Read from named pipe
if read message < named_pipe; then
    echo "Received: $message"
fi

# Cleanup named pipe
rm -f named_pipe

# =============================================================================
# EXEC AND FILE DESCRIPTOR MANIPULATION
# =============================================================================

echo -e "\n=== EXEC AND FILE DESCRIPTORS ==="

# Open file descriptor for reading
exec 3< input_test.txt
echo "Reading from fd 3:"
read line1 <&3
read line2 <&3
echo "Line 1: $line1"
echo "Line 2: $line2"
exec 3<&-  # Close fd 3

# Open file descriptor for writing
exec 4> fd_output.txt
echo "Writing to fd 4"
echo "Line written to fd 4" >&4
echo "Another line to fd 4" >&4
exec 4>&-  # Close fd 4

echo "Contents written via fd 4:"
cat fd_output.txt

# Duplicate file descriptors
exec 5>&1  # Save stdout
exec 1> fd_redirect.txt  # Redirect stdout to file
echo "This goes to the file"
echo "This also goes to the file"
exec 1>&5  # Restore stdout
exec 5>&-  # Close fd 5

echo "Output was redirected to file:"
cat fd_redirect.txt

# Swap stdout and stderr
exec 6>&1 7>&2  # Save original stdout and stderr
exec 1>&2 2>&6  # Swap them
echo "This appears as error"
echo "This also appears as error"
exec 1>&6 2>&7  # Restore original
exec 6>&- 7>&-  # Close temporary descriptors

# =============================================================================
# LOGGING AND OUTPUT FORMATTING
# =============================================================================

echo -e "\n=== LOGGING AND FORMATTING ==="

# Logging function
log() {
    local level="$1"
    shift
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $*" | tee -a application.log
}

# Test logging
log "INFO" "Application started"
log "WARN" "This is a warning"
log "ERROR" "This is an error"

echo "Log file contents:"
cat application.log

# Formatted output functions
print_header() {
    local title="$1"
    local width="${2:-50}"
    local char="${3:-=}"
    
    printf "%*s\n" "$width" | tr ' ' "$char"
    printf "%s\n" "$title"
    printf "%*s\n" "$width" | tr ' ' "$char"
}

print_table_row() {
    printf "| %-15s | %-10s | %-8s |\n" "$1" "$2" "$3"
}

# Demonstrate formatted output
print_header "User Information" 40 "-"
print_table_row "Name" "Age" "City"
print_table_row "---------------" "----------" "--------"
print_table_row "Alice" "30" "NYC"
print_table_row "Bob" "25" "LA"
print_table_row "Charlie" "35" "Chicago"

# Progress indicators
show_progress() {
    local current="$1"
    local total="$2"
    local width="${3:-50}"
    
    local percentage=$((current * 100 / total))
    local filled=$((current * width / total))
    local empty=$((width - filled))
    
    printf "\rProgress: ["
    printf "%*s" "$filled" | tr ' ' '#'
    printf "%*s" "$empty" | tr ' ' '-'
    printf "] %d%% (%d/%d)" "$percentage" "$current" "$total"
}

echo -e "\nProgress bar example:"
for i in $(seq 0 10); do
    show_progress "$i" 10
    sleep 0.2
done
echo  # New line after progress bar

# =============================================================================
# INTERACTIVE INPUT AND MENUS
# =============================================================================

echo -e "\n=== INTERACTIVE INPUT ==="

# Menu system
show_menu() {
    echo "=== Main Menu ==="
    echo "1. Option 1"
    echo "2. Option 2"
    echo "3. Option 3"
    echo "4. Exit"
    echo "================="
}

# Simulate menu interaction (non-interactive for script)
simulate_menu() {
    local choices=("1" "2" "invalid" "4")
    
    for choice in "${choices[@]}"; do
        echo "Simulating choice: $choice"
        
        case "$choice" in
            1)
                echo "  You selected Option 1"
                ;;
            2)
                echo "  You selected Option 2"
                ;;
            3)
                echo "  You selected Option 3"
                ;;
            4)
                echo "  Exiting..."
                break
                ;;
            *)
                echo "  Invalid choice: $choice"
                ;;
        esac
        echo
    done
}

show_menu
simulate_menu

# Input validation
validate_input() {
    local input="$1"
    local type="$2"
    
    case "$type" in
        "number")
            if [[ "$input" =~ ^[0-9]+$ ]]; then
                echo "Valid number: $input"
                return 0
            else
                echo "Invalid number: $input"
                return 1
            fi
            ;;
        "email")
            if [[ "$input" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
                echo "Valid email: $input"
                return 0
            else
                echo "Invalid email: $input"
                return 1
            fi
            ;;
        "phone")
            if [[ "$input" =~ ^[0-9]{3}-[0-9]{3}-[0-9]{4}$ ]]; then
                echo "Valid phone: $input"
                return 0
            else
                echo "Invalid phone format. Use XXX-XXX-XXXX"
                return 1
            fi
            ;;
    esac
}

# Test input validation
echo "Testing input validation:"
validate_input "123" "number"
validate_input "abc" "number"
validate_input "user@example.com" "email"
validate_input "invalid-email" "email"
validate_input "555-123-4567" "phone"
validate_input "555-1234" "phone"

# =============================================================================
# COMMAND LINE ARGUMENT PROCESSING
# =============================================================================

echo -e "\n=== COMMAND LINE ARGUMENTS ==="

# Function to demonstrate argument processing
process_arguments() {
    local verbose=false
    local output_file=""
    local input_files=()
    
    echo "Processing arguments: $*"
    
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -v|--verbose)
                verbose=true
                shift
                ;;
            -o|--output)
                output_file="$2"
                shift 2
                ;;
            -h|--help)
                echo "Usage: $0 [options] [files...]"
                echo "Options:"
                echo "  -v, --verbose    Enable verbose output"
                echo "  -o, --output     Specify output file"
                echo "  -h, --help       Show this help"
                return 0
                ;;
            -*)
                echo "Unknown option: $1" >&2
                return 1
                ;;
            *)
                input_files+=("$1")
                shift
                ;;
        esac
    done
    
    echo "Configuration:"
    echo "  Verbose: $verbose"
    echo "  Output file: ${output_file:-"(none)"}"
    echo "  Input files: ${input_files[*]:-"(none)"}"
}

# Test argument processing
process_arguments --verbose -o output.txt file1.txt file2.txt
process_arguments --help

# =============================================================================
# CONFIGURATION FILE PROCESSING
# =============================================================================

echo -e "\n=== CONFIGURATION FILES ==="

# Create sample configuration file
cat > config.conf << EOF
# Application Configuration
app_name=MyApp
version=1.0.0
debug=true
max_connections=100
server_host=localhost
server_port=8080

# Database settings
db_host=localhost
db_port=5432
db_name=myapp_db
EOF

# Function to read configuration
read_config() {
    local config_file="$1"
    
    if [[ ! -f "$config_file" ]]; then
        echo "Configuration file not found: $config_file" >&2
        return 1
    fi
    
    echo "Reading configuration from: $config_file"
    
    # Read configuration into associative array
    declare -A config
    
    while IFS='=' read -r key value; do
        # Skip comments and empty lines
        [[ "$key" =~ ^[[:space:]]*# ]] && continue
        [[ -z "$key" ]] && continue
        
        # Remove leading/trailing whitespace
        key=$(echo "$key" | xargs)
        value=$(echo "$value" | xargs)
        
        config["$key"]="$value"
        echo "  $key = $value"
    done < "$config_file"
}

read_config "config.conf"

# JSON-like configuration processing
cat > config.json << 'EOF'
{
    "app": {
        "name": "MyApp",
        "version": "1.0.0"
    },
    "server": {
        "host": "localhost",
        "port": 8080
    }
}
EOF

# Simple JSON value extraction (for basic cases)
extract_json_value() {
    local json_file="$1"
    local key_path="$2"
    
    if command -v jq >/dev/null 2>&1; then
        jq -r "$key_path" "$json_file"
    else
        # Fallback for simple cases without jq
        grep -o "\"${key_path##*.}\"[[:space:]]*:[[:space:]]*\"[^\"]*\"" "$json_file" | \
        cut -d'"' -f4
    fi
}

echo -e "\nJSON configuration:"
if command -v jq >/dev/null 2>&1; then
    echo "App name: $(extract_json_value config.json '.app.name')"
    echo "Server port: $(extract_json_value config.json '.server.port')"
else
    echo "jq not available for JSON parsing"
fi

# =============================================================================
# STREAM PROCESSING
# =============================================================================

echo -e "\n=== STREAM PROCESSING ==="

# Generate test data stream
generate_log_stream() {
    local count="${1:-10}"
    
    for i in $(seq 1 "$count"); do
        local level=$( (( RANDOM % 3 == 0 )) && echo "ERROR" || echo "INFO" )
        local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        echo "[$timestamp] [$level] Message $i"
        sleep 0.1
    done
}

# Process stream in real-time
process_log_stream() {
    local error_count=0
    local info_count=0
    
    while IFS= read -r line; do
        echo "Processing: $line"
        
        if [[ "$line" =~ ERROR ]]; then
            ((error_count++))
            echo "  -> Error detected! Total errors: $error_count"
        elif [[ "$line" =~ INFO ]]; then
            ((info_count++))
        fi
    done
    
    echo "Stream processing complete:"
    echo "  Info messages: $info_count"
    echo "  Error messages: $error_count"
}

echo "Generating and processing log stream:"
generate_log_stream 5 | process_log_stream

# Buffered stream processing
buffer_and_process() {
    local buffer_size="${1:-3}"
    local buffer=()
    local count=0
    
    while IFS= read -r line; do
        buffer+=("$line")
        ((count++))
        
        if (( count >= buffer_size )); then
            echo "Processing buffer of $count items:"
            for item in "${buffer[@]}"; do
                echo "  Buffer item: $item"
            done
            
            # Clear buffer
            buffer=()
            count=0
        fi
    done
    
    # Process remaining items
    if (( count > 0 )); then
        echo "Processing final buffer of $count items:"
        for item in "${buffer[@]}"; do
            echo "  Final item: $item"
        done
    fi
}

echo -e "\nBuffered stream processing:"
echo -e "item1\nitem2\nitem3\nitem4\nitem5\nitem6\nitem7" | buffer_and_process 3

# =============================================================================
# ERROR HANDLING AND DEBUGGING
# =============================================================================

echo -e "\n=== ERROR HANDLING AND DEBUGGING ==="

# Debug output function
debug() {
    local level="$1"
    shift
    
    case "$level" in
        1) [[ "${DEBUG:-0}" -ge 1 ]] && echo "[DEBUG1] $*" >&2 ;;
        2) [[ "${DEBUG:-0}" -ge 2 ]] && echo "[DEBUG2] $*" >&2 ;;
        3) [[ "${DEBUG:-0}" -ge 3 ]] && echo "[DEBUG3] $*" >&2 ;;
    esac
}

# Test debug output
DEBUG=2
debug 1 "This debug message will show (level 1)"
debug 2 "This debug message will show (level 2)"
debug 3 "This debug message will NOT show (level 3)"

# Error handling with proper exit codes
safe_operation() {
    local operation="$1"
    local file="$2"
    
    case "$operation" in
        "read")
            if [[ ! -f "$file" ]]; then
                echo "Error: Cannot read file '$file' - file not found" >&2
                return 1
            fi
            
            if [[ ! -r "$file" ]]; then
                echo "Error: Cannot read file '$file' - permission denied" >&2
                return 2
            fi
            
            cat "$file"
            ;;
            
        "write")
            local dir=$(dirname "$file")
            if [[ ! -d "$dir" ]]; then
                echo "Error: Directory '$dir' does not exist" >&2
                return 1
            fi
            
            if [[ ! -w "$dir" ]]; then
                echo "Error: Cannot write to directory '$dir' - permission denied" >&2
                return 2
            fi
            
            echo "Test content" > "$file"
            echo "Successfully wrote to '$file'"
            ;;
            
        *)
            echo "Error: Unknown operation '$operation'" >&2
            return 3
            ;;
    esac
}

# Test error handling
echo "Testing error handling:"
safe_operation "read" "input_test.txt"
safe_operation "write" "test_write.txt"
safe_operation "read" "nonexistent.txt" || echo "Read operation failed with code $?"

# =============================================================================
# PERFORMANCE MONITORING
# =============================================================================

echo -e "\n=== PERFORMANCE MONITORING ==="

# Time command execution
time_command() {
    local cmd="$*"
    echo "Timing command: $cmd"
    
    local start_time=$(date +%s.%N)
    eval "$cmd" > /dev/null
    local end_time=$(date +%s.%N)
    
    local duration=$(echo "$end_time - $start_time" | bc -l)
    printf "Execution time: %.3f seconds\n" "$duration"
}

# Monitor resource usage
monitor_resources() {
    local duration="${1:-5}"
    local interval="${2:-1}"
    
    echo "Monitoring resources for $duration seconds (interval: ${interval}s):"
    
    for ((i=0; i<duration; i+=interval)); do
        local timestamp=$(date '+%H:%M:%S')
        local load=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | tr -d ',')
        local memory=""
        
        if command -v free >/dev/null 2>&1; then
            memory=$(free | awk '/^Mem:/ {printf "%.1f%%", $3/$2 * 100}')
        else
            memory="N/A"
        fi
        
        printf "[%s] Load: %s, Memory: %s\n" "$timestamp" "$load" "$memory"
        sleep "$interval"
    done
}

# Test performance monitoring
time_command "sleep 0.5"
monitor_resources 3 1

# =============================================================================
# CLEANUP AND SUMMARY
# =============================================================================

echo -e "\n=== CLEANUP ==="

# Clean up test files
cleanup_files=(
    output.txt error.log combined.log stdout.log stderr.log
    input_test.txt greeting.txt literal.txt pipe_output.txt
    fd_output.txt fd_redirect.txt application.log config.conf
    config.json test_write.txt
)

echo "Cleaning up test files..."
for file in "${cleanup_files[@]}"; do
    rm -f "$file" 2>/dev/null || true
done

echo -e "\n=== INPUT/OUTPUT SUMMARY ==="
echo "✓ Basic output methods (echo, printf, colors)"
echo "✓ Standard input methods (read variations)"
echo "✓ File descriptors and redirection"
echo "✓ Advanced redirection techniques"
echo "✓ Pipes and pipelines"
echo "✓ Exec and file descriptor manipulation"
echo "✓ Logging and output formatting"
echo "✓ Interactive input and menus"
echo "✓ Command line argument processing"
echo "✓ Configuration file processing"
echo "✓ Stream processing"
echo "✓ Error handling and debugging"
echo "✓ Performance monitoring"

echo "Script completed successfully!"