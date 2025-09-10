# EXAMPLE: for loop with list
fruits = ["Apple", "Banana", "Cherry", "Mango", "Orange"]

print("1. Basic for loop (direct access):")
for fruit in fruits:
    print(fruit)
print()

print("2. Using index with range and len():")
for i in range(len(fruits)):
    print(f"Index {i}: {fruits[i]}")
print()

print("3. Using enumerate() for index + value:")
for index, fruit in enumerate(fruits):
    print(f"{index}: {fruit}")
print()

print("4. Loop with condition (e.g., fruits with 'a'):")
for fruit in fruits:
    if 'a' in fruit.lower():
        print(f"Contains 'a': {fruit}")
print()

print("5. Reverse loop using reversed():")
for fruit in reversed(fruits):
    print(fruit)
print()

print("6. Sorted loop (without changing original list):")
for fruit in sorted(fruits):
    print(fruit)
print()

print("7. Loop with index and slicing:")
for fruit in fruits[1:4]:
    print(f"Sliced fruit: {fruit}")
print()

print("8. Modify elements (uppercase) inside loop:")
for fruit in fruits:
    print(fruit.upper())
print()

print("9. Loop with custom step (every 2nd fruit):")
for i in range(0, len(fruits), 2):
    print(f"Step 2 -> Index {i}: {fruits[i]}")
print()

print("10. Nested loop example (list of lists):")
fruitColors = [["Apple", "Red"], ["Banana", "Yellow"], ["Cherry", "Red"]]
for fruit, color in fruitColors:
    print(f"{fruit} is {color}")
