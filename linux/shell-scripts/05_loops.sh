#!/bin/bash
# =============================================================================
# LOOPS - Complete Guide to All Loop Types
# =============================================================================

set -euo pipefail

# =============================================================================
# FOR LOOPS - BASIC SYNTAX
# =============================================================================

echo "=== BASIC FOR LOOPS ==="

# Simple list iteration
echo "Iterating over a list:"
for item in apple banana cherry; do
    echo "  Fruit: $item"
done

# Using variables in list
fruits="apple banana cherry date"
echo -e "\nIterating over variable list:"
for fruit in $fruits; do
    echo "  Fruit: $fruit"
done

# Array iteration
echo -e "\nIterating over array:"
colors=("red" "green" "blue" "yellow")
for color in "${colors[@]}"; do
    echo "  Color: $color"
done

# =============================================================================
# FOR LOOPS - NUMERIC RANGES
# =============================================================================

echo -e "\n=== NUMERIC FOR LOOPS ==="

# C-style for loop
echo "C-style for loop (1 to 5):"
for ((i=1; i<=5; i++)); do
    echo "  Number: $i"
done

# Countdown
echo -e "\nCountdown from 5 to 1:"
for ((i=5; i>=1; i--)); do
    echo "  $i..."
done
echo "  Blast off!"

# Step increment
echo -e "\nEven numbers from 2 to 10:"
for ((i=2; i<=10; i+=2)); do
    echo "  Even: $i"
done

# Using seq command
echo -e "\nUsing seq command:"
for i in $(seq 1 3 10); do  # start step end
    echo "  Sequence: $i"
done

# Brace expansion
echo -e "\nUsing brace expansion:"
for i in {1..5}; do
    echo "  Brace: $i"
done

# Brace expansion with step
echo -e "\nBrace expansion with step:"
for i in {0..20..5}; do  # start..end..step
    echo "  Step 5: $i"
done

# =============================================================================
# FOR LOOPS - FILE AND DIRECTORY OPERATIONS
# =============================================================================

echo -e "\n=== FILE OPERATIONS WITH FOR LOOPS ==="

# Create test files
mkdir -p test_loop_dir
touch test_loop_dir/{file1.txt,file2.log,file3.txt,script.sh}

# Iterate over files in directory
echo "Files in test_loop_dir:"
for file in test_loop_dir/*; do
    if [[ -f "$file" ]]; then
        echo "  File: $(basename "$file")"
    fi
done

# Iterate over specific file types
echo -e "\nText files only:"
for txtfile in test_loop_dir/*.txt; do
    if [[ -f "$txtfile" ]]; then
        echo "  Text file: $(basename "$txtfile")"
    fi
done

# Handle case when no files match pattern
echo -e "\nHandling no matches (PDF files):"
shopt -s nullglob  # Expand to nothing if no matches
for pdffile in test_loop_dir/*.pdf; do
    echo "  PDF file: $(basename "$pdffile")"
done
if [[ ${#test_loop_dir/*.pdf} -eq 0 ]]; then
    echo "  No PDF files found"
fi
shopt -u nullglob

# Recursive file iteration (using find)
echo -e "\nRecursive file search:"
for file in $(find test_loop_dir -type f -name "*.txt"); do
    echo "  Found: $file"
done

# =============================================================================
# WHILE LOOPS
# =============================================================================

echo -e "\n=== WHILE LOOPS ==="

# Basic while loop
echo "Basic while loop (countdown):"
counter=5
while [[ $counter -gt 0 ]]; do
    echo "  Counter: $counter"
    ((counter--))
done

# Reading from file
echo -e "\nReading file line by line:"
cat > temp_file.txt << EOF
Line 1
Line 2
Line 3
EOF

line_number=1
while IFS= read -r line; do
    echo "  Line $line_number: $line"
    ((line_number++))
done < temp_file.txt

# Infinite loop with break condition
echo -e "\nInfinite loop with break:"
counter=0
while true; do
    echo "  Iteration: $counter"
    ((counter++))
    if [[ $counter -ge 3 ]]; then
        echo "  Breaking out of loop"
        break
    fi
done

# While loop with multiple conditions
echo -e "\nWhile loop with multiple conditions:"
x=1
y=10
while [[ $x -lt 5 && $y -gt 5 ]]; do
    echo "  x=$x, y=$y"
    ((x++))
    ((y--))
done

# =============================================================================
# UNTIL LOOPS
# =============================================================================

echo -e "\n=== UNTIL LOOPS ==="

# Basic until loop (opposite of while)
echo "Until loop (counting up):"
counter=1
until [[ $counter -gt 5 ]]; do
    echo "  Counter: $counter"
    ((counter++))
done

# Until with file checking
echo -e "\nWaiting for file to be created:"
target_file="temp_target.txt"
attempts=0
until [[ -f "$target_file" || $attempts -ge 3 ]]; do
    echo "  Attempt $((attempts + 1)): File not found, waiting..."
    ((attempts++))
    sleep 1
    # Simulate file creation on 3rd attempt
    if [[ $attempts -eq 3 ]]; then
        touch "$target_file"
        echo "  File created!"
    fi
done

# =============================================================================
# NESTED LOOPS
# =============================================================================

echo -e "\n=== NESTED LOOPS ==="

# Multiplication table
echo "Multiplication table (3x3):"
for i in {1..3}; do
    for j in {1..3}; do
        result=$((i * j))
        printf "%2d " $result
    done
    echo  # New line after each row
done

# Matrix-like structure
echo -e "\nMatrix coordinates:"
for row in {1..3}; do
    for col in {A..C}; do
        echo "  Position: $row$col"
    done
done

# =============================================================================
# LOOP CONTROL STATEMENTS
# =============================================================================

echo -e "\n=== LOOP CONTROL STATEMENTS ==="

# Continue statement
echo "Using continue (skip even numbers):"
for i in {1..10}; do
    if (( i % 2 == 0 )); then
        continue  # Skip even numbers
    fi
    echo "  Odd number: $i"
done

# Break statement
echo -e "\nUsing break (stop at 7):"
for i in {1..10}; do
    if [[ $i -eq 7 ]]; then
        echo "  Breaking at $i"
        break
    fi
    echo "  Number: $i"
done

# Nested loop control
echo -e "\nNested loop with break:"
for outer in {1..3}; do
    echo "  Outer loop: $outer"
    for inner in {1..5}; do
        if [[ $inner -eq 3 ]]; then
            echo "    Breaking inner loop at $inner"
            break
        fi
        echo "    Inner loop: $inner"
    done
done

# =============================================================================
# ADVANCED LOOP PATTERNS
# =============================================================================

echo -e "\n=== ADVANCED LOOP PATTERNS ==="

# Loop with array indices
echo "Array with indices:"
animals=("cat" "dog" "bird" "fish")
for i in "${!animals[@]}"; do
    echo "  Index $i: ${animals[i]}"
done

# Associative array iteration
echo -e "\nAssociative array iteration:"
declare -A person
person[name]="John"
person[age]="30"
person[city]="New York"

for key in "${!person[@]}"; do
    echo "  $key: ${person[$key]}"
done

# Parallel iteration of two arrays
echo -e "\nParallel array iteration:"
names=("Alice" "Bob" "Charlie")
ages=(25 30 35)

for i in "${!names[@]}"; do
    echo "  ${names[i]} is ${ages[i]} years old"
done

# =============================================================================
# LOOPS WITH COMMAND SUBSTITUTION
# =============================================================================

echo -e "\n=== LOOPS WITH COMMAND SUBSTITUTION ==="

# Loop over command output
echo "Current processes (top 5):"
counter=0
for process in $(ps aux | tail -n +2 | awk '{print $11}' | head -5); do
    ((counter++))
    echo "  Process $counter: $process"
done

# Loop over lines from command (better approach)
echo -e "\nLoop over lines (using while read):"
counter=0
ps aux | tail -n +2 | head -5 | while IFS= read -r line; do
    ((counter++))
    process=$(echo "$line" | awk '{print $11}')
    echo "  Process $counter: $process"
done

# =============================================================================
# LOOPS FOR DATA PROCESSING
# =============================================================================

echo -e "\n=== DATA PROCESSING LOOPS ==="

# CSV processing
echo "Processing CSV data:"
cat > data.csv << EOF
Name,Age,City
Alice,25,New York
Bob,30,London
Charlie,35,Tokyo
EOF

# Skip header and process data
{
    read  # Skip header
    while IFS=',' read -r name age city; do
        echo "  $name ($age) lives in $city"
    done
} < data.csv

# Processing log files
echo -e "\nProcessing log entries:"
cat > access.log << EOF
192.168.1.1 - GET /index.html 200
192.168.1.2 - POST /login 401
192.168.1.1 - GET /dashboard 200
EOF

while read -r ip dash method path status; do
    if [[ $status == "401" ]]; then
        echo "  Security alert: Failed login from $ip"
    elif [[ $status == "200" ]]; then
        echo "  Success: $ip accessed $path"
    fi
done < access.log

# =============================================================================
# PERFORMANCE CONSIDERATIONS
# =============================================================================

echo -e "\n=== PERFORMANCE EXAMPLES ==="

# Efficient large number processing
echo "Processing large range efficiently:"
start_time=$(date +%s.%N)

# Method 1: Brace expansion (faster for small ranges)
sum=0
for i in {1..1000}; do
    ((sum += i))
done
echo "  Sum using brace expansion: $sum"

end_time=$(date +%s.%N)
duration=$(echo "$end_time - $start_time" | bc)
echo "  Time taken: ${duration} seconds"

# Method 2: C-style loop (better for large ranges)
start_time=$(date +%s.%N)
sum=0
for ((i=1; i<=1000; i++)); do
    ((sum += i))
done
echo "  Sum using C-style loop: $sum"

end_time=$(date +%s.%N)
duration=$(echo "$end_time - $start_time" | bc)
echo "  Time taken: ${duration} seconds"

# =============================================================================
# ERROR HANDLING IN LOOPS
# =============================================================================

echo -e "\n=== ERROR HANDLING IN LOOPS ==="

# Safe file processing
echo "Safe file processing:"
files=("existing_file.txt" "nonexistent_file.txt" "another_file.txt")

for file in "${files[@]}"; do
    if [[ -f "$file" ]]; then
        echo "  Processing $file"
        # Process file here
    else
        echo "  Warning: $file not found, skipping"
        continue
    fi
done

# Loop with error counting
echo -e "\nLoop with error tracking:"
error_count=0
total_operations=5

for i in $(seq 1 $total_operations); do
    # Simulate operation that might fail
    if (( RANDOM % 3 == 0 )); then
        echo "  Operation $i: Failed"
        ((error_count++))
    else
        echo "  Operation $i: Success"
    fi
done

echo "  Total errors: $error_count/$total_operations"

# =============================================================================
# PRACTICAL EXAMPLES
# =============================================================================

echo -e "\n=== PRACTICAL EXAMPLES ==="

# Backup multiple directories
echo "Backup simulation:"
directories=("documents" "pictures" "videos")
backup_base="/tmp/backup"

for dir in "${directories[@]}"; do
    backup_path="$backup_base/$dir"
    echo "  Backing up $dir to $backup_path"
    # mkdir -p "$backup_path"
    # cp -r "$HOME/$dir"/* "$backup_path/" 2>/dev/null || echo "    No files to backup in $dir"
done

# System monitoring loop
echo -e "\nSystem monitoring (3 iterations):"
for iteration in {1..3}; do
    echo "  Check $iteration:"
    echo "    Load: $(uptime | awk -F'load average:' '{print $2}')"
    echo "    Memory: $(free -h | awk '/^Mem:/ {print $3"/"$2}')"
    echo "    Disk: $(df -h / | awk 'NR==2 {print $5}')"
    [[ $iteration -lt 3 ]] && sleep 1
done

# Batch file processing
echo -e "\nBatch file processing:"
mkdir -p batch_input batch_output

# Create sample files
for i in {1..3}; do
    echo "Sample content $i" > "batch_input/file$i.txt"
done

# Process files
for input_file in batch_input/*.txt; do
    if [[ -f "$input_file" ]]; then
        filename=$(basename "$input_file")
        output_file="batch_output/processed_$filename"
        echo "  Processing $filename"
        # Simulate processing
        echo "Processed: $(cat "$input_file")" > "$output_file"
    fi
done

# =============================================================================
# CLEANUP AND SUMMARY
# =============================================================================

# Clean up test files and directories
rm -rf test_loop_dir temp_file.txt temp_target.txt data.csv access.log
rm -rf batch_input batch_output

echo -e "\n=== LOOPS SUMMARY ==="
echo "✓ Basic for loops with lists"
echo "✓ Numeric for loops (C-style and ranges)"
echo "✓ File and directory iteration"
echo "✓ While loops"
echo "✓ Until loops"
echo "✓ Nested loops"
echo "✓ Loop control (break, continue)"
echo "✓ Advanced patterns"
echo "✓ Command substitution in loops"
echo "✓ Data processing"
echo "✓ Performance considerations"
echo "✓ Error handling"
echo "✓ Practical examples"

echo "Script completed successfully!"