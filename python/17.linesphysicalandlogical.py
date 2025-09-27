# LOGICAL LINES IN PYTHON
# When a single line of code gets too long, you can split it across multiple lines using:
# ---------------------------------------
# () Parentheses
# ---------------------------------------

# ✅ Tuple creation
my_tuple = (1, 2, 3)
print("Tuple:", my_tuple)

# ✅ Grouping math expression (not a tuple)
result = (
    10 + 20 +
    30 + 40
)
print("Grouped expression result:", result)

# ✅ Single-value tuple (must have comma)
one_item = (5,)
print("Single-item tuple:", one_item)

# ✅ Function call with line continuation
print(
    "Hello",
    "World",
    "Split",
    "Across",
    "Lines"
)

# ---------------------------------------
# [] Brackets
# ---------------------------------------

# ✅ List creation
my_list = [
    "apple",
    "banana",
    "cherry",
    "mango"
]
print("List:", my_list)

# ✅ List comprehension with line break
squares = [
    x * x
    for x in range(1, 6)
]
print("List comprehension (squares):", squares)

# ✅ Indexing with brackets across lines
first_fruit = my_list[
    0
]
print("First fruit (indexing with []):", first_fruit)

# ---------------------------------------
# {} Braces
# ---------------------------------------

# ✅ Dictionary creation
my_dict = {
    "name": "Ravi",
    "age": 25,
    "city": "Mumbai"
}
print("Dictionary:", my_dict)

# ✅ Set creation (unordered, unique)
my_set = {
    "red",
    "green",
    "blue",
    "red"  # duplicate will be removed
}
print("Set:", my_set)

# ✅ Dictionary comprehension (multi-line)
squared_dict = {
    x: x * x
    for x in range(1, 6)
}
print("Dict comprehension:", squared_dict)

# ✅ Set comprehension (multi-line)
even_set = {
    x for x in range(10)
    if x % 2 == 0
}
print("Set comprehension (evens):", even_set)

# ------------------
# multiple lines in a single statement

a = 100; b = 40; c = 60

print(a,b,c)

# assign same value for multiple variables
a = b = c = 4
print(a,b,c)

myMessage = "This line is manually"  \
              " split into"  \
              " multiple lines" \
              " as you see"
print(myMessage)

a = 1 + 3 + 4 + 5 + \
    6 + 7 \
    + 8

print(a)

