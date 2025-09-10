# Flattening

# Flattening examples for different data structures

print("=== Flattening Examples ===\n")

### 1. Flatten Nested List of Numbers ###
nested_list_numbers = [[1, 2, 3], [4, 5], [6, 7, 8]]
flat_list_numbers = [num for sublist in nested_list_numbers for num in sublist]
print("1. Flattened List of Numbers:", flat_list_numbers)

# Equivalent for-loop:
# flat_list_numbers = []
# for sublist in nested_list_numbers:
#     for num in sublist:
#         flat_list_numbers.append(num)

### 2. Flatten List of Strings into Characters ###
words = ["Apple", "banana", "Cherry"]
flat_chars = [char for word in words for char in word]
print("2. Flattened Characters from List of Strings:", flat_chars)

# Equivalent for-loop:
# flat_chars = []
# for word in words:
#     for char in word:
#         flat_chars.append(char)

### 3. Flatten Set of Tuples (numbers) ###
set_of_tuples = {(1, 2), (3, 4), (5, 6)}
flat_set = {num for tup in set_of_tuples for num in tup}
print("3. Flattened Set of Tuples (Numbers):", flat_set)

# Equivalent for-loop:
# flat_set = set()
# for tup in set_of_tuples:
#     for num in tup:
#         flat_set.add(num)

### 4. Flatten Tuple of Tuples (numbers) ###
tuple_of_tuples = ((10, 20), (30, 40), (50, 60))
flat_tuple = tuple(num for tup in tuple_of_tuples for num in tup)
print("4. Flattened Tuple of Tuples (Numbers):", flat_tuple)

# Equivalent for-loop:
# flat_list = []
# for tup in tuple_of_tuples:
#     for num in tup:
#         flat_list.append(num)
# flat_tuple = tuple(flat_list)

### 5. Flatten Dictionary Keys ###
dict_simple = {"a": 1, "b": 2, "c": 3}
keys = [k for k in dict_simple]
print("5. Dictionary Keys:", keys)

# Equivalent for-loop:
# keys = []
# for k in dict_simple:
#     keys.append(k)

### 6. Flatten Dictionary Values (list of strings) ###
dict_values = {
    "fruits": ["apple", "banana"],
    "vegetables": ["carrot", "potato"],
    "grains": ["rice"]
}
flat_values = [item for sublist in dict_values.values() for item in sublist]
print("6. Flattened Dictionary Values:", flat_values)

# Equivalent for-loop:
# flat_values = []
# for sublist in dict_values.values():
#     for item in sublist:
#         flat_values.append(item)

### 7. Flatten Dictionary of Tuples (numbers) ###
dict_of_tuples = {
    "group1": (1, 2, 3),
    "group2": (4, 5),
    "group3": (6,)
}
flat_dict_tuples = [num for tup in dict_of_tuples.values() for num in tup]
print("7. Flattened Dictionary of Tuples:", flat_dict_tuples)

# Equivalent for-loop:
# flat_dict_tuples = []
# for tup in dict_of_tuples.values():
#     for num in tup:
#         flat_dict_tuples.append(num)

