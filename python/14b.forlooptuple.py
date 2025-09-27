# EXAMPLE: for loop with tuple
studentInfo = ("Rakesh", 20, "IT", "Bangalore")

print("1. Basic for loop (direct access):")
for item in studentInfo:
    print(item)
print()

print("2. Using index with range and len():")
for i in range(len(studentInfo)):
    print(f"Index {i}: {studentInfo[i]}")
print()

print("3. Using enumerate() for index + value:")
for index, value in enumerate(studentInfo):
    print(f"{index}: {value}")
print()

print("4. Tuple unpacking (when tuple has fixed structure):")
name, age, department, location = studentInfo
print(f"Name: {name}")
print(f"Age: {age}")
print(f"Department: {department}")
print(f"Location: {location}")
print()

print("5. Convert to list and loop (if needed for mutability):")
tempList = list(studentInfo)
for item in tempList:
    print(item)
print()

print("6. Reverse loop using reversed():")
for item in reversed(studentInfo):
    print(item)
print()

print("7. Loop through with condition (e.g., print only strings):")
for item in studentInfo:
    if isinstance(item, str):
        print(f"String value: {item}")
