#!/bin/bash
# --------------------------------------
# Bash String Manipulation Demo
# --------------------------------------

# 1. Declare a string variable
name="Praveen Kurra"
echo "Original string: $name"

# 2. String length
length=${#name}           # ${#var} gives the length of the string
echo "Length of string: $length"

# 3. Extract substring
# Syntax: ${var:position:length}
substr=${name:0:6}        # Extract first 6 characters
echo "Substring (first 6 chars): $substr"

# 4. Find a substring (using grep or parameter expansion)
# Check if 'Kurra' is in the string
if [[ $name == *"Kurra"* ]]; then
    echo "'Kurra' found in string"
else
    echo "'Kurra' not found"
fi

# 5. Replace substring
# Syntax: ${var/old/new} (replace first occurrence)
newname=${name/Praveen/PK}
echo "After replacement: $newname"

# 6. Replace all occurrences
# Syntax: ${var//old/new} (replace all occurrences)
text="apple banana apple cherry"
all_replace=${text//apple/kiwi}
echo "After replacing all 'apple': $all_replace"

# 7. Convert to uppercase
upper=${name^^}           # ^^ converts to uppercase
echo "Uppercase: $upper"

# 8. Convert to lowercase
lower=${name,,}           # ,, converts to lowercase
echo "Lowercase: $lower"

# 9. Trim leading and trailing whitespace
str="   Hello Bash   "
trimmed=$(echo "$str" | xargs)   # xargs removes leading/trailing spaces
echo "Trimmed string: '$trimmed'"

# 10. Concatenation
greeting="Hello, "
full_greeting="$greeting$name"
echo "Concatenated string: $full_greeting"

# 11. Access individual characters
# Syntax: ${var:position:1}
first_char=${name:0:1}
echo "First character: $first_char"

# --------------------------------------
# Notes:
# 1. ${#var} → length of string
# 2. ${var:pos:len} → substring
# 3. ${var/old/new} → replace first occurrence
# 4. ${var//old/new} → replace all occurrences
# 5. ^^ and ,, → uppercase and lowercase
# 6. Concatenation is simple: just combine variables
# 7. xargs or parameter expansion can trim whitespace
# --------------------------------------
