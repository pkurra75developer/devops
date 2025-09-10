# # Comprehensions in Python

# # Python has four main types of comprehensions:
# # ✅ 1. List Comprehension
# # Used to create lists.
# # 🔹 Syntax:
# # [expression for item in iterable if condition]

# # 🔹 Example:
# squares = [x**2 for x in range(5)]
# print(squares)
# # # Output: [0, 1, 4, 9, 16]

# # ✅ 2. Set Comprehension
# # Used to create sets (which automatically remove duplicates).
# # 🔹 Syntax:
# # {expression for item in iterable if condition}

# # 🔹 Example:
# unique_lengths = {len(word) for word in ["apple", "banana", "pear", "apple"]}
# print(unique_lengths)
# # # Output: {4, 5, 6}

# # ✅ 3. Dictionary Comprehension

# # Used to create dictionaries.

# # 🔹 Syntax:
# # {key_expr: value_expr for item in iterable if condition}

# # 🔹 Example:
# word_lengths = {word: len(word) for word in ["apple", "banana", "pear"]}
# print(word_lengths)
# # # Output: {'apple': 5, 'banana': 6, 'pear': 4}

# # ✅ 4. Generator Expression
# # Used to create a generator (lazy iterable — doesn’t store all values in memory).
# # 🔹 Syntax:
# # (expression for item in iterable if condition)
# # 🔹 Example:
# gen = (x**2 for x in range(5))
# print(next(gen))  # 0
# print(next(gen))  # 1

# EXAMPLE - COMPLETE

# Source data
numbers = [1, 2, 3, 4, 5, 6]

print("Original list:", numbers)
print()

# 1. List Comprehension with if
even_numbers = [x for x in numbers if x % 2 == 0]
print("1. List of even numbers:", even_numbers)

# 2. List Comprehension with if and transformation
even_squares = [x**2 for x in numbers if x % 2 == 0]
print("2. List of squares of even numbers:", even_squares)

# 3. Set Comprehension with if
even_squares_set = {x**2 for x in numbers if x % 2 == 0}
print("3. Set of squares of even numbers (no duplicates):", even_squares_set)

# 4. Dictionary Comprehension with if
even_square_dict = {x: x**2 for x in numbers if x % 2 == 0}
print("4. Dictionary of even numbers and their squares:", even_square_dict)

# 5. Generator Expression with if
even_square_gen = (x**2 for x in numbers if x % 2 == 0)
print("5. Generator Expression (printing values one by one):")
for val in even_square_gen:
    print(val)

# 6. List Comprehension with if-else
parity_labels = ["Even" if x % 2 == 0 else "Odd" for x in numbers]
print("6. List of labels (Even/Odd):", parity_labels)


# EXAMPLE WITH STRINGS WITH ALL THREE VARIATIONS USING SET
#Note: the below code will not work. because myList is NOT DEFINED YET for using reversed and you are
# trying to use it while it is actually mentioned it there!
# reversed will NOT work with sets. it works with lists and strings


words = ["Apple", "banana", "Cherry", "apricot", "blueberry"]

# 1. Basic copy
copied_words = [word for word in words]
print("1. Copied words:", copied_words)

# 2. With if condition
lowercase_words = [word for word in words if word[0].islower()]
print("2. Lowercase starting words:", lowercase_words)

# 2b. Words containing 'b'
contains_b = [word for word in words if "b" in word.lower()]
print("2b. Contains 'b':", contains_b)

# 3. With if-else
labels = ["StartsWithA" if word.lower().startswith("a") else "Other" for word in words]
print("3. Labels:", labels)

# 4. Transformations
uppercase_words = [word.upper() for word in words]
print("4. UPPERCASE:", uppercase_words)

# 4b. Lowercase
lowercase_words = [word.lower() for word in words]
print("4b. lowercase:", lowercase_words)

# 5. Combine filter + transformation
b_words_upper = [word.upper() for word in words if word.lower().startswith("b")]
print("5. 'b' words UPPERCASE:", b_words_upper)

# 6. Nested comprehension (flatten characters)
characters = [char for word in words for char in word]
print("6. Characters from all words:", characters)


