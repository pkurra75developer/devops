#!/bin/bash
# File: 18_project_template.sh
# Building Complex Shell Scripting Projects

# Colors for output formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "$${BLUE}=== Building Complex Shell Scripting Projects ===$$ {NC}\n"

# 1. PROJECT STRUCTURE AND MODULARIZATION
echo -e "$${YELLOW}1. Project Structure and Modularization$$ {NC}"

demonstrate_project_structure() {
    echo -e "${GREEN}✅ Recommended Project Structure:${NC}"
    
    cat << 'EOF'
myproject/
├── bin/                    # Main executable scripts
│   ├── myproject          # Main entry point
│   └── myproject-admin    # Admin utilities
├── lib/                   # Library modules
│   ├── common.sh         # Common functions
│   ├── config.sh         # Configuration handling
│   ├── logging.sh        # Logging utilities
│   ├── database.sh       # Database operations
│   └── api.sh            # API interactions
├── config/               # Configuration files
│   ├── default.conf      # Default configuration
│   ├── production.conf   # Production settings
│   └── development.conf  # Development settings
├── templates/            # Template files
│   ├── service.template  # Service file template
│   └── config.template   # Config file template
├── tests/                # Test scripts
│   ├── test_common.sh    # Unit tests for common functions
│   ├── test_config.sh    # Configuration tests
│   └── integration_tests.sh
├── docs/                 # Documentation
│   ├── README.md         # Project documentation
│   ├── INSTALL.md        # Installation guide
│   └── API.md            # API documentation
├── scripts/              # Utility scripts
│   ├── install.sh        # Installation script
│   ├── setup.sh          # Environment setup
│   └── package.sh        # Packaging script
├── .env.example          # Environment variables template
├── Makefile              # Build automation
├── VERSION               # Version file
└── LICENSE               # License file
EOF
    
    echo -e "\n${PURPLE}Creating sample project structure:${NC}"
    
    create_sample_structure() {
        local project_name="sample_project"
        
        # Create directory structure
        mkdir -p "$project_name"/{bin,lib,config,templates,tests,docs,scripts}
        
        echo "Created project structure for: $project_name"
        tree "$project_name" 2>/dev/null || find "$project_name" -type d | sed 's|[^/]*/|  |g'
        
        # Cleanup
        rm -rf "$project_name"
    }
    
    create_sample_structure
    echo ""
}

# 2. MODULAR SCRIPT DESIGN
echo -e "$${YELLOW}2. Modular Script Design$$ {NC}"

demonstrate_modular_design() {
    echo -e "${GREEN}✅ Creating Modular Components:${NC}"
    
    # Create lib/common.sh module
    create_common_module() {
        cat << 'EOF'
#!/bin/bash
# lib/common.sh - Common utility functions

# Global variables
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Logging functions
log_info() {
    echo -e "$(date '+%Y-%m-%d %H:%M:%S') [INFO] $*" >&2
}

log_error() {
    echo -e "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $*" >&2
}

log_debug() {
    if [ "${DEBUG:-0}" = "1" ]; then
        echo -e "$(date '+%Y-%m-%d %H:%M:%S') [DEBUG] $*" >&2
    fi
}

# Utility functions
check_command() {
    local cmd="$1"
    if ! command -v "$cmd" &> /dev/null; then
        log_error "Required command not found: $cmd"
        return 1
    fi
}

validate_file() {
    local file="$1"
    if [ ! -f "$file" ]; then
        log_error "File not found: $file"
        return 1
    fi
    if [ ! -r "$file" ]; then
        log_error "File not readable: $file"
        return 1
    fi
}

# Version comparison
version_compare() {
    local version1="$1"
    local version2="$2"
    
    if [ "$version1" = "$version2" ]; then
        return 0
    fi
    
    local IFS=.
    local i ver1=($$version1) ver2=($$ version2)
    
    for ((i=0; i<${#ver1[@]} || i<${#ver2[@]}; i++)); do
        if [[ -z ${ver2[i]} ]]; then
            ver2[i]=0
        fi
        if [[ -z ${ver1[i]} ]]; then
            ver1[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]})); then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]})); then
            return 2
        fi
    done
    return 0
}
EOF
        echo "Created lib/common.sh module"
    }
    
    # Create lib/config.sh module
    create_config_module() {
        cat << 'EOF'
#!/bin/bash
# lib/config.sh - Configuration management

# Default configuration
declare -A DEFAULT_CONFIG=(
    ["app.name"]="MyProject"
    ["app.version"]="1.0.0"
    ["app.debug"]="false"
    ["database.host"]="localhost"
    ["database.port"]="5432"
    ["api.timeout"]="30"
    ["logging.level"]="INFO"
)

# Current configuration
declare -A CONFIG

# Initialize configuration with defaults
init_config() {
    for key in "${!DEFAULT_CONFIG[@]}"; do
        CONFIG["$key"]="${DEFAULT_CONFIG[$key]}"
    done
}

# Load configuration from file
load_config() {
    local config_file="$1"
    
    if [ ! -f "$config_file" ]; then
        log_error "Configuration file not found: $config_file"
        return 1
    fi
    
    log_info "Loading configuration from: $config_file"
    
    while IFS='=' read -r key value; do
        # Skip comments and empty lines
        [[ "$key" =~ ^[[:space:]]*# ]] && continue
        [[ -z "$key" ]] && continue
        
        # Remove leading/trailing whitespace
        key=$(echo "$key" | xargs)
        value=$(echo "$value" | xargs)
        
        # Remove quotes from value
        value=$(echo "$value" | sed 's/^["'\'']$$.*$$["'\'']$/\1/')
        
        CONFIG["$key"]="$value"
    done < "$config_file"
}

# Get configuration value
get_config() {
    local key="$1"
    local default_value="$2"
    
    if [[ -n "${CONFIG[$key]:-}" ]]; then
        echo "${CONFIG[$key]}"
    elif [[ -n "$default_value" ]]; then
        echo "$default_value"
    else
        log_error "Configuration key not found: $key"
        return 1
    fi
}

# Set configuration value
set_config() {
    local key="$1"
    local value="$2"
    
    CONFIG["$key"]="$value"
    log_debug "Set configuration: $$key =$$ value"
}

# Validate configuration
validate_config() {
    local required_keys=("app.name" "app.version")
    
    for key in "${required_keys[@]}"; do
        if [[ -z "${CONFIG[$key]:-}" ]]; then
            log_error "Required configuration missing: $key"
            return 1
        fi
    done
    
    log_info "Configuration validation passed"
}

# Export configuration as environment variables
export_config() {
    for key in "${!CONFIG[@]}"; do
        local env_var=$(echo "$key" | tr '.' '_' | tr '[:lower:]' '[:upper:]')
        export "$env_var"="${CONFIG[$key]}"
    done
}
EOF
        echo "Created lib/config.sh module"
    }
    
    # Create lib/logging.sh module
    create_logging_module() {
        cat << 'EOF'
#!/bin/bash
# lib/logging.sh - Advanced logging system

# Log levels
declare -A LOG_LEVELS=(
    ["DEBUG"]=0
    ["INFO"]=1
    ["WARN"]=2
    ["ERROR"]=3
    ["FATAL"]=4
)

# Current log level (default: INFO)
CURRENT_LOG_LEVEL=${CURRENT_LOG_LEVEL:-1}

# Log file path
LOG_FILE="${LOG_FILE:-/var/log/myproject.log}"

# Initialize logging
init_logging() {
    local log_level="${1:-INFO}"
    local log_file="${2:-$LOG_FILE}"
    
    CURRENT_LOG_LEVEL=${LOG_LEVELS[$log_level]:-1}
    LOG_FILE="$log_file"
    
    # Create log directory if it doesn't exist
    local log_dir=$(dirname "$LOG_FILE")
    if [ ! -d "$log_dir" ]; then
        mkdir -p "$log_dir" || {
            echo "Failed to create log directory: $log_dir" >&2
            return 1
        }
    fi
    
    # Test log file writability
    if ! touch "$LOG_FILE" 2>/dev/null; then
        echo "Cannot write to log file: $LOG_FILE" >&2
        return 1
    fi
}

# Generic log function
write_log() {
    local level="$1"
    shift
    local message="$*"
    
    local level_num=${LOG_LEVELS[$level]:-1}
    
    # Check if we should log this level
    if [ "$level_num" -lt "$CURRENT_LOG_LEVEL" ]; then
        return 0
    fi
    
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local log_entry="[$timestamp] [$level] $message"
    
    # Write to console (stderr)
    case "$level" in
        "DEBUG") echo -e "\033[0;36m$log_entry\033[0m" >&2 ;;
        "INFO")  echo -e "\033[0;32m$log_entry\033[0m" >&2 ;;
        "WARN")  echo -e "\033[1;33m$log_entry\033[0m" >&2 ;;
        "ERROR") echo -e "\033[0;31m$log_entry\033[0m" >&2 ;;
        "FATAL") echo -e "\033[1;31m$log_entry\033[0m" >&2 ;;
    esac
    
    # Write to log file
    echo "$log_entry" >> "$LOG_FILE" 2>/dev/null
}

# Convenience logging functions
log_debug() { write_log "DEBUG" "$@"; }
log_info()  { write_log "INFO" "$@"; }
log_warn()  { write_log "WARN" "$@"; }
log_error() { write_log "ERROR" "$@"; }
log_fatal() { write_log "FATAL" "$@"; exit 1; }

# Log rotation
rotate_logs() {
    local max_size=${1:-10485760}  # 10MB default
    local max_files=${2:-5}
    
    if [ -f "$LOG_FILE" ] && [ $(stat -c%s "$LOG_FILE" 2>/dev/null || echo 0) -gt "$max_size" ]; then
        # Rotate existing log files
        for ((i=max_files-1; i>=1; i--)); do
            if [ -f "$${LOG_FILE}.$$ i" ]; then
                mv "$${LOG_FILE}.$$ i" "$${LOG_FILE}.$$ ((i+1))"
            fi
        done
        
        # Move current log to .1
        mv "$LOG_FILE" "${LOG_FILE}.1"
        
        log_info "Log rotated: $LOG_FILE"
    fi
}
EOF
        echo "Created lib/logging.sh module"
    }
    
    echo "Modular components created:"
    create_common_module
    create_config_module
    create_logging_module
    echo ""
}

# 3. CONFIGURATION FILE MANAGEMENT
echo -e "$${YELLOW}3. Configuration File Management$$ {NC}"

demonstrate_config_files() {
    echo -e "${GREEN}✅ Configuration File Examples:${NC}"
    
    # Create default configuration file
    create_default_config() {
        cat << 'EOF'
# config/default.conf
# Default configuration for MyProject

# Application settings
app.name=MyProject
app.version=1.0.0
app.debug=false
app.environment=development

# Database configuration
database.host=localhost
database.port=5432
database.name=myproject
database.pool_size=10
database.timeout=30

# API settings
api.base_url=https://api.example.com
api.timeout=30
api.retry_count=3
api.rate_limit=100

# Logging configuration
logging.level=INFO
logging.file=/var/log/myproject.log
logging.max_size=10485760
logging.max_files=5

# Feature flags
features.enable_metrics=true
features.enable_caching=false
features.enable_notifications=true

# Security settings
security.session_timeout=3600
security.max_login_attempts=3
security.password_min_length=8
EOF
        echo "Created config/default.conf"
    }
    
    # Create environment-specific configurations
    create_production_config() {
        cat << 'EOF'
# config/production.conf
# Production environment configuration

# Override development settings for production
app.environment=production
app.debug=false

# Production database
database.host=prod-db.example.com
database.pool_size=50

# Production API
api.base_url=https://prod-api.example.com
api.rate_limit=1000

# Production logging
logging.level=WARN
logging.file=/var/log/myproject/production.log

# Enable all features in production
features.enable_metrics=true
features.enable_caching=true
features.enable_notifications=true

# Stricter security in production
security.session_timeout=1800
security.max_login_attempts=5
security.password_min_length=12
EOF
        echo "Created config/production.conf"
    }
    
    # Create configuration loader
    create_config_loader() {
        cat << 'EOF'
#!/bin/bash
# scripts/load_config.sh - Configuration loader utility

load_project_config() {
    local environment="${1:-development}"
    local config_dir="${2:-./config}"
    
    # Load default configuration first
    local default_config="$config_dir/default.conf"
    if [ -f "$default_config" ]; then
        source "$default_config"
        log_info "Loaded default configuration"
    fi

    #!/bin/bash
# File: 18_project_template.sh (continued)
# Building Complex Shell Scripting Projects

    # Load environment-specific configuration
    local env_config="$$config_dir/$$ {environment}.conf"
    if [ -f "$env_config" ]; then
        source "$env_config"
        log_info "Loaded $environment configuration"
    fi
    
    # Load local overrides (not tracked in version control)
    local local_config="$config_dir/local.conf"
    if [ -f "$local_config" ]; then
        source "$local_config"
        log_info "Loaded local configuration overrides"
    fi
    
    # Load from environment variables
    load_env_overrides
}

# Load configuration from environment variables
load_env_overrides() {
    # Convert environment variables to configuration
    while IFS='=' read -r name value; do
        if [[ "$name" =~ ^MYPROJECT_ ]]; then
            # Convert MYPROJECT_DATABASE_HOST to database.host
            local config_key=$(echo "${name#MYPROJECT_}" | tr '[:upper:]' '[:lower:]' | tr '_' '.')
            set_config "$config_key" "$value"
            log_debug "Environment override: $$config_key =$$ value"
        fi
    done < <(env)
}
EOF
        echo "Created scripts/load_config.sh"
    }
    
    echo "Configuration management components:"
    create_default_config
    create_production_config
    create_config_loader
    echo ""
}

# 4. MAIN APPLICATION STRUCTURE
echo -e "$${YELLOW}4. Main Application Structure$$ {NC}"

demonstrate_main_application() {
    echo -e "${GREEN}✅ Main Application Entry Point:${NC}"
    
    # Create main application script
    create_main_script() {
        cat << 'EOF'
#!/bin/bash
# bin/myproject - Main application entry point

# Script metadata
readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
readonly VERSION_FILE="$PROJECT_ROOT/VERSION"

# Set secure defaults
set -euo pipefail
IFS=$'\n\t'

# Load project modules
source "$PROJECT_ROOT/lib/common.sh"
source "$PROJECT_ROOT/lib/config.sh"
source "$PROJECT_ROOT/lib/logging.sh"

# Application version
get_version() {
    if [ -f "$VERSION_FILE" ]; then
        cat "$VERSION_FILE"
    else
        echo "unknown"
    fi
}

# Usage information
usage() {
    cat << USAGE
$$SCRIPT_NAME v$$ (get_version)

USAGE:
    $SCRIPT_NAME [OPTIONS] COMMAND [ARGS...]

OPTIONS:
    -c, --config FILE    Configuration file path
    -e, --env ENV        Environment (development|production|testing)
    -v, --verbose        Enable verbose logging
    -d, --debug          Enable debug mode
    -h, --help           Show this help message
    --version            Show version information

COMMANDS:
    start                Start the application
    stop                 Stop the application
    restart              Restart the application
    status               Show application status
    install              Install the application
    uninstall            Uninstall the application
    config               Show current configuration
    test                 Run tests

EXAMPLES:
    $SCRIPT_NAME --env production start
    $SCRIPT_NAME --config /etc/myproject.conf status
    $SCRIPT_NAME --debug test

USAGE
}

# Parse command line arguments
parse_arguments() {
    local config_file=""
    local environment="development"
    local verbose=false
    local debug=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            -c|--config)
                config_file="$2"
                shift 2
                ;;
            -e|--env)
                environment="$2"
                shift 2
                ;;
            -v|--verbose)
                verbose=true
                shift
                ;;
            -d|--debug)
                debug=true
                verbose=true
                shift
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            --version)
                echo "$$SCRIPT_NAME v$$ (get_version)"
                exit 0
                ;;
            -*)
                log_error "Unknown option: $1"
                usage >&2
                exit 1
                ;;
            *)
                break
                ;;
        esac
    done
    
    # Set global variables
    ENVIRONMENT="$environment"
    VERBOSE="$verbose"
    DEBUG="$debug"
    CONFIG_FILE="$config_file"
    COMMAND="${1:-}"
    
    # Shift to get remaining arguments
    if [ $# -gt 0 ]; then
        shift
        COMMAND_ARGS=("$@")
    else
        COMMAND_ARGS=()
    fi
}

# Initialize application
initialize() {
    # Initialize logging
    local log_level="INFO"
    [ "$VERBOSE" = true ] && log_level="INFO"
    [ "$DEBUG" = true ] && log_level="DEBUG"
    
    init_logging "$log_level"
    
    # Initialize configuration
    init_config
    
    # Load configuration files
    if [ -n "$CONFIG_FILE" ]; then
        load_config "$CONFIG_FILE"
    else
        load_project_config "$ENVIRONMENT"
    fi
    
    # Validate configuration
    validate_config
    
    log_info "Application initialized (environment: $ENVIRONMENT)"
}

# Command implementations
cmd_start() {
    log_info "Starting application..."
    
    # Check if already running
    if cmd_status >/dev/null 2>&1; then
        log_error "Application is already running"
        return 1
    fi
    
    # Start application logic here
    log_info "Application started successfully"
}

cmd_stop() {
    log_info "Stopping application..."
    
    # Stop application logic here
    log_info "Application stopped successfully"
}

cmd_restart() {
    cmd_stop
    sleep 2
    cmd_start
}

cmd_status() {
    # Check application status logic here
    log_info "Application is running"
}

cmd_install() {
    log_info "Installing application..."
    
    # Installation logic here
    local install_script="$PROJECT_ROOT/scripts/install.sh"
    if [ -f "$install_script" ]; then
        bash "$install_script"
    else
        log_error "Install script not found: $install_script"
        return 1
    fi
}

cmd_uninstall() {
    log_info "Uninstalling application..."
    
    # Uninstallation logic here
    log_info "Application uninstalled successfully"
}

cmd_config() {
    echo "Current Configuration:"
    echo "===================="
    for key in "${!CONFIG[@]}"; do
        echo "$$key =$$ {CONFIG[$key]}"
    done | sort
}

cmd_test() {
    log_info "Running tests..."
    
    local test_script="$PROJECT_ROOT/tests/run_tests.sh"
    if [ -f "$test_script" ]; then
        bash "$test_script" "${COMMAND_ARGS[@]}"
    else
        log_error "Test script not found: $test_script"
        return 1
    fi
}

# Main execution function
main() {
    # Parse command line arguments
    parse_arguments "$@"
    
    # Initialize application
    initialize
    
    # Execute command
    case "$COMMAND" in
        start)
            cmd_start
            ;;
        stop)
            cmd_stop
            ;;
        restart)
            cmd_restart
            ;;
        status)
            cmd_status
            ;;
        install)
            cmd_install
            ;;
        uninstall)
            cmd_uninstall
            ;;
        config)
            cmd_config
            ;;
bash


#!/bin/bash
# File: 18_project_template.sh (continued and completed)
# Building Complex Shell Scripting Projects

        test)
            cmd_test
            ;;
        "")
            log_error "No command specified"
            usage >&2
            exit 1
            ;;
        *)
            log_error "Unknown command: $COMMAND"
            usage >&2
            exit 1
            ;;
    esac
}

# Cleanup function
cleanup() {
    local exit_code=${1:-0}
    log_debug "Performing cleanup..."
    
    # Cleanup logic here
    # - Close database connections
    # - Remove temporary files
    # - Kill background processes
    
    exit $exit_code
}

# Set up signal handlers
trap 'cleanup 130' INT   # Ctrl+C
trap 'cleanup 143' TERM  # Termination
trap 'cleanup 0' EXIT    # Normal exit

# Execute main function
main "$@"
EOF
        echo "Created bin/myproject (main application)"
    }
    
    create_main_script
    echo ""
}

# 5. TESTING FRAMEWORK
echo -e "$${YELLOW}5. Testing Framework$$ {NC}"

demonstrate_testing_framework() {
    echo -e "${GREEN}✅ Testing Framework Components:${NC}"
    
    # Create test runner
    create_test_runner() {
        cat << 'EOF'
#!/bin/bash
# tests/run_tests.sh - Test runner

# Test framework setup
TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$TEST_DIR")"

# Load project modules
source "$PROJECT_ROOT/lib/common.sh"
source "$PROJECT_ROOT/lib/logging.sh"

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Test result tracking
declare -a FAILED_TESTS=()

# Test assertion functions
assert_equals() {
    local expected="$1"
    local actual="$2"
    local message="${3:-Assertion failed}"
    
    ((TESTS_RUN++))
    
    if [ "$expected" = "$actual" ]; then
        ((TESTS_PASSED++))
        echo "✓ PASS: $message"
        return 0
    else
        ((TESTS_FAILED++))
        FAILED_TESTS+=("$message: expected '$$expected', got '$$ actual'")
        echo "✗ FAIL: $message (expected: '$expected', actual: '$actual')"
        return 1
    fi
}

assert_not_equals() {
    local not_expected="$1"
    local actual="$2"
    local message="${3:-Assertion failed}"
    
    ((TESTS_RUN++))
    
    if [ "$not_expected" != "$actual" ]; then
        ((TESTS_PASSED++))
        echo "✓ PASS: $message"
        return 0
    else
        ((TESTS_FAILED++))
        FAILED_TESTS+=("$message: expected not '$$not_expected', got '$$ actual'")
        echo "✗ FAIL: $message (should not equal: '$not_expected')"
        return 1
    fi
}

assert_true() {
    local condition="$1"
    local message="${2:-Condition should be true}"
    
    ((TESTS_RUN++))
    
    if [ "$condition" = "true" ] || [ "$condition" = "0" ]; then
        ((TESTS_PASSED++))
        echo "✓ PASS: $message"
        return 0
    else
        ((TESTS_FAILED++))
        FAILED_TESTS+=("$message: condition was false")
        echo "✗ FAIL: $message"
        return 1
    fi
}

assert_file_exists() {
    local file="$1"
    local message="${2:-File should exist: $file}"
    
    ((TESTS_RUN++))
    
    if [ -f "$file" ]; then
        ((TESTS_PASSED++))
        echo "✓ PASS: $message"
        return 0
    else
        ((TESTS_FAILED++))
        FAILED_TESTS+=("$message")
        echo "✗ FAIL: $message"
        return 1
    fi
}

# Test suite runner
run_test_suite() {
    local test_file="$1"
    
    echo "Running test suite: $(basename "$test_file")"
    echo "================================="
    
    # Source the test file
    if [ -f "$test_file" ]; then
        source "$test_file"
    else
        echo "Test file not found: $test_file"
        return 1
    fi
    
    echo ""
}

# Run all tests
run_all_tests() {
    echo "Starting test execution..."
    echo ""
    
    # Find and run all test files
    for test_file in "$TEST_DIR"/test_*.sh; do
        if [ -f "$test_file" ]; then
            run_test_suite "$test_file"
        fi
    done
    
    # Print summary
    echo "Test Summary:"
    echo "============="
    echo "Tests run: $TESTS_RUN"
    echo "Passed: $TESTS_PASSED"
    echo "Failed: $TESTS_FAILED"
    
    if [ $TESTS_FAILED -gt 0 ]; then
        echo ""
        echo "Failed tests:"
        for failed_test in "${FAILED_TESTS[@]}"; do
            echo "  - $failed_test"
        done
        return 1
    else
        echo ""
        echo "All tests passed! ✓"
        return 0
    fi
}

# Main execution
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    run_all_tests "$@"
fi
EOF
        echo "Created tests/run_tests.sh"
    }
    
    # Create sample unit tests
    create_sample_tests() {
        cat << 'EOF'
#!/bin/bash
# tests/test_common.sh - Unit tests for common functions

# Test version comparison function
test_version_compare() {
    # Test equal versions
    version_compare "1.0.0" "1.0.0"
    assert_equals "0" "$?" "Version comparison: equal versions"
    
    # Test greater version
    version_compare "2.0.0" "1.0.0"
    assert_equals "1" "$?" "Version comparison: greater version"
    
    # Test lesser version
    version_compare "1.0.0" "2.0.0"
    assert_equals "2" "$?" "Version comparison: lesser version"
}

# Test file validation
test_file_validation() {
    # Create temporary test file
    local test_file="/tmp/test_file_$$"
    echo "test content" > "$test_file"
    
    # Test existing file
    validate_file "$test_file"
    assert_equals "0" "$?" "File validation: existing file"
    
    # Test non-existent file
    validate_file "/non/existent/file"
    assert_not_equals "0" "$?" "File validation: non-existent file"
    
    # Cleanup
    rm -f "$test_file"
}

# Test command checking
test_command_check() {
    # Test existing command
    check_command "bash"
    assert_equals "0" "$?" "Command check: bash exists"
    
    # Test non-existent command
    check_command "nonexistentcommand12345"
    assert_not_equals "0" "$?" "Command check: non-existent command"
}

# Run tests
test_version_compare
test_file_validation
test_command_check
EOF
        echo "Created tests/test_common.sh"
    }
    
    create_test_runner
    create_sample_tests
    echo ""
}

# 6. PACKAGING AND DISTRIBUTION
echo -e "$${YELLOW}6. Packaging and Distribution$$ {NC}"
demonstrate_packaging() {
    echo -e "${GREEN}✅ Packaging and Distribution Components:${NC}"
    
    # Create installation script
    create_install_script() {
        cat << 'EOF'
#!/bin/bash
# scripts/install.sh - Installation script

# Installation configuration
readonly INSTALL_PREFIX="${INSTALL_PREFIX:-/usr/local}"
readonly BIN_DIR="$INSTALL_PREFIX/bin"
readonly LIB_DIR="$INSTALL_PREFIX/lib/myproject"
readonly CONFIG_DIR="${CONFIG_DIR:-/etc/myproject}"
readonly LOG_DIR="${LOG_DIR:-/var/log/myproject}"
readonly USER="${SUDO_USER:-$USER}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() {
    echo -e "${GREEN}[INFO]$${NC}$$ *"
}

log_warn() {
    echo -e "${YELLOW}[WARN]$${NC}$$ *"
}

log_error() {
    echo -e "${RED}[ERROR]$${NC}$$ *"
}

# Check prerequisites
check_prerequisites() {
    log_info "Checking prerequisites..."
    
    # Check if running as root for system installation
    if [ "$EUID" -ne 0 ] && [[ "$INSTALL_PREFIX" == "/usr"* ]]; then
        log_error "Root privileges required for system installation"
        log_info "Run with sudo or set INSTALL_PREFIX to user directory"
        exit 1
    fi
    
    # Check required commands
    local required_commands=("bash" "mkdir" "cp" "chmod")
    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            log_error "Required command not found: $cmd"
            exit 1
        fi
    done
    
    log_info "Prerequisites check passed"
}

# Create directories
create_directories() {
    log_info "Creating directories..."
    
    local dirs=("$BIN_DIR" "$LIB_DIR" "$CONFIG_DIR" "$LOG_DIR")
    
    for dir in "${dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir" || {
                log_error "Failed to create directory: $dir"
                exit 1
            }
            log_info "Created directory: $dir"
        fi
    done
}

# Install files
install_files() {
    log_info "Installing files..."
    
    # Install main executable
    cp "bin/myproject" "$BIN_DIR/" || {
        log_error "Failed to install main executable"
        exit 1
    }
    chmod 755 "$BIN_DIR/myproject"
    log_info "Installed: $BIN_DIR/myproject"
    
    # Install library modules
    cp -r lib/* "$LIB_DIR/" || {
        log_error "Failed to install library modules"
        exit 1
    }
    chmod 644 "$LIB_DIR"/*.sh
    log_info "Installed library modules to: $LIB_DIR"
    
    # Install configuration files
    if [ ! -f "$CONFIG_DIR/myproject.conf" ]; then
        cp "config/default.conf" "$CONFIG_DIR/myproject.conf" || {
            log_error "Failed to install configuration"
            exit 1
        }
        chmod 640 "$CONFIG_DIR/myproject.conf"
        log_info "Installed configuration: $CONFIG_DIR/myproject.conf"
    else
        log_warn "Configuration file already exists: $CONFIG_DIR/myproject.conf"
    fi
    
    # Set proper ownership for log directory
    if [ -n "$USER" ] && [ "$USER" != "root" ]; then
        chown -R "$USER:$USER" "$LOG_DIR" 2>/dev/null || true
    fi
    chmod 755 "$LOG_DIR"
}

# Create systemd service (optional)
install_service() {
    if command -v systemctl &> /dev/null && [ -d "/etc/systemd/system" ]; then
        log_info "Installing systemd service..."
        
        cat > "/etc/systemd/system/myproject.service" << SERVICE
[Unit]
Description=MyProject Application
After=network.target

[Service]
Type=simple
User=${USER}
ExecStart=${BIN_DIR}/myproject start
ExecStop=${BIN_DIR}/myproject stop
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
SERVICE
        
        systemctl daemon-reload
        log_info "Systemd service installed. Enable with: systemctl enable myproject"
    fi
}

# Update PATH
update_path() {
    if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
        log_info "Adding $BIN_DIR to PATH..."
        echo "export PATH=\"$BIN_DIR:\$PATH\"" >> ~/.bashrc
        log_info "PATH updated. Restart shell or run: source ~/.bashrc"
    fi
}

# Main installation
main() {
    log_info "Starting MyProject installation..."
    
    check_prerequisites
    create_directories
    install_files
    
    # Optional components
    if [ "${INSTALL_SERVICE:-true}" = "true" ]; then
        install_service
    fi
    
    if [ "${UPDATE_PATH:-true}" = "true" ]; then
        update_path
    fi
    
    log_info "Installation completed successfully!"
    log_info "Run 'myproject --help' to get started"
}

main "$@"
EOF
        echo "Created scripts/install.sh"
    }
    
    # Create packaging script
    create_package_script() {
        cat << 'EOF'
#!/bin/bash
# scripts/package.sh - Create distribution packages

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
VERSION=$(cat "$PROJECT_ROOT/VERSION" 2>/dev/null || echo "1.0.0")
PACKAGE_NAME="myproject"

# Create tarball package
create_tarball() {
    local output_dir="${1:-./dist}"
    local package_file="$$output_dir/$$ {PACKAGE_NAME}-${VERSION}.tar.gz"
    
    echo "Creating tarball package..."
    
    # Create output directory
    mkdir -p "$output_dir"
    
    # Create temporary directory for packaging
    local temp_dir=$(mktemp -d)
    local package_dir="$$temp_dir/$$ {PACKAGE_NAME}-${VERSION}"
    
    # Copy project files
    mkdir -p "$package_dir"
    cp -r "$PROJECT_ROOT"/{bin,lib,config,scripts,docs} "$package_dir/" 2>/dev/null || true
    cp "$PROJECT_ROOT"/{VERSION,LICENSE,README.md} "$package_dir/" 2>/dev/null || true
    
    # Create tarball
    (cd "$temp_dir" && tar -czf "$package_file" "$${PACKAGE_NAME}-$$ {VERSION}")
    
    # Cleanup
    rm -rf "$temp_dir"
    
    echo "Package created: $package_file"
    echo "Size: $(du -h "$package_file" | cut -f1)"
}

# Create DEB package (continued)
create_deb_package() {
    local output_dir="${1:-./dist}"
    
    echo "Creating DEB package..."
    
    # Check if dpkg-deb is available
    if ! command -v dpkg-deb &> /dev/null; then
        echo "dpkg-deb not found. Skipping DEB package creation."
        return 1
    fi
    
    # Create package structure
    local temp_dir=$(mktemp -d)
    local package_dir="$$temp_dir/$$ {PACKAGE_NAME}_${VERSION}"
    
    # Create DEBIAN control directory
    mkdir -p "$package_dir/DEBIAN"
    
    # Create control file
    cat > "$package_dir/DEBIAN/control" << CONTROL
Package: $PACKAGE_NAME
Version: $VERSION
Section: utils
Priority: optional
Architecture: all
Depends: bash (>= 4.0)
Maintainer: Your Name <your.email@example.com>
Description: MyProject - A complex shell scripting application
 This package provides a modular shell scripting framework
 with configuration management, logging, and testing capabilities.
CONTROL
    
    # Create postinst script
    cat > "$package_dir/DEBIAN/postinst" << POSTINST
#!/bin/bash
set -e

# Create log directory
mkdir -p /var/log/myproject
chmod 755 /var/log/myproject

# Create config directory if it doesn't exist
if [ ! -d /etc/myproject ]; then
    mkdir -p /etc/myproject
    chmod 755 /etc/myproject
fi

echo "MyProject installed successfully!"
echo "Run 'myproject --help' to get started"
POSTINST
    
    chmod 755 "$package_dir/DEBIAN/postinst"
    
    # Create prerm script
    cat > "$package_dir/DEBIAN/prerm" << PRERM
#!/bin/bash
set -e

# Stop service if running
if systemctl is-active --quiet myproject 2>/dev/null; then
    systemctl stop myproject
fi

# Disable service
if systemctl is-enabled --quiet myproject 2>/dev/null; then
    systemctl disable myproject
fi
PRERM
    
    chmod 755 "$package_dir/DEBIAN/prerm"
    
    # Copy application files
    mkdir -p "$package_dir/usr/local/bin"
    mkdir -p "$package_dir/usr/local/lib/myproject"
    mkdir -p "$package_dir/etc/myproject"
    
    cp "$PROJECT_ROOT/bin/myproject" "$package_dir/usr/local/bin/"
    cp -r "$PROJECT_ROOT/lib"/* "$package_dir/usr/local/lib/myproject/"
    cp "$PROJECT_ROOT/config/default.conf" "$package_dir/etc/myproject/myproject.conf"
    
    # Set permissions
    chmod 755 "$package_dir/usr/local/bin/myproject"
    chmod 644 "$package_dir/usr/local/lib/myproject"/*.sh
    chmod 640 "$package_dir/etc/myproject/myproject.conf"
    
    # Build package
    mkdir -p "$output_dir"
    dpkg-deb --build "$package_dir" "$output_dir"
    
    # Cleanup
    rm -rf "$temp_dir"
    
    echo "DEB package created in: $output_dir"
}

# Create RPM package
create_rpm_package() {
    local output_dir="${1:-./dist}"
    
    echo "Creating RPM package..."
    
    # Check if rpmbuild is available
    if ! command -v rpmbuild &> /dev/null; then
        echo "rpmbuild not found. Skipping RPM package creation."
        return 1
    fi
    
    # Create RPM build structure
    local rpm_root="$HOME/rpmbuild"
    mkdir -p "$rpm_root"/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
    
    # Create source tarball
    local source_dir="$rpm_root/SOURCES"
    create_tarball "$source_dir"
    
    # Create spec file
    cat > "$$rpm_root/SPECS/$$ {PACKAGE_NAME}.spec" << SPEC
Name:           $PACKAGE_NAME
Version:        $VERSION
Release:        1%{?dist}
Summary:        A complex shell scripting application
License:        MIT
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch
Requires:       bash >= 4.0

%description
MyProject is a modular shell scripting framework with configuration
management, logging, and testing capabilities.

%prep
%setup -q

%build
# No build required for shell scripts

%install
rm -rf \$RPM_BUILD_ROOT
mkdir -p \$RPM_BUILD_ROOT/usr/local/bin
mkdir -p \$RPM_BUILD_ROOT/usr/local/lib/myproject
mkdir -p \$RPM_BUILD_ROOT/etc/myproject

cp bin/myproject \$RPM_BUILD_ROOT/usr/local/bin/
cp -r lib/* \$RPM_BUILD_ROOT/usr/local/lib/myproject/
cp config/default.conf \$RPM_BUILD_ROOT/etc/myproject/myproject.conf

%files
%defattr(-,root,root,-)
/usr/local/bin/myproject
/usr/local/lib/myproject/
%config(noreplace) /etc/myproject/myproject.conf

%post
mkdir -p /var/log/myproject
chmod 755 /var/log/myproject
echo "MyProject installed successfully!"

%changelog
* $(date '+%a %b %d %Y') Your Name <your.email@example.com> - $VERSION-1
- Initial package
SPEC
    
    # Build RPM
    rpmbuild -ba "$$rpm_root/SPECS/$$ {PACKAGE_NAME}.spec"
    
    # Copy to output directory
    mkdir -p "$output_dir"
    cp "$$rpm_root/RPMS/noarch/$$ {PACKAGE_NAME}-${VERSION}-1"*.rpm "$output_dir/"
    
    echo "RPM package created in: $output_dir"
}

# Main packaging function
main() {
    local format="${1:-all}"
    local output_dir="${2:-./dist}"
    
    echo "Creating packages for MyProject v$VERSION"
    echo "Output directory: $output_dir"
    
    case "$format" in
        "tarball"|"tar")
            create_tarball "$output_dir"
            ;;
        "deb")
            create_deb_package "$output_dir"
            ;;
        "rpm")
            create_rpm_package "$output_dir"
            ;;
        "all")
            create_tarball "$output_dir"
            create_deb_package "$output_dir"
            create_rpm_package "$output_dir"
            ;;
        *)
            echo "Unknown format: $format"
            echo "Usage: $0 [tarball|deb|rpm|all] [output_dir]"
            exit 1
            ;;
    esac
    
    echo "Packaging completed!"
}

main "$@"
EOF
        echo "Created scripts/package.sh"
    }
    
    # Create Makefile for build automation
# Create Makefile for build automation (continued)
create_makefile() {
    cat << 'EOF'
# Makefile for MyProject

# Project configuration
PROJECT_NAME := myproject
VERSION := $(shell cat VERSION 2>/dev/null || echo "1.0.0")
INSTALL_PREFIX := /usr/local
CONFIG_DIR := /etc/myproject

# Directories
BIN_DIR := bin
LIB_DIR := lib
CONFIG_DIR_SRC := config
SCRIPTS_DIR := scripts
TESTS_DIR := tests
DIST_DIR := dist

# Default target
.PHONY: all
all: test package

# Run tests
.PHONY: test
test:
	@echo "Running tests..."
	@bash $(TESTS_DIR)/run_tests.sh

# Create packages
.PHONY: package
package: clean-dist
	@echo "Creating packages..."
	@bash $$(SCRIPTS_DIR)/package.sh all$$ (DIST_DIR)

# Install application
.PHONY: install
install:
	@echo "Installing $(PROJECT_NAME)..."
	@sudo bash $(SCRIPTS_DIR)/install.sh

# Uninstall application
.PHONY: uninstall
uninstall:
	@echo "Uninstalling $(PROJECT_NAME)..."
	@sudo rm -f $$(INSTALL_PREFIX)/bin/$$ (PROJECT_NAME)
	@sudo rm -rf $$(INSTALL_PREFIX)/lib/$$ (PROJECT_NAME)
	@sudo rm -f /etc/systemd/system/$(PROJECT_NAME).service
	@sudo systemctl daemon-reload 2>/dev/null || true

# Clean build artifacts
.PHONY: clean
clean:
	@echo "Cleaning build artifacts..."
	@rm -rf $(DIST_DIR)
	@find . -name "*.tmp" -delete
	@find . -name "*.log" -delete

# Clean distribution files
.PHONY: clean-dist
clean-dist:
	@rm -rf $(DIST_DIR)
	@mkdir -p $(DIST_DIR)

# Development setup
.PHONY: dev-setup
dev-setup:
	@echo "Setting up development environment..."
	@chmod +x $$(BIN_DIR)/$$ (PROJECT_NAME)
	@chmod +x $(SCRIPTS_DIR)/*.sh
	@chmod +x $(TESTS_DIR)/*.sh

# Lint shell scripts
.PHONY: lint
lint:
	@echo "Linting shell scripts..."
	@if command -v shellcheck >/dev/null 2>&1; then \
		find . -name "*.sh" -exec shellcheck {} +; \
	else \
		echo "shellcheck not found. Install it for linting support."; \
	fi

# Format shell scripts
.PHONY: format
format:
	@echo "Formatting shell scripts..."
	@if command -v shfmt >/dev/null 2>&1; then \
		find . -name "*.sh" -exec shfmt -w -i 4 {} +; \
	else \
		echo "shfmt not found. Install it for formatting support."; \
	fi

# Security check
.PHONY: security-check
security-check:
	@echo "Running security checks..."
	@bash $$(BIN_DIR)/$$ (PROJECT_NAME) --security-test 2>/dev/null || echo "Security test not implemented"

# Release preparation
.PHONY: release
release: clean lint test package
	@echo "Release $(VERSION) prepared successfully!"
	@echo "Packages available in $(DIST_DIR)/"

# Help target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all          - Run tests and create packages"
	@echo "  test         - Run all tests"
	@echo "  package      - Create distribution packages"
	@echo "  install      - Install application system-wide"
	@echo "  uninstall    - Remove installed application"
	@echo "  clean        - Clean build artifacts"
	@echo "  dev-setup    - Setup development environment"
	@echo "  lint         - Lint shell scripts with shellcheck"
	@echo "  format       - Format shell scripts with shfmt"
	@echo "  security-check - Run security checks"
	@echo "  release      - Prepare release (lint, test, package)"
	@echo "  help         - Show this help message"
EOF
        echo "Created Makefile"
    }
    
    create_install_script
    create_package_script
    create_makefile
    echo ""
}

# 7. DOCUMENTATION AND README
echo -e "$${YELLOW}7. Documentation Templates$$ {NC}"

demonstrate_documentation() {
    echo -e "${GREEN}✅ Documentation Templates:${NC}"
    
    # Create README.md
    create_readme() {
        cat << 'EOF'
# MyProject

A modular shell scripting framework with advanced features for building complex applications.

## Features

- **Modular Architecture**: Organized library modules for different functionalities
- **Configuration Management**: Flexible configuration system with environment support
- **Advanced Logging**: Multi-level logging with file rotation
- **Testing Framework**: Built-in testing capabilities with assertions
- **Security**: Built-in security best practices and validation
- **Packaging**: Support for multiple distribution formats (tar, deb, rpm)

## Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/myproject.git
cd myproject

# Install system-wide
sudo make install

# Or install to custom location
INSTALL_PREFIX=$HOME/.local make install
