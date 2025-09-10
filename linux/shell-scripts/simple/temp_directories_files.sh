#!/bin/bash

# ==============================
# Demonstration of mktemp
# ==============================

echo "=== Temporary File Demo ==="

# Create a temporary file and store its name in a variable
tmpfile=$(mktemp)

# Print the temporary file path
echo "Temporary file created: $tmpfile"

# Write something into the temp file
echo "Hello, this is a temporary file!" > "$tmpfile"

# Display the contents
echo "Contents of temp file:"
cat "$tmpfile"

# Remove the temp file
rm "$tmpfile"
echo "Temporary file deleted: $tmpfile"

echo ""
echo "=== Temporary Directory Demo ==="

# Create a temporary directory
tmpdir=$(mktemp -d)

# Print the temp directory path
echo "Temporary directory created: $tmpdir"

# Create a sample file inside the temp directory
echo "This is a file inside the temp directory" > "$tmpdir/sample.txt"

# List contents of the temp directory
echo "Contents of temp directory:"
ls -l "$tmpdir"

# Remove the temp directory and its contents
rm -r "$tmpdir"
echo "Temporary directory deleted: $tmpdir"

echo ""
echo "Demo complete!"
