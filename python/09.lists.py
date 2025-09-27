# lists example
# Lists are mutable. Square brackets
# They can contain data of any datatype
# Index starts from 0
# Like string characters you can index them in reverse order too. But -1 will be the last starting index
# List	empty_list = []	Square brackets with nothing inside

fruitList = ["Apples", "Oranges", "Pears", "Bananas"]
print(type(fruitList))
print(fruitList)
print(fruitList[0])
print(fruitList[1])
print(fruitList[2])
print(fruitList[3])
print("*"*10)
print("Below Using negative index")
print("*"*10)
print(fruitList[-1])
print(fruitList[-2])
print(fruitList[-3])
print(fruitList[-4])
print("*"*10)
print("Part of the list")
print("*"*10)
print(fruitList[-2:]) # starting at -2 until end of the list. it should print pears and bananas
print(fruitList[-2:-3]) # starting at -2 increments default +1. Not -1. so prints nothing
print(fruitList[-2:-3:-1]) # starting at -2 increments -1 Prints only Pears. Beause it exludes the ending index
print(fruitList[-2:-4:-1]) # starting at -2 increments -1 Prints Oranges, Pears. Beause it exludes the ending index. That's why Apples is not displayed

# Notice: In the above example, it displayed Pears and Oranges. Not Oranges and Pears.
# Append, insert, delete, clear etc.,
fruitList.append("Grapes")
print(fruitList)
# Deleting in two different ways!
#fruitList.remove("Apples")
del fruitList[1]
print(fruitList)
# Del is a keyword to delete a variable or list or an object etc.,
# Using Del python keyword
x = "hello"
print(type(x))
del x
# Once deleted, the below statement will throw error.
# print(type(x))
# extend will extend the current list
newFruits = ["Figs", "Cherries"]
fruitList.extend(newFruits)
print(fruitList)

# Extend as below and see what happens
fruitList.extend("Plums")
print(fruitList)
# ['Apples', 'Pears', 'Bananas', 'Grapes', 'Figs', 'Cherries', 'P', 'l', 'u', 'm', 's']
# Because Plums is an iterable item. not a list! so it will handle it in that way!

print("*"*10)
print("Pop")
print("*"*10)
print(fruitList)
# Pop will remove an item by index and also returns its value for future use if you need!
fruitList.pop(0)
print(fruitList)
goneItem1 = fruitList.pop(0)
print(fruitList)
goneItem2 = fruitList.pop(1)
print(fruitList)
print(goneItem1)
print(goneItem2)

# Different datatypes can be stored in a list

mixList = ["Ram", "Addanki", 30, False]
print(mixList)
print(len(mixList))
# Insert a value
mixList.insert(1,"Kumar")
print(mixList)
print(len(mixList))
# Note: mixList.insert[0] = "Kumar"  # ❌ This will cause a TypeError

# Repplace a list item
mixList[0] = "Praveen"
mixList[3] = 50
print(mixList)
print("Reverse of list")
print(mixList.reverse()) # mixList.reverse() will return None. because it will reverse in place. but will return none.
# correct way of reversing: mixList.reverse and then print(mixList)
print(mixList)

# Assigning and copying lists
a = [1, 2, 3]
b = a          # b points to the same list
c = a.copy()   # c is a separate copy

a[0] = 100
print(b)  # [100, 2, 3]
print(c)  # [1, 2, 3]

# Builtin functions of lists
print(f"Length: {len(a)}, Sum: {sum(a)}, Min: {min(a)}, Max: {max(a)}, Sorted: {sorted(a)}")

# Nested lists
students = [
    ["Name", "Age", "Grade"], # Row 0 (Header row)
    ["Alice", 14, "A"],  # Row 1
    ["Bob", 13, "C"], # Row 2
    ["Charlie", 15, "A"]  # Row 3
]

# Print 2nd row
print(students[2])  # Output: ["Bob", 13, "C"]

# Get Bob's grade
print(students[2][2])  # Output: C


# Print all and in reverse
# Print all
travelVehicles = ["Buses", "Trains", "Bicyles"]
print(travelVehicles[::1]) # Prints all
print(travelVehicles[::-1]) # Prints all but in reverse order