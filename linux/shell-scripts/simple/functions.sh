#!/bin/bash
# ====================================================
# Bash Functions Comprehensive Demo
# ====================================================
# This script demonstrates almost every feature of Bash functions:
#   - Function definition & call
#   - Arguments and default arguments
#   - Number of arguments
#   - Return values
#   - Global vs local variables
#   - Nested functions
#   - Using exit in functions
# ====================================================

echo "=== Functions Demo Start ==="

# ----------------------------------------------------
# Section 1: Basic function definition & call
# ----------------------------------------------------
hello_world() {
    echo "Hello, World!"
}
hello_world   # Calling function

# ----------------------------------------------------
# Section 2: Function with arguments
# ----------------------------------------------------
greet_user() {
    # $1 = first argument, $2 = second argument
    echo "Hello, $1! You are $2 years old."
}
greet_user "Alice" 25

# ----------------------------------------------------
# Section 3: Default arguments
# ----------------------------------------------------
greet_with_default() {
    local name=${1:-"Guest"}   # Default value "Guest"
    local age=${2:-"unknown"}  # Default value "unknown"
    echo "Hello, $name! Age: $age"
}
greet_with_default "Bob"   # Only first argument provided
greet_with_default          # No arguments, uses defaults

# ----------------------------------------------------
# Section 4: Check number of arguments
# ----------------------------------------------------
check_args() {
    echo "Number of arguments passed: $#"
    if [ $# -lt 2 ]; then
        echo "Warning: Less than 2 arguments provided"
    fi
}
check_args "only_one"
check_args "one" "two" "three"

# ----------------------------------------------------
# Section 5: Return values
# ----------------------------------------------------
add_numbers() {
    local sum=$(( $1 + $2 ))
    return $sum  # Return value as exit code (0-255)
}

add_numbers 10 20
ret=$?  # Capture return value
echo "Return value (sum modulo 256): $ret"

# If you need actual numbers > 255, use echo instead of return
add_numbers_large() {
    local sum=$(( $1 + $2 ))
    echo $sum  # Output to stdout
}
res=$(add_numbers_large 1000 2000)
echo "Sum using echo: $res"

# ----------------------------------------------------
# Section 6: Global vs Local variables
# ----------------------------------------------------
global_var="I am global"

show_scope() {
    local local_var="I am local"
    echo "Inside function: global_var=$global_var"
    echo "Inside function: local_var=$local_var"
}

show_scope
echo "Outside function: global_var=$global_var"
# echo "Outside function: local_var=$local_var"  # This will fail

# ----------------------------------------------------
# Section 7: Nested functions
# ----------------------------------------------------
outer_function() {
    echo "Outer function start"

    inner_function() {
        echo "Inner function executing"
    }

    inner_function
    echo "Outer function end"
}

outer_function

# ----------------------------------------------------
# Section 8: Exit from function (and script)
# ----------------------------------------------------
exit_demo() {
    local code=${1:-0}
    echo "Function will exit script with code $code"
    # exit $code   # Uncomment to test; will stop entire script
}
# exit_demo 2   # Uncomment to see script exit

# ----------------------------------------------------
# Section 9: Using "$@" and "$*" inside functions
# ----------------------------------------------------
show_all_args() {
    echo "Using \$@: $@"  # Each argument separate
    echo "Using \$*: $*"  # All arguments as single string
}
show_all_args one two three

# ----------------------------------------------------
# Section 10: Summary / Observations
# ----------------------------------------------------
echo "=== Functions Demo End ==="
echo "Key Observations:"
echo "- Use 'local' inside functions to avoid polluting global scope"
echo "- '$#' gives number of arguments, '$@' and '$*' give all arguments"
echo "- 'return' is limited to 0-255, use 'echo' to return larger numbers"
echo "- Functions can be nested; inner functions are created when outer runs"
echo "- 'exit' inside function will stop entire script"

