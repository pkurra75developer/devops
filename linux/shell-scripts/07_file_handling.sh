#!/bin/bash
# =============================================================================
# FILE AND DIRECTORY HANDLING - Complete Guide
# =============================================================================

set -euo pipefail

# =============================================================================
# BASIC FILE OPERATIONS
# =============================================================================

echo "=== BASIC FILE OPERATIONS ==="

# Create files
echo "Creating files:"
touch simple_file.txt
echo "Hello, World!" > content_file.txt
echo "Line 2" >> content_file.txt

# Create multiple files at once
touch file{1..3}.txt
echo "Created files: $(ls file*.txt)"

# Create file with specific permissions
touch restricted_file.txt
chmod 600 restricted_file.txt
echo "Restricted file permissions: $(ls -l restricted_file.txt | awk '{print $1}')"

# Create file with timestamp
timestamp_file="backup_$(date +%Y%m%d_%H%M%S).txt"
echo "Backup data" > "$timestamp_file"
echo "Created timestamped file: $timestamp_file"

# =============================================================================
# READING FILES
# =============================================================================

echo -e "\n=== READING FILES ==="

# Method 1: Using cat
echo "Reading with cat:"
cat content_file.txt

# Method 2: Using while read loop (best for line-by-line processing)
echo -e "\nReading line by line:"
line_number=1
while IFS= read -r line; do
    echo "Line $line_number: $line"
    ((line_number++))
done < content_file.txt

# Method 3: Reading into array
echo -e "\nReading into array:"
mapfile -t file_lines < content_file.txt
for i in "${!file_lines[@]}"; do
    echo "Array[$i]: ${file_lines[i]}"
done

# Method 4: Reading entire file into variable
echo -e "\nReading entire file:"
file_content=$(<content_file.txt)
echo "File content: $file_content"

# Method 5: Reading with different IFS
echo -e "\nReading CSV-like data:"
cat > data.csv << EOF
Name,Age,City
John,30,New York
Jane,25,London
Bob,35,Tokyo
EOF

{
    IFS=',' read -r header1 header2 header3
    echo "Headers: $header1 | $header2 | $header3"
    
    while IFS=',' read -r name age city; do
        echo "Person: $name ($age) from $city"
    done
} < data.csv

# =============================================================================
# WRITING AND APPENDING FILES
# =============================================================================

echo -e "\n=== WRITING AND APPENDING FILES ==="

# Redirect stdout to file (overwrite)
echo "This overwrites the file" > output.txt

# Redirect stdout to file (append)
echo "This appends to the file" >> output.txt
echo "Another appended line" >> output.txt

# Write multiple lines using here document
cat > multi_line.txt << EOF
Line 1
Line 2
Line 3
EOF

# Write with variables
name="Alice"
age=30
cat > person_info.txt << EOF
Name: $name
Age: $age
Date: $(date)
EOF

# Append with here document
cat >> person_info.txt << EOF
Additional info:
- Status: Active
- Location: Unknown
EOF

echo "Multi-line file content:"
cat multi_line.txt

echo -e "\nPerson info:"
cat person_info.txt

# Write array to file
fruits=("apple" "banana" "cherry" "date")
printf "%s\n" "${fruits[@]}" > fruits.txt
echo -e "\nFruits file:"
cat fruits.txt

# =============================================================================
# FILE TESTS AND PROPERTIES
# =============================================================================

echo -e "\n=== FILE TESTS AND PROPERTIES ==="

# Create test files with different properties
mkdir -p test_dir
touch test_dir/empty_file.txt
echo "content" > test_dir/non_empty_file.txt
ln -s non_empty_file.txt test_dir/symlink.txt
mkfifo test_dir/named_pipe 2>/dev/null || echo "Note: mkfifo not available"

# File existence tests
test_file_properties() {
    local file="$1"
    echo "Testing file: $file"
    
    [[ -e "$file" ]] && echo "  ✓ Exists" || echo "  ✗ Does not exist"
    [[ -f "$file" ]] && echo "  ✓ Regular file" || echo "  ✗ Not a regular file"
    [[ -d "$file" ]] && echo "  ✓ Directory" || echo "  ✗ Not a directory"
    [[ -L "$file" ]] && echo "  ✓ Symbolic link" || echo "  ✗ Not a symbolic link"
    [[ -p "$file" ]] && echo "  ✓ Named pipe" || echo "  ✗ Not a named pipe"
    [[ -s "$file" ]] && echo "  ✓ Non-empty" || echo "  ✗ Empty or doesn't exist"
    [[ -r "$file" ]] && echo "  ✓ Readable" || echo "  ✗ Not readable"
    [[ -w "$file" ]] && echo "  ✓ Writable" || echo "  ✗ Not writable"
    [[ -x "$file" ]] && echo "  ✓ Executable" || echo "  ✗ Not executable"
}

test_file_properties "test_dir"
test_file_properties "test_dir/non_empty_file.txt"
test_file_properties "test_dir/empty_file.txt"
test_file_properties "test_dir/symlink.txt"

# File age comparison
sleep 1
touch newer_file.txt

echo -e "\nFile age comparison:"
if [[ newer_file.txt -nt content_file.txt ]]; then
    echo "newer_file.txt is newer than content_file.txt"
fi

if [[ content_file.txt -ot newer_file.txt ]]; then
    echo "content_file.txt is older than newer_file.txt"
fi

# =============================================================================
# FILE INFORMATION AND METADATA
# =============================================================================

echo -e "\n=== FILE INFORMATION ==="

get_file_info() {
    local file="$1"
    
    if [[ ! -e "$file" ]]; then
        echo "File '$file' does not exist"
        return 1
    fi
    
    echo "File information for: $file"
    echo "  Type: $(file "$file" | cut -d: -f2-)"
    echo "  Size: $(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null) bytes"
    echo "  Permissions: $(stat -f%Sp "$file" 2>/dev/null || stat -c%A "$file" 2>/dev/null)"
    echo "  Owner: $(stat -f%Su "$file" 2>/dev/null || stat -c%U "$file" 2>/dev/null)"
    echo "  Group: $(stat -f%Sg "$file" 2>/dev/null || stat -c%G "$file" 2>/dev/null)"
    echo "  Modified: $(stat -f%Sm "$file" 2>/dev/null || stat -c%y "$file" 2>/dev/null)"
    echo "  Accessed: $(stat -f%Sa "$file" 2>/dev/null || stat -c%x "$file" 2>/dev/null)"
    
    # Calculate human-readable size
    local size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
    local human_size
    if (( size >= 1073741824 )); then
        human_size="$(echo "scale=1; $size / 1073741824" | bc)G"
    elif (( size >= 1048576 )); then
        human_size="$(echo "scale=1; $size / 1048576" | bc)M"
    elif (( size >= 1024 )); then
        human_size="$(echo "scale=1; $size / 1024" | bc)K"
    else
        human_size="${size}B"
    fi
    echo "  Human size: $human_size"
}

get_file_info "content_file.txt"

# =============================================================================
# DIRECTORY OPERATIONS
# =============================================================================

echo -e "\n=== DIRECTORY OPERATIONS ==="

# Create directories
echo "Creating directories:"
mkdir -p deep/nested/directory/structure
mkdir -p project/{src,docs,tests}/{main,utils}

# Create directory with specific permissions
mkdir -m 755 public_dir
mkdir -m 700 private_dir

echo "Directory structure created:"
tree project 2>/dev/null || find project -type d | sort

# Directory navigation and information
echo -e "\nDirectory operations:"
original_dir=$(pwd)
echo "Original directory: $original_dir"

cd project
echo "Changed to: $(pwd)"
echo "Directory contents: $(ls -1 | tr '\n' ' ')"

cd "$original_dir"
echo "Back to: $(pwd)"

# List directory contents with details
list_directory_details() {
    local dir="${1:-.}"
    echo "Detailed listing of $dir:"
    
    for item in "$dir"/*; do
        if [[ -e "$item" ]]; then
            local name=$(basename "$item")
            local type="file"
            [[ -d "$item" ]] && type="directory"
            [[ -L "$item" ]] && type="symlink"
            
            local size="0"
            if [[ -f "$item" ]]; then
                size=$(stat -f%z "$item" 2>/dev/null || stat -c%s "$item" 2>/dev/null)
            fi
            
            printf "  %-20s %-10s %8s bytes\n" "$name" "($type)" "$size"
        fi
    done
}

list_directory_details "project/src"

# =============================================================================
# FILE COPYING AND MOVING
# =============================================================================

echo -e "\n=== FILE COPYING AND MOVING ==="

# Create source files
mkdir -p source_dir
echo "File 1 content" > source_dir/file1.txt
echo "File 2 content" > source_dir/file2.txt

# Copy single file
cp source_dir/file1.txt copied_file.txt
echo "Copied file1.txt to copied_file.txt"

# Copy with backup
cp --backup=numbered source_dir/file1.txt copied_file.txt
echo "Created backup copy"

# Copy directory recursively
cp -r source_dir copied_dir
echo "Copied directory recursively"

# Copy with preservation of attributes
cp -p source_dir/file1.txt preserved_copy.txt
echo "Copied with preserved attributes"

# Move/rename files
mv copied_file.txt renamed_file.txt
echo "Renamed copied_file.txt to renamed_file.txt"

# Move to directory
mkdir -p destination
mv source_dir/file2.txt destination/
echo "Moved file2.txt to destination directory"

# Batch operations
echo "Batch file operations:"
mkdir -p batch_source batch_dest

# Create multiple files
for i in {1..5}; do
    echo "Content $i" > "batch_source/file$i.txt"
done

# Copy all .txt files
cp batch_source/*.txt batch_dest/
echo "Copied all .txt files to batch_dest"

# Move files matching pattern
mkdir -p odd_files even_files
for file in batch_dest/file*.txt; do
    number=$(basename "$file" .txt | sed 's/file//')
    if (( number % 2 == 0 )); then
        mv "$file" even_files/
    else
        mv "$file" odd_files/
    fi
done

echo "Separated files into odd and even directories"
echo "Odd files: $(ls odd_files/)"
echo "Even files: $(ls even_files/)"

# =============================================================================
# FILE SEARCHING AND FINDING
# =============================================================================

echo -e "\n=== FILE SEARCHING ==="

# Create test structure for searching
mkdir -p search_test/{dir1,dir2,dir3}
echo "text content" > search_test/file.txt
echo "log entry" > search_test/app.log
echo "more text" > search_test/dir1/document.txt
echo "script content" > search_test/dir2/script.sh
chmod +x search_test/dir2/script.sh

# Find by name
echo "Finding files by name pattern:"
find search_test -name "*.txt" -type f

# Find by size
echo -e "\nFinding files by size:"
find search_test -size +0c -type f  # Files larger than 0 bytes

# Find by permissions
echo -e "\nFinding executable files:"
find search_test -type f -executable

# Find by modification time
echo -e "\nFinding recently modified files (last 1 minute):"
find search_test -type f -mmin -1

# Find and execute command
echo -e "\nFinding and listing file details:"
find search_test -name "*.txt" -exec ls -l {} \;

# Using locate (if available)
if command -v locate >/dev/null 2>&1; then
    echo -e "\nUsing locate to find bash:"
    locate bash | head -3
fi

# Grep for content in files
echo -e "\nSearching for content in files:"
grep -r "text" search_test/

# Find files containing specific content
echo -e "\nFiles containing 'content':"
grep -l "content" search_test/**/*.* 2>/dev/null || echo "No matches found"

# =============================================================================
# FILE PERMISSIONS AND OWNERSHIP
# =============================================================================

echo -e "\n=== FILE PERMISSIONS ==="

# Create test file
echo "test content" > perm_test.txt

# Numeric permissions
chmod 644 perm_test.txt
echo "Set permissions to 644: $(ls -l perm_test.txt | awk '{print $1}')"

chmod 755 perm_test.txt
echo "Set permissions to 755: $(ls -l perm_test.txt | awk '{print $1}')"

# Symbolic permissions
chmod u+x perm_test.txt
echo "Added execute for user: $(ls -l perm_test.txt | awk '{print $1}')"

chmod g-w perm_test.txt
echo "Removed write for group: $(ls -l perm_test.txt | awk '{print $1}')"

chmod o=r perm_test.txt
echo "Set other to read-only: $(ls -l perm_test.txt | awk '{print $1}')"

# Recursive permissions
mkdir -p perm_dir/{sub1,sub2}
touch perm_dir/{file1.txt,sub1/file2.txt,sub2/file3.txt}

chmod -R 755 perm_dir
echo "Set recursive permissions on directory"

# Special permissions
echo -e "\nSpecial permissions:"
mkdir -p special_dir
chmod 1755 special_dir  # Sticky bit
echo "Sticky bit set: $(ls -ld special_dir | awk '{print $1}')"

# Check permissions programmatically
check_permissions() {
    local file="$1"
    local perms=$(stat -f%Sp "$file" 2>/dev/null || stat -c%A "$file" 2>/dev/null)
    echo "Permissions for $file: $perms"
    
    # Check specific permissions
    [[ -r "$file" ]] && echo "  ✓ Readable by current user"
    [[ -w "$file" ]] && echo "  ✓ Writable by current user"
    [[ -x "$file" ]] && echo "  ✓ Executable by current user"
}

check_permissions "perm_test.txt"

# =============================================================================
# FILE COMPRESSION AND ARCHIVES
# =============================================================================

echo -e "\n=== FILE COMPRESSION AND ARCHIVES ==="

# Create files for archiving
mkdir -p archive_test
echo "File 1" > archive_test/file1.txt
echo "File 2" > archive_test/file2.txt
echo "File 3" > archive_test/file3.txt

# Create tar archive
echo "Creating tar archive:"
tar -cf archive.tar archive_test/
echo "Archive created: $(ls -lh archive.tar | awk '{print $5}')"

# Create compressed tar archive
tar -czf archive.tar.gz archive_test/
echo "Compressed archive created: $(ls -lh archive.tar.gz | awk '{print $5}')"

# List archive contents
echo -e "\nArchive contents:"
tar -tf archive.tar.gz

# Extract archive
mkdir -p extracted
tar -xzf archive.tar.gz -C extracted/
echo "Archive extracted to extracted/"

# Create zip archive (if available)
if command -v zip >/dev/null 2>&1; then
    zip -r archive.zip archive_test/
    echo "ZIP archive created: $(ls -lh archive.zip | awk '{print $5}')"
    
    # List zip contents
    echo "ZIP contents:"
    unzip -l archive.zip
fi

# Compress individual files
if command -v gzip >/dev/null 2>&1; then
    cp archive_test/file1.txt file_to_compress.txt
    gzip file_to_compress.txt
    echo "File compressed: $(ls -lh file_to_compress.txt.gz | awk '{print $5}')"
    
    # Decompress
    gunzip file_to_compress.txt.gz
    echo "File decompressed"
fi

# =============================================================================
# FILE MONITORING AND WATCHING
# =============================================================================

echo -e "\n=== FILE MONITORING ==="

# Create file for monitoring
echo "initial content" > monitored_file.txt

# Function to monitor file changes
monitor_file() {
    local file="$1"
    local duration="${2:-5}"
    
    echo "Monitoring $file for $duration seconds..."
    
    local initial_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
    local initial_mtime=$(stat -f%m "$file" 2>/dev/null || stat -c%Y "$file" 2>/dev/null)
    
    sleep "$duration"
    
    local final_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
    local final_mtime=$(stat -f%m "$file" 2>/dev/null || stat -c%Y "$file" 2>/dev/null)
    
    if [[ $initial_mtime -ne $final_mtime ]]; then
        echo "File was modified!"
        echo "Size changed from $initial_size to $final_size bytes"
    else
        echo "No changes detected"
    fi
}

# Simulate file monitoring (in background)
(
    sleep 2
    echo "modified content" >> monitored_file.txt
) &

monitor_file "monitored_file.txt" 3

# Watch directory for changes (using inotify if available)
if command -v inotifywait >/dev/null 2>&1; then
    echo -e "\nUsing inotifywait for real-time monitoring:"
    mkdir -p watch_dir
    
    # Start monitoring in background
    inotifywait -m watch_dir/ -e create,delete,modify --format '%w%f %e' &
    INOTIFY_PID=$!
    
    # Make some changes
    sleep 1
    touch watch_dir/new_file.txt
    echo "content" > watch_dir/new_file.txt
    rm watch_dir/new_file.txt
    
    sleep 2
    kill $INOTIFY_PID 2>/dev/null
fi

# =============================================================================
# FILE LOCKING AND CONCURRENT ACCESS
# =============================================================================

echo -e "\n=== FILE LOCKING ==="

# Simple file locking mechanism
acquire_lock() {
    local lockfile="$1"
    local timeout="${2:-10}"
    local count=0
    
    while [[ $count -lt $timeout ]]; do
        if (set -C; echo $$ > "$lockfile") 2>/dev/null; then
            echo "Lock acquired: $lockfile"
            return 0
        fi
        echo "Waiting for lock... ($count/$timeout)"
        sleep 1
        ((count++))
    done
    
    echo "Failed to acquire lock after $timeout seconds"
    return 1
}

release_lock() {
    local lockfile="$1"
    if [[ -f "$lockfile" ]]; then
        rm "$lockfile"
        echo "Lock released: $lockfile"
    fi
}

# Demonstrate locking
lockfile="process.lock"

if acquire_lock "$lockfile" 5; then
    echo "Performing critical operation..."
    sleep 2
    echo "Operation completed"
    release_lock "$lockfile"
fi

# Atomic file operations
atomic_write() {
    local target_file="$1"
    local content="$2"
    local temp_file="${target_file}.tmp.$$"
    
    # Write to temporary file
    echo "$content" > "$temp_file"
    
    # Atomically move to target
    if mv "$temp_file" "$target_file"; then
        echo "Atomic write successful"
        return 0
    else
        rm -f "$temp_file"
        echo "Atomic write failed"
        return 1
    fi
}

atomic_write "atomic_test.txt" "This was written atomically"

# =============================================================================
# FILE BACKUP AND VERSIONING
# =============================================================================

echo -e "\n=== FILE BACKUP AND VERSIONING ==="

# Simple backup function
backup_file() {
    local file="$1"
    local backup_dir="${2:-./backups}"
    
    if [[ ! -f "$file" ]]; then
        echo "Error: File '$file' not found"
        return 1
    fi
    
    mkdir -p "$backup_dir"
    
    local filename=$(basename "$file")
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_name="${filename}.${timestamp}.bak"
    
    if cp "$file" "$backup_dir/$backup_name"; then
        echo "Backup created: $backup_dir/$backup_name"
        return 0
    else
        echo "Backup failed"
        return 1
    fi
}

# Versioned backup system
versioned_backup() {
    local file="$1"
    local max_versions="${2:-5}"
    local backup_dir="./versions"
    
    mkdir -p "$backup_dir"
    
    local filename=$(basename "$file")
    local base_name="${filename%.*}"
    local extension="${filename##*.}"
    
    # Shift existing versions
    for ((i=max_versions; i>1; i--)); do
        local current_version="$backup_dir/${base_name}.v$((i-1)).${extension}"
        local next_version="$backup_dir/${base_name}.v${i}.${extension}"
        
        if [[ -f "$current_version" ]]; then
            mv "$current_version" "$next_version"
        fi
    done
    
    # Create new version 1
    if [[ -f "$file" ]]; then
        cp "$file" "$backup_dir/${base_name}.v1.${extension}"
        echo "Created version 1 backup"
    fi
}

# Test backup functions
echo "content version 1" > version_test.txt
backup_file "version_test.txt"

echo "content version 2" > version_test.txt
versioned_backup "version_test.txt"

echo "content version 3" > version_test.txt
versioned_backup "version_test.txt"

echo "Backup files created:"
ls -la backups/ versions/ 2>/dev/null || echo "Backup directories not found"

# =============================================================================
# FILE SYNCHRONIZATION
# =============================================================================

echo -e "\n=== FILE SYNCHRONIZATION ==="

# Simple sync function
sync_directories() {
    local source_dir="$1"
    local target_dir="$2"
    local dry_run="${3:-false}"
    
    if [[ ! -d "$source_dir" ]]; then
        echo "Error: Source directory '$source_dir' not found"
        return 1
    fi
    
    mkdir -p "$target_dir"
    
    echo "Synchronizing $source_dir -> $target_dir"
    
    # Find files in source
    find "$source_dir" -type f | while read -r source_file; do
        local relative_path="${source_file#$source_dir/}"
        local target_file="$target_dir/$relative_path"
        local target_subdir=$(dirname "$target_file")
        
        # Create target subdirectory if needed
        mkdir -p "$target_subdir"
        
        # Check if sync is needed
        local need_sync=false
        
        if [[ ! -f "$target_file" ]]; then
            need_sync=true
            echo "  NEW: $relative_path"
        elif [[ "$source_file" -nt "$target_file" ]]; then
            need_sync=true
            echo "  UPDATED: $relative_path"
        fi
        
        # Perform sync
        if [[ $need_sync == true ]]; then
            if [[ $dry_run == false ]]; then
                cp "$source_file" "$target_file"
            else
                echo "    (dry run - would copy)"
            fi
        fi
    done
}

# Create test directories for sync
mkdir -p sync_source sync_target
echo "file 1" > sync_source/file1.txt
echo "file 2" > sync_source/file2.txt
mkdir -p sync_source/subdir
echo "nested file" > sync_source/subdir/nested.txt

# Perform sync
sync_directories "sync_source" "sync_target"

# Modify source and sync again
sleep 1
echo "modified file 1" > sync_source/file1.txt
echo "new file" > sync_source/file3.txt

echo -e "\nSecond sync:"
sync_directories "sync_source" "sync_target"

# =============================================================================
# TEMPORARY FILES AND CLEANUP
# =============================================================================

echo -e "\n=== TEMPORARY FILES ==="

# Create temporary files safely
create_temp_file() {
    local template="${1:-tmp.XXXXXX}"
    local temp_file
    
    temp_file=$(mktemp "$template")
    echo "Created temporary file: $temp_file"
    echo "$temp_file"
}

create_temp_dir() {
    local template="${1:-tmp.XXXXXX}"
    local temp_dir
    
    temp_dir=$(mktemp -d "$template")
    echo "Created temporary directory: $temp_dir"
    echo "$temp_dir"
}

# Test temporary file creation
temp_file=$(create_temp_file)
temp_dir=$(create_temp_dir)

echo "Using temporary file: $temp_file"
echo "test content" > "$temp_file"

echo "Using temporary directory: $temp_dir"
echo "nested content" > "$temp_dir/nested_file.txt"

# Cleanup function with trap
cleanup_temp_files() {
    echo "Cleaning up temporary files..."
    [[ -f "$temp_file" ]] && rm -f "$temp_file"
    [[ -d "$temp_dir" ]] && rm -rf "$temp_dir"
}

# Set trap for cleanup
trap cleanup_temp_files EXIT

# Working with temporary files in functions
process_with_temp() {
    local input_file="$1"
    local temp_work_file=$(mktemp)
    
    # Ensure cleanup
    trap "rm -f '$temp_work_file'" RETURN
    
    echo "Processing $input_file with temporary workspace"
    
    # Copy to temp for processing
    cp "$input_file" "$temp_work_file"
    
    # Simulate processing
    echo "# Processed on $(date)" >> "$temp_work_file"
    
    # Show result
    echo "Processed content:"
    cat "$temp_work_file"
}

process_with_temp "content_file.txt"

# =============================================================================
# FILE SYSTEM INFORMATION
# =============================================================================

echo -e "\n=== FILE SYSTEM INFORMATION ==="

# Disk usage information
show_disk_usage() {
    echo "Disk usage information:"
    df -h | head -5
    
    echo -e "\nDirectory sizes:"
    du -sh */ 2>/dev/null | head -5
}

show_disk_usage

# File system type and mount information
show_mount_info() {
    echo "Mount information:"
    if command -v mount >/dev/null 2>&1; then
        mount | grep -E "^/" | head -3
    fi
    
    echo -e "\nFile system types:"
    if [[ -f /proc/filesystems ]]; then
        cat /proc/filesystems | head -5
    fi
}

show_mount_info

# Inode information
show_inode_info() {
    local file="$1"
    if [[ -e "$file" ]]; then
        local inode=$(stat -f%i "$file" 2>/dev/null || stat -c%i "$file" 2>/dev/null)
        local links=$(stat -f%l "$file" 2>/dev/null || stat -c%h "$file" 2>/dev/null)
        echo "File: $file"
        echo "  Inode: $inode"
        echo "  Hard links: $links"
    fi
}

show_inode_info "content_file.txt"

# =============================================================================
# ADVANCED FILE OPERATIONS
# =============================================================================

echo -e "\n=== ADVANCED FILE OPERATIONS ==="

# File comparison
compare_files() {
    local file1="$1"
    local file2="$2"
    
    echo "Comparing $file1 and $file2:"
    
    if [[ ! -f "$file1" || ! -f "$file2" ]]; then
        echo "One or both files don't exist"
        return 1
    fi
    
    # Binary comparison
    if cmp -s "$file1" "$file2"; then
        echo "Files are identical"
    else
        echo "Files differ"
        
        # Show differences if they're text files
        if file "$file1" | grep -q text && file "$file2" | grep -q text; then
            echo "Differences:"
            diff "$file1" "$file2" || true
        fi
    fi
}

# Create files for comparison
echo -e "line 1\nline 2\nline 3" > file_a.txt
echo -e "line 1\nline 2 modified\nline 3" > file_b.txt

compare_files "file_a.txt" "file_b.txt"

# File splitting and joining
split_file() {
    local file="$1"
    local lines_per_file="${2:-10}"
    local prefix="${3:-split_}"
    
    if [[ ! -f "$file" ]]; then
        echo "File not found: $file"
        return 1
    fi
    
    echo "Splitting $file into chunks of $lines_per_file lines each"
    split -l "$lines_per_file" "$file" "$prefix"
    
    echo "Created files:"
    ls -la ${prefix}* 2>/dev/null || echo "No split files created"
}

# Create large file for splitting
seq 1 25 > large_file.txt
split_file "large_file.txt" 10 "chunk_"

# Join files back
join_files() {
    local pattern="$1"
    local output_file="$2"
    
    echo "Joining files matching pattern: $pattern"
    cat $pattern > "$output_file"
    echo "Joined file created: $output_file"
}

join_files "chunk_*" "rejoined_file.txt"

# Verify join
echo "Original file lines: $(wc -l < large_file.txt)"
echo "Rejoined file lines: $(wc -l < rejoined_file.txt)"

# =============================================================================
# ERROR HANDLING AND VALIDATION
# =============================================================================

echo -e "\n=== ERROR HANDLING ==="

# Safe file operations with error handling
safe_file_operation() {
    local operation="$1"
    local source="$2"
    local target="$3"
    
    case "$operation" in
        "copy")
            if [[ ! -f "$source" ]]; then
                echo "Error: Source file '$source' not found" >&2
                return 1
            fi
            
            if ! cp "$source" "$target" 2>/dev/null; then
                echo "Error: Failed to copy '$source' to '$target'" >&2
                return 2
            fi
            
            echo "Successfully copied '$source' to '$target'"
            ;;
            
        "move")
            if [[ ! -f "$source" ]]; then
                echo "Error: Source file '$source' not found" >&2
                return 1
            fi
            
            if ! mv "$source" "$target" 2>/dev/null; then
                echo "Error: Failed to move '$source' to '$target'" >&2
                return 2
            fi
            
            echo "Successfully moved '$source' to '$target'"
            ;;
            
        *)
            echo "Error: Unknown operation '$operation'" >&2
            return 3
            ;;
    esac
}

# Test error handling
echo "Testing safe file operations:"
safe_file_operation "copy" "content_file.txt" "safe_copy.txt"
safe_file_operation "copy" "nonexistent.txt" "failed_copy.txt" || echo "Copy failed as expected"

# File validation
validate_file() {
    local file="$1"
    local expected_type="$2"
    local max_size="$3"
    
    echo "Validating file: $file"
    
    # Check existence
    if [[ ! -e "$file" ]]; then
        echo "  ✗ File does not exist"
        return 1
    fi
    
    # Check type
    case "$expected_type" in
        "text")
            if ! file "$file" | grep -q text; then
                echo "  ✗ Not a text file"
                return 2
            fi
            ;;
        "directory")
            if [[ ! -d "$file" ]]; then
                echo "  ✗ Not a directory"
                return 2
            fi
            ;;
    esac
    
    # Check size
    if [[ -n "$max_size" ]]; then
        local size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
        if (( size > max_size )); then
            echo "  ✗ File too large: $size > $max_size bytes"
            return 3
        fi
    fi
    
    echo "  ✓ File validation passed"
    return 0
}

validate_file "content_file.txt" "text" 1000
validate_file "project" "directory"

# =============================================================================
# CLEANUP AND SUMMARY
# =============================================================================

echo -e "\n=== CLEANUP ==="

# Clean up all test files and directories
cleanup_files=(
    simple_file.txt content_file.txt file*.txt restricted_file.txt
    backup_*.txt data.csv output.txt multi_line.txt person_info.txt
    fruits.txt newer_file.txt test_dir copied_file.txt* renamed_file.txt
    preserved_copy.txt destination source_dir copied_dir batch_source
    batch_dest odd_files even_files search_test perm_test.txt perm_dir
    special_dir archive_test archive.tar* extracted file_to_compress.txt*
    monitored_file.txt watch_dir process.lock atomic_test.txt backups
    versions version_test.txt sync_source sync_target file_a.txt
    file_b.txt large_file.txt chunk_* rejoined_file.txt safe_copy.txt
    project deep
)

echo "Cleaning up test files and directories..."
for item in "${cleanup_files[@]}"; do
    rm -rf "$item" 2>/dev/null || true
done

# The trap will clean up temporary files

echo -e "\n=== FILE HANDLING SUMMARY ==="
echo "✓ Basic file operations (create, read, write)"
echo "✓ File tests and properties"
echo "✓ File information and metadata"
echo "✓ Directory operations"
echo "✓ File copying and moving"
echo "✓ File searching and finding"
echo "✓ File permissions and ownership"
echo "✓ File compression and archives"
echo "✓ File monitoring and watching"
echo "✓ File locking and concurrent access"
echo "✓ File backup and versioning"
echo "✓ File synchronization"
echo "✓ Temporary files and cleanup"
echo "✓ File system information"
echo "✓ Advanced file operations"
echo "✓ Error handling and validation"

echo "Script completed successfully!"