#!/bin/bash
# 99_snippets.sh
# A collection of useful shell scripting snippets with explanations.

###########################
# 1. Check if a file exists
###########################
FILE="/path/to/file"
if [ -f "$FILE" ]; then
  echo "File exists: $FILE"
else
  echo "File does not exist: $FILE"
fi

###########################
# 2. Loop through all files in a directory
###########################
DIR="/path/to/directory"
for file in "$DIR"/*; do
  echo "Processing file: $file"
done

###########################
# 3. Read a file line by line
###########################
INPUT_FILE="/path/to/input.txt"
while IFS= read -r line; do
  echo "Line: $line"
done < "$INPUT_FILE"

###########################
# 4. Get the length of a string
###########################
STR="Hello, World!"
echo "Length of string: ${#STR}"

###########################
# 5. Get the current date/time in format YYYY-MM-DD_HH-MM-SS
###########################
CURRENT_DATE=$(date +"%Y-%m-%d_%H-%M-%S")
echo "Current date/time: $CURRENT_DATE"

###########################
# 6. Redirect stdout and stderr to a file
###########################
LOGFILE="/tmp/mylog.log"
echo "This is a log message" >> "$LOGFILE" 2>&1

###########################
# 7. Use a here-document to create a file
###########################
cat << EOF > /tmp/myfile.txt
This is line 1
This is line 2
EOF

###########################
# 8. Extract filename from a path
###########################
FULLPATH="/home/user/docs/file.txt"
FILENAME=$(basename "$FULLPATH")
echo "Filename: $FILENAME"

###########################
# 9. Extract directory path from a full path
###########################
DIRPATH=$(dirname "$FULLPATH")
echo "Directory path: $DIRPATH"

###########################
# 10. Check if a command exists
###########################
if command -v curl >/dev/null 2>&1; then
  echo "curl is installed"
else
  echo "curl is not installed"
fi

###########################
# 11. Use getopts to parse command-line options
###########################
while getopts ":u:p:h" opt; do
  case $opt in
    u) USERNAME="$OPTARG"
       echo "Username: $USERNAME"
       ;;
    p) PASSWORD="$OPTARG"
       echo "Password: $PASSWORD"
       ;;
    h) echo "Usage: $0 -u username -p password"
       exit 0
       ;;
    \?) echo "Invalid option: -$OPTARG" >&2
        ;;
  esac
done

###########################
# 12. Create a temporary directory safely
###########################
TMPDIR=$(mktemp -d)
echo "Created temp dir: $TMPDIR"

###########################
# 13. Trap script exit or interrupt and cleanup
###########################
cleanup() {
  echo "Cleaning up..."
  rm -rf "$TMPDIR"
}
trap cleanup EXIT INT

###########################
# 14. Loop with a counter
###########################
for ((i=1; i<=5; i++)); do
  echo "Count: $i"
done

###########################
# 15. Download a file using curl with progress bar
###########################
URL="https://example.com/file.zip"
curl -# -O "$URL"

###########################
# 16. Replace text in a file using sed
###########################
sed -i 's/oldtext/newtext/g' /tmp/myfile.txt

###########################
# 17. Print colored text (red)
###########################
echo -e "\e[31mThis is red text\e[0m"

###########################
# 18. Check if a variable is empty
###########################
VAR=""
if [ -z "$VAR" ]; then
  echo "Variable is empty"
else
  echo "Variable is not empty"
fi

###########################
# 19. Compare two strings
###########################
STR1="abc"
STR2="def"
if [ "$STR1" = "$STR2" ]; then
  echo "Strings are equal"
else
  echo "Strings are different"
fi

###########################
# 20. Append output of a command to a file
###########################
date >> /tmp/date.log

###########################
# End of snippets collection
###########################
