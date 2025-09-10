# For loop
# A for loop in Python is used to iterate over:
# Sequences (list, tuple, string)
# Iterables (range(), dict, set)
# Anything that implements the iterator protocol

# Note: the index starts from 0
# End value not included
# for i in range(10):
#     print(i)

# for i in range(10):
#     print(i+1)

# for i in range(1,11):
#     print(i)

# for i in range(5,105,5):
#     print(i)

# for i in range(100,1,-2):
#     print(i)

# EXAMPLE NESTED LOOPS
for x in range(1,6):
    for y in range(1,6):
        for z in range(1,6):
            print(x, y, z)

# EXAMPLE - for loop with string
# myStr = "Welcome to the world of Python"

# for i in myStr: # i will be a character for every iteration
#     print(i)


# Above program in a different way!
# EXAMPLE - for loop with string
# myStr = "Welcome to the world of Python"

# for i in range(0,len(myStr)): #
#     print(myStr[i])


# # EXAMPLE - for loop with lists
# empList = ["Rakesh", "Praveen", "Veeren"]

# for emp in empList:
#     print(emp)


# # EXAMPLE - for loop with Tuples
# empList = ("Rakesh", "Praveen", "Veeren")

# for emp in empList:
#     print(emp)

# # EXAMPLE - for loop with Dictionaries
# empDetails = {"Name": "Rakesh", "Age": 20}

# for emp in empDetails:
#     print(f"{emp} : {empDetails[emp]}")

# # EXAMPLE - for loop with Dictionaries - MORE EFFICIENT WAY WITH ITEMS
# empDetails = {"Name": "Rakesh", "Age": 20}

# for key, value in empDetails.items():
#     print(f"{key} : {value}")

# # EXAMPLE: for loop with set
# majorCities = {"London", "New York", "Tokyo", "Paris", "Beijing"}
# for city in majorCities:
#     print(f"{city}")


# all_about_for_loops.py

# 1. Basic for loop over a list
fruits = ['apple', 'banana', 'cherry']
print("Basic loop over list:")
for fruit in fruits:
    print(fruit)
print()

# 2. Looping with range()
print("Looping with range(5):")
for i in range(5):
    print(i)
print()

print("Looping with range(start=10, stop=0, step=-2):")
for i in range(10, 0, -2):
    print(i)
print()

# 3. Looping over a string
print("Looping over string 'hello':")
for char in "hello":
    print(char)
print()

# 4. Looping over a dictionary
person = {'name': 'Alice', 'age': 25}
print("Loop over dictionary keys:")
for key in person:
    print(key)

print("\nLoop over dictionary values:")
for value in person.values():
    print(value)

print("\nLoop over dictionary items (key-value pairs):")
for key, value in person.items():
    print(f"{key}: {value}")
print()

# 5. Looping over a set (unordered)
items = {'pen', 'notebook', 'eraser'}
print("Looping over a set (unordered):")
for item in items:
    print(item)
print()

# 6. For-else loop (else runs if no break)
print("For-else example:")
for i in range(5):
    if i == 3:
        print("Breaking at 3")
        break
else:
    print("Loop completed without break")
print()

# 7. Using break and continue
print("Using break and continue:")
for i in range(5):
    if i == 2:
        print("Skipping 2 with continue")
        continue
    if i == 4:
        print("Breaking at 4")
        break
    print(i)
print()

# 8. Using enumerate to get index and value
colors = ['red', 'green', 'blue']
print("Looping with enumerate:")
for index, color in enumerate(colors):
    print(f"{index}: {color}")
print()

# 9. Using zip to loop over multiple sequences
names = ['Alice', 'Bob', 'Charlie']
scores = [85, 92, 78]
print("Looping with zip over two lists:")
for name, score in zip(names, scores):
    print(f"{name} scored {score}")
print()

# 10. Nested loops
print("Nested loops:")
for i in range(3):
    for j in range(2):
        print(f"i={i}, j={j}")
print()

# 11. List comprehension (one-line for loop)
print("List comprehension to create squares:")
squares = [x**2 for x in range(5)]
print(squares)

print("List comprehension with condition (even numbers):")
evens = [x for x in range(10) if x % 2 == 0]
print(evens)
print()

# 12. Looping in reverse
print("Looping in reverse using reversed(range(5)):")
for i in reversed(range(5)):
    print(i)

items = ['a', 'b', 'c']
print("\nLooping in reverse over list:")
for item in reversed(items):
    print(item)
print()

# 13. For-else used in searching
print("For-else used for search:")
numbers = [1, 3, 5, 7]
for num in numbers:
    if num == 4:
        print("Found 4!")
        break
else:
    print("4 not found in list")
