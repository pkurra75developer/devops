

# ALL OPERATORS IN SINGLE FILE


# Note: you can assign multiple values also
print("Multiple variable in one single line:")
x, y, text = 1,350, "I am intelligent"

print(x)
print(y)
print(text)
print("-" * 40)

# ------------------------
# 1. Arithmetic Operators
# ------------------------
a = 10
b = 3

print("Arithmetic Operators:")
print("Addition:", a + b)            # 10 + 3 = 13
print("Subtraction:", a - b)         # 10 - 3 = 7
print("Multiplication:", a * b)      # 10 * 3 = 30
print("Division:", a / b)            # 10 / 3 = 3.333...
print("Floor Division:", a // b)     # 10 // 3 = 3
print("Modulus:", a % b)             # 10 % 3 = 1
print("Exponentiation:", a ** b)     # 10 ** 3 = 1000
print("-" * 40)

# ------------------------
# 2. Comparison Operators
# ------------------------
print("Comparison Operators:")
print("Equal to:", a == b)           # False
print("Not equal to:", a != b)       # True
print("Greater than:", a > b)        # True
print("Less than:", a < b)           # False
print("Greater than or equal:", a >= b)  # True
print("Less than or equal:", a <= b)     # False
print("-" * 40)

# ------------------------
# 3. Assignment Operators
# ------------------------
print("Assignment Operators:")
x = 5
x += 2     # x = x + 2 → 7
print("x += 2 →", x)
x -= 1     # x = x - 1 → 6
print("x -= 1 →", x)
x *= 3     # x = x * 3 → 18
print("x *= 3 →", x)
x /= 2     # x = x / 2 → 9.0
print("x /= 2 →", x)
x //= 2    # x = x // 2 → 4.0
print("x //= 2 →", x)
x %= 3     # x = x % 3 → 1.0
print("x %= 3 →", x)
x **= 4    # x = x ** 4 → 1.0
print("x **= 4 →", x)
print("-" * 40)

# ------------------------
# 4. Logical Operators
# ------------------------
print("Logical Operators:")
a = 5
b = 2
print("a > 3 and b < 5:", a > 3 and b < 5)   # True and True → True
print("a < 3 or b < 5:", a < 3 or b < 5)     # False or True → True
print("not(a == b):", not(a == b))          # not(False) → True
print("-" * 40)

# ------------------------
# 5. Bitwise Operators
# ------------------------
print("Bitwise Operators:")
a = 5    # Binary: 0101
b = 3    # Binary: 0011
print("a & b (AND):", a & b)        # 0101 & 0011 = 0001 → 1
print("a | b (OR):", a | b)         # 0101 | 0011 = 0111 → 7
print("a ^ b (XOR):", a ^ b)        # 0101 ^ 0011 = 0110 → 6
print("~a (NOT):", ~a)              # ~0101 = -(0101 + 1) = -6
print("a << 1 (Left Shift):", a << 1)  # 0101 → 1010 = 10
print("a >> 1 (Right Shift):", a >> 1) # 0101 → 0010 = 2
print("-" * 40)

# ------------------------
# 6. Identity Operators
# ------------------------
print("Identity Operators:")
x = [1, 2, 3]
y = [1, 2, 3]
z = x
print("x is z:", x is z)           # True (same object)
print("x is y:", x is y)           # False (same content, different object)
print("x == y:", x == y)           # True (same content)
print("x is not y:", x is not y)   # True
print("-" * 40)

# ------------------------
# 7. Membership Operators
# ------------------------
print("Membership Operators:")
fruits = ["apple", "banana", "cherry"]
print("'apple' in fruits:", "apple" in fruits)     # True
print("'grape' not in fruits:", "grape" not in fruits)  # True
print("-" * 40)

# ------------------------
# 8. Ternary Operator
# ------------------------
print("Ternary Operator:")
num = 7
result = "Even" if num % 2 == 0 else "Odd"
print("7 is:", result)
print("-" * 40)

# ------------------------
# 9. Walrus Operator (Python 3.8+)
# ------------------------
print("Walrus Operator:")
# Assign and test in the same line
if (length := len("hello")) > 3:
    print("Length of 'hello' is:", length)
print("-" * 40)
