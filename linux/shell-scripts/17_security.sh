#!/bin/bash
# File: 17_security.sh
# Shell Scripting Security Best Practices

# Colors for output formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

echo -e "$${BLUE}=== Shell Scripting Security Best Practices ===$$ {NC}\n"

# 1. HANDLING SENSITIVE DATA SECURELY
echo -e "$${YELLOW}1. Handling Sensitive Data$$ {NC}"

# BAD: Hardcoding sensitive information [citation:8](#)
demonstrate_bad_practices() {
    echo -e "${RED}❌ BAD PRACTICES (DO NOT USE):${NC}"
    echo "# Never hardcode sensitive data like this:"
    echo 'PASSWORD="secret123"'
    echo 'API_KEY="sk-1234567890abcdef"'
    echo 'DB_CONNECTION="mysql://user:password@host/db"'
    echo ""
}

# GOOD: Secure handling of sensitive data
demonstrate_secure_data_handling() {
    echo -e "${GREEN}✅ SECURE PRACTICES:${NC}"
    
    # Method 1: Environment variables
    echo "Method 1: Using environment variables"
    cat << 'EOF'
# Set in environment or .env file (not in script)
export DB_PASSWORD="${DB_PASSWORD:-}"
export API_KEY="${API_KEY:-}"

# In script - check if variables are set
if [ -z "$DB_PASSWORD" ]; then
    echo "Error: DB_PASSWORD environment variable not set" >&2
    exit 1
fi
EOF
    
    echo -e "\nMethod 2: Reading from secure files"
    cat << 'EOF'
# Read from file with restricted permissions (600)
if [ -f "/etc/myapp/credentials" ]; then
    source /etc/myapp/credentials
else
    echo "Credentials file not found" >&2
    exit 1
fi
EOF
    
    echo -e "\nMethod 3: Prompting for sensitive input"
    cat << 'EOF'
# Prompt for password without echoing
read -s -p "Enter password: " password
echo # New line after hidden input
EOF
    
    # Demonstrate secure password reading
    echo -e "\n${PURPLE}Demo: Secure password input${NC}"
    secure_password_input() {
        local password
        echo -n "Enter a test password (input hidden): "
        read -s password
        echo ""
        if [ ${#password} -ge 8 ]; then
            echo -e "${GREEN}Password accepted (length: ${#password})${NC}"
        else
            echo -e "$${RED}Password too short$$ {NC}"
        fi
        # Clear password from memory
        unset password
    }
    secure_password_input
    echo ""
}

# 2. AVOIDING INJECTION VULNERABILITIES
echo -e "$${YELLOW}2. Preventing Code Injection Vulnerabilities$$ {NC}"

# Demonstrate injection vulnerabilities and prevention [citation:5](#)
demonstrate_injection_prevention() {
    echo -e "${RED}❌ VULNERABLE CODE EXAMPLES:${NC}"
    
    echo "# Command injection vulnerability:"
    echo 'user_input="test; rm -rf /"'
    echo 'eval "ls $user_input"  # DANGEROUS!'
    echo ""
    
    echo "# SQL injection potential:"
    echo 'query="SELECT * FROM users WHERE name = $user_name"'
    echo 'mysql -e "$query"  # VULNERABLE if user_name not sanitized'
    echo ""
    
    echo -e "${GREEN}✅ SECURE ALTERNATIVES:${NC}"
    
    # Safe input validation
    validate_input() {
        local input="$1"
        local pattern="^[a-zA-Z0-9_-]+$"
        
        if [[ "$input" =~ $pattern ]]; then
            echo -e "${GREEN}Input validated: $$input$$ {NC}"
            return 0
        else
            echo -e "${RED}Invalid input detected: $$input$$ {NC}"
            return 1
        fi
    }
    
    # Demonstrate safe input handling
    echo "Function: validate_input()"
    validate_input "safe_input"
    validate_input "dangerous; rm -rf /"
    
    echo -e "\n${PURPLE}Safe variable usage with quotes:${NC}"
    cat << 'EOF'
# Always quote variables to prevent word splitting
safe_file_operation() {
    local filename="$1"
    if [ -f "$filename" ]; then
        # Quoted variables prevent injection
        cp "$filename" "${filename}.backup"
    fi
}
EOF
    
    echo -e "\n${PURPLE}Using arrays for command arguments:${NC}"
    cat << 'EOF'
# Safe way to build commands with user input
build_safe_command() {
    local -a cmd_args=()
    cmd_args+=("ls")
    cmd_args+=("-la")
    cmd_args+=("$user_directory")  # Safely quoted
    
    "${cmd_args[@]}"  # Execute with proper quoting
}
EOF
    echo ""
}

# Input sanitization functions
sanitize_filename() {
    local filename="$1"
    # Remove dangerous characters and paths
    filename=$(echo "$filename" | sed 's/[^a-zA-Z0-9._-]//g')
    filename=$(basename "$filename")  # Remove path components
    echo "$filename"
}

sanitize_sql_input() {
    local input="$1"
    # Escape single quotes and remove dangerous characters
    input=$(echo "$input" | sed "s/'/''/g" | sed 's/[;<>&|`$]//g')
    echo "$input"
}

demonstrate_sanitization() {
    echo -e "${PURPLE}Input Sanitization Examples:${NC}"
    
    dangerous_file="../../../etc/passwd"
    safe_file=$(sanitize_filename "$dangerous_file")
    echo "Original: $dangerous_file"
    echo "Sanitized: $safe_file"
    
    dangerous_sql="'; DROP TABLE users; --"
    safe_sql=$(sanitize_sql_input "$dangerous_sql")
    echo "SQL Original: $dangerous_sql"
    echo "SQL Sanitized: $safe_sql"
    echo ""
}

# 3. SECURE TEMPORARY FILES AND DIRECTORIES
echo -e "$${YELLOW}3. Secure Temporary Files and Directories$$ {NC}"

# Demonstrate secure temporary file creation [citation:3](#)[citation:4](#)[citation:9](#)
demonstrate_secure_temp_files() {
    echo -e "${RED}❌ INSECURE TEMPORARY FILE PRACTICES:${NC}"
    cat << 'EOF'
# NEVER do this - predictable names, race conditions
temp_file="/tmp/myapp_$$"
echo "sensitive data" > $temp_file

# NEVER use world-writable directories unsafely
temp_dir="/tmp/myapp"
mkdir $temp_dir
EOF
    
    echo -e "\n${GREEN}✅ SECURE TEMPORARY FILE PRACTICES:${NC}"
    
    # Method 1: Using mktemp for files
    create_secure_temp_file() {
        local temp_file
        temp_file=$(mktemp) || {
            echo "Failed to create temporary file" >&2
            return 1
        }
        
        # Set restrictive permissions immediately [citation:4](#)
        chmod 600 "$temp_file"
        
        echo "Created secure temp file: $temp_file"
        echo "Permissions: $(ls -l "$temp_file" | cut -d' ' -f1)"
        
        # Use the temp file
        echo "This is sensitive data" > "$temp_file"
        
        # Always clean up
        rm -f "$temp_file"
        echo "Temp file cleaned up"
    }
    
    # Method 2: Using mktemp for directories
    create_secure_temp_dir() {
        local temp_dir
        temp_dir=$(mktemp -d) || {
            echo "Failed to create temporary directory
           temp_dir=$(mktemp -d) || {
            echo "Failed to create temporary directory" >&2
            return 1
        }
        
        # Set restrictive permissions
        chmod 700 "$temp_dir"
        
        echo "Created secure temp directory: $temp_dir"
        echo "Permissions: $(ls -ld "$temp_dir" | cut -d' ' -f1)"
        
        # Use the temp directory
        echo "sensitive file content" > "$temp_dir/secret.txt"
        chmod 600 "$temp_dir/secret.txt"
        
        # Always clean up
        rm -rf "$temp_dir"
        echo "Temp directory cleaned up"
    }
    
    # Method 3: Secure temp file with custom template
    create_custom_temp_file() {
        local temp_file
        temp_file=$(mktemp /tmp/myapp.XXXXXX) || {
            echo "Failed to create custom temp file" >&2
            return 1
        }
        
        # Set umask for additional security
        local old_umask=$(umask)
        umask 077  # Only owner can read/write
        
        echo "Custom temp file: $temp_file"
        echo "Current umask: $(umask)"
        
        # Restore original umask
        umask "$old_umask"
        
        # Cleanup
        rm -f "$temp_file"
    }
    
    echo "Demonstrating secure temporary file creation:"
    create_secure_temp_file
    echo ""
    
    echo "Demonstrating secure temporary directory creation:"
    create_secure_temp_dir
    echo ""
    
    echo "Demonstrating custom temp file with umask:"
    create_custom_temp_file
    echo ""
}

# 4. FILE PERMISSIONS AND ACCESS CONTROL
echo -e "$${YELLOW}4. File Permissions and Access Control$$ {NC}"

demonstrate_file_security() {
    echo -e "${GREEN}✅ Secure File Handling Practices:${NC}"
    
    # Create a demo file with proper permissions
    secure_file_creation() {
        local filename="$1"
        local content="$2"
        
        # Create file with restrictive permissions from start
        (umask 077; echo "$content" > "$filename")
        
        # Verify permissions
        echo "Created file: $filename"
        echo "Permissions: $(ls -l "$filename" 2>/dev/null | cut -d' ' -f1)"
        
        # Additional security check
        if [ -O "$filename" ] && [ ! -g "$filename" ] && [ ! -o "$filename" ]; then
            echo -e "${GREEN}File security: OK${NC}"
        else
            echo -e "${RED}File security: WARNING${NC}"
        fi
        
        # Cleanup
        rm -f "$filename"
    }
    
    echo "Creating secure file with sensitive content:"
    secure_file_creation "test_secure.txt" "This is sensitive information"
    echo ""
    
    # Demonstrate secure directory creation
    secure_directory_creation() {
        local dirname="$1"
        
        # Create directory with secure permissions
        mkdir -m 700 "$dirname" 2>/dev/null || {
            echo "Failed to create directory: $dirname" >&2
            return 1
        }
        
        echo "Created directory: $dirname"
        echo "Permissions: $(ls -ld "$dirname" | cut -d' ' -f1)"
        
        # Cleanup
        rmdir "$dirname"
    }
    
    echo "Creating secure directory:"
    secure_directory_creation "test_secure_dir"
    echo ""
}

# 5. SECURE SCRIPT EXECUTION
echo -e "$${YELLOW}5. Secure Script Execution Practices$$ {NC}"

demonstrate_secure_execution() {
    echo -e "${GREEN}✅ Secure Execution Practices:${NC}"
    
    # Set secure defaults
    echo "Setting secure script defaults:"
    cat << 'EOF'
#!/bin/bash
# Secure script header
set -euo pipefail  # Exit on error, undefined vars, pipe failures
IFS=$'\n\t'        # Secure Internal Field Separator

# Set secure PATH
export PATH="/usr/local/bin:/usr/bin:/bin"

# Clear environment of potentially dangerous variables
unset CDPATH
unset GLOBIGNORE
EOF
    
    echo -e "\n${PURPLE}Validating script environment:${NC}"
    
    # Check if running as root (usually not recommended)
    check_privileges() {
        if [ "$EUID" -eq 0 ]; then
            echo -e "${RED}WARNING: Running as root! Consider using a less privileged user.${NC}"
        else
            echo -e "${GREEN}Running as non-root user: $$(whoami)$$ {NC}"
        fi
    }
    
    # Validate PATH security
    validate_path() {
        echo "Current PATH: $PATH"
        
        # Check for world-writable directories in PATH
        IFS=':'
        for dir in $PATH; do
            if [ -d "$dir" ] && [ -w "$dir" ]; then
                if [ "$(stat -c %a "$dir" 2>/dev/null)" -gt 755 ]; then
                    echo -e "${RED}WARNING: World-writable directory in PATH: $$dir$$ {NC}"
                fi
            fi
        done
        IFS=$'\n\t'
    }
    
    check_privileges
    validate_path
    echo ""
}

# 6. LOGGING AND AUDITING
echo -e "$${YELLOW}6. Security Logging and Auditing$$ {NC}"

demonstrate_secure_logging() {
    echo -e "${GREEN}✅ Secure Logging Practices:${NC}"
    
    # Secure logging function
    secure_log() {
        local level="$1"
        local message="$2"
        local logfile="${3:-/var/log/myapp.log}"
        
        # Create log entry with timestamp
        local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        local log_entry="[$timestamp] [$level] $message"
        
        # Log to file with proper permissions
        if [ -w "$(dirname "$logfile")" ]; then
            echo "$log_entry" >> "$logfile"
            chmod 640 "$logfile" 2>/dev/null
        fi
        
        # Also log to syslog for security events
        case "$level" in
            "SECURITY"|"ERROR")
                logger -p auth.warning "$log_entry"
                ;;
        esac
        
        echo "$log_entry"
    }
    
    # Demonstrate logging
    echo "Security logging examples:"
    secure_log "INFO" "Application started"
    secure_log "SECURITY" "Failed login attempt from user: testuser"
    secure_log "ERROR" "Permission denied accessing sensitive file"
    echo ""
    
    # Audit trail function
    create_audit_trail() {
        local action="$1"
        local resource="$2"
        local user="${3:-$(whoami)}"
        
        secure_log "AUDIT" "User '$$user' performed '$$ action' on '$resource'"
    }
    
    echo "Audit trail examples:"
    create_audit_trail "READ" "/etc/passwd"
    create_audit_trail "WRITE" "/tmp/sensitive.txt"
    create_audit_trail "DELETE" "/tmp/old_file.txt"
    echo ""
}

# 7. SECURE NETWORK OPERATIONS
echo -e "$${YELLOW}7. Secure Network Operations$$ {NC}"

demonstrate_secure_network() {
    echo -e "${GREEN}✅ Secure Network Practices:${NC}"
    
    # Secure curl/wget usage
    echo "Secure HTTP client practices:"
    cat << 'EOF'
# Always validate SSL certificates
curl_secure() {
    local url="$1"
    local output="$2"
    
    curl --fail \
         --silent \
         --show-error \
         --location \
         --max
    echo "Secure HTTP client practices:"
    cat << 'EOF'
# Always validate SSL certificates
curl_secure() {
    local url="$1"
    local output="$2"
    
    curl --fail \
         --silent \
         --show-error \
         --location \
         --max-time 30 \
         --connect-timeout 10 \
         --cacert /etc/ssl/certs/ca-certificates.crt \
         --user-agent "MyApp/1.0" \
         --output "$output" \
         "$url"
}

# Secure wget usage
wget_secure() {
    local url="$1"
    local output="$2"
    
    wget --quiet \
         --timeout=30 \
         --tries=3 \
         --no-check-certificate=false \
         --ca-certificate=/etc/ssl/certs/ca-certificates.crt \
         --output-document="$output" \
         "$url"
}
EOF

    echo -e "\n${PURPLE}Network security validation:${NC}"
    
    # Validate URLs before making requests
    validate_url() {
        local url="$1"
        
        # Check for valid HTTPS URLs only
        if [[ "$url" =~ ^https://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?$ ]]; then
            echo -e "${GREEN}URL validation: PASSED - $$url$$ {NC}"
            return 0
        else
            echo -e "${RED}URL validation: FAILED - $$url$$ {NC}"
            return 1
        fi
    }
    
    # Test URL validation
    validate_url "https://api.example.com/data"
    validate_url "http://insecure.example.com"  # Should fail
    validate_url "https://malicious-site.com/../../../etc/passwd"  # Should fail
    echo ""
}

# 8. SECURE CONFIGURATION MANAGEMENT
echo -e "$${YELLOW}8. Secure Configuration Management$$ {NC}"

demonstrate_secure_config() {
    echo -e "${GREEN}✅ Secure Configuration Practices:${NC}"
    
    # Secure configuration file handling
    load_secure_config() {
        local config_file="$1"
        
        # Validate config file exists and has proper permissions
        if [ ! -f "$config_file" ]; then
            echo -e "${RED}Config file not found: $$config_file$$ {NC}" >&2
            return 1
        fi
        
        # Check file permissions (should not be world-readable)
        local perms=$(stat -c %a "$config_file" 2>/dev/null)
        if [ "$perms" -gt 640 ]; then
            echo -e "${RED}WARNING: Config file has overly permissive permissions: $$perms$$ {NC}" >&2
        fi
        
        # Check file ownership
        if [ ! -O "$config_file" ]; then
            echo -e "${RED}WARNING: Config file not owned by current user${NC}" >&2
        fi
        
        # Safely source the config file
        set +u  # Temporarily allow undefined variables
        source "$config_file"
        set -u
        
        echo -e "${GREEN}Config loaded successfully from: $$config_file$$ {NC}"
    }
    
    # Create a sample secure config file
    create_sample_config() {
        local config_file="/tmp/secure_config_demo.conf"
        
        cat > "$config_file" << 'EOF'
# Secure configuration file
# No sensitive data should be stored here in plain text

# Application settings
APP_NAME="MySecureApp"
APP_VERSION="1.0.0"
LOG_LEVEL="INFO"

# Paths (no credentials)
DATA_DIR="/var/lib/myapp"
LOG_DIR="/var/log/myapp"

# External service endpoints (no API keys here)
API_BASE_URL="https://api.example.com"
DATABASE_HOST="localhost"
DATABASE_PORT="5432"

# Feature flags
ENABLE_LOGGING="true"
ENABLE_METRICS="true"
EOF
        
        # Set secure permissions
        chmod 640 "$config_file"
        
        echo "Created sample config: $config_file"
        load_secure_config "$config_file"
        
        # Cleanup
        rm -f "$config_file"
    }
    
    create_sample_config
    echo ""
}

# 9. SECURE ERROR HANDLING
echo -e "$${YELLOW}9. Secure Error Handling$$ {NC}"

demonstrate_secure_error_handling() {
    echo -e "${GREEN}✅ Secure Error Handling Practices:${NC}"
    
    # Secure error reporting (don't leak sensitive info)
    secure_error_handler() {
        local exit_code=$?
        local line_number=${1:-"unknown"}
        
        # Log detailed error for debugging (to secure log)
        secure_log "ERROR" "Script error at line $line_number (exit code: $exit_code)"
        
        # Show generic error to user (don't reveal system details)
        echo -e "$${RED}An error occurred. Please check the logs or contact support.$$ {NC}" >&2
        
        # Cleanup any temporary files
        cleanup_on_error
        
        exit $exit_code
    }
    
    # Cleanup function for error conditions
    cleanup_on_error() {
        # Remove any temporary files created by the script
        find /tmp -name "myapp_*" -user "$(whoami)" -type f -mmin -60 -delete 2>/dev/null || true
        
        # Kill any background processes started by this script
        jobs -p | xargs -r kill 2>/dev/null || true
    }
    
    # Set up error trapping
    trap 'secure_error_handler ${LINENO}' ERR
    
    echo "Error handling configured with secure cleanup"
    
    # Demonstrate safe error handling
    safe_file_operation() {
        local filename="$1"
        
        # Validate input
        if [ -z "$filename" ]; then
            secure_log "ERROR" "Filename parameter is empty"
            echo -e "$${RED}Invalid filename provided$$ {NC}" >&2
            return 1
        fi
        
        # Sanitize filename
        filename=$(sanitize_filename "$filename")
        
        # Perform operation with error checking
        if [ -f "$filename" ]; then
            echo -e "${GREEN}File exists: $$filename$$ {NC}"
        else
            echo -e "${YELLOW}File not found: $$filename$$ {NC}"
        fi
    }
    
    echo "Testing secure file operation:"
    safe_file_operation "test.txt"
    safe_file_operation ""  # This will trigger error handling
    echo ""
}

# 10. SECURITY CHECKLIST AND BEST PRACTICES SUMMARY
echo -e "$${YELLOW}10. Security Checklist$$ {NC}"

display_security_checklist() {
    echo -e "${GREEN}✅ Shell Script Security Checklist:${NC}"
    
    cat << 'EOF'

SENSITIVE DATA:
□ Never hardcode passwords, API keys, or secrets
□ Use environment variables or secure config files
□ Prompt for sensitive input with read -s
□ Clear sensitive variables after use: unset variable
□ Use proper file permissions (600/640) for config files

INJECTION PREVENTION:
□ Always quote variables: "$variable"
□ Validate and sanitize all user input
□ Use arrays for command arguments: "${cmd_args[@]}"
□ Avoid eval and dynamic command construction
□ Use parameter expansion instead of external commands when possible

TEMPORARY FILES:
□ Use mktemp for creating temporary files/directories
□ Set restrictive permissions immediately: chmod 600
□ Always clean up temporary files in exit handlers
□ Use umask 077 for additional security
□ Never use predictable temporary file names

FILE SECURITY:
□ Check file permissions before reading sensitive files
□ Verify file ownership: [ -O "$file" ]
□ Create files with secure permissions from start
□ Use absolute paths when possible
□ Validate file paths to prevent directory traversal

EXECUTION SECURITY:
□ Set secure script options: set -euo pipefail
□ Use secure PATH: export PATH="/usr/local/bin:/usr/bin:/bin"
□ Clear dangerous environment variables: unset CDPATH
□ Don't run scripts as root unless absolutely necessary
□ Validate script integrity with checksums

NETWORK SECURITY:
□ Always use HTTPS for external communications
□ Validate SSL certificates (don't use --insecure)
□ Set reasonable timeouts for network operations
□ Validate URLs before making requests
□ Use proper User-Agent headers

LOGGING AND AUDITING:
□ Log security-relevant events
□ Use secure log file permissions (640)
□ Don't log sensitive data (passwords, keys)
□ Include timestamps in log entries
□ Send critical events to syslog

ERROR HANDLING:
□ Don't expose system details in error messages
□ Clean up resources on script exit
□ Use trap handlers for cleanup
□ Log detailed errors securely
□ Provide generic user-facing error messages

GENERAL PRACTICES:
□ Regular security reviews of scripts
□ Use version control for script changes
□ Document security assumptions
□ Test with different input scenarios
□ Keep scripts updated and patched
EOF

    echo ""
}

# 11. SECURITY TESTING AND VALIDATION
echo -e "$${YELLOW}11. Security Testing Functions$$ {NC}"

security_test_suite() {
    echo -e "${GREEN}✅ Running Security Tests:${NC}"
    
    local test_count=0
    local passed_tests=0
    
    # Test 1: Check script permissions
    test_script_permissions() {
        ((test_count++))
        local script_perms=$(stat -c %a "$0" 2>/dev/null)
        
        if [ "$script_perms" -le 755 ]; then
            echo -e "${GREEN}✓ Script permissions OK ($$script_perms)$$ {NC}"
            ((passed_tests++))
        else
            echo -e "${RED}✗ Script permissions too open ($$script_perms)$$ {NC}"
        fi
    }
    
    # Test 2: Check for hardcoded secrets
    test_hardcoded_secrets() {
        ((test_count++))
        local secret_patterns="password|secret|key|token|credential"
        
        if ! grep -qi "$secret_patterns.*=" "$0"; then
            echo -e "${GREEN}✓ No hardcoded secrets detected${NC}"
            ((passed_tests++))
        else
            echo -e "${RED}✗ Potential hardcoded secrets found${NC}"
        fi
    }
    
    # Test 3: Check PATH security
    test_path_security() {
        ((test_count++))
        local secure_path="/usr/local/bin:/usr/bin:/bin"
        
        if [[ "$PATH" == *"/usr/local/bin"* ]] && [[ "$PATH" == *"/usr/bin"* ]]; then
            echo -e "${GREEN}✓ PATH contains secure directories${NC}"
            ((passed_tests++))
        else
            echo -e "${YELLOW}⚠ PATH may not be secure: $$PATH$$ {NC}"
        fi
    }
    
    # Test 4: Check umask setting
    test_umask_security() {
        ((test_count++))
        local current_umask=$(umask)
        
        if [ "$current_umask" = "0022" ] || [ "$current_umask" = "0077" ]; then
            echo -e "${GREEN}✓ Umask is secure ($$current_umask)$$ {NC}"
            ((passed_tests++))
        else
            echo -e "${YELLOW}⚠ Umask may be insecure ($$current_umask)$$ {NC}"
        fi
    }
    
    # Run all tests
    test_script_permissions
    test_hardcoded_secrets
    test_path_security
    test_umask_security
    
    # Summary
    echo -e "\n${BLUE}Security Test Results: $$passed_tests/$$ test_count tests passed${NC}"
    
    if [ $$passed_tests -eq$$ test_count ]; then
        echo -e "${GREEN}All security tests passed!${NC}"
    else
        echo -e "$${YELLOW}Some security tests failed. Review the issues above.$$ {NC}"
    fi
    echo ""
}

# 12. CLEANUP AND EXIT HANDLERS
setup_cleanup_handlers() {
    echo -e "$${YELLOW}12. Setting up Cleanup Handlers$$ {NC}"
    
    # Global cleanup function
    cleanup() {
        local exit_code=${1:-0}
        
        echo -e "\n$${BLUE}Performing cleanup...$$ {NC}"
        
        # Remove any demo files created
        rm -f /tmp/secure_config_demo.conf 2>/dev/null
        rm -f /tmp/test_secure.txt 2>/dev/null
        rmdir /tmp/test_secure_dir 2>/dev/null
        
        # Clear any sensitive variables
        unset password 2>/dev/null
        unset api_key 2>/dev/null
        
        # Kill background jobs
        jobs -p | xargs -r kill 2>/dev/null
        
        echo -e "$${GREEN}Cleanup completed$$ {NC}"
        exit $exit_code
    }
    
    # Set up signal handlers
    trap 'cleanup 130' INT   # Ctrl+C
    trap 'cleanup 143' TERM  # Termination
    trap 'cleanup 0' EXIT    # Normal exit
    
    echo -e "$${GREEN}Cleanup handlers configured$$ {NC}"
    echo ""
}

# MAIN EXECUTION FUNCTION
main() {
    echo -e "$${BLUE}Starting Security Demonstration...$$ {NC}\n"
    
    # Set secure defaults
    set -euo pipefail
    IFS=$'\n\t'
    umask 022
    
    # Setup cleanup
    setup_cleanup_handlers
    
    # Run demonstrations
    demonstrate_bad_practices
    demonstrate_secure_data_handling
    demonstrate_injection_prevention
    demonstrate_sanitization
    demonstrate_secure_temp_files
    demonstrate_file_security
    demonstrate_secure_execution
    demonstrate_secure_logging
    demonstrate_secure_network
    demonstrate_secure_config
    demonstrate_secure_error_handling
    display_security_checklist
    security_test_suite
    
    echo -e "$${BLUE}=== Security Demonstration Complete ===$$ {NC}"
    echo -e "${GREEN}Key Security Reminders:${NC}"
    echo "1. Never hardcode sensitive data"
    echo "2. Always validate and sanitize input"
    echo "3. Use secure temporary files with mktemp"
    echo "4. Set restrictive file permissions"
    echo "5. Implement proper error handling"
    echo "6. Log security events appropriately"
    echo "7. Test your scripts for security vulnerabilities"
    echo "8. Keep scripts updated and reviewed"
    
    echo -e "\n${PURPLE}For more security resources:${NC}"
    echo "- OWASP Secure Coding Practices"
    echo "- CIS Benchmarks for Linux"
    echo "- NIST Cybersecurity Framework"
    echo "- ShellCheck for static analysis"
}

# Execute main function with all arguments
main "$@"

# End of file: 17_security.sh