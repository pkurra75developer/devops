#!/bin/bash

# Assign value 1 to variable x
# Bash: NO spaces allowed around =    ✅ x=1
# Python: spaces are allowed          ✅ x = 1 or x=1
x=1

# Assign value 2 to variable y
# Bash: NO spaces allowed             ✅ y=2
# Python: spaces are allowed          ✅ y = 2 or y=2
y=2

# Perform arithmetic addition of x and y
# Bash: use $(( ... )) for arithmetic
#       Inside $(( ... )), you can use variable names directly without $
# Python: you just write x + y
result=$((x + y))  

# Print the result to the terminal
# Bash: echo is used
# Python: print() is used
echo "Result is $result"
