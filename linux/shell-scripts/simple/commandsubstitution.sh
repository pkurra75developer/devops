#!/bin/bash
# --------------------------------------
# Script: Greeting with User, Date, and Time
# Demonstrates variables, command substitution, and echo output
# --------------------------------------

# Get the current logged-in user
# $USER is an environment variable that stores the username
user=$USER

# Get current date using command substitution
# $(command) runs 'command' and stores its output in a variable
# Here, 'date +"%Y-%m-%d"' formats the date as YYYY-MM-DD
dt=$(date +"%Y-%m-%d")

# Get current time using command substitution
# 'date +"%H:%M:%S"' formats the time as HH:MM:SS
tm=$(date +"%H:%M:%S")

# Print a greeting message using the variables
echo "Hello, $user! Today is $dt and current time is $tm."

# --------------------------------------
# Notes:
# 1. Command substitution: variable=$(command)
#    - Runs 'command' in a subshell and stores its output
#    - Older syntax: `command` (backticks), but $() is preferred
# 2. $USER is a predefined environment variable
# 3. date command can be formatted using + format strings
# --------------------------------------
