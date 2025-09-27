# DEVOPS MUST DO
✅ What to Brush Up Today (Before Writing Scripts Tomorrow)
🔹 1. Core Python Syntax

Make sure you’re quick with:

for, while, if-elif-else

break, continue, else on loops

try-except blocks

with open(...) as f: (file handling)

Working with lists, dicts, sets, and strings

📌 Goal: You should not be googling "how to loop" or "how to open a file" tomorrow.

🔹 2. Working with Files

Brush up:

open(file, 'r'), read(), readlines()

Writing: open(file, 'w'), write(), writelines()

File paths: relative/absolute

os.path.exists(), os.path.getsize()

Use with blocks to avoid leaks

🔹 3. JSON & YAML

Practice:

Load/save JSON: json.load(), json.dump()

Load/save YAML: yaml.safe_load(), yaml.dump()

Convert between JSON and dict

Know how to check for keys in dicts: if "host" in config:

🔹 4. Command Line Args

Be ready with:

sys.argv to access CLI args

Optional: argparse (for nicer scripts)

You should know how to:

import sys
print(sys.argv[1])  # First argument

🔹 5. Subprocess Module

Review:

subprocess.run(["ls", "-l"], capture_output=True)

Getting stdout: .stdout.decode()

Check for command errors: check=True

Practice running a shell command from Python

🔹 6. Regex Basics

Just the essentials:

Importing: import re

re.findall(), re.search(), re.sub()

Simple patterns: IPs, emails, keywords like password=

You don’t need to master regex, but you should know how to:

re.findall(r"\d{1,3}(?:\.\d{1,3}){3}", text)  # IP pattern

🔹 7. Working with os and sys

Useful functions:

os.listdir(), os.path.getsize()

os.rename(), os.remove(), os.environ

sys.exit(), sys.argv, sys.path

🔹 8. Datetime & Timestamps

You might need to:

Get current time: datetime.now()

Format timestamp for filenames: .strftime("%Y%m%d_%H%M%S")

🔹 9. Exception Handling

Quick recap of:

try:
    # risky code
except FileNotFoundError:
    print("File not found")
except Exception as e:
    print("Some error:", e)

🔹 10. Basic Scripting Hygiene

Be mindful of:

Using functions (if time permits)

Adding comments

Printing meaningful messages

Error messages that help debug

🧠 Brushup Tip:

Open a Python shell or script and run small snippets of:

File read/write

JSON/YAML load/dump

subprocess calls

sys.argv tests

regex finds

Just to build muscle memory.

📦 OPTIONAL: Setup for Tomorrow

To save time tomorrow:

Create a project folder: devops-codertest/

Add subfolders: logs/, configs/, scripts/

Prepare 1 sample .json, .yaml, .log, and .txt file (or ask me for examples)

Install any needed modules:

pip install pyyaml requests