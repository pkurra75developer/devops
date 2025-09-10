#!/bin/bash
# ==================================================
# Program 1: If, If-Else, If-Elif-Else, Nested If
# ==================================================

read -p "Enter a number: " num

# Basic if
if [ $num -gt 0 ]; then
    echo "Number is positive"
fi

# If-Else
if [ $num -eq 0 ]; then
    echo "Number is zero"
else
    echo "Number is not zero"
fi

# If-Elif-Else
if [ $num -lt 0 ]; then
    echo "Negative number"
elif [ $num -gt 0 ]; then
    echo "Positive number"
else
    echo "Zero"
fi

# Nested If
if [ $num -ne 0 ]; then
    if [ $((num % 2)) -eq 0 ]; then
        echo "Even number"
    else
        echo "Odd number"
    fi
fi
