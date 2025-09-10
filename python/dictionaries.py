# Dictionaries are unordered lists unlike lists and tuples
# Key value pairs
# Keys cannot be changed. But values can!
# Use curly brances
# While referencing you again use square brackets. But no index! because it is not ordered!
# empty dictionary defined as myDict = {}

empLocation = {"Alan": "Delhi", "Ramesh": "Hyderabad", "Prakash": "Chennai"}
print(empLocation)
print(empLocation["Ramesh"])

# Change the value
empLocation["Alan"]  = "New York"
print(empLocation)

# Retrieving values from Dict
# Why use get() instead of dict[key]?
# dict[key] will raise an error if the key is not found.
# dict.get(key) will not crash — it returns None or the default value you provide.
print(empLocation.get("Alan"))

print(empLocation.get("Suresh", "Not Found"))  # Output: Not Found

#--------------------------
# EXAMPLE Example -1
#--------------------------
user = {
    "username": "johndoe",
    "email": "john@example.com",
    "is_active": True,
    "roles": ["admin", "editor"] # Notice you can have lists within dictories
}

# Accessing values
print(user["roles"])  # Output: ['admin', 'editor']

# Check if user is admin
if "admin" in user["roles"]:
    print("User has admin access.")

#--------------------------
# EXAMPLE Word count example
#--------------------------
# to understand this example in detail, refer to dictionaries2.py

text = "apple banana apple orange banana apple"
words = text.split()


word_count = {}
for word in words:
    word_count[word] = word_count.get(word, 0) + 1

print(word_count)
# Output: {'apple': 3, 'banana': 2, 'orange': 1}

#--------------------------
# EXAMPLE Product example
#--------------------------

products = [
    ("laptop", "electronics"),
    ("shirt", "clothing"),
    ("phone", "electronics"),
    ("jeans", "clothing"),
]

grouped = {}

for item, category in products:
    if category not in grouped:
        grouped[category] = []
    grouped[category].append(item)

print(grouped)
# Output:
# {
#   'electronics': ['laptop', 'phone'],
#   'clothing': ['shirt', 'jeans']
# }
#--------------------------
# EXAMPLE Another example - Nested Dictionaries - JSON style
#--------------------------

employee = {
    "id": 101,
    "name": "Alice",
    "department": {
        "name": "Engineering",
        "manager": "Bob"
    }
}

print(employee["department"]["manager"])  # Output: Bob
#--------------------------
# EXAMPLE: Useful dictionary methods
#--------------------------

person = {"name": "Alice", "age": 30}

# Get value with default
print(person.get("email", "Not provided"))

# Get all keys and values
print(person.keys())    # dict_keys(['name', 'age'])
print(person.values())  # dict_values(['Alice', 30])
print(person.items())   # dict_items([('name', 'Alice'), ('age', 30)])

# Check if key exists
if "name" in person:
    print("Name found")

# Remove a key
person.pop("age")

# Merge dictionaries
new_info = {"email": "alice@example.com"}
person.update(new_info)
#--------------------------
# EXAMPLE Looping through dictionary
#--------------------------
user = {"name": "Tom", "email": "tom@example.com"}

for key, value in user.items():
    print(f"{key}: {value}")
