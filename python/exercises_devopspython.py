# # Exercises - DevOps and Python
# 🔸 File Handling & File System

# Read a file line-by-line and count how many lines contain a given keyword.

# List all files in a directory that match a specific extension (e.g., .log, .yml).

# Compress a given directory into a .tar.gz archive.

# Search and replace text in a file (like sed) and write to a new file.

# Monitor file size, and rotate it if it exceeds a certain limit.

# Write a script that watches a log file in real time (tail -f behavior).

# 🔸 JSON / YAML Processing

# Read a JSON config file, update a specific key’s value, and save it back.

# Validate a JSON file for required keys and proper types.

# Convert a JSON file to YAML and vice versa.

# Merge two JSON configuration files with priority to the second one.

# 🔸 String Parsing & Regular Expressions

# Extract IP addresses from a text file using regex.

# Parse an Apache/Nginx access log and print summary (status codes, IPs, URLs).

# Extract all email addresses from a file.

# Detect and redact passwords/secrets from a config file.

# Validate an environment variable name using regex.

# 🔸 Command Line Input / Output

# Accept arguments from CLI (e.g., --path, --dry-run, --verbose) and print them.

# Create a script that accepts a list of filenames and renames them with a prefix or timestamp.

# Simulate a basic CLI tool like ls, grep, or df using Python.

# Write a script that pings a list of IPs passed via CLI.

# Build a CLI menu for basic server operations (start, stop, status).

# 🔸 subprocess, os, sys Modules

# Run a shell command using subprocess and capture the output.

# Check if a service (e.g., nginx) is running and restart it if not.

# Use os to check disk space usage and print an alert if it’s > 90%.

# Execute a system command and log its output to a file.

# List all environment variables and allow filtering by a keyword.

# 🔸 Error Handling & Logging

# Open a file safely with error handling if file doesn't exist or permission denied.

# Use try-except to handle bad JSON/YAML formatting.

# Retry a failing shell command up to 3 times before giving up.

# Implement a logging mechanism to record errors and script execution steps.

# Write a wrapper that logs success/failure of any shell command you pass to it.

# 🔸 Lists, Dicts, Sets, and Other Core Python

# Count frequency of each HTTP status code from a list of log entries.

# Given a list of filenames, filter only .conf or .env files.

# Sort services in a dictionary by their memory usage.

# Find duplicate entries in a list of hostnames.

# Group users by role from a list of dictionaries.

# 🔸 Automation-Oriented Problems

# Monitor CPU or memory usage periodically and print a warning if usage is high.

# Backup configuration files from /etc/ to a timestamped backup directory.

# Schedule a Python script to run every N seconds (simulate cron in Python).

# Build a simple "deployment simulator" that runs dummy shell commands from a YAML playbook.

# Simulate .env file loader: parse key=value pairs and export them to environment.

# 🧠 Advanced (Stretch) Questions — Optional But Impressive

# Parse a Docker Compose YAML and print all services and their ports.

# Detect circular references in JSON/YAML includes.

# Create a CLI tool to upload files to AWS S3 using boto3 (mock credentials).

# Write a script that checks SSL certificate expiry for a list of domains.

# Simulate a basic Ansible playbook runner in Python.