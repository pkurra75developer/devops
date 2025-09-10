#!/bin/bash
# =============================================================================
# TEXT PROCESSING AND REGULAR EXPRESSIONS - Complete Guide
# =============================================================================

set -euo pipefail

# =============================================================================
# BASIC TEXT PROCESSING TOOLS
# =============================================================================

echo "=== BASIC TEXT PROCESSING TOOLS ==="

# Create sample text files for processing
cat > sample.txt << EOF
John Doe,30,Engineer,New York
Jane Smith,25,Designer,Los Angeles
Bob Johnson,35,Manager,Chicago
Alice Brown,28,Developer,Seattle
Charlie Wilson,32,Analyst,Boston
EOF

cat > log_sample.txt << EOF
2023-10-01 10:15:23 INFO User login successful
2023-10-01 10:16:45 ERROR Database connection failed
2023-10-01 10:17:12 WARN Memory usage high
2023-10-01 10:18:33 INFO User logout
2023-10-01 10:19:55 ERROR File not found
EOF

cat > text_sample.txt << EOF
The quick brown fox jumps over the lazy dog.
This sentence contains every letter of the alphabet.
Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
EOF

echo "Sample files created for text processing demonstrations."

# =============================================================================
# GREP - PATTERN SEARCHING
# =============================================================================

echo -e "\n=== GREP - PATTERN SEARCHING ==="

# Basic grep usage
echo "Basic grep examples:"
echo "Lines containing 'ERROR':"
grep "ERROR" log_sample.txt

echo -e "\nCase-insensitive search for 'error':"
grep -i "error" log_sample.txt

echo -e "\nInvert match (lines NOT containing 'ERROR'):"
grep -v "ERROR" log_sample.txt

echo -e "\nShow line numbers:"
grep -n "INFO" log_sample.txt

echo -e "\nCount matching lines:"
grep -c "ERROR" log_sample.txt

echo -e "\nShow only matching part:"
grep -o "[0-9][0-9]:[0-9][0-9]:[0-9][0-9]" log_sample.txt

# Multiple patterns
echo -e "\nMultiple patterns (ERROR or WARN):"
grep -E "ERROR|WARN" log_sample.txt

# Recursive search
mkdir -p test_dir
cp log_sample.txt test_dir/
echo -e "\nRecursive search:"
grep -r "ERROR" test_dir/

# Context lines
echo -e "\nShow 1 line before and after match:"
grep -C 1 "ERROR" log_sample.txt

# =============================================================================
# SED - STREAM EDITOR
# =============================================================================

echo -e "\n=== SED - STREAM EDITOR ==="

# Basic substitution
echo "Basic sed substitution:"
echo "Original line: Hello World"
echo "Hello World" | sed 's/World/Universe/'

# Global substitution
echo -e "\nGlobal substitution:"
echo "Original: foo bar foo baz foo"
echo "foo bar foo baz foo" | sed 's/foo/FOO/g'

# Case-insensitive substitution
echo -e "\nCase-insensitive substitution:"
echo "Original: Hello WORLD hello world"
echo "Hello WORLD hello world" | sed 's/hello/hi/gi'

# Delete lines
echo -e "\nDelete lines containing 'ERROR':"
sed '/ERROR/d' log_sample.txt

# Print specific lines
echo -e "\nPrint lines 2-4:"
sed -n '2,4p' sample.txt

# Multiple commands
echo -e "\nMultiple sed commands:"
sed -e 's/ERROR/CRITICAL/' -e 's/WARN/WARNING/' log_sample.txt

# In-place editing (backup original)
cp sample.txt sample_backup.txt
sed -i.bak 's/Engineer/Software Engineer/' sample_backup.txt
echo "Modified file:"
cat sample_backup.txt

# Advanced sed patterns
echo -e "\nAdvanced sed - extract email-like patterns:"
echo "Contact: john@example.com or jane@test.org" | \
sed 's/.*\([a-zA-Z0-9._%+-]*@[a-zA-Z0-9.-]*\.[a-zA-Z]{2,}\).*/\1/'

# =============================================================================
# AWK - PATTERN SCANNING AND PROCESSING
# =============================================================================

echo -e "\n=== AWK - PATTERN SCANNING AND PROCESSING ==="

# Basic awk usage
echo "Basic awk examples:"
echo "Print first and third columns:"
awk -F',' '{print $1, $3}' sample.txt

echo -e "\nPrint with custom formatting:"
awk -F',' '{printf "Name: %-15s Job: %s\n", $1, $3}' sample.txt

# Pattern matching
echo -e "\nLines where age > 30:"
awk -F',' '$2 > 30 {print $1, "is", $2, "years old"}' sample.txt

# Built-in variables
echo -e "\nUsing built-in variables:"
awk -F',' '{print "Line", NR ":", $1, "has", NF, "fields"}' sample.txt

# BEGIN and END blocks
echo -e "\nUsing BEGIN and END:"
awk -F',' 'BEGIN {print "Employee Report"; print "================"}
           {total_age += $2; count++}
           END {print "Average age:", total_age/count}' sample.txt

# Conditional processing
echo -e "\nConditional processing:"
awk -F',' '{
    if ($2 < 30) 
        category = "Young"
    else if ($2 < 35) 
        category = "Middle"
    else 
        category = "Senior"
    print $1, "(" category ")"
}' sample.txt

# String functions
echo -e "\nString functions:"
awk -F',' '{print toupper($1), length($1)}' sample.txt

# Mathematical operations
echo -e "\nMathematical operations:"
awk 'BEGIN {
    for (i = 1; i <= 5; i++) {
        print i, i^2, sqrt(i)
    }
}'

# =============================================================================
# CUT - EXTRACT COLUMNS
# =============================================================================

echo -e "\n=== CUT - EXTRACT COLUMNS ==="

# Extract by character position
echo "Extract characters 1-10:"
cut -c1-10 sample.txt

# Extract by delimiter
echo -e "\nExtract fields 1 and 3 (comma-delimited):"
cut -d',' -f1,3 sample.txt

# Extract multiple ranges
echo -e "\nExtract characters 1-5 and 15-25:"
cut -c1-5,15-25 sample.txt

# Extract from specific field onwards
echo -e "\nExtract from field 2 onwards:"
cut -d',' -f2- sample.txt

# =============================================================================

# SORT - SORTING TEXT
# =============================================================================

echo -e "\n=== SORT - SORTING TEXT ==="

# Basic sorting
echo "Basic alphabetical sort:"
sort sample.txt

# Numeric sort
echo -e "\nNumeric sort by age (field 2):"
sort -t',' -k2,2n sample.txt

# Reverse sort
echo -e "\nReverse alphabetical sort:"
sort -r sample.txt

# Sort by multiple fields
echo -e "\nSort by job (field 3), then by age (field 2):"
sort -t',' -k3,3 -k2,2n sample.txt

# Unique sort (remove duplicates)
echo -e "\nCreate file with duplicates and sort unique:"
cat > duplicates.txt << EOF
apple
banana
apple
cherry
banana
date
EOF

echo "Original with duplicates:"
cat duplicates.txt
echo "Sorted unique:"
sort -u duplicates.txt

# Case-insensitive sort
echo -e "\nCase-insensitive sort:"
echo -e "Zebra\napple\nBanana\ncherry" | sort -f

# =============================================================================
# UNIQ - REPORT OR OMIT REPEATED LINES
# =============================================================================

echo -e "\n=== UNIQ - REPORT OR OMIT REPEATED LINES ==="

# Create file with consecutive duplicates
cat > consecutive_dups.txt << EOF
apple
apple
banana
banana
banana
cherry
date
date
EOF

echo "Original file with consecutive duplicates:"
cat consecutive_dups.txt

echo -e "\nRemove consecutive duplicates:"
uniq consecutive_dups.txt

echo -e "\nCount occurrences:"
uniq -c consecutive_dups.txt

echo -e "\nShow only duplicated lines:"
uniq -d consecutive_dups.txt

echo -e "\nShow only unique lines (no duplicates):"
uniq -u consecutive_dups.txt

# =============================================================================
# TR - TRANSLATE OR DELETE CHARACTERS
# =============================================================================

echo -e "\n=== TR - TRANSLATE OR DELETE CHARACTERS ==="

# Character translation
echo "Character translation examples:"
echo "hello world" | tr 'a-z' 'A-Z'

echo -e "\nReplace spaces with underscores:"
echo "hello world test" | tr ' ' '_'

echo -e "\nDelete specific characters:"
echo "hello123world456" | tr -d '0-9'

echo -e "\nSqueeze repeated characters:"
echo "hellooo   world" | tr -s 'o '

echo -e "\nComplement (translate everything except specified):"
echo "hello123world" | tr -c 'a-z' '*'

# ROT13 encoding
echo -e "\nROT13 encoding:"
echo "hello world" | tr 'a-zA-Z' 'n-za-mN-ZA-M'

# =============================================================================
# WC - WORD, LINE, CHARACTER, AND BYTE COUNT
# =============================================================================

echo -e "\n=== WC - WORD, LINE, CHARACTER COUNT ==="

echo "Word count examples:"
echo "Lines, words, characters in sample.txt:"
wc sample.txt

echo -e "\nJust line count:"
wc -l sample.txt

echo -e "\nJust word count:"
wc -w sample.txt

echo -e "\nJust character count:"
wc -c sample.txt

echo -e "\nCount from pipe:"
echo "This is a test sentence with several words" | wc -w

# =============================================================================
# REGULAR EXPRESSIONS
# =============================================================================

echo -e "\n=== REGULAR EXPRESSIONS ==="

# Create test data for regex examples
cat > regex_test.txt << EOF
Phone numbers: 555-123-4567, (555) 123-4567, 555.123.4567
Email addresses: john@example.com, jane.doe@company.org, user123@test.co.uk
Dates: 2023-10-01, 10/01/2023, Oct 1, 2023
IP addresses: 192.168.1.1, 10.0.0.1, 172.16.0.1
URLs: https://www.example.com, http://test.org, ftp://files.company.com
EOF

echo "Regular expression examples:"

# Basic character classes
echo "Find digits:"
grep -o '[0-9]' regex_test.txt | head -10

echo -e "\nFind words (letters only):"
grep -o '[a-zA-Z]\+' regex_test.txt | head -10

# Quantifiers
echo -e "\nFind 3-digit numbers:"
grep -o '[0-9]\{3\}' regex_test.txt

echo -e "\nFind words with 4 or more letters:"
grep -o '[a-zA-Z]\{4,\}' regex_test.txt | head -5

# Anchors
echo -e "\nLines starting with 'Phone':"
grep '^Phone' regex_test.txt

echo -e "\nLines ending with '.com':"
grep '\.com$' regex_test.txt

# Character classes and special characters
echo -e "\nFind email addresses:"
grep -o '[a-zA-Z0-9._%+-]\+@[a-zA-Z0-9.-]\+\.[a-zA-Z]\{2,\}' regex_test.txt

echo -e "\nFind phone numbers (various formats):"
grep -o '\([0-9]\{3\}\)[ -]\?[0-9]\{3\}[ -]\?[0-9]\{4\}' regex_test.txt

echo -e "\nFind IP addresses:"
grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' regex_test.txt

# Extended regular expressions (ERE)
echo -e "\nUsing extended regex for URLs:"
grep -E 'https?://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' regex_test.txt

echo -e "\nUsing extended regex for dates:"
grep -E '[0-9]{4}-[0-9]{2}-[0-9]{2}|[0-9]{2}/[0-9]{2}/[0-9]{4}' regex_test.txt

# =============================================================================
# ADVANCED TEXT PROCESSING FUNCTIONS
# =============================================================================

echo -e "\n=== ADVANCED TEXT PROCESSING FUNCTIONS ==="

# Function to extract and validate email addresses
extract_emails() {
    local file="$1"
    local email_regex='[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'
    
    echo "Extracting email addresses from $file:"
    grep -o "$email_regex" "$file" | while read email; do
        # Basic validation
        if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
            echo "  Valid: $email"
        else
            echo "  Invalid: $email"
        fi
    done
}

extract_emails "regex_test.txt"

# Function to parse log files
parse_log() {
    local log_file="$1"
    
    echo "Log analysis for $log_file:"
    
    # Count by log level
    echo "Log level counts:"
    awk '{print $3}' "$log_file" | sort | uniq -c | sort -nr
    
    # Extract time range
    echo -e "\nTime range:"
    awk '{print $2}' "$log_file" | sort | sed -n '1p;$p'
    
    # Find errors with context
    echo -e "\nError messages:"
    grep "ERROR" "$log_file" | awk '{print $2, $4, $5, $6}'
}

parse_log "log_sample.txt"

# Function to process CSV data
process_csv() {
    local csv_file="$1"
    
    echo "CSV processing for $csv_file:"
    
    # Statistics
    local total_records=$(wc -l < "$csv_file")
    echo "Total records: $total_records"
    
    # Age statistics
    echo "Age statistics:"
    awk -F',' '{ages[NR] = $2} END {
        # Sort ages
        n = asort(ages)
        sum = 0
        for (i = 1; i <= n; i++) sum += ages[i]
        
        print "  Average:", sum/n
        print "  Minimum:", ages[1]
        print "  Maximum:", ages[n]
        print "  Median:", (n % 2) ? ages[(n+1)/2] : (ages[n/2] + ages[n/2+1])/2
    }' "$csv_file"
    
    # Group by job
    echo "Records by job:"
    awk -F',' '{jobs[$3]++} END {
        for (job in jobs) print "  " job ":", jobs[job]
    }' "$csv_file"
}

process_csv "sample.txt"

# Function to clean and normalize text
clean_text() {
    local input="$1"
    
    echo "Original text: $input"
    
    # Remove extra whitespace, convert to lowercase, remove punctuation
    cleaned=$(echo "$input" | \
        tr '[:upper:]' '[:lower:]' | \
        tr -s ' ' | \
        tr -d '[:punct:]' | \
        sed 's/^ *//;s/ *$//')
    
    echo "Cleaned text: $cleaned"
    
    # Word count
    word_count=$(echo "$cleaned" | wc -w)
    echo "Word count: $word_count"
    
    # Unique words
    echo "Unique words:"
    echo "$cleaned" | tr ' ' '\n' | sort -u | tr '\n' ' '
    echo
}

clean_text "The Quick, Brown Fox! Jumps over the lazy dog."

# =============================================================================
# TEXT FORMATTING AND PRESENTATION
# =============================================================================

echo -e "\n=== TEXT FORMATTING AND PRESENTATION ==="

# Column formatting
echo "Column formatting with column command:"
if command -v column >/dev/null 2>&1; then
    echo "Name,Age,Job,City" | cat - sample.txt | column -t -s','
else
    echo "column command not available, using awk:"
    (echo "Name,Age,Job,City"; cat sample.txt) | \
    awk -F',' '{printf "%-15s %-5s %-15s %s\n", $1, $2, $3, $4}'
fi

# Text wrapping
echo -e "\nText wrapping example:"
long_text="This is a very long line of text that should be wrapped to fit within a specific width to make it more readable and properly formatted for display purposes."

if command -v fold >/dev/null 2>&1; then
    echo "$long_text" | fold -w 40
else
    # Simple word wrapping with awk
    echo "$long_text" | awk '{
        line_length = 40
        current_length = 0
        for (i = 1; i <= NF; i++) {
            word_length = length($i)
            if (current_length + word_length + 1 > line_length && current_length > 0) {
                print ""
                current_length = 0
            }
            if (current_length > 0) {
                printf " "
                current_length++
            }
            printf "%s", $i
            current_length += word_length
        }
        print ""
    }'
fi

# Number lines
echo -e "\nNumber lines:"
cat -n text_sample.txt

# =============================================================================
# TEXT COMPARISON AND DIFF
# =============================================================================

echo -e "\n=== TEXT COMPARISON ==="

# Create two similar files for comparison
cat > file1.txt << EOF
Line 1: Same content
Line 2: Different in file1
Line 3: Same content
Line 4: Only in file1
Line 5: Same content
EOF

cat > file2.txt << EOF
Line 1: Same content
Line 2: Different in file2
Line 3: Same content
Line 5: Same content
Line 6: Only in file2
EOF

echo "Comparing two files:"
if command -v diff >/dev/null 2>&1; then
    diff file1.txt file2.txt || true
    
    echo -e "\nSide-by-side comparison:"
    diff -y file1.txt file2.txt || true
    
    echo -e "\nUnified diff format:"
    diff -u file1.txt file2.txt || true
fi

# Compare using comm
echo -e "\nUsing comm (requires sorted input):"
sort file1.txt > file1_sorted.txt
sort file2.txt > file2_sorted.txt

if command -v comm >/dev/null 2>&1; then
    echo "Lines only in file1 | Lines only in file2 | Common lines"
    comm file1_sorted.txt file2_sorted.txt
fi

# =============================================================================
# STREAM PROCESSING AND PIPELINES
# =============================================================================

echo -e "\n=== STREAM PROCESSING PIPELINES ==="

# Complex pipeline example
echo "Complex text processing pipeline:"
echo "Processing log file to find top error sources:"

# Create extended log file
cat > extended_log.txt << EOF
2023-10-01 10:15:23 INFO [auth] User login successful
2023-10-01 10:16:45 ERROR [database] Connection timeout
2023-10-01 10:17:12 WARN [memory] Usage above 80%
2023-10-01 10:18:33 INFO [auth] User logout
2023-10-01 10:19:55 ERROR [filesystem] Disk full
2023-10-01 10:20:12 ERROR [database] Query failed
2023-10-01 10:21:33 ERROR [network] Connection refused
2023-10-01 10:22:45 ERROR [database] Connection timeout
EOF

# Pipeline to analyze errors
cat extended_log.txt | \
grep "ERROR" | \
sed 's/.*\[\([^]]*\)\].*/\1/' | \
sort | \
uniq -c | \
sort -nr | \
awk '{printf "%-15s: %d errors\n", $2, $1}'

# Real-time log monitoring simulation
echo -e "\nSimulating real-time log monitoring:"
monitor_logs() {
    local duration="$1"
    local log_patterns=("INFO" "WARN" "ERROR" "DEBUG")
    local components=("auth" "database" "network" "filesystem")
    
    for ((i=1; i<=duration; i++)); do
        local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        local level=${log_patterns[$((RANDOM % ${#log_patterns[@]}))]}
        local component=${components[$((RANDOM % ${#components[@]}))]}
        local message="Operation $i completed"
        
        echo "[$timestamp] $level [$component] $message"
        sleep 0.5
    done
}

# Process the simulated logs
echo "Monitoring and processing logs for 3 iterations:"
monitor_logs 3 | while read line; do
    echo "Processing: $line"
    
    # Extract and categorize
    if echo "$line" | grep -q "ERROR"; then
        echo "  -> ALERT: Error detected!"
    elif echo "$line" | grep -q "WARN"; then
        echo "  -> Warning noted"
    fi
done

# =============================================================================
# TEXT ENCODING AND CHARACTER HANDLING
# =============================================================================

echo -e "\n=== TEXT ENCODING AND CHARACTER HANDLING ==="

# Character encoding examples
echo "Character encoding examples:"

# Create file with special characters
cat > special_chars.txt << EOF
Regular ASCII: Hello World
Accented: café, naïve, résumé
Symbols: © ® ™ € £ ¥
Math: α β γ δ ∑ ∏ ∞
Arrows: → ← ↑ ↓ ⇒ ⇐
EOF

echo "File with special characters:"
cat special_chars.txt

# Character counting
echo -e "\nCharacter analysis:"
echo "Total characters: $(wc -c < special_chars.txt)"
echo "Total lines: $(wc -l < special_chars.txt)"

# Remove non-ASCII characters
echo -e "\nRemoving non-ASCII characters:"
tr -cd '[:print:]\n' < special_chars.txt

# Convert case with locale awareness
echo -e "\nCase conversion:"
echo "MIXED CaSe TeXt" | tr '[:upper:]' '[:lower:]'

# =============================================================================
# PERFORMANCE OPTIMIZATION
# =============================================================================

echo -e "\n=== PERFORMANCE OPTIMIZATION ==="

# Create large test file
echo "Creating large test file for performance testing..."
seq 1 1000 | awk '{print "Line " $1 ": This is test data with some random content " rand()}' > large_test.txt

# Benchmark different approaches
benchmark_text_processing() {
    local file="$1"
    local pattern="$2"
    
    echo "Benchmarking text processing approaches for pattern '$pattern':"
    
    # Method 1: grep
    echo -n "grep: "
    time (grep "$pattern" "$file" > /dev/null) 2>&1 | grep real
    
    # Method 2: awk
    echo -n "awk: "
    time (awk "/$pattern/" "$file" > /dev/null) 2>&1 | grep real
    
    # Method 3: sed
    echo -n "sed: "
    time (sed -n "/$pattern/p" "$file" > /dev/null) 2>&1 | grep real
}

benchmark_text_processing "large_test.txt" "Line 5[0-9][0-9]"

# Memory-efficient processing for large files
process_large_file() {
    local file="$1"
    local chunk_size="${2:-100}"
    
    echo "Processing large file in chunks of $chunk_size lines:"
    
    local line_count=0
    local chunk_count=0
    
    while IFS= read -r line; do
        ((line_count++))
        
        # Process line here (example: count words)
        local words=$(echo "$line" | wc -w)
        
        if ((line_count % chunk_size == 0)); then
            ((chunk_count++))
            echo "Processed chunk $chunk_count (lines $((line_count - chunk_size + 1))-$line_count)"
        fi
    done < "$file"
    
    echo "Total lines processed: $line_count"
}

process_large_file "large_test.txt" 200

# =============================================================================
# ERROR HANDLING AND VALIDATION
# =============================================================================

echo -e "\n=== ERROR HANDLING AND VALIDATION ==="

# Robust text processing function
safe_text_process() {
    local input_file="$1"
    local operation="$2"
    local pattern="$3"
    
    # Validate input file
    if [[ ! -f "$input_file" ]]; then
        echo "Error: Input file '$input_file' not found" >&2
        return 1
    fi
    
    if [[ ! -r "$input_file" ]]; then
        echo "Error: Cannot read input file '$input_file'" >&2
        return 2
    fi
    
    # Validate operation
    case "$operation" in
        "search"|"count"|"extract"|"replace")
            ;;
        *)
            echo "Error: Unknown operation '$operation'" >&2
            echo "Valid operations: search, count, extract, replace" >&2
            return 3
            ;;
    esac
    
    # Validate pattern
    if [[ -z "$pattern" ]]; then
        echo "Error: Pattern cannot be empty" >&2
        return 4
    fi
    
    # Perform operation
    case "$operation" in
        "search")
            grep -n "$pattern" "$input_file" || {
                echo "No matches found for pattern '$pattern'"
                return 0
            }
            ;;
        "count")
            local count=$(grep -c "$pattern" "$input_file" || echo "0")
            echo "Pattern '$pattern' found $count times"
            ;;
        "extract")
            grep -o "$pattern" "$input_file" || {
                echo "No matches found for pattern '$pattern'"
                return 0
            }
            ;;
    esac
}

# Test error handling
echo "Testing error handling:"
safe_text_process "sample.txt" "search" "Engineer"
safe_text_process "nonexistent.txt" "search" "test" || echo "Handled missing file error"
safe_text_process "sample.txt" "invalid_op" "test" || echo "Handled invalid operation error"

# =============================================================================
# CLEANUP AND SUMMARY
# =============================================================================

echo -e "\n=== CLEANUP ==="

# Clean up test files
cleanup_files=(
    sample.txt log_sample.txt text_sample.txt duplicates.txt
    consecutive_dups.txt regex_test.txt sample_backup.txt*
    file1.txt file2.txt file1_sorted.txt file2_sorted.txt
    extended_log.txt special_chars.txt large_test.txt
    test_dir
)

echo "Cleaning up test files..."
for item in "${cleanup_files[@]}"; do
    rm -rf "$item" 2>/dev/null || true
done

echo -e "\n=== TEXT PROCESSING SUMMARY ==="
echo "✓ Basic text processing tools (grep, sed, awk, cut, sort, uniq, tr, wc)"
echo "✓ Regular expressions and pattern matching"
echo "✓ Advanced text processing functions"
echo "✓ Text formatting and presentation"
echo "✓ Text comparison and diff"
echo "✓ Stream processing and pipelines"
echo "✓ Text encoding and character handling"
echo "✓ Performance optimization techniques"
echo "✓ Error handling and validation"

echo "Script completed successfully!"