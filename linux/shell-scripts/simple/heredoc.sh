#!/bin/bash
# =============================================================================
# HERE DOCUMENTS AND HERE STRINGS DEMO
# =============================================================================

set -euo pipefail

# =============================================================================
# WHY DO WE NEED HERE DOCUMENTS / HERE STRINGS?
# =============================================================================
# 1. Avoids creating temporary files for feeding input to commands.
#    Instead of writing multi-line content to a file and then reading it,
#    you can feed it directly via a Here Document.
#
# 2. Makes scripts cleaner and more readable.
#    Multi-line input is embedded right in the script.
#
# 3. Useful for automation: feeding commands to programs like ssh, mysql,
#    awk, sed, or any command that reads from stdin.
#
# 4. Here Strings (<<<) are convenient for feeding single-line input
#    without creating a file or multi-line block.
#
# 5. Prevents extra I/O overhead and simplifies temporary data handling.

# =============================================================================
# 1. Basic Here Document
# =============================================================================
echo "=== Basic Here Document ==="
cat <<EOF
This is a here document.
It can have multiple lines.
Variables are substituted, e.g., HOME = $HOME
EOF

# =============================================================================
# 2. Here Document with no variable expansion
# =============================================================================
echo -e "\n=== Here Document without variable expansion ==="
cat <<'EOF'
This is a here document with single quotes.
Variables like $HOME will not be expanded.
EOF

# =============================================================================
# 3. Here Document with command substitution
# =============================================================================
echo -e "\n=== Here Document with command substitution ==="
USERNAME=$(whoami)
cat <<EOF
Current user: $USERNAME
Current date: $(date)
EOF

# =============================================================================
# 4. Stripping leading tabs using <<-EOF
# =============================================================================
echo -e "\n=== Here Document with leading tabs stripped ==="
cat <<-EOF
	This line has a tab in the script but tab is removed in output
	Another tabbed line
EOF

# =============================================================================
# 5. Here String (single line input)
# =============================================================================
echo -e "\n=== Here String ==="
grep "bash" <<< "This is a test string containing bash"

# =============================================================================
# 6. Feeding multi-line input to a command using Here Document
# =============================================================================
echo -e "\n=== Feeding multi-line input to a command ==="
sort <<EOF
banana
apple
cherry
date
EOF

# =============================================================================
# 7. Practical Example: sending commands to another program
# =============================================================================
echo -e "\n=== Practical Example: feeding SQL commands (simulation) ==="
cat <<EOF | awk '{print NR, $0}'
SELECT * FROM users;
INSERT INTO users VALUES (1, "Alice");
UPDATE users SET name="Bob" WHERE id=2;
EOF
