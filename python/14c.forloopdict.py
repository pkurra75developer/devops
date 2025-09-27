# EXAMPLE: for loop with Dictionary
empDetails = {
    "Name": "Rakesh",
    "Age": 20,
    "Department": "IT",
    "Location": "Bangalore"
}

print("1. Loop through keys (default dictionary iteration):")
for key in empDetails:
    print(f"{key}: {empDetails[key]}")
print()

print("2. Loop through keys explicitly using .keys():")
for key in empDetails.keys():
    print(f"{key}: {empDetails[key]}")
print()

print("3. Loop through values only using .values():")
for value in empDetails.values():
    print(f"Value: {value}")
print()

print("4. Loop through key-value pairs using .items():")
for key, value in empDetails.items():
    print(f"{key}: {value}")
print()

print("5. Enumerate over items (get index + key-value):")
for index, (key, value) in enumerate(empDetails.items()):
    print(f"{index + 1}. {key}: {value}")
print()

print("6. Display dictionary using pretty formatting:")
for key, value in empDetails.items():
    print(f"{key:<12} : {value}")
print()

print("7. Convert to list of tuples and loop through:")
tupleList = list(empDetails.items())
for item in tupleList:
    print(item)

# Understanding the last bit if you are confused.

# 🔍 Why it's called tupleList
# tupleList = list(empDetails.items())


# This line converts the dictionary items into a list. But what's inside that list?

# 👉 What empDetails.items() returns:

# The .items() method returns a view of key-value pairs, each as a tuple:
# Example:

# dict_items([('Name', 'Rakesh'), ('Age', 20), ('Department', 'IT'), ('Location', 'Bangalore')])


# So when you convert it to a list:

# tupleList = list(empDetails.items())


# You get:

# [('Name', 'Rakesh'), ('Age', 20), ('Department', 'IT'), ('Location', 'Bangalore')]


# This is a list of tuples, where:

# Each tuple is a key-value pair.

# Hence, the variable name tupleList reflects its content: a list of tuples.

# 🧠 Breakdown:

# list → The outer structure (container) is a list.

# tupleList → The items inside are tuples.

# tupleList[0] → Would be something like ('Name', 'Rakesh')

# ✅ Example (to make it clearer):
# tupleList = list(empDetails.items())
# print(type(tupleList))         # <class 'list'>
# print(type(tupleList[0]))      # <class 'tuple'>
# print(tupleList[0])            # ('Name', 'Rakesh')
# print(tupleList[0][0])         # Name
# print(tupleList[0][1])         # Rakesh