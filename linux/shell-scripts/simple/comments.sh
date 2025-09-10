#!/bin/bash

# --------------------------------------
# This is a Bash program to demonstrate
# single-line and multi-line comments.
# --------------------------------------

# Single-line comment: explaining the next line
echo "Hello, this is a single-line comment example."

# Multi-line comment using a trick with : ' ' 
: '
This is a multi-line comment.
You can write as many lines as you want here.
Bash ignores everything inside this block.
'
echo "This is after the multi-line comment."

# Another single-line comment
echo "End of the comment demonstration."
