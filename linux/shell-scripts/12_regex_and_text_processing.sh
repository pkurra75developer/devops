#!/bin/bash
# =============================================================================
# REGULAR EXPRESSIONS AND PATTERN MATCHING - Complete Guide
# =============================================================================

set -euo pipefail

# =============================================================================
# GLOBBING PATTERNS
# =============================================================================

echo "=== GLOBBING PATTERNS ==="

# Create test files for globbing demonstrations
setup_test_files() {
    echo "Setting up test files for globbing:"
    
    # Create directory structure
    mkdir -p test_glob/{dir1,dir2,subdir/nested}
    
    # Create various test files
    touch test_glob/file1.txt
    touch test_glob/file2.txt
    touch test_glob/file3.log
    touch test_glob/document.pdf
    touch test_glob/image.jpg
    touch test_glob/script.sh
    touch test_glob/README.md
    touch test_glob/config.conf
    touch test_glob/data.csv
    touch test_glob/archive.tar.gz
    touch test_glob/backup_2023.sql
    touch test_glob/temp_file
    touch test_glob/.hidden_file
    touch test_glob/dir1/nested_file.txt
    touch test_glob/dir2/another_file.log
    touch test_glob/subdir/nested/deep_file.dat
    
    # Create files with special characters
    touch "test_glob/file with spaces.txt"
    touch "test_glob/file-with-dashes.txt"
    touch "test_glob/file_with_underscores.txt"
    touch "test_glob/UPPERCASE.TXT"
    
    echo "Test files created in test_glob/"
}

setup_test_files

# Basic globbing patterns
echo -e "\nBasic globbing patterns:"

echo "1. Asterisk (*) - matches any number of characters:"
echo "   *.txt files:"
for file in test_glob/*.txt; do
    [[ -f "$file" ]] && echo "     $(basename "$file")"
done

echo "   file* pattern:"
for file in test_glob/file*; do
    [[ -f "$file" ]] && echo "     $(basename "$file")"
done

echo -e "\n2. Question mark (?) - matches exactly one character:"
echo "   file?.txt pattern:"
for file in test_glob/file?.txt; do
    [[ -f "$file" ]] && echo "     $(basename "$file")"
done

echo -e "\n3. Square brackets ([]) - character classes:"
echo "   file[12].txt pattern:"
for file in test_glob/file[12].txt; do
    [[ -f "$file" ]] && echo "     $(basename "$file")"
done

echo "   *.[jl]* pattern (files with j or l in extension):"
for file in test_glob/*.[jl]*; do
    [[ -f "$file" ]] && echo "     $(basename "$file")"
done

echo -e "\n4. Character ranges:"
echo "   file[1-3].* pattern:"
for file in test_glob/file[1-3].*; do
    [[ -f "$file" ]] && echo "     $(basename "$file")"
done

echo "   *[A-Z]* pattern (files with uppercase letters):"
for file in test_glob/*[A-Z]*; do
    [[ -f "$file" ]] && echo "     $(basename "$file")"
done

# Advanced globbing patterns
echo -e "\n5. Negation with [!] or [^]:"
echo "   file[!1].txt pattern (not file1.txt):"
for file in test_glob/file[!1].txt; do
    [[ -f "$file" ]] && echo "     $(basename "$file")"
done

# Extended globbing (requires shopt -s extglob)
echo -e "\n6. Extended globbing patterns:"
shopt -s extglob

echo "   *.@(txt|log) pattern (txt OR log extensions):"
for file in test_glob/*.@(txt|log); do
    [[ -f "$file" ]] && echo "     $(basename "$file")"
done

echo "   *.!(txt) pattern (NOT txt extension):"
for file in test_glob/*.!(txt); do
    [[ -f "$file" ]] && echo "     $(basename "$file")"
done | head -5

echo "   file+(1|2).txt pattern (file1 OR file2):"
for file in test_glob/file+(1|2).txt; do
    [[ -f "$file" ]] && echo "     $(basename "$file")"
done

# Recursive globbing (bash 4+)
if [[ ${BASH_VERSION%%.*} -ge 4 ]]; then
    echo -e "\n7. Recursive globbing (**):"
    shopt -s globstar
    
    echo "   **/*.txt pattern (all txt files recursively):"
    for file in test_glob/**/*.txt; do
        [[ -f "$file" ]] && echo "     $file"
    done
    
    echo "   **/file* pattern (all files starting with 'file'):"
    for file in test_glob/**/file*; do
        [[ -f "$file" ]] && echo "     $file"
    done
fi

# Globbing options
echo -e "\n8. Globbing options (shopt):"

echo "   dotglob - include hidden files:"
shopt -s dotglob
echo "   .* pattern with dotglob:"
for file in test_glob/.*; do
    [[ -f "$file" ]] && echo "     $(basename "$file")"
done
shopt -u dotglob

echo -e "\n   nullglob - empty result if no matches:"
shopt -s nullglob
echo "   *.nonexistent pattern with nullglob:"
files=(test_glob/*.nonexistent)
echo "     Result: ${files[*]:-'(empty)'}"
shopt -u nullglob

echo -e "\n   failglob - error if no matches:"
# Note: We can't demonstrate failglob easily in a script as it would cause errors

# Case-insensitive globbing
echo -e "\n9. Case-insensitive globbing:"
shopt -s nocaseglob
echo "   *.TXT pattern with nocaseglob:"
for file in test_glob/*.TXT; do
    [[ -f "$file" ]] && echo "     $(basename "$file")"
done
shopt -u nocaseglob

# =============================================================================
# GREP BASICS
# =============================================================================

echo -e "\n=== GREP BASICS ==="

# Create test content for grep examples
cat > test_content.txt << 'EOF'
This is a sample text file for grep demonstrations.
It contains multiple lines with different patterns.
Some lines have UPPERCASE text.
Others have lowercase text.
Numbers like 123, 456, and 789 are scattered throughout.
Email addresses: john@example.com, jane.doe@company.org
Phone numbers: (555) 123-4567, 555-987-6543
Dates: 2023-10-15, 10/15/2023, Oct 15, 2023
IP addresses: 192.168.1.1, 10.0.0.1, 172.16.254.1
URLs: https://www.example.com, http://test.org
Special characters: !@#$%^&*()_+-=[]{}|;:,.<>?
This line contains the word "error" in lowercase.
This line contains the word "ERROR" in uppercase.
This line has both Error and error in different cases.
Line with tabs	and	multiple	spaces    here.
EOF

echo "Created test content file. Demonstrating grep:"

echo -e "\n1. Basic pattern matching:"
echo "   Lines containing 'text':"
grep 'text' test_content.txt

echo -e "\n2. Case-insensitive search (-i):"
echo "   Lines containing 'error' (any case):"
grep -i 'error' test_content.txt

echo -e "\n3. Line numbers (-n):"
echo "   Lines with numbers, showing line numbers:"
grep -n '[0-9]' test_content.txt

echo -e "\n4. Invert match (-v):"
echo "   Lines NOT containing 'the':"
grep -v 'the' test_content.txt | head -3

echo -e "\n5. Word boundaries (-w):"
echo "   Whole word 'error' only:"
grep -w 'error' test_content.txt

echo -e "\n6. Count matches (-c):"
echo "   Count of lines containing digits:"
grep -c '[0-9]' test_content.txt

echo -e "\n7. Show only matching part (-o):"
echo "   Extract email addresses:"
grep -o '[a-zA-Z0-9._%+-]\+@[a-zA-Z0-9.-]\+\.[a-zA-Z]\{2,\}' test_content.txt

echo -e "\n8. Multiple patterns (-E for extended regex):"
echo "   Lines with email OR phone patterns:"
grep -E '(@|[0-9]{3}.*[0-9]{3}.*[0-9]{4})' test_content.txt

echo -e "\n9. Context lines (-A, -B, -C):"
echo "   Lines with 'ERROR' plus 1 line after (-A 1):"
grep -A 1 'ERROR' test_content.txt

echo -e "\n10. Recursive search (-r):"
echo "    Search for 'file' in test_glob directory:"
grep -r 'file' test_glob/ 2>/dev/null | head -3 || echo "    (no matches in binary files)"

# =============================================================================
# SED BASICS
# =============================================================================

echo -e "\n=== SED BASICS ==="

echo "Demonstrating sed (Stream Editor):"

echo -e "\n1. Substitute command (s///):"
echo "   Replace 'text' with 'content':"
echo "This is sample text" | sed 's/text/content/'

echo -e "\n2. Global substitution (s///g):"
echo "   Replace all occurrences of 'e' with 'E':"
echo "The quick brown fox" | sed 's/e/E/g'

echo -e "\n3. Case-insensitive substitution (s///i):"
echo "   Replace 'ERROR' (any case) with 'WARNING':"
sed 's/error/WARNING/gi' test_content.txt | grep -i warning

echo -e "\n4. Delete lines (d):"
echo "   Delete lines containing 'Special':"
sed '/Special/d' test_content.txt | tail -5

echo -e "\n5. Print specific lines (p with -n):"
echo "   Print lines 5-8:"
sed -n '5,8p' test_content.txt

echo -e "\n6. Insert and append (i and a):"
echo "   Insert line before first line:"
sed '1i\=== HEADER ===' test_content.txt | head -3

echo -e "\n7. Multiple commands (-e or ;):"
echo "   Replace 'line' with 'row' AND 'text' with 'content':"
echo "This line has text" | sed -e 's/line/row/' -e 's/text/content/'

echo -e "\n8. Address ranges:"
echo "   Substitute only in lines 10-15:"
sed '10,15s/the/THE/g' test_content.txt | sed -n '8,17p'

echo -e "\n9. Regular expressions in addresses:"
echo "   Substitute only in lines containing 'Email':"
sed '/Email/s/@/ AT /g' test_content.txt | grep AT

echo -e "\n10. Backreferences:"
echo "    Swap first two words:"
echo "hello world test" | sed 's/\([^ ]*\) \([^ ]*\)/\2 \1/'

# Advanced sed examples
echo -e "\n11. Advanced sed patterns:"

echo "    Extract domain from email:"
echo "user@example.com" | sed 's/.*@\(.*\)/\1/'

echo "    Add line numbers:"
sed = test_content.txt | sed 'N;s/\n/: /' | head -5

echo "    Remove empty lines:"
printf "line1\n\nline2\n\nline3\n" | sed '/^$/d'

# =============================================================================
# AWK BASICS
# =============================================================================

echo -e "\n=== AWK BASICS ==="

# Create structured data for awk examples
cat > employees.csv << 'EOF'
Name,Department,Salary,Years
John Smith,Engineering,75000,5
Jane Doe,Marketing,65000,3
Bob Johnson,Engineering,80000,7
Alice Brown,Sales,60000,2
Charlie Wilson,Marketing,70000,4
Diana Davis,Engineering,85000,8
Eve Miller,Sales,55000,1
Frank Garcia,Engineering,90000,10
EOF

echo "Created employee data. Demonstrating awk:"

echo -e "\n1. Print specific fields:"
echo "   Print names and salaries (fields 1 and 3):"
awk -F',' '{print $1, $3}' employees.csv | head -5

echo -e "\n2. Pattern matching:"
echo "   Print Engineering employees:"
awk -F',' '/Engineering/ {print $1, $2, $3}' employees.csv

echo -e "\n3. Field conditions:"
echo "   Employees with salary > 70000:"
awk -F',' '$3 > 70000 {print $1, $3}' employees.csv

echo -e "\n4. Built-in variables:"
echo "   Print line numbers with names:"
awk -F',' '{print NR ": " $1}' employees.csv | head -5

echo -e "\n5. Mathematical operations:"
echo "   Calculate total and average salary:"
awk -F',' 'NR>1 {sum+=$3; count++} END {print "Total:", sum, "Average:", sum/count}' employees.csv

echo -e "\n6. String functions:"
echo "   Convert names to uppercase:"
awk -F',' '{print toupper($1)}' employees.csv | head -5

echo -e "\n7. Conditional statements:"
echo "   Categorize salaries:"
awk -F',' 'NR>1 {
    if ($3 >= 80000) category="High"
    else if ($3 >= 65000) category="Medium"
    else category="Low"
    print $1, category
}' employees.csv

echo -e "\n8. Arrays and counting:"
echo "   Count employees by department:"
awk -F',' 'NR>1 {dept[$2]++} END {for (d in dept) print d, dept[d]}' employees.csv

echo -e "\n9. BEGIN and END blocks:"
echo "   Formatted report:"
awk -F',' '
BEGIN {print "=== SALARY REPORT ==="; print "Name\t\tSalary"}
NR>1 {printf "%-15s %s\n", $1, $3}
END {print "=== END REPORT ==="}
' employees.csv

echo -e "\n10. Multiple field separators:"
echo "    Process mixed delimiters:"
echo "name:john,age:30;city:NYC" | awk -F'[:,;]' '{print $2, $4, $6}'

# Advanced awk examples
echo -e "\n11. Advanced awk patterns:"

echo "    Group and sum by department:"
awk -F',' 'NR>1 {
    dept_salary[$2] += $3
    dept_count[$2]++
} END {
    for (d in dept_salary) {
        printf "%s: Total=%d, Average=%.0f\n", d, dept_salary[d], dept_salary[d]/dept_count[d]
    }
}' employees.csv

echo -e "\n    Find employees with experience > average:"
awk -F',' 'NR>1 {years[NR]=$4; total_years+=$4; names[NR]=$1} 
END {
    avg = total_years/(NR-1)
    print "Average years:", avg
    for (i in years) {
        if (years[i] > avg) print names[i], years[i]
    }
}' employees.csv

# =============================================================================
# BASH REGEX MATCHING [[ =~ ]]
# =============================================================================

echo -e "\n=== BASH REGEX MATCHING [[ =~ ]] ==="

echo "Demonstrating bash built-in regex matching:"

# Function to demonstrate regex matching
test_regex() {
    local string="$1"
    local pattern="$2"
    local description="$3"
    
    echo -n "Testing '$string' against /$pattern/: "
    if [[ $string =~ $pattern ]]; then
        echo "MATCH"
        # Show captured groups if any
        if [[ ${#BASH_REMATCH[@]} -gt 1 ]]; then
            echo "  Captured groups:"
            for i in $(seq 1 $((${#BASH_REMATCH[@]} - 1))); do
                echo "    Group $i: '${BASH_REMATCH[i]}'"
            done
        fi
    else
        echo "NO MATCH"
    fi
    [[ -n "$description" ]] && echo "  ($description)"
}

echo -e "\n1. Basic pattern matching:"
test_regex "hello world" "hello" "Simple string match"
test_regex "hello world" "^hello" "Start anchor"
test_regex "hello world" "world$" "End anchor"

echo -e "\n2. Character classes:"
test_regex "abc123" "[0-9]+" "One or more digits"
test_regex "Hello World" "[A-Z][a-z]+" "Uppercase followed by lowercase"
test_regex "test@example.com" "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" "Email pattern"

echo -e "\n3. Quantifiers:"
test_regex "aaabbb" "a{3}" "Exactly 3 a's"
test_regex "aaabbb" "a{2,4}" "2 to 4 a's"
test_regex "aaabbb" "a+" "One or more a's"
test_regex "aaabbb" "a*b+" "Zero or more a's, one or more b's"

echo -e "\n4. Groups and capturing:"
test_regex "John Smith" "([A-Z][a-z]+) ([A-Z][a-z]+)" "First and last name"
test_regex "2023-10-15" "([0-9]{4})-([0-9]{2})-([0-9]{2})" "Date components"
test_regex "(555) 123-4567" "\(([0-9]{3})\) ([0-9]{3})-([0-9]{4})" "Phone number parts"

echo -e "\n5. Alternation:"
test_regex "cat" "(cat|dog|bird)" "Pet animals"
test_regex "dog" "(cat|dog|bird)" "Pet animals"
test_regex "fish" "(cat|dog|bird)" "Pet animals"

echo -e "\n6. Special characters:"
test_regex "192.168.1.1" "^([0-9]{1,3}\.){3}[0-9]{1,3}$" "IP address format"
test_regex "file.txt" "\.[a-z]{3}$" "Three-letter extension"
test_regex "hello@world.com" "^[^@]+@[^@]+$" "Basic email structure"

# Practical regex validation functions
echo -e "\n7. Practical validation functions:"

validate_email() {
    local email="$1"
    local pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    
    if [[ $email =~ $pattern ]]; then
        echo "✓ Valid email: $email"
        return 0
    else
        echo "✗ Invalid email: $email"
        return 1
    fi
}

validate_phone() {
    local phone="$1"
    local pattern="^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$"
    
    if [[ $phone =~ $pattern ]]; then
        echo "✓ Valid phone: $phone (${BASH_REMATCH[1]}-${BASH_REMATCH[2]}-${BASH_REMATCH[3]})"
        return 0
    else
        echo "✗ Invalid phone: $phone"
        return 1
    fi
}

validate_date() {
    local date="$1"
    local pattern="^([0-9]{4})-([0-9]{2})-([0-9]{2})$"
    
    if [[ $date =~ $pattern ]]; then
        local year="${BASH_REMATCH[1]}"
        local month="${BASH_REMATCH[2]}"
        local day="${BASH_REMATCH[3]}"
        
        # Basic validation
        if [[ $month -ge 1 && $month -le 12 && $day -ge 1 && $day -le 31 ]]; then
            echo "✓ Valid date: $date (Year: $year, Month: $month, Day: $day)"
            return 0
        fi
    fi
    
    echo "✗ Invalid date: $date"
    return 1
}

# Test validation functions
echo "Testing validation functions:"
validate_email "user@example.com"
validate_email "invalid.email"
validate_phone "(555) 123-4567"
validate_phone "555-123-4567"
validate_phone "invalid-phone"
validate_date "2023-10-15"
validate_date "2023-13-45"

# =============================================================================
# ADVANCED PATTERN MATCHING
# =============================================================================

echo -e "\n=== ADVANCED PATTERN MATCHING ==="

# Complex pattern matching examples
echo "Advanced pattern matching scenarios:"

# Log parsing function
parse_log_entry() {
    local log_line="$1"
    local pattern="^([0-9]{4}-[0-9]{2}-[0-9]{2}) ([0-9]{2}:[0-9]{2}:[0-9]{2}) \[([A-Z]+)\] (.+)$"
    
    if [[ $log_line =~ $pattern ]]; then
        echo "Parsed log entry:"
        echo "  Date: ${BASH_REMATCH[1]}"
        echo "  Time: ${BASH_REMATCH[2]}"
        echo "  Level: ${BASH_REMATCH[3]}"
        echo "  Message: ${BASH_REMATCH[4]}"
    else
        echo "Invalid log format: $log_line"
    fi
}

# URL parsing function
parse_url() {
    local url="$1"
    local pattern="^(https?):\/\/([^\/]+)(\/.*)?(\?.*)?$"
    
    if [[ $url =~ $pattern ]]; then
        echo "Parsed URL:"
        echo "  Protocol: ${BASH_REMATCH[1]}"
        echo "  Host: ${BASH_REMATCH[2]}"
        echo "  Path: ${BASH_REMATCH[3]:-'/'}"
        echo "  Query: ${BASH_REMATCH[4]:-'(none)'}"
    else
        echo "Invalid URL format: $url"
    fi
}

# Test advanced parsing
echo -e "\n1. Log entry parsing:"
parse_log_entry "2023-10-15 14:30:25 [ERROR] Database connection failed"
parse_log_entry "2023-10-15 14:31:00 [INFO] User login successful"

echo -e "\n2. URL parsing:"
parse_url "https://www.example.com/path/to/page?param=value"
parse_url "http://localhost:8080/api/users"

# Text extraction and transformation
echo -e "\n3. Text extraction and transformation:"

extract_and_format() {
    local text="$1"
    
    # Extract phone numbers and format them
    if [[ $text =~ \(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4}) ]]; then
        echo "Formatted phone: (${BASH_REMATCH[1]}) ${BASH_REMATCH[2]}-${BASH_REMATCH[3]}"
    fi
    
    # Extract email and split into parts
    if [[ $text =~ ([a-zA-Z0-9._%+-]+)@([a-zA-Z0-9.-]+)\.([a-zA-Z]{2,}) ]]; then
        echo "Email parts: User='${BASH_REMATCH[1]}', Domain='${BASH_REMATCH[2]}', TLD='${BASH_REMATCH[3]}'"
    fi
}

extract_and_format "Contact: john.doe@example.com or call 555-123-4567"

# =============================================================================
# PERFORMANCE COMPARISON
# =============================================================================

echo -e "\n=== PERFORMANCE COMPARISON ==="

# Create large test file for performance testing
echo "Creating large test file for performance comparison..."
{
    for i in {1..1000}; do
        echo "Line $i: This is test data with email user$i@example.com and phone (555) 123-$(printf "%04d" $i)"
    done
} > large_test.txt

# Performance testing function
time_command() {
    local description="$1"
    shift
    echo -n "$description: "
    time "$@" >/dev/null 2>&1
}

echo "Performance comparison (processing 1000 lines):"

echo -e "\n1. Email extraction methods:"
time_command "grep -o" grep -o '[a-zA-Z0-9._%+-]\+@[a-zA-Z0-9.-]\+\.[a-zA-Z]\{2,\}' large_test.txt
time_command "sed extraction" sed -n 's/.*\([a-zA-Z0-9._%+-]\+@[a-zA-Z0-9.-]\+\.[a-zA-Z]\{2,\}\).*/\1/p' large_test.txt
time_command "awk extraction" awk '{match($0, /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/); if (RSTART) print substr($0, RSTART, RLENGTH)}' large_test.txt

echo -e "\n2. Line counting methods:"
time_command "wc -l" wc -l large_test.txt
time_command "grep -c" grep -c '.*' large_test.txt
time_command "awk END" awk 'END {print NR}' large_test.txt

# =============================================================================
# CLEANUP AND SUMMARY
# =============================================================================

echo -e "\n=== CLEANUP ==="

# Clean up test files
rm -rf test_glob/
rm -f test_content.txt employees.csv large_test.txt

echo -e "\n=== REGULAR EXPRESSIONS AND PATTERN MATCHING SUMMARY ==="
echo "✓ Globbing patterns (*, ?, [], extended globbing)"
echo "✓ grep basics (search, options, patterns)"
echo "✓ sed basics (substitute, delete, insert, addresses)"
echo "✓ awk basics (fields, patterns, built-ins, arrays)"
echo "✓ Bash regex matching with [[ =~ ]]"
echo "✓ Capture groups and BASH_REMATCH"
echo "✓ Advanced pattern matching and parsing"
echo "✓ Performance comparison of different tools"

echo "Script completed successfully!"
