# 12 - MUST DO EXERCISES

# ✅ Must-Do Python Questions for DevOps Codertest (Pick These)
# 🔹 1. Log Analyzer (Regex + File I/O)

# Read a sample access.log file and:

# Count total lines

# Count requests per status code (e.g., 200, 404, 500)

# Find the top 5 IP addresses by number of requests

# 🔧 Skills: open(), regex, dicts, file handling

# 🔹 2. JSON Configuration Validator

# Load a config.json file and:

# Ensure required keys: host, port, username, password

# Print "Valid" or "Missing: [key]"

# 🔧 Skills: json module, dicts, error handling

# 🔹 3. YAML to JSON Converter

# Convert a YAML file to a JSON file using Python.

# 🔧 Skills: yaml, json, file handling, CLI args

# 🔹 4. Disk Space Checker

# Use subprocess to run df -h, parse the output, and:

# Show used % of each mounted drive

# Highlight drives over 80% usage

# 🔧 Skills: subprocess, string parsing, loops

# 🔹 5. Log Rotation Script

# Check if a log file exceeds 100MB.

# If yes, rename it with a timestamp suffix

# Create a new empty file in its place

# 🔧 Skills: os, shutil, time, file I/O

# 🔹 6. CLI Tool for File Rename

# Rename all .log files in a folder by adding a timestamp prefix.

# 🔧 Skills: os.listdir(), sys.argv, datetime, file renaming

# 🔹 7. Ping Hosts from File

# Read a file hosts.txt (1 hostname/IP per line), and:

# Ping each host once

# Print if it is reachable or not

# 🔧 Skills: subprocess, file reading, for loops

# 🔹 8. Environment Variable Dumper

# Print all environment variables that start with APP_ to a .env file in KEY=VALUE format.

# 🔧 Skills: os.environ, file writing

# 🔹 9. Process Checker

# Ask the user for a process name (e.g., nginx) and:

# Check if it's running

# Print PID(s) if found, else print "Not running"

# 🔧 Skills: subprocess, filtering strings, error handling

# 🔹 10. JSON Merger

# Merge two JSON files.
# Keys in the second file should override values in the first.

# 🔧 Skills: json, file I/O, dict updates

# 🔹 11. Secret Scrubber

# Given a config file, remove lines containing any of these keywords: password, secret, token.

# 🔧 Skills: File reading/writing, string matching, regex (optional)

# 🔹 12. Simple Health Check CLI

# Accept a list of URLs from CLI and:

# Send HTTP GET request to each

# Print status code and response time

# Retry 2 times if connection fails

# 🔧 Skills: requests or urllib, loops, exception handling

# 🧠 Pro Tip: Don’t Just Read — Code

# For each problem above:

# 🚀 Try writing from scratch

# ✅ Then test it on sample data

# 🧪 Add at least one try-except block

# 📦 Use modules (os, subprocess, json, sys, argparse, etc.)