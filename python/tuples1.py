# Tuples are similar to lists in a way!
# Major difference: Immutable. Meaning cannot add or modify
# Major difference: use () instead of [] while creating
# Same: Referencing is same by using []
# Then what's the advantage?
# Tuples are faster for processing compared to Lists
# Tuple	empty_tuple = ()	Parentheses with nothing inside

# Tuple Creation
my_tuple = (1, 2, 3, 4, 5)

# Accessing Elements
print("First Element:", my_tuple[0])

# Slicing
print("Slice [1:4]:", my_tuple[1:4])

# Iteration
print("Iterating over tuple:")
for item in my_tuple:
    print(item)

# Membership Test
print("Is 3 in tuple?", 3 in my_tuple)

# Length
print("Length of tuple:", len(my_tuple))

# Nested Tuples
nested_tuple = (1, 2, (3, 4), (5, (6, 7)))
print("Nested tuple:", nested_tuple)
print("Accessing nested element:", nested_tuple[2][1])  # Should print 4
print("Deeply nested element:", nested_tuple[3][1][0])  # Should print 6

# Tuple with different data types
mixed_tuple = (42, "hello", 3.14, True)
print("Mixed tuple:", mixed_tuple)

# Using tuple as dictionary key
coords = {(0, 0): "Origin", (1, 2): "Point A"}
print("Value at (1, 2):", coords[(1, 2)])

# Immutability test
try:
    my_tuple[0] = 100  # This will raise an error
except TypeError as e:
    print("Error:", e)

# another example
# Each city is identified by its (latitude, longitude) pair
city_locations = {
    ("New York",): (40.7128, -74.0060),
    ("San Francisco",): (37.7749, -122.4194),
    ("London",): (51.5074, -0.1278)
}

# Accessing coordinates
for city, coords in city_locations.items():
    print(f"{city[0]} is located at Latitude {coords[0]}, Longitude {coords[1]}")

# Example to see that they can be used in Dictionaries. Lists cannot be used!

employee_data = {
    ("John", "Doe"): {"position": "Manager", "salary": 80000},
    ("Jane", "Smith"): {"position": "Developer", "salary": 90000},
    ("Alice", "Wong"): {"position": "Designer", "salary": 70000}
}

# Looking up an employee
name = ("Jane", "Smith")
if name in employee_data:
    print(f"{name[0]} {name[1]}'s position:", employee_data[name]["position"])

# Tuple returning multiple values

def get_user_info(user_id):
    # Imagine this comes from a database
    return ("Alice", "Wong", "alice@example.com")

# Unpacking the returned tuple
first_name, last_name, email = get_user_info(101)
print(f"User: {first_name} {last_name}, Email: {email}")

# Nested tuple

# (Day, (Course, Time))
schedule = (
    ("Monday", ("Math", "9 AM")),
    ("Tuesday", ("Physics", "11 AM")),
    ("Wednesday", ("Chemistry", "10 AM")),
)

for day, (course, time) in schedule:
    print(f"{day}: {course} at {time}")

# another example of tuple

routes = {
    ("New York", "London"),
    ("Paris", "Tokyo"),
    ("Berlin", "Rome"),
    ("New York", "London")  # duplicate — won't be added again
}

print("Unique routes:")
for route in routes:
    print(f"{route[0]} → {route[1]}")

