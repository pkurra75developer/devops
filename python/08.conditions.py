# All conditional control variations
# -------------------------------
# 1. Basic if / elif / else
# -------------------------------
x = 7

if x > 10:
    print("x is greater than 10")
elif x > 5:
    print("x is greater than 5 but not more than 10")
else:
    print("x is 5 or less")

# -------------------------------------
# 2. Nested if
# -------------------------------------
if x > 0:
    print("x is positive")
    if x % 2 == 0:
        print("x is even")
    else:
        print("x is odd")

# -------------------------------------
# 3. Ternary Operator
# -------------------------------------
result = "Even" if x % 2 == 0 else "Odd"
print("Ternary result:", result)

# -------------------------------------
# 4. match-case (Python 3.10+)
# -------------------------------------
command = "stop"

match command:
    case "start":
        print("Command: Starting system...")
    case "stop":
        print("Command: Stopping system...")
    case "pause":
        print("Command: Pausing system...")
    case _:
        print("Unknown command")

# -------------------------------------
# 5. Short-circuit Evaluation
# -------------------------------------
# Only evaluates the second condition if the first is True
y = None
if y is not None and y > 0:
    print("y is positive")
else:
    print("Short-circuit: y is None or not positive")  # This runs

# Another short-circuit example
username = ""
password = "admin123"

if username and password == "admin123":
    print("Login successful")
else:
    print("Login failed (short-circuited if username is empty)")

# -------------------------------------
# 6. Boolean Contexts
# -------------------------------------
# Using data structures directly in if-statements

items = []  # Empty list is falsy

if items:
    print("Items list is not empty")
else:
    print("Boolean context: Items list is empty")  # This runs

text = "hello"
if text:
    print("Boolean context: Text is non-empty")

count = 0
if not count:
    print("Boolean context: Count is zero or falsy")

# -------------------------------------
# 7. Identity Check (Bonus)
# -------------------------------------
a = [1, 2, 3]
b = a
c = [1, 2, 3]

if a is b:
    print("a and b are the same object")

if a == c:
    print("a and c have the same content")

if a is not c:
    print("a and c are different objects (but same values)")
