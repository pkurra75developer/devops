bash


#!/bin/bash
# =============================================================================
# COMMAND-LINE ARGUMENTS AND PARAMETERS - Complete Guide
# =============================================================================

set -euo pipefail

# =============================================================================
# POSITIONAL PARAMETERS
# =============================================================================

echo "=== POSITIONAL PARAMETERS ==="

# Function to demonstrate positional parameters
demo_positional_params() {
    echo "Function called with $# arguments"
    echo "Function name: $0"
    echo "First argument: ${1:-'(not provided)'}"
    echo "Second argument: ${2:-'(not provided)'}"
    echo "Third argument: ${3:-'(not provided)'}"
    
    echo -e "\nAll arguments individually:"
    local i=1
    for arg in "$@"; do
        echo "  Argument $i: '$arg'"
        ((i++))
    done
}

# Test with different argument sets
echo "Testing positional parameters:"
demo_positional_params "hello" "world" "test"
echo
demo_positional_params "single"
echo
demo_positional_params

# Accessing arguments beyond $9
demo_many_args() {
    echo "Accessing arguments beyond \$9:"
    echo "Arg 1: $1"
    echo "Arg 9: $9"
    echo "Arg 10: ${10}"  # Must use braces for double digits
    echo "Arg 11: ${11}"
    echo "Arg 15: ${15}"
}

echo "Testing many arguments:"
demo_many_args a b c d e f g h i j k l m n o p q r s t

# Shifting parameters
demo_shift() {
    echo -e "\nDemonstrating shift command:"
    echo "Initial arguments: $*"
    
    while [[ $# -gt 0 ]]; do
        echo "Processing: $1 (remaining: $#)"
        shift
    done
    
    echo "All arguments processed"
}

demo_shift "first" "second" "third" "fourth"

# =============================================================================
# SPECIAL PARAMETERS
# =============================================================================

echo -e "\n=== SPECIAL PARAMETERS ==="

demo_special_params() {
    echo "Special parameters demonstration:"
    echo "Number of arguments (\$#): $#"
    echo "All arguments as single string (\$*): $*"
    echo "All arguments as separate strings (\$@): $@"
    echo "Script name (\$0): $0"
    echo "Process ID (\$\$): $$"
    echo "Exit status of last command (\$?): $?"
    echo "Background process ID (\$!): ${!:-'(no background process)'}"
    
    # Demonstrate difference between $* and $@
    echo -e "\nDifference between \$* and \$@:"
    
    echo "Using \$* in for loop:"
    for arg in $*; do
        echo "  '$arg'"
    done
    
    echo "Using \$@ in for loop:"
    for arg in "$@"; do
        echo "  '$arg'"
    done
    
    echo "Using \"\$*\" (single string):"
    echo "  '$*'"
    
    echo "Using \"\$@\" (separate strings):"
    printf "  '%s'\n" "$@"
}

# Test special parameters
demo_special_params "hello world" "test with spaces" "single"

# Demonstrate $? (exit status)
echo -e "\nExit status examples:"
true
echo "Exit status after 'true': $?"

false || true  # Prevent script exit due to set -e
echo "Exit status after 'false': $?"

ls /nonexistent 2>/dev/null || true
echo "Exit status after failed 'ls': $?"

# =============================================================================
# PARAMETER EXPANSION AND DEFAULT VALUES
# =============================================================================

echo -e "\n=== PARAMETER EXPANSION ==="

demo_parameter_expansion() {
    local arg1="$1"
    local arg2="$2"
    local arg3="$3"
    
    echo "Parameter expansion examples:"
    
    # Default values
    echo "arg1 with default: ${arg1:-'default1'}"
    echo "arg2 with default: ${arg2:-'default2'}"
    echo "arg3 with default: ${arg3:-'default3'}"
    
    # Assign default if unset
    echo "arg1 assign default: ${arg1:='assigned_default1'}"
    
    # Error if unset
    echo "Testing required parameter:"
    echo "arg1 (required): ${arg1:?'arg1 is required'}"
    
    # Use alternative value if set
    echo "arg1 alternative: ${arg1:+'arg1 is set'}"
    
    # String length
    echo "Length of arg1: ${#arg1}"
    
    # Substring extraction
    if [[ ${#arg1} -gt 5 ]]; then
        echo "First 5 chars of arg1: ${arg1:0:5}"
        echo "From position 2: ${arg1:2}"
        echo "From position 2, length 3: ${arg1:2:3}"
    fi
    
    # Pattern matching
    local filename="test.txt.backup"
    echo "Filename: $filename"
    echo "Remove shortest suffix (.*): ${filename%.*}"
    echo "Remove longest suffix (.*): ${filename%%.*}"
    echo "Remove shortest prefix (*.): ${filename#*.}"
    echo "Remove longest prefix (*.): ${filename##*.}"
    
    # Case modification (bash 4+)
    if [[ ${BASH_VERSION%%.*} -ge 4 ]]; then
        local text="Hello World"
        echo "Original: $text"
        echo "Uppercase: ${text^^}"
        echo "Lowercase: ${text,,}"
        echo "Capitalize: ${text^}"
    fi
}

demo_parameter_expansion "hello_world_test" "second_arg"

# =============================================================================
# BASIC OPTION PARSING (MANUAL)
# =============================================================================

echo -e "\n=== BASIC OPTION PARSING ==="

# Simple manual option parsing
manual_option_parsing() {
    local verbose=false
    local output_file=""
    local input_files=()
    local help=false
    
    echo "Manual option parsing example:"
    echo "Arguments received: $*"
    
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -v|--verbose)
                verbose=true
                echo "Verbose mode enabled"
                shift
                ;;
            -o|--output)
                if [[ -n "$2" && "$2" != -* ]]; then
                    output_file="$2"
                    echo "Output file set to: $output_file"
                    shift 2
                else
                    echo "Error: --output requires an argument" >&2
                    return 1
                fi
                ;;
            -h|--help)
                help=true
                shift
                ;;
            --)
                shift
                break
                ;;
            -*)
                echo "Error: Unknown option $1" >&2
                return 1
                ;;
            *)
                input_files+=("$1")
                shift
                ;;
        esac
    done
    
    # Add remaining arguments as input files
    while [[ $# -gt 0 ]]; do
        input_files+=("$1")
        shift
    done
    
    if [[ $help == true ]]; then
        echo "Usage: script [options] [files...]"
        echo "Options:"
        echo "  -v, --verbose    Enable verbose output"
        echo "  -o, --output     Specify output file"
        echo "  -h, --help       Show this help"
        return 0
    fi
    
    echo "Final configuration:"
    echo "  Verbose: $verbose"
    echo "  Output file: ${output_file:-'(stdout)'}"
    echo "  Input files: ${input_files[*]:-'(none)'}"
}

# Test manual parsing
manual_option_parsing --verbose -o output.txt file1.txt file2.txt
echo
manual_option_parsing --help

# =============================================================================
# GETOPTS - POSIX OPTION PARSING
# =============================================================================

echo -e "\n=== GETOPTS - POSIX OPTION PARSING ==="

# Function using getopts
demo_getopts() {
    local OPTIND=1  # Reset getopts
    local verbose=false
    local output_file=""
    local count=1
    local help=false
    
    echo "getopts demonstration:"
    echo "Arguments: $*"
    
    while getopts "vho:c:" opt; do
        case "$opt" in
            v)
                verbose=true
                echo "Verbose mode enabled"
                ;;
            h)
                help=true
                ;;
            o)
                output_file="$OPTARG"
                echo "Output file: $output_file"
                ;;
            c)
                if [[ "$OPTARG" =~ ^[0-9]+$ ]]; then
                    count="$OPTARG"
                    echo "Count set to: $count"
                else
                    echo "Error: -c requires a numeric argument" >&2
                    return 1
                fi
                ;;
            \?)
                echo "Error: Invalid option -$OPTARG" >&2
                return 1
                ;;
            :)
                echo "Error: Option -$OPTARG requires an argument" >&2
                return 1
                ;;
        esac
    done
    
    shift $((OPTIND - 1))
    
    if [[ $help == true ]]; then
        echo "Usage: demo_getopts [-v] [-h] [-o output] [-c count] [files...]"
        echo "Options:"
        echo "  -v          Enable verbose mode"
        echo "  -h          Show help"
        echo "  -o output   Specify output file"
        echo "  -c count    Specify count (numeric)"
        return 0
    fi
    
    echo "Remaining arguments: $*"
    echo "Configuration:"
    echo "  Verbose: $verbose"
    echo "  Output: ${output_file:-'(stdout)'}"
    echo "  Count: $count"
    echo "  Files: $*"
}

# Test getopts
demo_getopts -v -o test.out -c 5 file1 file2
echo
demo_getopts -h
echo
demo_getopts -v -c invalid 2>/dev/null || echo "Handled invalid count argument"

# =============================================================================
# ADVANCED GETOPTS USAGE
# =============================================================================

echo -e "\n=== ADVANCED GETOPTS USAGE ==="

# More complex getopts example
advanced_getopts() {
    local OPTIND=1
    local config_file=""
    local log_level="INFO"
    local dry_run=false
    local force=false
    local exclude_patterns=()
    
    echo "Advanced getopts example:"
    
    # Note: getopts doesn't support long options natively
    # This is a workaround for demonstration
    while getopts "c:l:dfhe:" opt; do
        case "$opt" in
            c)
                config_file="$OPTARG"
                if [[ ! -f "$config_file" ]]; then
                    echo "Warning: Config file '$config_file' not found"
                fi
                ;;
            l)
                case "$OPTARG" in
                    DEBUG|INFO|WARN|ERROR)
                        log_level="$OPTARG"
                        ;;
                    *)
                        echo "Error: Invalid log level '$OPTARG'" >&2
                        echo "Valid levels: DEBUG, INFO, WARN, ERROR" >&2
                        return 1
                        ;;
                esac
                ;;
            d)
                dry_run=true
                ;;
            f)
                force=true
                ;;
            e)
                exclude_patterns+=("$OPTARG")
                ;;
            h)
                cat << EOF
Usage: advanced_getopts [options]
Options:
  -c file     Configuration file
  -l level    Log level (DEBUG|INFO|WARN|ERROR)
  -d          Dry run mode
  -f          Force operation
  -e pattern  Exclude pattern (can be used multiple times)
  -h          Show this help
EOF
                return 0
                ;;
            \?)
                echo "Error: Invalid option -$OPTARG" >&2
                echo "Use -h for help" >&2
                return 1
                ;;
            :)
                echo "Error: Option -$OPTARG requires an argument" >&2
                return 1
                ;;
        esac
    done
    
    shift $((OPTIND - 1))
    
    echo "Advanced configuration:"
    echo "  Config file: ${config_file:-'(default)'}"
    echo "  Log level: $log_level"
    echo "  Dry run: $dry_run"
    echo "  Force: $force"
    echo "  Exclude patterns: ${exclude_patterns[*]:-'(none)'}"
    echo "  Remaining args: $*"
}

# Test advanced getopts
advanced_getopts -c config.ini -l DEBUG -d -e "*.tmp" -e "*.log" remaining args
echo
advanced_getopts -h

# =============================================================================
# LONG OPTIONS SUPPORT
# =============================================================================

echo -e "\n=== LONG OPTIONS SUPPORT ==="

# Function to handle both short and long options
parse_long_options() {
    local verbose=false
    local output_file=""
    local input_dir=""
    local help=false
    
    echo "Long options parsing:"
    
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
            --output=*)
                output_file="${1#*=}"
                shift
                ;;
            -i|--input-dir)
                input_dir="$2"
                shift 2
                ;;
            --input-dir=*)
                input_dir="${1#*=}"
                shift
                ;;
            -h|--help)
                help=true
                shift
                ;;
            --)
                shift
                break
                ;;
            -*)
                echo "Error: Unknown option $1" >&2
                return 1
                ;;
            *)
                break
                ;;
        esac
    done
    
    if [[ $help == true ]]; then
        cat << EOF
Usage: parse_long_options [options] [files...]
Options:
  -v, --verbose           Enable verbose output
  -o, --output FILE       Output file
  -i, --input-dir DIR     Input directory
  -h, --help              Show this help
  
Long options can use = syntax: --output=file.txt
EOF
        return 0
    fi
    
    echo "Long options result:"
    echo "  Verbose: $verbose"
    echo "  Output: ${output_file:-'(not set)'}"
    echo "  Input dir: ${input_dir:-'(not set)'}"
    echo "  Remaining: $*"
}

# Test long options
parse_long_options --verbose --output=result.txt --input-dir /tmp file1 file2
echo
parse_long_options -v -o output.txt -i /home/user
echo
parse_long_options --help

# =============================================================================
# ARGUMENT VALIDATION
# =============================================================================

echo -e "\n=== ARGUMENT VALIDATION ==="

# Function with comprehensive argument validation
validate_arguments() {
    local operation=""
    local source_file=""
    local target_file=""
    local verbose=false
    local OPTIND=1
    
    # Parse options
    while getopts "o:s:t:vh" opt; do
        case "$opt" in
            o)
                operation="$OPTARG"
                ;;
            s)
                source_file="$OPTARG"
                ;;
            t)
                target_file="$OPTARG"
                ;;
            v)
                verbose=true
                ;;
            h)
                cat << EOF
Usage: validate_arguments -o operation -s source -t target [-v]
Options:
  -o operation    Operation to perform (copy|move|delete)
  -s source       Source file
  -t target       Target file
  -v              Verbose mode
  -h              Show help
EOF
                return 0
                ;;
            \?)
                return 1
                ;;
        esac
    done
    
    # Validation
    local errors=()
    
    # Required arguments
    [[ -z "$operation" ]] && errors+=("Operation (-o) is required")
    [[ -z "$source_file" ]] && errors+=("Source file (-s) is required")
    
    # Validate operation
    case "$operation" in
        copy|move|delete) ;;
        "") ;;  # Already handled above
        *) errors+=("Invalid operation '$operation'. Valid: copy, move, delete") ;;
    esac
    
    # Validate source file
    if [[ -n "$source_file" && ! -f "$source_file" ]]; then
        errors+=("Source file '$source_file' does not exist")
    fi
    
    # Target required for copy/move
    if [[ "$operation" =~ ^(copy|move)$ && -z "$target_file" ]]; then
        errors+=("Target file (-t) is required for $operation operation")
    fi
    
    # Report errors
    if [[ ${#errors[@]} -gt 0 ]]; then
        echo "Validation errors:" >&2
        for error in "${errors[@]}"; do
            echo "  - $error" >&2
        done
        return 1
    fi
    
    # Success
    echo "Validation successful:"
    echo "  Operation: $operation"
    echo "  Source: $source_file"
    echo "  Target: ${target_file:-'(not applicable)'}"
    echo "  Verbose: $verbose"
}

# Create test file for validation
echo "test content" > test_source.txt

# Test validation
echo "Testing argument validation:"
validate_arguments -o copy -s test_source.txt -t test_target.txt -v
echo
validate_arguments -o invalid -s test_source.txt 2>/dev/null || echo "Validation failed as expected"
echo
validate_arguments -h

# =============================================================================
# CONFIGURATION FROM MULTIPLE SOURCES
# =============================================================================

echo -e "\n=== CONFIGURATION FROM MULTIPLE SOURCES ==="

# Function that combines config file, environment, and command line
multi_source_config() {
    # Default values
    local app_name="MyApp"
    local log_level="INFO"
    local max_connections=100
    local debug=false
    
    # 1. Load from config file if it exists
    local config_file="${CONFIG_FILE:-config.conf}"
    if [[ -f "$config_file" ]]; then
        echo "Loading configuration from $config_file"
        source "$config_file"
    fi
    
    # 2. Override with environment variables
    app_name="${APP_NAME:-$app_name}"
    log_level="${LOG_LEVEL:-$log_level}"
    max_connections="${MAX_CONNECTIONS:-$max_connections}"
    [[ "${DEBUG:-}" == "true" ]] && debug=true
    
    # 3. Override with command line options
    local OPTIND=1
    while getopts "n:l:c:dh" opt; do
        case "$opt" in
            n) app_name="$OPTARG" ;;
            l) log_level="$OPTARG" ;;
            c) max_connections="$OPTARG" ;;
            d) debug=true ;;
            h)
                cat << EOF
Usage: multi_source_config [options]
Configuration sources (in order of precedence):
  1. Default values
  2. Config file (CONFIG_FILE env var or config.conf)
  3. Environment variables (APP_NAME, LOG_LEVEL, MAX_CONNECTIONS, DEBUG)
  4. Command line options

Options:
  -n name         Application name
  -l level        Log level
  -c connections  Max connections
  -d              Enable debug mode
  -h              Show help
EOF
                return 0
                ;;
        esac
    done
    
    echo "Final configuration:"
    echo "  App name: $app_name"
    echo "  Log level: $log_level"
    echo "  Max connections: $max_connections"
    echo "  Debug: $debug"
}

# Create sample config file
cat > config.conf << EOF
app_name="ConfigApp"
log_level="WARN"
max_connections=200
EOF

# Test multi-source configuration
echo "Testing multi-source configuration:"

echo "1. Default configuration:"
multi_source_config

echo -e "\n2. With config file:"
CONFIG_FILE=config.conf multi_source_config

echo -e "\n3. With environment variables:"
APP_NAME="EnvApp" LOG_LEVEL="DEBUG" multi_source_config

echo -e "\n4. With command line options:"
multi_source_config -n "CmdApp" -l "ERROR" -c 500 -d

# =============================================================================
# SUBCOMMAND HANDLING
# =============================================================================

echo -e "\n=== SUBCOMMAND HANDLING ==="

# Function to handle subcommands (like git, docker, etc.)
handle_subcommands() {
    local subcommand="$1"
    shift
    
    case "$subcommand" in
        "create")
            handle_create_subcommand "$@"
            ;;
        "delete")
            handle_delete_subcommand "$@"
            ;;
        "list")
            handle_list_subcommand "$@"
            ;;
        "help"|"--help"|"-h")
            show_main_help
            ;;
        "")
            echo "Error: No subcommand specified" >&2
            show_main_help
            return 1
            ;;
        *)
            echo "Error: Unknown subcommand '$subcommand'" >&2
            show_main_help
            return 1
            ;;
    esac
}

handle_create_subcommand() {
    local name=""
    local type="default"
    local OPTIND=1
    
    while getopts "n:t:h" opt; do
        case "$opt" in
            n) name="$OPTARG" ;;
            t) type="$OPTARG" ;;
            h)
                echo "Usage: create -n name [-t type]"
                echo "Create a new item"
                echo "Options:"
                echo "  -n name    Item name (required)"
                echo "  -t type    Item type (default: default)"
                return 0
                ;;
            \?) return 1 ;;
        esac
    done
    
    if [[ -z "$name" ]]; then
        echo "Error: Name is required for create command" >&2
        return 1
    fi
    
    echo "Creating item '$name' of type '$type'"
}

handle_delete_subcommand() {
    local name=""
    local force=false
    local OPTIND=1
    
    while getopts "n:fh" opt; do
        case "$opt" in
            n) name="$OPTARG" ;;
            f) force=true ;;
            h)
                echo "Usage: delete -n name [-f]"
                echo "Delete an item"
                echo "Options:"
                echo "  -n name    Item name (required)"
                echo "  -f         Force deletion"
                return 0
                ;;
            \?) return 1 ;;
        esac
    done
    
    if [[ -z "$name" ]]; then
        echo "Error: Name is required for delete command" >&2
        return 1
    fi
    
    echo "Deleting item '$name' (force: $force)"
}

handle_list_subcommand() {
    local filter=""
    local verbose=false
    local OPTIND=1
    
    while getopts "f:vh" opt; do
        case "$opt" in
            f) filter="$OPTARG" ;;
            v) verbose=true ;;
            h)
                echo "Usage: list [-f filter] [-v]"
                echo "List items"
                echo "Options:"
                echo "  -f filter  Filter items"
                echo "  -v         Verbose output"
                return 0
                ;;
            \?) return 1 ;;
        esac
    done
    
    echo "Listing items (filter: ${filter:-'none'}, verbose: $verbose)"
}

show_main_help() {
    cat << EOF
Usage: script <subcommand> [options]

Subcommands:
  create    Create a new item
  delete    Delete an item
  list      List items
  help      Show this help

Use 'script <subcommand> -h' for subcommand-specific help.
EOF
}

# Test subcommand handling
echo "Testing subcommand handling:"
handle_subcommands create -n "test_item" -t "special"
echo
handle_subcommands delete -n "old_item" -f
echo
handle_subcommands list -f "active" -v
echo
handle_subcommands help

# =============================================================================
# CLEANUP AND SUMMARY
# =============================================================================

echo -e "\n=== CLEANUP ==="

# Clean up test files
rm -f test_source.txt config.conf

echo -e "\n=== COMMAND-LINE ARGUMENTS SUMMARY ==="
echo "✓ Positional parameters (\$1, \$2, ...)"
echo "✓ Special parameters (\$#, \$@, \$*, \$?, etc.)"
echo "✓ Parameter expansion and default values"
echo "✓ Basic manual option parsing"
echo "✓ getopts for POSIX option parsing"
echo "✓ Advanced getopts usage"
echo "✓ Long options support"
echo "✓ Argument validation"
echo "✓ Configuration from multiple sources"
echo "✓ Subcommand handling"

echo "Script completed successfully!"